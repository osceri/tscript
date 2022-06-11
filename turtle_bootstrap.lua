-- hopes; download the contents of a lua file on the internet and places it in a local file with a given name
-- takes; a local file name: str, an internet link: str
-- gives; nothing
function get_as(file_name, link)
    local request = http.get(link)
    local str = request.readAll()
    local file = io.open(file_name, "w")
    io.output(file)
    io.write(str)
    io.close(file)
end

-- Standard lib
get_as("lib.lua", "https://github.com/osceri/tscript/raw/main/lib.lua")
-- Math lib
get_as("math_lib.lua", "https://github.com/osceri/tscript/raw/main/math_lib.lua")
-- Code that should always run
get_as("startup.lua", "https://github.com/osceri/tscript/raw/main/turtle_startup.lua")
