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

local modem_0 = peripheral.find("modem_0") or error("No modem_0 connected")
local modem_1 = peripheral.find("modem_1") or error("No modem_1 connected")
local modem_2 = peripheral.find("modem_2") or error("No modem_2 connected")
local modem_3 = peripheral.find("modem_3") or error("No modem_3 connected")
local modem_4 = peripheral.find("modem_4") or error("No modem_4 connected")

modem_0.open(999)
modem_1.open(999)
modem_2.open(999)
modem_3.open(999)
modem_4.open(999)

while true do
    ytps()
end