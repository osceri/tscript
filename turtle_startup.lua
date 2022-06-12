require("lib")
require("math2_lib")

local modem = peripheral.find("modem") or error("No modem connected")
modem.open(9999)

local pos = {}

function get_location()
    local event, side, channel, reply_channel, message, distance
    modem.transmit(10000, 9999, "ping")

    positions = {}
    distances = {}
    for i = 1,9 do
        event, side, channel, reply_channel, message, distance = os.pullEvent("modem_message")
        position, _ = parse_location(message)
        positions[3*i - 2] = position[1]
        positions[3*i - 1] = position[2]
        positions[3*i - 0] = position[3]
        distances[i] = distance
    end
    position, success = multilaterate(matrix(9, 3, positions), matrix(9, 1, distances))
    print("new:")
    print(repr(positions))
    print(repr(distances))
    print(repr(position), success)
end

while true do
    for i=1,5 do
        get_location()
        turtle.forward()
    end
    turtle.turnLeft()
end
