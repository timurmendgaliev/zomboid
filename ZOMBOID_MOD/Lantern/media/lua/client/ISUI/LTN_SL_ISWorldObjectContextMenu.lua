require 'ISUI/ISWorldObjectContextMenu';

local function predicatePetrol(item)
	return (item:hasTag("Petrol") or item:getType() == "PetrolCan") and (item:getDrainableUsesInt() > 0)
end


local ISWorldObjectContextMenu_fetch = ISWorldObjectContextMenu.fetch; -- Preserve Base Functionality
ISWorldObjectContextMenu.fetch = function(v, player, doSquare)
    ISWorldObjectContextMenu_fetch(v, player, doSquare) -- Call Base Functionality
    
    -- If Item Is Lantern Add Variable with Item
    if instanceof(v, "IsoWorldInventoryObject") and v:getItem():getType() == "Lantern" then
        lantern = v;
    end
    
    -- If Item Is Gas Lantern Add Variable with Item
    if instanceof(v, "IsoWorldInventoryObject") and v:getItem():getType() == "GasLantern" then
        gasLantern = v;
    end

end

local ISWorldObjectContextMenu_clearFetch = ISWorldObjectContextMenu.clearFetch; -- Preserve Base Functionality
ISWorldObjectContextMenu.clearFetch = function()
    ISWorldObjectContextMenu_clearFetch() -- Call Base Functionality
    lantern = nil
    gasLantern = nil
end


function onLantern_Toggle(lantern, player)
    if luautils.walkAdj(player, lantern:getSquare()) then
		ISTimedActionQueue.add(ISLanternToggleLightAction:new(player, lantern))
	end
end

function onLantern_Insert(lantern, player, battery)
    if luautils.walkAdj(player, lantern:getSquare()) then
        ISTimedActionQueue.add(ISLanternInsertBatteryAction:new(player, lantern, battery))
    end
end

function onLantern_Refill(lantern, player, petrolCan)
    if luautils.walkAdj(player, lantern:getSquare()) then
        ISWorldObjectContextMenu.equip(player, player:getPrimaryHandItem(), petrolCan, true, false)
        ISTimedActionQueue.add(ISGasLanternRefillAction:new(player, lantern, petrolCan))
    end
end

local ISWorldObjectContextMenu_createMenu = ISWorldObjectContextMenu.createMenu; -- Preserve Base Functionality
function ISWorldObjectContextMenu.createMenu(player, worldobjects, x, y, test)
    local context = ISWorldObjectContextMenu_createMenu(player, worldobjects, x, y, test) -- Call Base Functionality

    if test == true then return true end
    if not context then return true end

    if lantern or gasLantern then

        local playerObj = getSpecificPlayer(player)
        local lanternObject = nil
        
        if lantern then lanternObject = lantern end
        if gasLantern then lanternObject = gasLantern end

        local lanternItem = lanternObject:getItem()
        local id = lanternItem:getID()
        local Lanterns = ModData.getOrCreate("LTN_Lanterns")
        
        if Lanterns[id] and Lanterns[id].battery <= 0 then

            local playerInv = playerObj:getInventory()
            
            if lantern ~= nil then
            
                -- Add Insert Battery Context Options
                local items = playerInv:getItems()
                local battery = nil
                local charge = 0
    
                for j=1,items:size() do
                    local item = items:get(j-1)
                    if item:getType() == "Battery" then
                        if item:getDelta() > charge then
                            charge = item:getDelta()
                            battery = item
                        end
                    end
                end
    
                if battery ~= nil then
                    context:addOption(getText("ContextMenu_Insert_Battery"), lantern, onLantern_Insert, playerObj, battery)
                end
               
            elseif gasLantern then
            
               local petrolCan = playerInv:getFirstEvalRecurse(predicatePetrol);

                if petrolCan ~= nil then
                    context:addOption(getText("ContextMenu_Add_Gasoline"), gasLantern, onLantern_Refill, playerObj, petrolCan)
                end
               
            end
            
        else

            -- Add Turn On and Off Context Options
            local contextTxt = getText("ContextMenu_Turn_On")
            if Lanterns[id] and Lanterns[id].state == "On" then
                contextTxt = getText("ContextMenu_Turn_Off")
            end

            context:addOption(contextTxt, lanternObject, onLantern_Toggle, playerObj)
        end

    end

    return context;
end

