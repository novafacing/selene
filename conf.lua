-- https://love2d.org/wiki/Config_Files
package.path = package.path .. ";./lib/moonscript/?.lua"
package.path = package.path .. ";./lib/lulpeg/?.lua"

function love.conf(t)
    require("lib.moonscript")
    t.console = true
    t.window.title = "My Selene Game"
    t.window.width = 800
    t.window.height = 480
end
