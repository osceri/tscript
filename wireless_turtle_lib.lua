local orientation_map = {}
orientation_map['E'] = { 1, 0, 0 }
orientation_map['W'] = { -1, 0, 0 }
orientation_map['S'] = { 0, 1, 0 }
orientation_map['N'] = { 0, -1, 0 }

calibrated = false
position = { 0, 0, 0 }
orientation = 'N'

-- hopes; to retrieve the current location
-- gives; current location: table[3]
function get_location()
    if not(modem) then
        modem = peripheral.find("modem") or error("No modem connected")
        modem.open(9999)
    end

    local event, side, channel, reply_channel, message, distance
    modem.transmit(10000, 9999, "ping")

    local d = {}

    while true do
        event, side, channel, reply_channel, message, distance = os.pullEvent("modem_message")
        d[message] = distance
        if d['x'] and d['y'] and d['z'] and d['o'] then
            position = quad(2, d)
            break
        end
    end

    position[1] = position[1] + 0.5
    position[2] = position[2] + 0.5
    position[3] = position[3] + 0.5

    return position
end

-- hopes; calibrates the device
function calibrate()
    local x1 = get_location()
    turtle.forward()
    local x2 = get_location()
    turtle.back()

    if x2[1] > x1[1] then
        orientation = 'E'
        calibrated = true
        return
    end
    if x2[1] < x1[1] then
        orientation = 'W'
        calibrated = true
        return
    end
    if x2[3] > x1[3] then
        orientation = 'S'
        calibrated = true
        return
    end
    if x2[3] < x1[3] then
        orientation = 'N'
        calibrated = true
        return
    end
end

function set_orientation(direction)
    if orientation == 'E' then
        if direction == 'S' then
            turtle.turnLeft()
            orientation = direction
            return
        end
        if direction == 'W' then
            turtle.turnLeft()
            turtle.turnLeft()
            orientation = direction
            return
        end
        if direction == 'N' then
            turtle.turnRight()
            orientation = direction
            return
        end
    end
    if orientation == 'S' then
        if direction == 'E' then
            turtle.turnRight()
            orientation = direction
            return
        end
        if direction == 'W' then
            turtle.turnLeft()
            orientation = direction
            return
        end
        if direction == 'N' then
            turtle.turnLeft()
            turtle.turnLeft()
            orientation = direction
            return
        end
    end
    if orientation == 'W' then
        if direction == 'E' then
            turtle.turnLeft()
            turtle.turnLeft()
            orientation = direction
            return
        end
        if direction == 'S' then
            turtle.turnRight()
            orientation = direction
            return
        end
        if direction == 'N' then
            turtle.turnLeft()
            orientation = direction
            return
        end
    end
    if orientation == 'N' then
        if direction == 'E' then
            turtle.turnLeft()
            orientation = direction
            return
        end
        if direction == 'S' then
            turtle.turnLeft()
            turtle.turnLeft()
            orientation = direction
            return
        end
        if direction == 'W' then
            turtle.turnRight()
            orientation = direction
            return
        end
    end
end

-- Choose N, E, S, W, U, D
function move(direction) 
    if direction == 'N' then
        set_orientation('N')
        turtle.forward()
    elseif direction == 'E' then
        set_orientation('E')
        turtle.forward()
    elseif direction == 'S' then
        set_orientation('S')
        turtle.forward()
    elseif direction == 'W' then
        set_orientation('W')
        turtle.forward()
    elseif direction == 'U' then
        turtle.up()
    elseif direction == 'D' then
        turtle.down()
    end
end

function inventory_empty()
    return false
end