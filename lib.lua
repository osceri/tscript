-- takes; a: float, b: float
-- gives; block a is block b: bool
function same_block(a, b)
    return math.floor(a) == math.floor(b)
end

-- takes; x: table[3], y: table[3]
-- gives; block x is block y: bool
function eq(x, y)
    return same_block(x[1], y[1]) and same_block(x[2], y[2]) and same_block(x[3], y[3])
end

-- takes; text like ("x y z", "x: x, y: y, z: z", etc): str
-- gives; location: table[3], indices: int
function parse_location(text)
    x = {}
    index = 0
    for integer in text:gmatch "-?%d+" do
        index = index + 1
        x[index] = tonumber(integer)
    end

    return x, index
end