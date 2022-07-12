{
    graphics: lg,
    keyboard: lk,
    mouse: lm,
    audio: la,
    event: le,
    window: lw
} = love

SCREEN_WIDTH = 800
SCREEN_HEIGHT = 480

demo = nil

love.load = () ->
    require("src.demo")
    demo = DemoClass(SCREEN_WIDTH, SCREEN_HEIGHT)
    lw.setMode(SCREEN_WIDTH, SCREEN_HEIGHT, {})

love.keypressed = (key, scancode, isrepeat) ->
    if key == "escape"
        le.quit!

love.update = (dt) ->
    dx = 0
    dy = 0
    if lk.isDown("up")
        dy -= 1
    if lk.isDown("down")
        dy += 1
    if lk.isDown("left")
        dx -= 1
    if lk.isDown("right")
        dx += 1
    demo\move(dx, dy)

love.draw = (dt) ->
    lg.clear(0, 0.6, 0.8)
    demo\draw!
