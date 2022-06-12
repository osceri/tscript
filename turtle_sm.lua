x_internal_destination = {}
for i = 1,3 do
  x_internal_destination[i] = 0
end

x_internal_home = {}
for i = 1,3 do
  x_internal_home[i] = 0
end


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

X_MAIN_ = "X_MAIN_"
X_MAIN_CAL = "X_MAIN_CAL"
X_MAIN_DONE = "X_MAIN_DONE"
X_MAIN_INIT = "X_MAIN_INIT"

x_calibrate_state = X_CALIBRATE_

x_goto_state = X_GOTO_

x_main_state = X_MAIN_

x_calibrate_timer = 0.

x_goto_timer = 0.

x_main_timer = 0.

function x_calibrate(delta)
   function before(time) 
       return x_calibrate_timer < time
   end
   function after(time)
       return time < x_calibrate_timer
   end
   while x_calibrate_state == X_CALIBRATE_ do
       if 1 then
           x_calibrate_state = X_CALIBRATE_INIT
           x_calibrate_timer = 0
           break
       end
       break;
   end
   while x_calibrate_state == X_CALIBRATE_END do
       if 1 then
           x_calibrate_timer = x_calibrate_timer + delta
       end
       break;
   end
   while x_calibrate_state == X_CALIBRATE_GOTO do
       if eq(position, x_internal_destination) then
           calibrate()
           x_goto_state = X_GOTO_
           x_calibrate_state = X_CALIBRATE_END
           x_calibrate_timer = 0
           break
       end
       if 1 then
           x_goto(delta)
           x_calibrate_timer = x_calibrate_timer + delta
       end
       break;
   end
   while x_calibrate_state == X_CALIBRATE_INIT do
       if 1 then
           
x_internal_destination = get_location()
x_internal_destination[2] = x_internal_home[2]

           x_calibrate_state = X_CALIBRATE_GOTO
           x_calibrate_timer = 0
           break
       end
       if 1 then
           x_calibrate_timer = x_calibrate_timer + delta
       end
       break;
   end
end

function x_goto(delta)
   function before(time) 
       return x_goto_timer < time
   end
   function after(time)
       return time < x_goto_timer
   end
   while x_goto_state == X_GOTO_ do
       if 1 then
           x_goto_state = X_GOTO_INIT
           x_goto_timer = 0
           break
       end
       break;
   end
   while x_goto_state == X_GOTO_DOWN do
       if 1 then
           x_goto_state = X_GOTO_INIT
           x_goto_timer = 0
           break
       end
       if 1 then
           x_goto_timer = x_goto_timer + delta
       end
       break;
   end
   while x_goto_state == X_GOTO_EAST do
       if 1 then
           x_goto_state = X_GOTO_INIT
           x_goto_timer = 0
           break
       end
       if 1 then
           x_goto_timer = x_goto_timer + delta
       end
       break;
   end
   while x_goto_state == X_GOTO_INIT do
       if 1 then
           
get_location()

           x_goto_state = X_GOTO_MOVE
           x_goto_timer = 0
           break
       end
       if 1 then
           x_goto_timer = x_goto_timer + delta
       end
       break;
   end
   while x_goto_state == X_GOTO_MOVE do
       if x_internal_destination[2]>position[2] then
           move('U')
           x_goto_state = X_GOTO_UP
           x_goto_timer = 0
           break
       end
       if 
x_internal_destination[2]<position[2] then
           
move('D')

           x_goto_state = X_GOTO_DOWN
           x_goto_timer = 0
           break
       end
       if x_internal_destination[1]<position[1] then
           move('W')
           x_goto_state = X_GOTO_WEST
           x_goto_timer = 0
           break
       end
       if x_internal_destination[1]>position[1] then
           move('E')
           x_goto_state = X_GOTO_EAST
           x_goto_timer = 0
           break
       end
       if x_internal_destination[3]>position[3] then
           move('S')
           x_goto_state = X_GOTO_SOUTH
           x_goto_timer = 0
           break
       end
       if 
x_internal_destination[3]<position[3] then
           
move('N')

           x_goto_state = X_GOTO_NORTH
           x_goto_timer = 0
           break
       end
       if 1 then
           x_goto_timer = x_goto_timer + delta
       end
       break;
   end
   while x_goto_state == X_GOTO_NORTH do
       if 1 then
           x_goto_state = X_GOTO_INIT
           x_goto_timer = 0
           break
       end
       if 1 then
           x_goto_timer = x_goto_timer + delta
       end
       break;
   end
   while x_goto_state == X_GOTO_SOUTH do
       if 1 then
           x_goto_state = X_GOTO_INIT
           x_goto_timer = 0
           break
       end
       if 1 then
           x_goto_timer = x_goto_timer + delta
       end
       break;
   end
   while x_goto_state == X_GOTO_UP do
       if 1 then
           x_goto_state = X_GOTO_INIT
           x_goto_timer = 0
           break
       end
       if 1 then
           x_goto_timer = x_goto_timer + delta
       end
       break;
   end
   while x_goto_state == X_GOTO_WEST do
       if 1 then
           x_goto_state = X_GOTO_INIT
           x_goto_timer = 0
           break
       end
       if 1 then
           x_goto_timer = x_goto_timer + delta
       end
       break;
   end
end

function x_main(delta)
   function before(time) 
       return x_main_timer < time
   end
   function after(time)
       return time < x_main_timer
   end
   while x_main_state == X_MAIN_ do
       if 1 then
           x_main_state = X_MAIN_INIT
           x_main_timer = 0
           break
       end
       break;
   end
   while x_main_state == X_MAIN_CAL do
       if calibrated then
           x_calibrate_state = X_CALIBRATE_
           x_main_state = X_MAIN_DONE
           x_main_timer = 0
           break
       end
       if 1 then
           x_calibrate(delta)
           x_main_timer = x_main_timer + delta
       end
       break;
   end
   while x_main_state == X_MAIN_DONE do
       if 1 then
           x_main_timer = x_main_timer + delta
       end
       break;
   end
   while x_main_state == X_MAIN_INIT do
       if 1 then
           x_internal_home = { 40, 40, 40 }x_internal_destination = { -1, -1, -1 }position = get_location()
           x_main_state = X_MAIN_CAL
           x_main_timer = 0
           break
       end
       if 1 then
           x_main_timer = x_main_timer + delta
       end
       break;
   end
end

