package.path = package.path .. ";./lib/moonscript/?.lua"
package.path = package.path .. ";./lib/lulpeg/?.lua"

function love.conf(t)
    require("lib.moonscript")
end
