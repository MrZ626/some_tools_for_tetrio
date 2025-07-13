-- Usage: lua comp.lua inputFile [outputFile]

local f1, f2 = arg[1], arg[2] or "output.txt"

local f = io.open(f1, "r")
local o = io.open(f2, "w")

assert(f, "File not found: " .. f1)
assert(o, "Could not open output file: " .. f2)

while true do
    local line = f:read("*l")
    if not line then break end
    line = line:gsub("[%a_%$]", "z")
    o:write(line .. "\n")
end
