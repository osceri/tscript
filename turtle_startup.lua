require("lib")
require("math_lib")

local modem = peripheral.find("modem") or error("No modem connected")
modem.open(9999)

function get_location()
    local event, side, channel, reply_channel, message, distance
    modem.transmit(10000, 9999, "ping")

    local d = {}
    local x = {}

    while true do
        event, side, channel, reply_channel, message, distance = os.pullEvent("modem_message")
        d[message] = distance
        if d['x'] and d['y'] and d['z'] and d['o'] then
            x = quad(2, d)
        end
    end

    return x
end

while true do
    for i=1,5 do
        get_location()
        turtle.forward()
    end
    turtle.turnLeft()
end
