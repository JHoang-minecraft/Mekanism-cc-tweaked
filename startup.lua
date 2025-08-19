
local url = "https://raw.githubusercontent.com/JHoang-minecraft/Mekanism-cc-tweaked/refs/heads/main/APISystem/APICore.lua"

local response = http.get(url)
if not response then
    error("APPLICATION CRASHER! MISSING APICORE")
end

local code = response.readAll()
response.close()

local API = load(code)()
print("APICore loaded successfully!")

local packages = {"GPU.package", "System.package", "menu.package", "API.package"}
for _, pkg in ipairs(packages) do
    for i = 1, 20 do
        print("Loading " .. pkg .. " (" .. i .. "/20)")
    end
end

print("Application Install complete! Enter Configure")
