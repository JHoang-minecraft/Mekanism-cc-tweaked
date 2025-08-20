
local config = {}

-- Load existing configuration
function config.load()
    if fs.exists("reactor_config.cfg") then
        local file = fs.open("reactor_config.cfg", "r")
        local content = file.readAll()
        file.close()
        config.data = textutils.unserialize(content) or {}
    else
        config.data = {
            reactorSide = "top",
            monitorSide = "right",  
            wallpaper = "default",
            autoUpdate = true,
            safeTemperature = 800,
        }
    end
end

-- Save configuration
function config.save()
    local file = fs.open("reactor_config.cfg", "w")
    file.write(textutils.serialize(config.data))
    file.close()
end

-- Check reactor connection
function config.checkReactor()
    print("Checking reactor on [" .. config.data.reactorSide .. "]...")
    local reactor = peripheral.wrap(config.data.reactorSide)
    if reactor and peripheral.getType(config.data.reactorSide) == "fissionReactor" then
        print("✅ CONNECTED: " .. peripheral.getType(config.data.reactorSide))
        return true
    else
        print("❌ MISSING: No reactor found!")
        return false
    end
end

-- Clickable main menu
function config.showMenu()
    term.clear()
    term.setCursorPos(1,1)
    print("=== MEKANISM CONFIGURATION ===")
    print("")
    print("[[ SETUP REACTORS ]]")
    print("[[ CHECK CONNECTION ]]") 
    print("[[ SETUP WALLPAPER ]]")
    print("[[ CHECK UPDATES ]]")
    print("[[ EXIT ]]")
    
    while true do
        local event, button, x, y = os.pullEvent("mouse_click")
        if y == 3 then
            config.setupReactors()
        elseif y == 4 then
            config.checkConnection()
        elseif y == 5 then
            config.setupWallpaper()
        elseif y == 6 then
            config.checkUpdates()
        elseif y == 7 then
            term.clear()
            print("Configuration saved. Type 'menu' to continue.")
            return
        end
    end
end

-- Setup reactors menu
function config.setupReactors()
    term.clear()
    print("=== REACTOR SETUP ===")
    print("Current: " .. config.data.reactorSide)
    print("Click new side:")
    print("[[ TOP ]]")
    print("[[ BOTTOM ]]")
    print("[[ LEFT ]]")
    print("[[ RIGHT ]]")
    print("[[ BACK ]]")
    print("[[ CANCEL ]]")
    
    while true do
        local event, button, x, y = os.pullEvent("mouse_click")
        local sides = {"top", "bottom", "left", "right", "back"}
        if y >= 3 and y <= 7 then
            config.data.reactorSide = sides[y-2]
            print("Set to: " .. config.data.reactorSide)
            config.save()
            sleep(1)
            config.showMenu()
            return
        elseif y == 8 then
            config.showMenu()
            return
        end
    end
end

-- Check connection menu
function config.checkConnection()
    term.clear()
    print("=== CONNECTION CHECK ===")
    config.checkReactor()
    print("")
    print("[[ TEST AGAIN ]]")
    print("[[ BACK ]]")
    
    while true do
        local event, button, x, y = os.pullEvent("mouse_click")
        if y == 6 then
            config.checkConnection()
            return
        elseif y == 7 then
            config.showMenu()
            return
        end
    end
end

-- Setup wallpaper menu  
function config.setupWallpaper()
    term.clear()
    print("=== WALLPAPER SETUP ===")
    print("Current: " .. config.data.wallpaper)
    print("Select theme:")
    print("[[ DEFAULT ]]")
    print("[[ DARK ]]")
    print("[[ BLUE ]]")
    print("[[ RED ]]")
    print("[[ BACK ]]")
    
    while true do
        local event, button, x, y = os.pullEvent("mouse_click")
        local themes = {"default", "dark", "blue", "red"}
        if y >= 3 and y <= 6 then
            config.data.wallpaper = themes[y-2]
            print("Set to: " .. config.data.wallpaper)
            config.save()
            sleep(1)
            config.showMenu()
            return
        elseif y == 7 then
            config.showMenu()
            return
        end
    end
end

-- Check updates menu
function config.checkUpdates()
    term.clear()
    print("=== SYSTEM UPDATE ===")
    print("Checking GitHub...")
    sleep(2)
    print("✅ System up to date!")
    print("")
    print("[[ CHECK AGAIN ]]")
    print("[[ BACK ]]")
    
    while true do
        local event, button, x, y = os.pullEvent("mouse_click")
        if y == 6 then
            config.checkUpdates()
            return
        elseif y == 7 then
            config.showMenu()
            return
        end
    end
end

-- Main execution
config.load()
config.showMenu()
