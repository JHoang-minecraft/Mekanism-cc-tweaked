
local monitor, adapter
local monitorSide = nil

for _, side in pairs(peripheral.getNames()) do
  local pType = peripheral.getType(side)
  if pType == "monitor" then
    monitor = peripheral.wrap(side)
    monitorSide = side:match("^(%w+)%_") or side
    monitor.setTextScale(0.5)
    break
  end
end

-- Phần còn lại giữ nguyên như code của bạn
for _, side in pairs({"top","bottom","left","right","front","back"}) do
  if peripheral.getType(side) == "fissionReactorLogicAdapter" then
    adapter = peripheral.wrap(side)
    break
  end
end
-- Check if monitor is Advanced Monitor
if not monitor or not peripheral.hasType(monitorSide, "advanced") then
  print("ERROR: Can only use Advanced Monitor for touch!")
  return
end

-- Find Reactor Adapter
for _, side in pairs({"top","bottom","left","right","front","back"}) do
  if peripheral.getType(side) == "fissionReactorLogicAdapter" then
    adapter = peripheral.wrap(side)
    break
  end
end

-- Connection Check
if not adapter then
  monitor.clear()
  monitor.setCursorPos(1,1)
  monitor.write("Connect to Reactor Adapter!")
  return
end

-- Improved Touch Menu
local function drawMenu()
  monitor.clear()
  monitor.setCursorPos(1,1)
  monitor.write("=== REACTOR CONTROL ===")
  
  -- Draw buttons with borders
  monitor.setCursorPos(2,3)
  monitor.write("┌─────────────────┐")
  monitor.setCursorPos(2,4)
  monitor.write("│ 1. Toggle Reactor │")
  monitor.setCursorPos(2,5)
  monitor.write("└─────────────────┘")
  
  monitor.setCursorPos(2,7)
  monitor.write("┌─────────────────┐")
  monitor.setCursorPos(2,8)
  monitor.write("│ 2. Emergency Stop │")
  monitor.setCursorPos(2,9)
  monitor.write("└─────────────────┘")
  
  monitor.setCursorPos(2,11)
  monitor.write("┌─────────────────┐")
  monitor.setCursorPos(2,12)
  monitor.write("│ 3. Reactor Info  │")
  monitor.setCursorPos(2,13)
  monitor.write("└─────────────────┘")
  
  monitor.setCursorPos(2,15)
  monitor.write("┌─────────────────┐")
  monitor.setCursorPos(2,16)
  monitor.write("│ 0. Exit Program  │")
  monitor.setCursorPos(2,17)
  monitor.write("└─────────────────┘")
end

-- Function to display reactor status
local function updateStatus()
  local status = adapter.getStatus()
  monitor.setCursorPos(20,4)
  monitor.write(status and "[RUNNING]" or "[STOPPED]")
  
  -- Display temperature in Celsius
  local temp = adapter.getTemperature() - 273.15
  monitor.setCursorPos(1,19)
  monitor.write(("Temp: %.2f °C"):format(temp))
end

-- Main Program
drawMenu()
updateStatus()

while true do
  local event, side, x, y = os.pullEvent()
  
  -- Debug touch coordinates
  if event == "monitor_touch" then
    print("Touch at:", x, y)
    
    -- Check if touch is on our monitor
    if side == monitorSide then
      -- Toggle Reactor (button row 4-5)
      if y >= 4 and y <= 5 then
        if adapter.getStatus() then
          adapter.scram()
        else
          adapter.activate()
        end
        updateStatus()
      
      -- Emergency Stop (button row 8-9)
      elseif y >= 8 and y <= 9 then
        adapter.scram()
        monitor.setCursorPos(20,8)
        monitor.write("[STOPPED]")
        sleep(1)
        drawMenu()
        updateStatus()
      
      -- Reactor Info (button row 12-13)
      elseif y >= 12 and y <= 13 then
        monitor.setCursorPos(1,20)
        monitor.write(("Burn Rate: %d/%d"):format(
          adapter.getActualBurnRate(),
          adapter.getMaxBurnRate()
        ))
        monitor.setCursorPos(1,21)
        monitor.write(("Fuel: %.1f%%"):format(
          adapter.getFuelFilledPercentage() * 100
        ))
      
      -- Exit (button row 16-17)
      elseif y >= 16 and y <= 17 then
        monitor.clear()
        monitor.setCursorPos(1,1)
        monitor.write("Program terminated")
        return
      end
    end
  end
end
