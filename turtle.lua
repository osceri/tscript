require("lua")

local modem = peripheral.find("modem") or error("No modem connected")
modem.open(9999)

local pos = {}

function get_location()
    local event, side, channel, reply_channel, message, distance
    while true do
        event, side, channel, reply_channel, message, distance = os.pullEvent("modem_message")
        x, _ = parse_location(message)
        print(x[1], x[2], x[3], distance)
    end
end

get_location()