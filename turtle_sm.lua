x_internal_size = {}
for i = 1,3 do
  x_internal_size[i] = 0
end

x_internal_done = 0

x_internal_home = {}
for i = 1,3 do
  x_internal_home[i] = 0
end

x_internal_cursor = 0

x_internal_work = {}
for i = 1,3 do
  x_internal_work[i] = 0
end

x_internal_destination = {}
for i = 1,3 do
  x_internal_destination[i] = 0
end


X_BUILD_ = "X_BUILD_"
X_BUILD_BUILD = "X_BUILD_BUILD"
X_BUILD_BUILD1 = "X_BUILD_BUILD1"
X_BUILD_BUILD2 = "X_BUILD_BUILD2"
X_BUILD_BUILD3 = "X_BUILD_BUILD3"
X_BUILD_HOME = "X_BUILD_HOME"
X_BUILD_INIT = "X_BUILD_INIT"
X_BUILD_NO_FUEL = "X_BUILD_NO_FUEL"
X_BUILD_REFILL = "X_BUILD_REFILL"
X_BUILD_WORK = "X_BUILD_WORK"

X_CALIBRATE_ = "X_CALIBRATE_"
X_CALIBRATE_END = "X_CALIBRATE_END"
X_CALIBRATE_GOTO = "X_CALIBRATE_GOTO"
X_CALIBRATE_INIT = "X_CALIBRATE_INIT"

X_GOTO_ = "X_GOTO_"
X_GOTO_DOWN = "X_GOTO_DOWN"
X_GOTO_EAST = "X_GOTO_EAST"
X_GOTO_INIT = "X_GOTO_INIT"
X_GOTO_MOVE = "X_GOTO_MOVE"
X_GOTO_NORTH = "X_GOTO_NORTH"
X_GOTO_SOUTH = "X_GOTO_SOUTH"
X_GOTO_UP = "X_GOTO_UP"
X_GOTO_WEST = "X_GOTO_WEST"

X_HOME_ = "X_HOME_"
X_HOME_END = "X_HOME_END"
X_HOME_GOTO = "X_HOME_GOTO"
X_HOME_GOTO1 = "X_HOME_GOTO1"
X_HOME_INIT = "X_HOME_INIT"

X_MAIN_ = "X_MAIN_"
X_MAIN_BUILD = "X_MAIN_BUILD"
X_MAIN_CAL = "X_MAIN_CAL"
X_MAIN_DONE = "X_MAIN_DONE"
X_MAIN_INIT = "X_MAIN_INIT"

X_WORK_ = "X_WORK_"
X_WORK_END = "X_WORK_END"
X_WORK_GOTO = "X_WORK_GOTO"
X_WORK_GOTO1 = "X_WORK_GOTO1"
X_WORK_INIT = "X_WORK_INIT"

x_build_state = X_BUILD_

x_calibrate_state = X_CALIBRATE_

x_goto_state = X_GOTO_

x_home_state = X_HOME_

x_main_state = X_MAIN_

x_work_state = X_WORK_

x_build_timer = 0.

x_calibrate_timer = 0.

x_goto_timer = 0.

x_home_timer = 0.

x_main_timer = 0.

x_work_timer = 0.

