
local function findLogicAdapter()
    for _, side in pairs({"front","back","left","right","top","bottom"}) do
        if peripheral.isPresent(side) then
            local pType = peripheral.getType(side)
            if pType == "fissionReactorLogicAdapter" then
                print("CONNECTED TO LOGIC ADAPTER ("..side..")")
                return peripheral.wrap(side)
            end
        end
    end
    return nil
end

local reactor = findLogicAdapter()

if not reactor then
    print("DEBUG: Nearby peripherals:")
    for _, side in pairs({"front","back","left","right","top","bottom"}) do
        if peripheral.isPresent(side) then
            print("- "..side..": "..peripheral.getType(side))
        end
    end
    error("NO LOGIC ADAPTER FOUND! Place computer against Fission Reactor Logic Adapter block")
end

while true do
    term.clear()
    print("MEKANISM LOGIC ADAPTER CONTROL")
    print("1. Toggle Reactor")
    print("2. Emergency Stop")
    print("0. Exit")
    write("> ")

    local input = read()
    if input == "1" then
        reactor.setActive(not reactor.isActive())
        print("Reactor: "..(reactor.isActive() and "ACTIVATED" or "DEACTIVATED"))
        sleep(1)
    elseif input == "2" then
        reactor.setActive(false)
        print("EMERGENCY SHUTDOWN!")
        sleep(1)
    elseif input == "0" then
        break
    end
end
