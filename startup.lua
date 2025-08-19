local function findReactor()
    for _, side in pairs({"front","back","left","right","top","bottom"}) do
        if peripheral.isPresent(side) then
            local pType = peripheral.getType(side)
            if pType:lower():find("reactor") then
                return peripheral.wrap(side)
            end
        end
    end
    return nil
end

local reactor = findReactor()

local function loading()
    term.clear()
    local dots = {"", ".", "..", "...", "...."}
    for i = 1, 5 do
        term.setCursorPos(1,1)
        term.write("SCANNING REACTORS"..dots[i])
        sleep(0.2)
    end
end

local function uninstall()
    fs.delete("startup.lua")
    print("UNINSTALL COMPLETE!")
    return true
end

local function main()
    loading()
    
    while true do
        term.clear()
        print("REACTOR CONTROL v2.0")
        print("1. Toggle Power")
        print("2. Emergency Stop")
        print("9. Uninstall")
        print("0. Exit")
        write("> ")
        
        local cmd = read()
        if cmd == "1" then
            reactor.setActive(not reactor.isActive())
        elseif cmd == "2" then
            reactor.setActive(false)
            print("EMERGENCY STOPPED!")
            sleep(1)
        elseif cmd == "9" then
            if uninstall() then break end
        elseif cmd == "0" then
            break
        end
    end
end

if reactor then
    print("FOUND: "..peripheral.getType(reactor))
    main()
else
    print("ERROR: No reactor detected nearby!")
    print("Connect to any side of reactor block")
end
