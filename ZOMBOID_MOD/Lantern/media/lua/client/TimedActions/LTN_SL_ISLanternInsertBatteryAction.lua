require "TimedActions/ISBaseTimedAction"

ISLanternInsertBatteryAction = ISBaseTimedAction:derive("ISLanternInsertBatteryAction");

function ISLanternInsertBatteryAction:isValid()
    return true
end

function ISLanternInsertBatteryAction:update()
end

function ISLanternInsertBatteryAction:start()
    self.character:faceThisObject(self.object)

    self:setActionAnim("Loot")
    self.character:SetVariable("LootPosition", "Low")
    self.sound = self.character:playSound("Dismantle")
end

function ISLanternInsertBatteryAction:stop()
    self.character:stopOrTriggerSound(self.sound)
    ISBaseTimedAction.stop(self);
    self.item:setJobDelta(0.0);
end

function ISLanternInsertBatteryAction:perform()
    self.item:setJobDelta(0.0);
    self.character:stopOrTriggerSound(self.sound)

    local sq = self.object:getSquare()
    if not sq then return end

    --local args = { id = self.item:getID(), battery = self.battery:getDelta(), x = sq:getX(), y = sq:getY(), z = sq:getZ() }
    --sendClientCommand(self.character, 'lantern', 'updateBattery', args)

    local lanterns = ModData.getOrCreate("LTN_Lanterns")
    local args = lanterns[self.item:getID()]

    if args then
        args.battery =  self.battery:getDelta()

        sendClientCommand(self.character, 'lantern', 'updateBattery', args)
        self.character:getInventory():Remove(self.battery)
    end

    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISLanternInsertBatteryAction:new(character, lantern, battery)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character;
    o.stopOnWalk = true;
    o.stopOnRun = true;
    o.maxTime = 50;
    -- custom fields
    o.object = lantern
    o.item = lantern:getItem()
    o.battery = battery
    return o;
end