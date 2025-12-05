----------------------------------------------------
-- Lantern Redux — client commands (отправка на сервер)
----------------------------------------------------

LR_Client_Commands = LR_Client_Commands or {}

local function LR_LR_getProps(item)
    if not item then
        return 10, { r = 1.0, g = 0.95, b = 0.8 }
    end

    local ft = item:getFullType()
    if ft == "LanternRedux.LR_BatteryLantern" then
        return 12, { r = 1.0, g = 1.0,  b = 0.80 }
    elseif ft == "LanternRedux.LR_GasLantern" then
        return 9,  { r = 1.0, g = 0.92, b = 0.65 }
    end

    return 10, { r = 1.0, g = 0.95, b = 0.8 }
end

function LR_Client_Commands.Toggle(worldObj, playerObj)
    if not worldObj or not instanceof(worldObj, "IsoWorldInventoryObject") then return end

    local square = worldObj:getSquare()
    if not square then return end

    local item = worldObj:getItem()
    if not item then return end

    -- локально переключаем иконку
    local newState = not item:isActivated()
    item:setActivated(newState)

    local x, y, z = square:getX(), square:getY(), square:getZ()
    local radius, color = LR_LR_getProps(item)

    local args = {
        x      = x,
        y      = y,
        z      = z,
        isOn   = newState,
        radius = radius,
        color  = color,
    }

    -- одна единственная серверная команда
    sendServerCommand("LR", "Toggle", args)
end

print("[LanternRedux] LR_ClientCommands.lua loaded (client)")
