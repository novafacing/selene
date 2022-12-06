-- Selene Build Script
require("lfs")

class DirectoryTraversal 
    new: (func) =>
        -- Instantiate a new DirectoryTraversal that will apply a function to file paths
        -- recursively

        @func = func

    traverse: (path) =>
        -- Traverse a directory recursively and apply a function to files found

        traverse_stack = [ "#{path}/#{entry}" for entry in lfs.dir(path) ]
        seen = {}

        while #traverse_stack > 0
            entry = table.remove(traverse_stack)

            filename = entry\match("([^/]+)$")

            -- Skip builtin traversals
            if filename == "." or filename == ".."                
                continue

            -- If we have seen this entry before, skip it
            if #[e for _, e in ipairs seen when e == entry] != 0
                continue


            table.insert(seen, entry)

            -- Recurse on directories and call the callback on files
            if lfs.attributes(entry, "mode") == "directory"
                for sentry in lfs.dir(entry)
                    table.insert(traverse_stack, "#{entry}/#{sentry}")
            else
                    @func(entry)

class SeleneBuild
    new: (src) =>
        -- Instantiate a new build of the directory
        -- given in src

        @src = src

    build_file: (path) =>
        -- Build a .moon file. Called as a callback by the
        -- directory traversal
        if path\match("^.+%.moon$")
            fd = io.popen("moonc #{path}")
            fd\close()

    clean_file: (path) =>
        if path\match("^.+%.lua$")
            os.remove(path)
            print "Removed #{path}"

    dist_file: (path) =>
        if path\match("^.+%.moon$")
            os.remove(path)
            print "Removed #{path}"

    run: () =>
        -- Run the build

        traversal = DirectoryTraversal(@build_file)
        traversal\traverse(@src)

    clean: () =>
        traversal = DirectoryTraversal(@clean_file)
        traversal\traverse(@src)

    dist: (yes) =>
        -- Prompt for y/n, this is a dangerous operation
        io.write "Building distribution. Are you want to remove all moonscript files? (y/n) "
        answer = io.read()

        git_status = io.popen("git status -s")
        if git_status\read("*a") != "" and not yes
            print "Git tree is dirty. Commit your changes or use the --yes flag"
            return
        git_status\close()

        @\run!

        if answer == "y" or yes
            traversal = DirectoryTraversal(@dist_file)
            traversal\traverse(@src)

            conffile = io.open("conf.lua", "r")
            conf = conffile\read("*a")
            conffile\close()
            conf\gsub("require(\"lib.moonscript\")", "")
            conffile = io.open("conf.lua", "w")
            conffile\write(conf)
            conffile\close()
        else
            print "Aborting"
            return

    test: () =>
        io.popen("busted -P Test.+%.moon$ #{@src}")


main = (arg) ->
    -- Create and run the build
    argparse = require("argparse")
    parser = argparse("selenebuild", "Build a Selene project")
    parser\argument("src", "Source directory")
    parser\flag("-c --clean", "Clean the build directory (remove lua build files)")\args("?")
    parser\flag("-d --dist", "Build a distribution and remove all moonscript files after building")\args("?")
    parser\flag("-y --yes", "Answer yes to all prompts. THIS MAY BE DANGEROUS!")\args("?")
    parser\flag("-t --test", "Run tests")\args("?")
    args = parser\parse(arg)

    if #arg < 1
        print "Usage: selene <srcdir>"
        return

    build = SeleneBuild(args["src"])

    if args["test"]
        build\test!
    elseif args["clean"]
        build\clean!
    elseif args["dist"]
        build\dist(args["yes"])
    else
        build\run!

    return 0

main(arg)