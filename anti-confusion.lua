-- Usage: lua comp.lua inputFile [outputFile]

local f1, f2 = assert(arg[1], "require input file"), arg[2] or "f" .. arg[1]

local f = io.open(f1, "r")
local o = io.open(f2, "w")

assert(f, "File not found: " .. f1)
assert(o, "Could not open output file: " .. f2)

while true do
    local line = f:read("*L")
    if not line then break end
    local p = 1
    while true do
        local s, e, cap = line:find("[^%w_%$]([%a_%$]+)[^%w_%$]", p)
        if not s then break end
        line = line:sub(1, s) .. (#cap > 2 and cap or #cap == 2 and "zz" or "z") .. line:sub(e)
        p = e
    end
    o:write(line)
end

f:close()