function x_build(delta)
   function before(time) 
       return x_build_timer < time
   end
   function after(time)
       return time < x_build_timer
   end
   if x_build_state == X_BUILD_ then
       if 1 then
           x_build_state = X_BUILD_INIT
           x_build_timer = 0
           return
       end
       return
   end
   if x_build_state == X_BUILD_BUILD then
       if x_internal_work[2] == x_internal_home[2] then
           x_internal_cursor = x_internal_cursor + 1
           x_build_state = X_BUILD_BUILD1
           x_build_timer = 0
           return
       end
       if 1 then
           turtle.placeDown()
           x_internal_work[2] = x_internal_work[2] + 1
           x_build_state = X_BUILD_INIT
           x_build_timer = 0
           return
       end
       if 1 then
           x_build_timer = x_build_timer + delta
       end
       return
   end
   if x_build_state == X_BUILD_BUILD1 then
       if 0 == (x_internal_cursor % x_internal_size[1]) then
           x_internal_work[3] = x_internal_work[3] + 1
           x_internal_work[1] = x_internal_home[1]
           x_internal_work[2] = x_internal_home[2] - x_internal_size[2]
           x_build_state = X_BUILD_BUILD2
           x_build_timer = 0
           return
       end
       if 1 then
           x_internal_work[1] = x_internal_work[1] + 1
           x_internal_work[2] = x_internal_home[2] - x_internal_size[2]
           x_build_state = X_BUILD_BUILD3
           x_build_timer = 0
           return
       end
       if 1 then
           x_build_timer = x_build_timer + delta
       end
       return
   end
   if x_build_state == X_BUILD_BUILD2 then
       if 1 then
           x_build_state = X_BUILD_INIT
           x_build_timer = 0
           return
       end
       if 1 then
           x_build_timer = x_build_timer + delta
       end
       return
   end
   if x_build_state == X_BUILD_BUILD3 then
       if 1 then
           x_build_state = X_BUILD_BUILD2
           x_build_timer = 0
           return
       end
       if 1 then
           x_build_timer = x_build_timer + delta
       end
       return
   end
   if x_build_state == X_BUILD_HOME then
       if eq(position, x_internal_home) then
           set_orientation('N')
           x_home_state = X_HOME_
           x_build_state = X_BUILD_REFILL
           x_build_timer = 0
           return
       end
       if 1 then
           x_home(delta)
           x_build_timer = x_build_timer + delta
       end
       return
   end
   if x_build_state == X_BUILD_INIT then
       if turtle.getFuelLevel() < 1000 then
           turtle.select(1)
           turtle.refuel(1000)
           x_build_state = X_BUILD_NO_FUEL
           x_build_timer = 0
           return
       end
       if inventory_empty() then
           x_build_state = X_BUILD_HOME
           x_build_timer = 0
           return
       end
       if 1 then
           x_build_state = X_BUILD_WORK
           x_build_timer = 0
           return
       end
       if 1 then
           x_build_timer = x_build_timer + delta
       end
       return
   end
   if x_build_state == X_BUILD_NO_FUEL then
       if (turtle.getFuelLevel() < 1000)and (turtle.getItemCount(1) < 1) then
           x_build_state = X_BUILD_HOME
           x_build_timer = 0
           return
       end
       if 1 then
           x_build_state = X_BUILD_INIT
           x_build_timer = 0
           return
       end
       if 1 then
           x_build_timer = x_build_timer + delta
       end
       return
   end
   if x_build_state == X_BUILD_REFILL then
       if 1 then
           x_build_timer = x_build_timer + delta
       end
       return
   end
   if x_build_state == X_BUILD_WORK then
       if eq(position, x_internal_work) then
           x_work_state = X_WORK_
           x_build_state = X_BUILD_BUILD
           x_build_timer = 0
           return
       end
       if 1 then
           x_work(delta)
           x_build_timer = x_build_timer + delta
       end
       return
   end
end

function x_calibrate(delta)
   function before(time) 
       return x_calibrate_timer < time
   end
   function after(time)
       return time < x_calibrate_timer
   end
   if x_calibrate_state == X_CALIBRATE_ then
       if 1 then
           x_calibrate_state = X_CALIBRATE_INIT
           x_calibrate_timer = 0
           return
       end
       return
   end
   if x_calibrate_state == X_CALIBRATE_END then
       if 1 then
           x_calibrate_timer = x_calibrate_timer + delta
       end
       return
   end
   if x_calibrate_state == X_CALIBRATE_GOTO then
       if eq(position, x_internal_destination) then
           calibrate()
           x_goto_state = X_GOTO_
           x_calibrate_state = X_CALIBRATE_END
           x_calibrate_timer = 0
           return
       end
       if 1 then
           x_goto(delta)
           x_calibrate_timer = x_calibrate_timer + delta
       end
       return
   end
   if x_calibrate_state == X_CALIBRATE_INIT then
       if 1 then
           x_internal_destination = position
           x_internal_destination[2] = x_internal_home[2]
           x_calibrate_state = X_CALIBRATE_GOTO
           x_calibrate_timer = 0
           return
       end
       if 1 then
           x_calibrate_timer = x_calibrate_timer + delta
       end
       return
   end
