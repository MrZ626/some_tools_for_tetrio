-- Usage: lua comp.lua file1 file2 [<start #1>] [<start #2>] [<rows>]

local f1 = io.open(arg[1], "r")
local f2 = io.open(arg[2], "r")

local s1 = assert(tonumber(arg[3]), "expected an integer argument")
local s2 = assert(tonumber(arg[4]), "expected an integer argument")
local rows = tonumber(arg[5]) or 1e99

local o1 = io.open("out1.txt", "w")
local o2 = io.open("out2.txt", "w")

for _ = 1, s1 - 1 do f1:read("*l") end
for _ = 1, s2 - 1 do f2:read("*l") end

local diffCount=0

for i = 1, rows do
    local line1 = f1:read("*l")
    local line2 = f2:read("*l")
    if not (line1 and line2) then break end
    if #line1 ~= #line2 then
        o1:write(i .. ": " .. line1 .. "\n")
        o2:write(i .. ": " .. line2 .. "\n")
        diffCount=diffCount+1
        if diffCount>=100 then
            print("Too many differences, early quit with 100 lines.")
            break
        end
    end
end

f1:close()
f2:close()
o1:close()
o2:close()
