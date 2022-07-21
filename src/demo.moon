{
    graphics: lg,
    keyboard: lk,
    mouse: lm,
    audio: la,
    event: le
} = love

clamp = (val, lower, upper) ->
    return math.max(lower, math.min(upper, val))

export class DemoClass 
    new: (sw, sh) =>
        @x = 200
        @y = 100
        @sw = sw
        @sh = sh
        @speed = 4
        @image = lg.newImage("assets/moon.png")

    move: (dx, dy) =>
        @x += dx * @speed
        @y += dy * @speed
        iw, ih = @image\getDimensions!
        @x = clamp(@x, 0, @sw - iw)
        @y = clamp(@y, 0, @sh - ih)

    draw: () =>
        lg.draw(@image, @x, @y)
