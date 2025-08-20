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

local function downloadFile(url, filename)
    write("Downloading " .. filename .. "... ")
    local response = http.get(url .. "/" .. filename)
    if not response then
        print("FAILED!")
        return false
    end
    local content = response.readAll()
    response.close()
    local f = fs.open(filename, "w")
    f.write(content)
    f.close()
    print("DONE!")
    return true
end

local function installer()
    print("Installing Mekanism Control System...")
    
    -- Check API Core first
    local response = http.get(api_url .. "/APICore.lua")
    if not response then
        error("APPLICATION CRASHED! MISSING CONTROL SYSTEM\nPLEASE CHECK: " .. api_url)
    end
    response.close()

    -- Download all packages
    local packages = {"APICore.lua", "GPU.package", "System.package", "menu.package", "API.package"}
    for _, pkg in ipairs(packages) do
        for i = 1, 3 do 
            if downloadFile(api_url, pkg) then
                break
            elseif i == 3 then
                error("Failed to download " .. pkg .. " after 3 attempts!")
            end
            sleep(1.3)
        end
    end

    print("Installation complete! Launching application...")
    sleep(2)
    
    if fs.exists("menu.package") then
        shell.run("menu.package")
    else
        error("Main menu not found!")
    end
end

-- Main menu
while true do
    term.clear()
    term.setCursorPos(1,1)
    print("=== MEKANISM CONTROL SYSTEM ===")
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
