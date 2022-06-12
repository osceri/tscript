require("lib")
require("math_lib")

while true do
    for i=1,5 do
        get_location()
        turtle.forward()
    end
    turtle.turnLeft()
end
