local reactor = peripheral.find("fissionReactorLogicAdapter")

local function loading()
    term.clear()
    local anim = {"|", "/", "-", "\\"}
    for i=1,8 do
        term.setCursorPos(1,1)
        term.write("BOOTING "..anim[(i%4)+1])
        sleep(0.15)
    end
end

local function uninstall()
    fs.delete("startup.lua")
    print("UNINSTALLED! Restart computer.")
    return true
end

local function main()
    loading()
    
    while true do
        term.clear()
        print("MEKANISM REMOTE CONTROL")
        print("1. Toggle Reactor")
        print("2. Emergency Stop")
        print("3. Status")
        print("9. UNINSTALL")
        print("0. Exit")
        write("> ")

        local cmd = read()
        if cmd == "1" then
            reactor.setActive(not reactor.isActivated())
        elseif cmd == "2" then
            reactor.setActive(false)
            print("SHUTDOWN!")
            sleep(1)
        elseif cmd == "3" then
            print("Temp:", reactor.getTemperature(), "K")
            print("Fuel:", reactor.getFuel())
            sleep(2)
        elseif cmd == "9" then
            if uninstall() then break end
        elseif cmd == "0" then
            break
        end
    end
end

if reactor then
    main()
else
    print("ERROR: No reactor detected!")
end
