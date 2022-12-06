require("src.Player")

{
    graphics: lg,
    keyboard: lk,
    mouse: lm,
    audio: la,
    event: le
} = love

export class Game
    new: () =>
        -- Instantiate a new game. For now, we just have a player
        -- and that's it!
        @player = Player!

    keypressed: (key, scancode, isrepeat) ->
        -- Called when a key is pressed. We will check for keypresses in
        -- our player's update function for movement, so this just serves
        -- as a way to quit the game.
        if key == "escape"
            le.quit!
    
    update: (dt) =>
        -- Update the game. This is called at a time delta of dt, which
        -- is the time since the last update
        @player\update(dt)

    draw: (dt) =>
        -- Draw the game. This is called at a time delta of dt, which
        -- is the time since the last draw
        @player\draw(dt)
