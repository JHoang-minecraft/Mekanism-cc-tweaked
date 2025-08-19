local function uninstall()
    print("Uninstalling Mekanism application...")
end

local function installer()
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
    print("Mekanism application:")
    print("1: Uninstall")
    print("2: Installer")
    print("3: Exit")
    write("Choose an option: ")
    local choice = read()
    if choice == "1" then
        uninstall()
    elseif choice == "2" then
        installer()
    elseif choice == "3" then
        print("Exiting...")
        break
    else
        print("Invalid option, try again.")
    end
end
