
local adapter
for _, side in pairs({"front","back","left","right","top","bottom"}) do
    if peripheral.getType(side) == "fissionReactorLogicAdapter" then
        adapter = peripheral.wrap(side)
        print("CONNECTED TO LOGIC ADAPTER ("..side..")")
        break
    end
end

if not adapter then
    print("ERROR: Place computer against LOGIC ADAPTER block!")
    print("Debug nearby blocks:")
    for _, s in pairs({"front","back","left","right","top","bottom"}) do
        print(s..": "..(peripheral.getType(s) or "air"))
    end
    return
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
        -- HÀM CHUẨN CỦA LOGIC ADAPTER: getStatus()/setActive()
        local current = adapter.getStatus() 
        adapter.setActive(current == "inactive")
        print("Reactor: "..adapter.getStatus():upper())
        sleep(1)
    elseif input == "2" then
        adapter.setActive(false)
        print("FORCED SHUTDOWN!")
        sleep(1)
    elseif input == "0" then
        break
    end
end
