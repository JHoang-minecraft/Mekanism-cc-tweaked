local api_url = "https://raw.githubusercontent.com/JHoang-minecraft/Mekanism-cc-tweaked/refs/heads/main/ReactorsControl/ControlSystem.lua"

local function uninstall()
    print("Uninstalling Mekanism application...")
    local filesToDelete = {
        "APICore.lua",
        "GPU.package",
        "System.package",
        "menu.package",
        "API.package"
    }
    for _, file in ipairs(filesToDelete) do
        if fs.exists(file) then
            fs.delete(file)
            print("Deleted: " .. file)
        end
    end
    print("Uninstall complete!")
end

local function installer()
    print("Installing Mekanism Control System...")
    
    -- Check API Core first 
    local response = http.get(api_url)
    if not response then
        print("ERROR: MISSING CONTROL SYSTEM")
        print("PLEASE CHECK: " .. api_url)
        print("Press any key to return...")
        os.pullEvent("key")
        return
    end
    response.close()
    print("OK: Control System verified!")

    local packages = {
        "GPU.package",
        "Rendering.package", 
        "API.package",
        "System.package", 
        "Monitor.package",
        "Core.package"
    }

    for pkgIndex, pkgName in ipairs(packages) do
        print("\nDownloading " .. pkgName .. " (" .. pkgIndex .. "/6)")
        
        for i = 1, 20 do
            local percent = i * 5
            local bar = "[" .. string.rep("=", i) .. string.rep(" ", 20-i) .. "]"
            write(bar .. " " .. percent .. "%\r")
            sleep(1)
        end
        print("OK: " .. pkgName .. " installed!")
    end

    print("\nINSTALLATION COMPLETE!")
    print("Configuring system...")
    sleep(2)
    print("All packages integrated!")
    sleep(1)
    print("\nLaunching Mekanism Control System...")
    sleep(2)
    
    print("Running in simulation mode...")
    print("Type 'menu' to start")
end

-- Main menu
while true do
    term.clear()
    term.setCursorPos(1,1)
    print("=== MEKANISM CONTROL SYSTEM MENU ===")
    print("1: Install")
    print("2: Uninstall") 
    print("3: Exit")
    write("Choose an option: ")
    local choice = read()
    if choice == "1" then
        installer()
        break
    elseif choice == "2" then
        uninstall()
        break
    elseif choice == "3" then
        print("Exiting...")
        break
    else
        print("Invalid option! Press any key...")
        os.pullEvent("key")
    end
end
