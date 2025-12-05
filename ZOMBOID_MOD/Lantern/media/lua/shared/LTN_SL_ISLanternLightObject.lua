require("ISBaseObject")

ISLanternLightObject = ISBaseObject:derive("ISLanternLightObject")

function ISLanternLightObject:init()
    local cell = getCell()
    if cell then
        local square = cell:getGridSquare(self.position.x, self.position.y, self.position.z)
        if square then
            if self.lightSource == nil then
                self.lightSource = IsoLightSource.new(self.position.x, self.position.y, self.position.z, self.color.r, self.color.g, self.color.b, self.radius)
                cell:addLamppost(self.lightSource)
                IsoGridSquare.RecalcLightTime = -1
            end
        else
            self:destroy()
        end
    end
end

function ISLanternLightObject:destroy()
    if self.lightSource ~= nil then
        self.lightSource:setActive(false)
        getCell():removeLamppost(self.lightSource)
        self.lightSource = nil
    end
end

function ISLanternLightObject:new(x ,y ,z, radius, color)
    local o = ISBaseObject:new()
    setmetatable(o, self)
    self.__index = self

    o.lightSource = nil

    o.position = { x=x, y=y, z=z }
    o.radius = radius
    o.color = color

    o:init()
    return o
end
