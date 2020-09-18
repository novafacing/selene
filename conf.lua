package.path = package.path .. ";./moonscript/?.lua"
package.path = package.path .. ";./lulpeg/?.lua"

function love.conf(t)
    require("moonscript.moonscript")
end
