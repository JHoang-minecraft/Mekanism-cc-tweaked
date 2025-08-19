
if not fs.exists("APISystem.APICore.lua") then
    error("APPLICATION CRASHER! MISSING APICORE")
end

local API = require("APISystem.APICore")
print("APICore loaded successfully!")

local packages = {"GPU.package", "System.package", "menu.package", "API.package"}

for _, pkg in ipairs(packages) do
    for i = 1, 20 do
        print("Loading " .. pkg .. " (" .. i .. "/20)")
    end
end

print("Application Install complete! Enter Configure =))")