end

function x_goto(delta)
   function before(time) 
       return x_goto_timer < time
   end
   function after(time)
       return time < x_goto_timer
   end
   if x_goto_state == X_GOTO_ then
       if 1 then
           x_goto_state = X_GOTO_INIT
           x_goto_timer = 0
           return
       end
       return
   end
   if x_goto_state == X_GOTO_DOWN then
       if 1 then
           x_goto_state = X_GOTO_INIT
           x_goto_timer = 0
           return
       end
       if 1 then
           x_goto_timer = x_goto_timer + delta
       end
       return
   end
   if x_goto_state == X_GOTO_EAST then
       if 1 then
           x_goto_state = X_GOTO_INIT
           x_goto_timer = 0
           return
       end
       if 1 then
           x_goto_timer = x_goto_timer + delta
       end
       return
   end
   if x_goto_state == X_GOTO_INIT then
       if 1 then
           get_location()
           x_goto_state = X_GOTO_MOVE
           x_goto_timer = 0
           return
       end
       if 1 then
           x_goto_timer = x_goto_timer + delta
       end
       return
   end
   if x_goto_state == X_GOTO_MOVE then
       if x_internal_destination[2]>position[2] then
           move('U')
           x_goto_state = X_GOTO_UP
           x_goto_timer = 0
           return
       end
       if x_internal_destination[2]<position[2] then
           move('D')
           x_goto_state = X_GOTO_DOWN
           x_goto_timer = 0
           return
       end
       if x_internal_destination[1]<position[1] then
           move('W')
           x_goto_state = X_GOTO_WEST
           x_goto_timer = 0
           return
       end
       if x_internal_destination[1]>position[1] then
           move('E')
           x_goto_state = X_GOTO_EAST
           x_goto_timer = 0
           return
       end
       if x_internal_destination[3]>position[3] then
           move('S')
           x_goto_state = X_GOTO_SOUTH
           x_goto_timer = 0
           return
       end
       if x_internal_destination[3]<position[3] then
           move('N')
           x_goto_state = X_GOTO_NORTH
           x_goto_timer = 0
           return
       end
       if 1 then
           x_goto_timer = x_goto_timer + delta
       end
       return
   end
   if x_goto_state == X_GOTO_NORTH then
       if 1 then
           x_goto_state = X_GOTO_INIT
           x_goto_timer = 0
           return
       end
       if 1 then
           x_goto_timer = x_goto_timer + delta
       end
       return
   end
   if x_goto_state == X_GOTO_SOUTH then
       if 1 then
           x_goto_state = X_GOTO_INIT
           x_goto_timer = 0
           return
       end
       if 1 then
           x_goto_timer = x_goto_timer + delta
       end
       return
   end
   if x_goto_state == X_GOTO_UP then
       if 1 then
           x_goto_state = X_GOTO_INIT
           x_goto_timer = 0
           return
       end
       if 1 then
           x_goto_timer = x_goto_timer + delta
       end
       return
   end
   if x_goto_state == X_GOTO_WEST then
       if 1 then
           x_goto_state = X_GOTO_INIT
           x_goto_timer = 0
           return
       end
       if 1 then
           x_goto_timer = x_goto_timer + delta
       end
       return
   end
end

