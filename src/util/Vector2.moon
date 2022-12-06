require("src.util.Math")

export ^

class Vector2
    new: (x, y) =>
        -- constructor
        -- Returns a new vector2 with the given x and y values
        -- @param: x The x value of the vector
        -- @param: y The y value of the vector
        @x = x
        @y = y

    __add: (o) =>
        -- + operator
        -- Returns the scalar sum of this vector with the vector2 o
        -- @param: o The other vector to add to this one
        Vector2(@x + o.x, @y + o.y)

    __sub: (o) =>
        -- - operator
        -- Returns the scalar difference of this vector minus the vector2 o
        -- @param: o The other vector to subtract from this one
        @ + -o

    __mul: (s) =>
        -- * operator
        -- Returns the scalar product of this vector with the scalar s
        -- @param: s The scalar to multiply this vector by
        -- 
        -- This method implements scalar multiplication because it is more common in 2D games,
        -- for the canonical 'multiplication' of vectors, see dot()
        Vector2(@x * s, @y * s)

    dot: (o) =>
        -- Dot product 
        -- Returns the dot product of this vector with another
        -- @param: o The other vector to dot with this vector
        @x * o.x + @y * o.y

    __unm: () =>
        -- unary - operator
        -- Returns the negation of this vector
        Vector2(-@x, -@y)

    __eq: (o) =>
        -- == operator
        -- Returns whether this vector is equal to another
        -- @param: o The other vector
        @x == o.x and @y == o.y

    __lt: (o) =>
        -- < operator
        -- Returns whether this vector is of a smaller magnitude than another
        -- @param: o The other vector to compare to this one
        #@ < #o

    __le: (o) =>
        -- <= operator
        -- Returns whether this vector is of lesser or equal magnitude than this one
        -- @param: o The other vector
        #@ < #o or #@ == #o

    magnitude: () =>
        math.sqrt((@x * @x) + (@y * @y))

    clamp: (minx, miny, maxx, maxy) =>
        -- Clamps the vector to the given bounds
        -- @param: minx The minimum x value
        -- @param: miny The minimum y value
        -- @param: maxx The maximum x value
        -- @param: maxy The maximum y value
        @x = clamp(@x, minx, maxx)
        @y = clamp(@y, miny, maxy)

    
Up = () ->
    Vector2(0, 1)
Left = () ->
    Vector2(-1, 0)
Unit = () ->
    Vector2(1, 1)
Right = () ->
    Vector2(1, 0)
Down = () ->
    Vector2(0, -1)
Zero = () ->
    Vector2(0, 0)