require("src.util.Vector2")

{
    graphics: lg,
    keyboard: lk,
} = love

export class Player
    new: () =>
        -- Instantiate a new player with default location
        -- Returns a new player instance

        @position = Vector2(lg.getWidth! / 2, lg.getHeight! / 2)
        -- The player's movement speed in each direction
        @speed = 500
        -- The player's sprite (moon!)
        @sprite = lg.newImage("assets/moon.png")
        -- The width and height of the sprite used for clamping
        @sprite_width, @sprite_height = @sprite\getDimensions!

    update: (dt) =>
        -- Update the player's position based on keyboard input
        -- Called every tick, where the time between ticks is variable
        -- @param dt The time delta since the last tick

        dir = Zero()

        -- These are opposite because the screen starts at the top left! You can
        -- change this by changing the Vector defaults or by changing your math,
        -- either one works.
        if lk.isDown("up")
            dir += Down()
        if lk.isDown("down")
            dir += Up()
        if lk.isDown("left")
            dir += Left()
        if lk.isDown("right")
            dir += Right()

        @\move(dir * dt)

    move: (dir) =>
        -- Move the player in the given direction
        --
        -- @param {Vector2} dir The vector sum of the keypressed directions to move in

        @position = @position + (dir * @speed)
        @position\clamp(0, 0, 
            lg.getWidth! - @sprite_width, lg.getHeight! - @sprite_height)

    draw: () =>
        -- Draw the player to the screen

        lg.draw(@sprite, @position.x, @position.y)
