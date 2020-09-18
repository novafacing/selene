{
    graphics: lg,
    keyboard: lk,
    mouse: lm,
    audio: la,
    event: le
} = love

love.load = () ->
    require("src.demo")
    t = DemoClass()
    print(t.val)

love.update = (dt) ->



