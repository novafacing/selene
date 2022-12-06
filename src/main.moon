{
    graphics: lg,
    keyboard: lk,
    mouse: lm,
    audio: la,
    event: le,
    window: lw
} = love

game = nil

love.load = () ->
    -- Called when the game is loaded
    require("src.Game")
    game = Game!

love.keypressed = (key, scancode, isrepeat) ->
    -- Called when a key is pressed
    game\keypressed(key, scancode, isrepeat)

love.update = (dt) ->
    -- Called every update interval
    game\update(dt)

love.draw = (dt) ->
    -- Called every draw interval
    game\draw(dt)
