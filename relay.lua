require("lib")

local modem = peripheral.find("modem") or error("No modem connected")

location = "x: 10, y: 10, z: 10"

modem.open(10000)

local event, side, channel, reply_channel, message, distance
while true do
    event, side, channel, reply_channel, message, distance = os.pullEvent("modem_message")
    if message == "ping" then
        print("pinged!", os.time())
        modem.transmit(9999, 0, location)
    end
end