function x_home(delta)
   function before(time) 
       return x_home_timer < time
   end
   function after(time)
       return time < x_home_timer
   end
   if x_home_state == X_HOME_ then
       if 1 then
           x_home_state = X_HOME_INIT
           x_home_timer = 0
           return
       end
       return
   end
   if x_home_state == X_HOME_END then
       if 1 then
           x_home_timer = x_home_timer + delta
       end
       return
   end
   if x_home_state == X_HOME_GOTO then
       if eq(position, x_internal_destination) then
           x_internal_destination = x_internal_home
           x_home_state = X_HOME_GOTO1
           x_home_timer = 0
           return
       end
       if 1 then
           x_home_timer = x_home_timer + delta
       end
       return
   end
   if x_home_state == X_HOME_GOTO1 then
       if eq(position, x_internal_destination) then
           x_home_state = X_HOME_END
           x_home_timer = 0
           return
       end
       if 1 then
           x_home_timer = x_home_timer + delta
       end
       return
   end
   if x_home_state == X_HOME_INIT then
       if 1 then
           x_internal_destination = position
           x_internal_destination[2] = x_internal_home[2]
           x_home_state = X_HOME_GOTO
           x_home_timer = 0
           return
       end
       if 1 then
           x_home_timer = x_home_timer + delta
       end
       return
   end
end

function x_main(delta)
   function before(time) 
       return x_main_timer < time
   end
   function after(time)
       return time < x_main_timer
   end
   if x_main_state == X_MAIN_ then
       if 1 then
           x_main_state = X_MAIN_INIT
           x_main_timer = 0
           return
       end
       return
   end
   if x_main_state == X_MAIN_BUILD then
       if x_internal_done then
           x_build_state = X_BUILD_
           x_main_state = X_MAIN_DONE
           x_main_timer = 0
           return
       end
       if 1 then
           x_build(delta)
           x_main_timer = x_main_timer + delta
       end
       return
   end
   if x_main_state == X_MAIN_CAL then
       if calibrated then
           x_calibrate_state = X_CALIBRATE_
           x_main_state = X_MAIN_BUILD
           x_main_timer = 0
           return
       end
       if 1 then
           x_calibrate(delta)
           x_main_timer = x_main_timer + delta
       end
       return
   end
   if x_main_state == X_MAIN_DONE then
       if 1 then
           x_main_timer = x_main_timer + delta
       end
       return
   end
   if x_main_state == X_MAIN_INIT then
       if 1 then
           x_internal_done = 0
           x_internal_home = { 40, 40, 40 }
           x_internal_size = { 3, 3, 3 }
           x_internal_cursor = {0, 0, 0, 0}
           x_internal_destination = { -1, -1, -1 }
           position = get_location()
           x_main_state = X_MAIN_CAL
           x_main_timer = 0
           return
       end
       if 1 then
           x_main_timer = x_main_timer + delta
       end
       return
   end
end

function x_work(delta)
   function before(time) 
       return x_work_timer < time
   end
   function after(time)
       return time < x_work_timer
   end
   if x_work_state == X_WORK_ then
       if 1 then
           x_work_state = X_WORK_INIT
           x_work_timer = 0
           return
       end
       return
   end
   if x_work_state == X_WORK_END then
       if 1 then
           x_work_timer = x_work_timer + delta
       end
       return
   end
   if x_work_state == X_WORK_GOTO then
       if eq(position, x_internal_destination) then
           x_internal_destination = x_internal_work
           x_internal_destination[2] = x_internal_home[2]
           x_work_state = X_WORK_GOTO1
           x_work_timer = 0
           return
       end
       if 1 then
           x_work_timer = x_work_timer + delta
       end
       return
   end
   if x_work_state == X_WORK_GOTO1 then
       if eq(position, x_internal_destination) then
           x_internal_destination = x_internal_work
           x_work_state = X_WORK_END
           x_work_timer = 0
           return
       end
       if 1 then
           x_work_timer = x_work_timer + delta
       end
       return
   end
   if x_work_state == X_WORK_INIT then
       if 1 then
           x_internal_destination = position
           x_internal_destination[2] = x_internal_home[2]
           x_work_state = X_WORK_GOTO
           x_work_timer = 0
           return
       end
       if 1 then
           x_work_timer = x_work_timer + delta
       end
       return
   end
end

