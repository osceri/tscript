require("lib")

function tps(time_out)
    local event, side, channel, reply_channel, message, distance

    os.startTimer(time_out)
    event, side, channel, reply_channel, message, distance = os.pullEvent()

    if event == "modem_message" then
        print(message)
    else
        print(".")
    end
end

function ytps()
    local event, side, channel, reply_channel, message, distance

    event, side, channel, reply_channel, message, distance = os.pullEvent()
    print(side, distance)
end

-- except modem to be attached to modem_0, modem_1 ... modem_4
local modem = peripheral.find("modem") or error("No modem connected")

modem.callRemote("modem_0", "open", 999)
modem.callRemote("modem_1", "open", 999)
modem.callRemote("modem_2", "open", 999)
modem.callRemote("modem_3", "open", 999)
modem.callRemote("modem_4", "open", 999)

while true do
    ytps()
end