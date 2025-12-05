require "TimedActions/ISBaseTimedAction"

ISGasLanternRefillAction = ISBaseTimedAction:derive("ISGasLanternRefillAction");

function ISGasLanternRefillAction:isValid()
    return true
end

function ISGasLanternRefillAction:update()
end

function ISGasLanternRefillAction:start()
    self.character:faceThisObject(self.object)

	self:setActionAnim("refuelgascan")
	self:setOverrideHandModels(self.petrol:getStaticModel(), nil)
	self.sound = self.character:playSound("GeneratorAddFuel")
end

function ISGasLanternRefillAction:stop()
    self.character:stopOrTriggerSound(self.sound)
    ISBaseTimedAction.stop(self)
    self.item:setJobDelta(0.0)
end

function ISGasLanternRefillAction:perform()
    self.item:setJobDelta(0.0)
    self.character:stopOrTriggerSound(self.sound)

    local sq = self.object:getSquare()
    if not sq then return end

    --local args = { id = self.item:getID(), battery = self.battery:getDelta(), x = sq:getX(), y = sq:getY(), z = sq:getZ() }
    --sendClientCommand(self.character, 'lantern', 'updateBattery', args)

    local lanterns = ModData.getOrCreate("LTN_Lanterns")
    local args = lanterns[self.item:getID()]

    if args then
        self.petrol:Use();
        args.battery = 1
        sendClientCommand(self.character, 'lantern', 'updateBattery', args)
    end

    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self)
end

function ISGasLanternRefillAction:new(character, lantern, petrolCan)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character
    o.stopOnWalk = true
    o.stopOnRun = true
    o.maxTime = 50;
    -- custom fields
    o.object = lantern
    o.item = lantern:getItem()
    o.petrol = petrolCan;
    return o;
end