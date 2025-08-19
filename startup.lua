-- Auto-detect monitor and adapter
local monitor, adapter
local monitorSide

for _, side in pairs({"top","bottom","left","right","front","back"}) do
  local pType = peripheral.getType(side)
  if pType == "monitor" then
    monitor = peripheral.wrap(side)
    monitor.setTextScale(0.5)
    monitorSide = side -- Lưu hướng monitor
  elseif pType == "fissionReactorLogicAdapter" then
    adapter = peripheral.wrap(side)
  end
end

-- Check connection
if not monitor then error("No monitor connected!") end
if not adapter then error("No reactor adapter found!") end

-- Loading animation
local function loading()
  monitor.clear()
  monitor.setCursorPos(1,1)
  monitor.write("BOOTING SYSTEM")
  for i = 1, 3 do
    monitor.write(".")
    sleep(0.3)
  end
end

-- Draw touch menu
local function drawMenu()
  monitor.clear()
  monitor.setCursorPos(2,2)
  monitor.write("[1] TOGGLE REACTOR")
  monitor.setCursorPos(2,4)
  monitor.write("[2] EMERGENCY STOP")
  monitor.setCursorPos(2,6)
  monitor.write("[0] EXIT")
end

-- Main program
loading()
drawMenu()

while true do
  local event, side, x, y = os.pullEvent("monitor_touch")
  
  -- Only process touch on our monitor
  if side == monitorSide then
    if y == 2 then -- Toggle
      adapter.setActive(not adapter.getActive())
    elseif y == 4 then -- Emergency stop
      adapter.scram()
      monitor.setCursorPos(2,8)
      monitor.write("REACTOR SCRAMMED!")
      sleep(2)
      drawMenu()
    elseif y == 6 then -- Exit
      break
    end
  end
end
