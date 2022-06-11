require("lib")
require("math_lib")

local modem = peripheral.find("modem") or error("No modem connected")
modem.open(9999)

local pos = {}

function get_location()
    local event, side, channel, reply_channel, message, distance
    modem.transmit(10000, 9999, "ping")

    positions = {}
    distances = {}
    for i = 1,3 do
        event, side, channel, reply_channel, message, distance = os.pullEvent("modem_message")
        position, _ = parse_location(message)
        positions[i] = position
        distances[i] = distance
    end
    position, success = trilocate(positions[1], distances[1], positions[2], distances[2], positions[3], distances[3])
    print(repr_vec(position), success)
end

while true do
    for i=1,5 do
        get_location()
        turtle.forward()
    end
    turtle.turnLeft()
end
