local reactor = peripheral.find("fissionReactor")

-- Hiệu ứng loading
local function loading()
    for i=1,3 do
        term.clear()
        term.setCursorPos(1,1)
        term.write("LOADING" .. string.rep(".",i))
        sleep(0.3)
    end
end

-- Xoá chương trình
local function uninstall()
    if not fs.exists("startup.lua") then
        print("ERROR: Not installed!")
        return false
    end
    
    fs.delete("startup.lua")
    print("UNINSTALLED! Restart computer.")
    return true
end

-- Menu chính
local function mainMenu()
    while true do
        term.clear()
        print("==== MEKANISM CONTROL ====")
        print("1. Toggle Reactor")
        print("2. Emergency Stop")
        print("3. Reactor Status")
        print("9. UNINSTALL")  -- Chức năng gỡ bỏ
        print("0. Exit")
        write("Select: ")

        local choice = read()
        if choice == "1" then
            reactor.setActive(not reactor.isActivated())
        elseif choice == "2" then
            reactor.setActive(false)
            print("EMERGENCY SHUTDOWN!")
            sleep(1)
        elseif choice == "3" then
            print("Temp:", reactor.getTemperature(), "K")
            print("Status:", reactor.isActivated() and "ACTIVE" or "INACTIVE")
            sleep(2)
        elseif choice == "9" then
            if uninstall() then break end  -- Thoát menu sau khi gỡ
        elseif choice == "0" then
            break
        end
    end
end

-- Chạy chương trình
loading()
if reactor then
    mainMenu()
else
    print("ERROR: No reactor found!")
end
