
local reactor = peripheral.find("fissionReactorLogicAdapter")

if not reactor then
    print("ERROR: Đặt computer SÁT Logic Adapter của reactor!")
    print("Debug các peripheral gần đó:")
    for _, side in pairs({"front","back","left","right","top","bottom"}) do
        if peripheral.isPresent(side) then
            print("- "..side..": "..peripheral.getType(side))
        end
    end
    return
end

while true do
    term.clear()
    print("MEKANISM CONTROL - LUA EDITION")
    print("1. Bật/Tắt reactor")
    print("0. Thoát")
    write("Lựa chọn: ")

    local cmd = read()
    if cmd == "1" then
        local current = reactor.getActive() 
        reactor.setActive(not current)
        print("Trạng thái: " .. (reactor.getActive() and "BẬT" or "TẮT"))
    elseif cmd == "0" then
        break
    end
    sleep(1)
end
