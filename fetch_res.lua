local head = "https://tetr.io/res/"

local list = {
    "avatar.png",
    "supporter-tag.png",
    "verified-admin.png",
    "verified-halfmod.png",
    "verified-mod.png",
    "verified-sysop.png",
}

local soil = select(2, pcall(require, 'res_panelsoil'))
if type(soil) == 'table' then
    print("Load res_panelsoil.lua? (~900MB) (y/N)")
    if io.read():upper() == "Y" then
        local ins = table.insert
        for i = 1, #soil do
            ins(list, soil[i])
        end
    end
end

print("Full refresh? (y/N)")
local fullRefresh = io.read():upper() == "Y"
local stat = {
    new = 0,
    edit = 0,
    skip = 0,
}

os.execute("mkdir -p res")

for i = 1, #list do
    local url = head .. list[i]
    if list[i]:find("/") then
        os.execute("mkdir -p res/" .. list[i]:match("(.+)/"))
    end
    local exist = io.open("res/" .. list[i], 'r')
    if fullRefresh or not exist then
        io.popen("curl -s -o res/" .. list[i] .. " " .. url)
        if exist then
            print("x " .. list[i])
            stat.edit = stat.edit + 1
        else
            print("+ " .. list[i])
            stat.new = stat.new + 1
        end
    else
        stat.skip = stat.skip + 1
    end
    if exist then exist:close() end
end

print("Total: " .. #list)
print("New: " .. stat.new)
print("Edit: " .. stat.edit)
print("Skip: " .. stat.skip)
