-- When creating item in result box of crafting panel.
function Recipe.OnCreate.LanternBatteryRemoval(items, result, player)
	for i=0, items:size()-1 do
		local item = items:get(i)
		-- we found the battery, we change his used delta according to the battery
		if item:getType() == "Lantern" then
			result:setUsedDelta(item:getUsedDelta());
			-- then we empty the torch used delta (his energy)
			item:setUsedDelta(0);
		end
	end
end

function Recipe.OnTest.LanternBatteryInsert(sourceItem, result)
	if sourceItem:getType() == "Lantern" then
		return sourceItem:getUsedDelta() == 0; -- Only allow the battery inserting if the flashlight has no battery left in it.
	end
	return true -- the battery
end

function Recipe.OnTest.GasLanternRefill(sourceItem, result)
	if sourceItem:getType() == "GasLantern" then
		return sourceItem:getUsedDelta() == 0; -- Only allow the refilling if the lantern has no fuel left in it.
	end
	return true -- the fuel
end

function Recipe.OnCreate.DismantleLantern(items, result, player, selectedItem)
	local success = 50 + (player:getPerkLevel(Perks.Electricity)*5);
	player:getInventory():AddItem("Base.Aluminum");
	player:getInventory():AddItem("Base.LightBulb");

	if ZombRand(0,100)<success then
		player:getInventory():AddItem("Base.ElectronicsScrap");
	end

	if ZombRand(0,100)<success then
		player:getInventory():AddItem("Base.Aluminum");
	end
end
