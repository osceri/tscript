require("lib")
require("math_lib")
require("wireless_turtle_lib")
require("turtle_sm")

local delta = 0.1

while true do
    print(repr_vec(position))
    print(repr_vec(x_internal_destination))
    print(repr_vec(x_internal_home))
    x_main(delta)
    sleep(delta)
end

