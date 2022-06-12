require("lib")

function tps(time_out)
    local event, side, channel, reply_channel, message, distance

    os.startTimer(time_out)
    event = {}

    while true do
        event, side, channel, reply_channel, message, distance = os.pullEvent()
        if event ~= "timer" then
            print(message, distance)
        else
            break
        end
    end
end

local modem = peripheral.find("modem") or error("No modem connected")

modem.open(1000)

while true do
    modem.transmit(999, 1000, "ping")
    tps(2)
end