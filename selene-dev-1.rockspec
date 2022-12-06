package = "selene"
version = "dev-1"
source = {
   url = "git+ssh://git@github.com/novafacing/selene.git"
}
description = {
   detailed = [[
Selene is a project template to quickly set up LOVE2D to run moonscript instead of Lua,
*without* precompiling your `.moon` files to `.lua`]],
   homepage = "https://github.com/novafacing/selene.git",
   license = "MIT"
}
dependencies = {
   "lua >= 5.2",
   "busted >= 2.0.0",
   "moonscript == dev-1",
   "luafilesystem >= 1.8.0",
   "argparse >= 0.7.1"
}
build = {
   type = "builtin",
   modules = {}
}
