local function loadingAnimation(stepName, duration)
    term.write("["..stepName.."] ")
    for i=1,3 do
        term.write(".")
        sleep(duration/3)
    end
    print(" DONE")
end

local function bootSequence()
    term.clear()
    term.setCursorPos(1,1)
    print("MEKANISM CONTROL SYSTEM BOOTING...")
    print("---------------------------------")

    loadingAnimation("GPU INIT", 1.2)
    loadingAnimation("MEMORY TEST", 1.5)
    loadingAnimation("REACTOR LINK", 2.0)
    loadingAnimation("MONITOR CALIB", 1.0)
    loadingAnimation("SAFETY CHECK", 1.8)

    print("\nSYSTEM READY")
    sleep(0.5)
    term.clear()
end

local function findReactor()
    for _,name in pairs(peripheral.getNames()) do
        if peripheral.getType(name):find("fissionReactor") then
            return peripheral.wrap(name)
        end
    end
    return nil
end

local function mainMenu(reactor)
    while true do
        term.clear()
        print("MEKANISM REACTOR CONTROL")
        print("-----------------------")
        print("1. Toggle Reactor")
        print("2. Status Report")
        print("3. Emergency Stop")
        print("0. Exit")

        write("Select: ")
        local input = read()

        if input == "1" then
            reactor.setActive(not reactor.getActive())
        elseif input == "2" then
            print("Temp: "..reactor.getTemperature().." K")
            print("Status: "..(reactor.getActive() and "ACTIVE" or "INACTIVE"))
            sleep(2)
        elseif input == "3" then
            reactor.setActive(false)
            print("EMERGENCY SHUTDOWN INITIATED")
            sleep(1)
        elseif input == "0" then
            break
        end
    end
end

local reactor = findReactor()
if not reactor then
    print("ERROR: No reactor detected!")
    return
end

bootSequence()
mainMenu(reactor)
