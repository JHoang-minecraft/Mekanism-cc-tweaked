local api_url = "https://raw.githubusercontent.com/JHoang-minecraft/Mekanism-cc-tweaked/refs/heads/main/ReactorsControl/ControlSystem"

local function uninstall()
    print("Uninstalling Mekanism application...")
end

local function installer()
    -- check APICore
    local response = http.get(api_url)
    if not response then
        error("APPLICATION CRASHER! MISSING CONTROL SYSTEM")
        error("PLEASE CHECK https://github.com/JHoang-minecraft/Mekanism-cc-tweaked/tree/main/ReactorsControl ")
    end

    local code = response.readAll()
    response.close()

    local API = load(code)()
    print("APICore loaded successfully!")

    local packages = {"GPU.package", "System.package", "menu.package", "API.package"}
    for _, pkg in ipairs(packages) do
        for i = 1, 20 do
            print("Loading " .. pkg .. " (" .. i .. "/20)")
            sleep(0.1) 
        end
    end

    print("Application Install complete! Enter Configure")
end

while true do
    print("\nMekanism application:")
    print("1: Uninstall")
    print("2: Installer")
    print("3: Exit")
    write("Choose an option: ")
    local choice = read()
    if choice == "1" then
        uninstall()
        break
    elseif choice == "2" then
        installer()
        break
    elseif choice == "3" then
        print("Exiting...")
        break
    else
        print("Invalid option, try again.")
    end
end

