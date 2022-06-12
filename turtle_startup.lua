require("lib")
require("math_lib")
require("wireless_turtle_lib")
require("turtle_sm")

local delta = 0.1

while true do
    print(x_main_state, x_calibrate_state, x_goto_state)
    x_main(delta)
    sleep(delta)
end

