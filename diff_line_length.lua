-- Usage: lua comp.lua file1 file2
-- Usage: lua comp.lua file1 file2 start_offset1 start_offset2 line_count

local i1 = assert(io.open(arg[1], "r"), "Cannot open file " .. arg[1])
local i2 = assert(io.open(arg[2], "r"), "Cannot open file " .. arg[2])

local o1 = assert(io.open("out1.txt", "w"), "Cannot open output file out1.txt")
local o2 = assert(io.open("out2.txt", "w"), "Cannot open output file out2.txt")

local off1 = tonumber(arg[3])
local off2 = tonumber(arg[4])
local lineCnt = tonumber(arg[5]) or 1e99
local stopSeq

if not off1 then
    off1, off2 = 0, 0
    stopSeq = ".init(),"
end

for _ = 1, off1 - 1 do _ = i1:read("*l") end
for _ = 1, off2 - 1 do _ = i2:read("*l") end

local diffCount = 0

for i = 1, lineCnt do
    local line1 = i1:read("*l")
    local line2 = i2:read("*l")
    if not (line1 and line2) then break end
    if stopSeq and (line1:find(stopSeq, nil, true) or line2:find(stopSeq, nil, true)) then
        print("Stop sequence found at line " .. i .. ", exiting.")
        break
    end
    if #line1 ~= #line2 then
        o1:write(i .. ": " .. line1 .. "\n")
        o2:write(i .. ": " .. line2 .. "\n")
        diffCount = diffCount + 1
        if diffCount >= 100 then
            print("Too many differences, early quit with 100 lines.")
            break
        end
    end
end

print("Total differences found: " .. diffCount)

i1:close()
i2:close()
o1:close()
o2:close()
os.exit()
