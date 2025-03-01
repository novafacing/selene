-- Selene Build Script
require("lfs")

ERR = 1
OK = 0

BLOCKLIST_LINES =
    ["conf.lua"]: {
        "%s*require%(\"lib.moonscript\"%)[^\n]*",
        "package%.path = package%.path %.%. \";%./lib/moonscript/%?%.lua\"[^\n]*\n",
        "package%.path = package%.path %.%. \";%./lib/lulpeg/%?%.lua\"[^\n]*\n",
    }

export traverse = (func, path, dirs) ->
    -- Traverse a directory recursively and apply a function to files found
    -- Returns OK on success, ERR on failure from the func result
    -- @param func The function to apply to files
    -- @param path The path to traverse from

    traverse_stack = [ "#{path}/#{entry}" for entry in lfs.dir(path) ]
    seen = {}
    rv = OK

    while #traverse_stack > 0
        entry = table.remove(traverse_stack)

        filename = entry\match("([^/]+)$")

        -- Skip builtin traversals and nonexistent files/dirs
        if filename == "." or filename == ".." or lfs.attributes(entry) == nil
            continue

        -- If we have seen this entry before, skip it
        if #[e for _, e in ipairs seen when e == entry] != 0
            continue


        table.insert(seen, entry)

        -- Recurse on directories and call the callback on files
        if lfs.attributes(entry, "mode") == "directory"
            for sentry in lfs.dir(entry)
                table.insert(traverse_stack, "#{entry}/#{sentry}")

            if dirs and not func(entry)
                rv = ERR
        else
            if not func(entry)
                rv = ERR

    return rv

class SeleneBuild
    new: (src) =>
        -- Instantiate a new build of the directory
        -- given in src

        @src = src



    build_file: (path) =>
        -- Build a .moon file. Called as a callback by the
        -- directory traversal. Returns OK on success, ERR on failure
        rv = OK
        if path\match("^.+%.moon$")
            fd = io.popen("moonc #{path}")
            output = fd\read("*a")

            status = fd\close()
            if not status 
                print "Error building #{path}"
                print output
                rv = ERR
        return rv

    clean_file: (path) =>
        -- Clean a .lua file. Called as a callback by the
        -- directory traversal. Returns OK on success, and cannot fail
        if path\match("^.+%.lua$") and not path\match("conf.lua") and not path\match("main.lua")
            os.remove(path)
            print "Removed #{path}"

        return OK

    dist_file: (path) =>
        -- Clean a .moon file. Called as a callback by the
        -- directory traversal. Returns OK on success, and cannot fail

        if path\match("^.+%.moon$")
            os.remove(path)
            print "Removed #{path}"

        return OK

    delete_all: (path) =>
        -- Delete a file or directory. Called as a callback by the
        -- directory traversal. Returns OK on success, and cannot fail

        if lfs.attributes(path, "mode") == "directory"
            for entry in lfs.dir(path)
                print "Removing #{path}/#{entry}"
                os.remove("#{path}/#{entry}")
            print "Removing #{path}"
            os.remove(path)
        else
            print "Removing #{path}"
            os.remove(path)

        return OK

    build: () =>
        -- Run the build. Returns the status of the build

        return traverse(@\build_file, @src, false)

    clean: () =>
        -- Clean the source directory of build files. Returns the status of the clean

        return traverse(@\clean_file, @src, false)

    dist: (yes) =>
        -- Build for distribution by building lua files and removing moonscript files.

        rv = OK

        -- Prompt for y/n, this is a dangerous operation

        git_status = io.popen("git status -s")
        if git_status\read("*a") != "" and not yes
            print "Git tree is dirty. Commit changes and commit/remove untracked files or use the --yes flag"
            print "Maybe you forgot to run 'build.moon -c'"
            rv = ERR
            return rv
        git_status\close()

        rv = @\build!

        if rv == ERR
            print "Build errors occured. Aborting."
            return rv


        answer = "n"
        if yes
            answer = "y"
        else
            io.write "Building distribution. Are you want to remove all moonscript files? (y/n) "
            answer = io.read()

        if answer == "y" or yes
            rv = traverse(@\dist_file, @src, false)

            for file, blocklist in pairs BLOCKLIST_LINES
                print "Removing blocklist lines from #{file}"

                file_h = io.open(file, "r")
                content = file_h\read("*a")
                file_h\close()

                for _, line in ipairs blocklist
                    content = content\gsub(line, "")

                file_h = io.open(file, "w")
                file_h\write(content)
                file_h\close()

            -- Kind of a workaround for now, just call it twice to clean up dirs after
            -- All files are deleted
            traverse(@\delete_all, "lib/lulpeg", true)
            traverse(@\delete_all, "lib/lulpeg", true)
            lfs.rmdir("lib/lulpeg")
            traverse(@\delete_all, "lib/moonscript", true)
            traverse(@\delete_all, "lib/moonscript", true)
            lfs.rmdir("lib/moonscript")
            
        else
            print "Aborting: '#{answer}' is not y"
            rv = ERR
        
        return rv

    test: (patterns, verbose) =>
        rv = OK
        for _, pattern in ipairs patterns
            print("Running tests with pattern #{pattern}")
            result = io.popen("busted -p #{pattern} #{@src}")
            output = result\read("*a")
            status = result\close!
            if not status
                rv = ERR
            if not status or verbose
                print(output)

        if rv == ERR
            print("Tests failed")
        else
            print("All tests passed")

        return rv


main = (arg) ->
    -- Create and run the build
    argparse = require("argparse")
    parser = argparse("build", "Build a Selene project")
    parser\argument("src", "Source directory")
    parser\flag("-c --clean", "Clean the build directory (remove lua build files)")
    parser\flag("-d --dist", "Build a distribution and remove all moonscript files after building")
    parser\flag("-y --yes", "Answer yes to all prompts. THIS MAY BE DANGEROUS!")
    parser\flag("-t --test", "Run tests")
    parser\flag("-v --verbose", "Run tests")
    parser\option("-p --pattern", "Pattern(s) to use to search for test files")\args("+")\default("Test.+%.moon")\defmode("u")
    args = parser\parse(arg)

    if #arg < 1
        print "Usage: selene <srcdir>"
        return

    build = SeleneBuild(args["src"])

    rv = OK

    if args["test"]
        rv = build\test(args["pattern"], args["verbose"])
    elseif args["clean"]
        rv = build\clean!
    elseif args["dist"]
        rv = build\dist(args["yes"])
    else
        rv = build\build!

    return rv

os.exit(main(arg))
