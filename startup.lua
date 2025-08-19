-- Tìm monitor và reactor logic adapter
local monitor, adapter

for _, side in pairs({"top","bottom","left","right","front","back"}) do
    local pType = peripheral.getType(side)
    if pType == "monitor" then
        monitor = peripheral.wrap(side)
        monitor.setTextScale(0.5)
    elseif pType == "fissionReactorLogicAdapter" then
        adapter = peripheral.wrap(side)
    end
end

-- Kiểm tra kết nối
if not monitor then print("Lỗi: Gắn monitor vào computer!") return end
if not adapter then print("Lỗi: Đặt computer áp Logic Adapter!") return end

-- Hiệu ứng loading
local function loading()
    monitor.clear()
    monitor.setCursorPos(1,1)
    for i=1,3 do
        monitor.write("KHỞI ĐỘNG" .. string.rep(".",i))
        sleep(0.3)
    end
end

-- Vẽ menu cảm ứng
local function drawMenu()
    monitor.clear()
    monitor.setCursorPos(2,2)
    monitor.write("[1] BẬT/TẮT REACTOR")
    monitor.setCursorPos(2,4)
    monitor.write("[2] DỪNG KHẨN CẤP")
    monitor.setCursorPos(2,6)
    monitor.write("[0] THOÁT")
end

-- Chạy chương trình
loading()
drawMenu()

while true do
    local event, side, x, y = os.pullEvent("monitor_touch")
    
    -- Xử lý chạm vào vị trí menu
    if y == 2 then  -- Chạm vào dòng 2 (BẬT/TẮT)
        local status = adapter.getStatus()
        adapter.setActive(status == "inactive")
        monitor.setCursorPos(15,2)
        monitor.write("["..(status == "active" and "TẮT" or "BẬT").."]")
    elseif y == 4 then  -- Chạm vào dòng 4 (DỪNG KHẨN)
        adapter.setActive(false)
        monitor.setCursorPos(15,4)
        monitor.write("[ĐÃ DỪNG]")
        sleep(1)
        drawMenu()
    elseif y == 6 then  -- Chạm vào dòng 6 (THOÁT)
        break
    end
end
