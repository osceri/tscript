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

function ytps(modem)
    local event, side, channel, reply_channel, message, distance

    event, side, channel, reply_channel, message, distance = os.pullEvent()
    modem.callRemote("modem_0", "transmit", 1000, 999, "0")
    modem.callRemote("modem_1", "transmit", 1000, 999, "1")
    modem.callRemote("modem_2", "transmit", 1000, 999, "2")
    modem.callRemote("modem_3", "transmit", 1000, 999, "3")
    modem.callRemote("modem_4", "transmit", 1000, 999, "4")
end

-- except modem to be attached to modem_0, modem_1 ... modem_4
local modem = peripheral.find("modem") or error("No modem connected")

modem.callRemote("modem_0", "open", 999)

while true do
    print(os.time())
    ytps(modem)
end