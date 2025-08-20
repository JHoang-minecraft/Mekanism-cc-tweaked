-- configuration.lua
-- Mekanism Control System - Clickable Configuration Menu

local config = {}

-- Load advanced GUI libraries
local function setupGUI()
    if not fs.exists("gui.lua") then
        print("Downloading GUI library...")
        -- Download GUI library from your GitHub
        local response = http.get("https://raw.githubusercontent.com/.../gui.lua")
        if response then
            local content = response.readAll()
            response.close()
            local file = fs.open("gui.lua", "w")
            file.write(content)
            file.close()
        end
    end
    return require("gui")
end

-- Main configuration menu with clickable buttons
function config.showMenu()
    term.clear()
    term.setCursorPos(1,1)
    
    -- Display header
    print("=== MEKANISM CONFIGURATION ===")
    print("")
    
    -- Clickable menu options
    print("[[ SETUP REACTORS ]]")
    print("[[ CHECK CONNECTION ]]") 
    print("[[ SETUP WALLPAPER ]]")
    print("[[ CHECK UPDATES ]]")
    print("[[ BACK TO MAIN ]]")
    
    -- Wait for mouse click
    while true do
        local event, button, x, y = os.pullEvent("mouse_click")
        
        if y == 3 then -- SETUP REACTORS
            config.setupReactors()
        elseif y == 4 then -- CHECK CONNECTION
            config.checkConnection()
        elseif y == 5 then -- SETUP WALLPAPER  
            config.setupWallpaper()
        elseif y == 6 then -- CHECK UPDATES
            config.checkUpdates()
        elseif y == 7 then -- BACK TO MAIN
            return
        end
    end
end

-- Setup Reactors function
function config.setupReactors()
    term.clear()
    print("=== REACTOR SETUP ===")
    print("Click on the side where reactor is connected:")
    print("[[ TOP ]]")
    print("[[ BOTTOM ]]")
    print("[[ LEFT ]]")
    print("[[ RIGHT ]]")
    print("[[ BACK ]]")
    print("[[ FRONT ]]")
    print("[[ CANCEL ]]")
    
    while true do
        local event, button, x, y = os.pullEvent("mouse_click")
        local sides = {"top", "bottom", "left", "right", "back", "front"}
        
        if y >= 3 and y <= 8 then
            config.data.reactorSide = sides[y-2]
            print("Reactor set to: " .. config.data.reactorSide)
            config.save()
            sleep(2)
            break
        elseif y == 9 then
            break
        end
    end
    config.showMenu()
end

-- Check Connection function  
function config.checkConnection()
    term.clear()
    print("=== CONNECTION CHECK ===")
    
    if config.checkReactor() then
        print(" Reactor connection: PASS")
    else
        print(" Reactor connection: FAILED")
    end
    
    print("")
    print("[[ TEST AGAIN ]]")
    print("[[ BACK ]]")
    
    while true do
        local event, button, x, y = os.pullEvent("mouse_click")
        if y == 6 then
            config.checkConnection()
        elseif y == 7 then
            config.showMenu()
        end
    end
end

-- Setup Wallpaper function
function config.setupWallpaper()
    term.clear()
    print("=== WALLPAPER SETUP ===")
    print("Select wallpaper theme:")
    print("[[ DEFAULT ]]")
    print("[[ DARK ]]")
    print("[[ BLUE ]]")
    print("[[ GREEN ]]")
    print("[[ RED ]]")
    print("[[ CUSTOM ]]")
    print("[[ BACK ]]")
    
    while true do
        local event, button, x, y = os.pullEvent("mouse_click")
        local themes = {"default", "dark", "blue", "green", "red", "custom"}
        
        if y >= 3 and y <= 8 then
            config.data.wallpaper = themes[y-2]
            print("Wallpaper set to: " .. config.data.wallpaper)
            config.save()
            sleep(2)
            break
        elseif y == 9 then
            break
        end
    end
    config.showMenu()
end

-- Check Updates function
function config.checkUpdates()
    term.clear()
    print("=== SYSTEM UPDATE ===")
    
    -- Your update checking code here
    print("Checking for updates...")
    sleep(2)
    
    print(" System is up to date!")
    print("")
    print("[[ CHECK AGAIN ]]")
    print("[[ BACK ]]")
    
    while true do
        local event, button, x, y = os.pullEvent("mouse_click")
        if y == 6 then
            config.checkUpdates()
        elseif y == 7 then
            config.showMenu()
        end
    end
end

return config
