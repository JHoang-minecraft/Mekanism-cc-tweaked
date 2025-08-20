-- APICore.lua
local APICore = {}

APICore.API_LIST = {
    [1] = { name = "activate", func = function(reactorSide) peripheral.wrap(reactorSide).activate() end },
    [2] = { name = "scram", func = function(reactorSide) peripheral.wrap(reactorSide).scram() end },
    [3] = { name = "getStatus", func = function(reactorSide) return peripheral.wrap(reactorSide).getStatus() end },
    [4] = { name = "getTemperature", func = function(reactorSide) return peripheral.wrap(reactorSide).getTemperature() end },
    [5] = { name = "getDamagePercent", func = function(reactorSide) return peripheral.wrap(reactorSide).getDamagePercent() end },
    [6] = { name = "getCoolant", func = function(reactorSide) return peripheral.wrap(reactorSide).getCoolant() end },
    [7] = { name = "getCoolantFilledPercentage", func = function(reactorSide) return peripheral.wrap(reactorSide).getCoolantFilledPercentage() end },
    [8] = { name = "getHeatedCoolant", func = function(reactorSide) return peripheral.wrap(reactorSide).getHeatedCoolant() end },
    [9] = { name = "getHeatedCoolantFilledPercentage", func = function(reactorSide) return peripheral.wrap(reactorSide).getHeatedCoolantFilledPercentage() end },
    [10] = { name = "getFuel", func = function(reactorSide) return peripheral.wrap(reactorSide).getFuel() end },
    [11] = { name = "getFuelFilledPercentage", func = function(reactorSide) return peripheral.wrap(reactorSide).getFuelFilledPercentage() end },
    [12] = { name = "getFuelNeeded", func = function(reactorSide) return peripheral.wrap(reactorSide).getFuelNeeded() end },
    [13] = { name = "getFuelCapacity", func = function(reactorSide) return peripheral.wrap(reactorSide).getFuelCapacity() end },
    [14] = { name = "getWaste", func = function(reactorSide) return peripheral.wrap(reactorSide).getWaste() end },
    [15] = { name = "getWasteFilledPercentage", func = function(reactorSide) return peripheral.wrap(reactorSide).getWasteFilledPercentage() end },
    [16] = { name = "getBurnRate", func = function(reactorSide) return peripheral.wrap(reactorSide).getBurnRate() end },
    [17] = { name = "getActualBurnRate", func = function(reactorSide) return peripheral.wrap(reactorSide).getActualBurnRate() end },
    [18] = { name = "getMaxBurnRate", func = function(reactorSide) return peripheral.wrap(reactorSide).getMaxBurnRate() end },
    [19] = { name = "getHeatingRate", func = function(reactorSide) return peripheral.wrap(reactorSide).getHeatingRate() end },
    [20] = { name = "getEnvironmentalLoss", func = function(reactorSide) return peripheral.wrap(reactorSide).getEnvironmentalLoss() end },
    [21] = { name = "isForceDisabled", func = function(reactorSide) return peripheral.wrap(reactorSide).isForceDisabled() end },
    [22] = { name = "setBurnRate", func = function(reactorSide, rate) return peripheral.wrap(reactorSide).setBurnRate(rate) end },
}

function APICore.call(apiId, ...)
    local api = APICore.API_LIST[apiId]
    if not api then error("API ID Not found: " .. tostring(apiId)) end
    return api.func(...)
end

return APICore
