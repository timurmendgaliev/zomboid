--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISLanternToggleLightAction = ISBaseTimedAction:derive("ISLanternToggleLightAction");

function ISLanternToggleLightAction:isValid()
	return true
end

function ISLanternToggleLightAction:update()
end

function ISLanternToggleLightAction:start()
	self.character:faceThisObject(self.object)

	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
end

function ISLanternToggleLightAction:stop()
	ISBaseTimedAction.stop(self)
end

function ISLanternToggleLightAction:perform()

	local sq = self.object:getSquare()
	if not sq then return end
	sq:playSound("LightSwitch")

	local invItem = self.object:getItem()
	local lanterns = ModData.getOrCreate("LTN_Lanterns")
	local args = lanterns[invItem:getID()]

	if args then
		if args.state == "On" then
			sendClientCommand(self.character, 'lantern', 'turnOff', args)
		else
			sendClientCommand(self.character, 'lantern', 'turnOn', args)
		end
	end

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISLanternToggleLightAction:new(character, object)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character
	o.stopOnWalk = false
	o.stopOnRun = false
	o.maxTime = 0
	-- custom fields
	o.object = object
	return o
end
