if love then
    string.unpack = love.data.unpack
    string.pack   = function(a, b, c) love.data.pack("string", a, b, c) end
end

if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

local F = io.open('tetrio.opus.rsd', 'rb')
assert(F, "Cannot find file 'tetrio.opus.rsd'")

assert(F:read(4) == 'tRSD', 'Not a tRSD file')

local version = F:read(1)
assert(version == '\1', 'Only support tRSD v1, got ' .. string.byte(version))

assert(F:read(11) == '\0\0\0\0\0\0\0\0\0\0\0', 'Invalid header')

local last = 0
local res = {}
while true do
    local nameLen = F:read(4)
    if nameLen == '\0\0\0\0' then break end
    local nameLenNum = string.unpack('I4', nameLen)
    assert(nameLenNum <= 255, 'Too long name:' .. nameLenNum)

    local name = F:read(nameLenNum)
    local endTime = string.unpack('f', F:read(4))
    table.insert(res, {
        name = name,
        startTime = last,
        endTime = endTime,
        duration = endTime - last,
    })
    last = endTime
end

print("Meta data parsing finished")

local function write(text)
    io.stdout:write(text)
    io.stdout:flush()
end

local function clear()
    write('\27[2J')
    write('\27[H')
end

local lenStr = ""
repeat
    lenStr = lenStr .. F:read(1)
until lenStr:sub(-1) == "\0"
local datalen = string.unpack("<I" .. #lenStr, lenStr)

while true do
    clear()
    print("1 - Print meta data simply")
    if F then
        print(("2 - Extract ogg file as 'tetrio.opus.rsd.ogg'(%.1f MB)"):format(datalen / 2 ^ 20))
    end
    print("3 - Generate ffmpeg commands as 'tetrio_sfx_unpack.bat'")
    print("else - quit")
    write("Choose an option: ")

    local c = io.read()
    if c == '1' then
        clear()
        for i = 1, #res do
            local t = res[i].startTime
            print(('%02d:%02d  %.1fs  %s'):format(
                math.floor(t / 60), math.floor(t % 60),
                res[i].duration,
                res[i].name)
            )
        end
    elseif c == '2' and F then
        local f = io.open('tetrio.opus.rsd.ogg', 'wb')
        if f then
            f:write(F:read(datalen))
            f:flush()
            f:close()
            F:close()
            F = nil
            print("\nDONE")
        else
            print("Cannot write file 'tetrio.opus.rsd.ogg'")
        end
    elseif c == '3' then
        local f = io.open('tetrio_sfx_unpack.bat', 'w')
        if f then
            f:write("mkdir tetrio_sfx\n")
            local line = "ffmpeg -loglevel quiet -i tetrio.opus.rsd.ogg -ss %f -to %f -c copy tetrio_sfx/%s.ogg\n"
            for i = 1, #res do
                f:write(line:format(res[i].startTime, res[i].endTime, res[i].name))
            end
            f:flush()
            f:close()
            print("\nDONE")
        else
            print("Cannot write file 'tetrio_sfx_unpack.bat'")
        end
    else
        break
    end
    print("\npress return to continue")
    io.read()
end

os.exit()
