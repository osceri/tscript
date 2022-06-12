require("lib")
require("math_lib")

function save_state(file_name, str)
    local file = io.open(file_name, "w")
    io.output(file)
    io.write(str)
    io.close(file)
end

function load_state(file_name)
    local file = io.open(file_name, "r")
    str = io.read()
    io.close(file)
end


state = load_state("state")

if not(state) then
    print("!")
    
end

