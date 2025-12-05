local debugItems = false;

local function giveItems()

    if debugItems then
        local player = getSpecificPlayer(0);
        
        print ("Adding SL_Lantern.GasLantern to Inventory");
        player:getInventory():AddItem("LTN_SL.Lantern");
        
        print ("Adding SL_Lantern.GasLantern to Inventory");
        player:getInventory():AddItem("LTN_SL.GasLantern");

        if getActivatedMods():contains("noirbackpacksattachments") then
            player:getInventory():AddItem("Bag_Alicepack_II");
        end
    end
    
end

Events.OnGameStart.Add(giveItems);