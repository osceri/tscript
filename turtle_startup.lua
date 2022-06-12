require("lib")
require("math_lib")

while true do
    for i=1,5 do
        local x = get_location()
        print(x[1], x[2], x[3])
        turtle.forward()
    end
    turtle.turnLeft()
end
