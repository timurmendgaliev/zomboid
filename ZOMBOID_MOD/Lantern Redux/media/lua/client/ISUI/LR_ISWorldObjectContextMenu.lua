------------------------------------------------
-- Lantern Redux – контекстное меню фонарей на земле
------------------------------------------------

require "ISUI/ISWorldObjectContextMenu"
require "LR_ClientCommands"

local LR_lanternWorldObj    = nil
local LR_gasLanternWorldObj = nil

local function LR_isBatteryLanternItem(item)
    return item and item:getFullType() == "LanternRedux.LR_BatteryLantern"
end

local function LR_isGasLanternItem(item)
    return item and item:getFullType() == "LanternRedux.LR_GasLantern"
end

------------------------------------------------
-- fetch / clearFetch
------------------------------------------------

local _orig_fetch = ISWorldObjectContextMenu.fetch
ISWorldObjectContextMenu.fetch = function(v, player, doSquare)
    _orig_fetch(v, player, doSquare)

    if instanceof(v, "IsoWorldInventoryObject") then
        local item = v:getItem()
        if LR_isBatteryLanternItem(item) then
            LR_lanternWorldObj = v
        elseif LR_isGasLanternItem(item) then
            LR_gasLanternWorldObj = v
        end
    end
end

local _orig_clearFetch = ISWorldObjectContextMenu.clearFetch
ISWorldObjectContextMenu.clearFetch = function()
    _orig_clearFetch()
    LR_lanternWorldObj    = nil
    LR_gasLanternWorldObj = nil
end

------------------------------------------------
-- Переключение
------------------------------------------------

local function LR_onToggleLantern(worldObj, playerObj)
    LR_Client_Commands.Toggle(worldObj, playerObj)
end

local _orig_createMenu = ISWorldObjectContextMenu.createMenu
function ISWorldObjectContextMenu.createMenu(player, worldobjects, x, y, test)
    local context = _orig_createMenu(player, worldobjects, x, y, test)
    if test == true then return true end
    if not context then return true end

    if not (LR_lanternWorldObj or LR_gasLanternWorldObj) then
        return context
    end

    local playerObj = getSpecificPlayer(player)
    if not playerObj then return context end

    local worldObj = LR_lanternWorldObj or LR_gasLanternWorldObj
    local item     = worldObj:getItem()
    if not item then return context end

    local txt = item:isActivated()
        and getText("ContextMenu_Turn_Off")
        or  getText("ContextMenu_Turn_On")

    context:addOption(txt, worldObj, LR_onToggleLantern, playerObj)

    return context
end

print("[LanternRedux] LR_ISWorldObjectContextMenu.lua loaded")
