shell.run("wget https://github.com/osceri/tscript/raw/main/t5")
shell.run("wget https://github.com/osceri/tscript/raw/main/t8")
require("t5")
require("t8")

local x_work = 5
local y_work = 5
local z_work = 0

local shaft_size = 4

function go_retire()
  x, y, z = get_location()
  movex(x_work - x)
  movey(y_work - y)
  minez(1-z)
end

function go_work()
  x, y, z = get_location()
  movex(x_work - x)
  movey(y_work - y)
  movez(z_work - z)
end

function go_home()
  x, y, z = get_location()
  movez(-z)
  movey(-y)
  movex(-x)
end

function shaft(N)
  local sign = 1
  local n = 0
  
  local dx = 0
  local dy = 0
  
  while n < N do
    n = n + 1
    minex(sign*n)
    miney(sign*n)
    dx = dx + sign*n
    dy = dy + sign*n
    sign = -sign
  end
  minex(sign*n)
  dx = dx + sign*n
  
  movey(-dy)
  movex(-dx)
end
  
function work()
  minez(-1)
  shaft(shaft_size)
  z_work = z_work - 1
  
  if z_work < -120 then
    return true
  else
    return false
  end
end

function repl_count_func()
  return turtle.getFuelLevel()
end

function repl_action_func()
  go_home()
  return turtle.refuel(1)
end

function coal_count_func()
  turtle.select(1)
  return turtle.getItemCount()
end

function coal_action_func()
  go_home()
  set_orientation(1)
  return turtle.suck(4)
end

function inventory_count_func()
  local slot = 0
  for i = 2,16 do
    turtle.select(i)
    if turtle.getItemCount() < 1 then
      slot = slot + 1
    end
  end
  return slot
end

function inventory_action_func()
  go_home()
  set_orientation(2)
  for i = 2,16 do
    turtle.select(i)
    turtle.drop()
  end
  return true
end

function get_good()
  print("Levels:")
  inv_good = level_check("inventory", inventory_count_func, inventory_action_func, 2, 15)
  coal_good = level_check("coal", coal_count_func, coal_action_func, 8, 16)
  fuel_good = level_check("fuel", repl_count_func, repl_action_func, 500, 100)
  print("")
  return inv_good and coal_good and fuel_good 
end

good_next = false

while true do
  good_prev = good_next
  good_next = get_good()
  
  if not(good_next) and good_prev then
    go_home()
  end
  if good_next and not(good_prev) then
    go_work()
  end
  
  if good_next then
    finished = work()
  else
    print("Attempting fix(es):")
    level_fix(" - inventory", inventory_count_func, inventory_action_func, 2, 15)
    level_fix(" - coal", coal_count_func, coal_action_func, 8, 16)
    level_fix(" - fuel", repl_count_func, repl_action_func, 500, 1000)
    print("")
  end
  
  if finished then
    go_retire()
    break
  end
end
