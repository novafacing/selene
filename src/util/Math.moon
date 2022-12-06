export clamp

clamp = (value, min, max) ->
    -- clamp a value between min and max
    -- @param value: the value to clamp
    -- @param min: the minimum value
    -- @param max: the maximum value
    return math.max(min, math.min(max, value))
