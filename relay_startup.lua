location = "x: 0, y: 0, z: 0"
require("lib")

local modem = peripheral.find("modem") or error("No modem connected")


modem.open(10000)

local event, side, channel, reply_channel, message, distance
while true do
    event, side, channel, reply_channel, message, distance = os.pullEvent("modem_message")
    if message == "ping" then
        print("pinged!", os.time())
        modem.transmit(9999, 0, location)
    end
end