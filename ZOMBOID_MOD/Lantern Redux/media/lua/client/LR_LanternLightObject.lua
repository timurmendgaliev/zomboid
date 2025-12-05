----------------------------------------------------
-- Lantern Redux — клиентский свет
----------------------------------------------------

require "ISBaseObject"

LR_LanternLightObject = LR_LanternLightObject or ISBaseObject:derive("LR_LanternLightObject")
LR_LanternLightObject.Active = LR_LanternLightObject.Active or {}

local function LR_LR_key(x, y, z)
    return tostring(x) .. "_" .. tostring(y) .. "_" .. tostring(z)
end

----------------------------------------------------
-- Экземпляр
----------------------------------------------------
function LR_LanternLightObject:new(x, y, z, radius, color)
    local o = ISBaseObject:new()
    setmetatable(o, self)
    self.__index = self

    o.x = x
    o.y = y
    o.z = z
    o.radius = radius or 10
    o.color = color or { r = 1.0, g = 0.95, b = 0.8 }
    o.light = nil

    o:createLight()
    return o
end

function LR_LanternLightObject:createLight()
    -- dedicated server does not have client lighting classes
    if not IsoLightSource or not IsoLightSource.new then return end

    local cell = getCell()
    if not cell then return end

    local sq = cell:getGridSquare(self.x, self.y, self.z)
    if not sq then return end
    if self.light then return end

    local L = IsoLightSource.new(
        self.x + 0.5,
        self.y + 0.5,
        self.z,
        self.color.r,
        self.color.g,
        self.color.b,
        self.radius
    )

    L:setActive(true)
    cell:addLamppost(L)
    self.light = L

    sq:RecalcProperties()
    sq:RecalcAllWithNeighbours(true)
    local world = getWorld()
    if world then
        IsoGridSquare.RecalcLightTime = -1
        world:setLightingUpdate(true)
    end
end

function LR_LanternLightObject:destroy()
    if self.light then
        local cell = getCell()
        if cell then
            cell:removeLamppost(self.light)
        end
        self.light:setActive(false)
        self.light = nil
    end
end

----------------------------------------------------
-- Статика: включить / выключить по записи ModData
----------------------------------------------------
function LR_LanternLightObject.turnOn(entry)
    if not entry then return end
    local k = LR_LR_key(entry.x, entry.y, entry.z)

    if LR_LanternLightObject.Active[k] then
        LR_LanternLightObject.Active[k]:destroy()
    end

    LR_LanternLightObject.Active[k] =
        LR_LanternLightObject:new(entry.x, entry.y, entry.z, entry.radius, entry.color)
end

function LR_LanternLightObject.turnOff(entry)
    if not entry then return end
    local k = LR_LR_key(entry.x, entry.y, entry.z)

    if LR_LanternLightObject.Active[k] then
        LR_LanternLightObject.Active[k]:destroy()
        LR_LanternLightObject.Active[k] = nil
    end
end

----------------------------------------------------
-- Полный рефреш из ModData
----------------------------------------------------
local function LR_LR_refresh()
    local data = ModData.getOrCreate("LR_Lanterns")
    if not data then return end

    -- гасим старые
    for _, obj in pairs(LR_LanternLightObject.Active) do
        obj:destroy()
    end
    LR_LanternLightObject.Active = {}

    -- создаём новые
    for _, entry in pairs(data) do
        if entry.isOn then
            LR_LanternLightObject.turnOn(entry)
        end
    end
end

local function LR_OnReceiveGlobalModData(key, data)
    if key ~= "LR_Lanterns" then return end
    LR_LR_refresh()
end

local function LR_requestModData()
    ModData.request("LR_Lanterns")
end

Events.OnReceiveGlobalModData.Add(LR_OnReceiveGlobalModData)
Events.OnConnected.Add(LR_requestModData)
Events.OnGameStart.Add(LR_requestModData)
Events.OnGameStart.Add(LR_LR_refresh)
Events.OnLoad.Add(LR_LR_refresh)

print("[LanternRedux] LR_LanternLightObject.lua loaded (client)")
