require ("Hotbar/ISHotbar")

availableSlots = nil

local ISCraftAction_addOrDropItem = ISCraftAction.addOrDropItem
ISCraftAction.addOrDropItem = function(self, item)

    ISCraftAction_addOrDropItem(self, item)

    if not self.character:getInventory():contains(item) then
        print("SOMEHOW ITEM FAILED TO BE ADDED TO INVENTORY")
        return
    end

    if item:getType() == "Lantern" or item:getType() == "GasLantern" then
        
        local slot = {}
        slot.idx = self.item:getAttachedSlot()
        if slot.idx ~= -1 and availableSlots ~= nil then
            slot.def = availableSlots[slot.idx].def
            slot.attachment = slot.def.attachments[self.item:getAttachmentType()]

            -- Remove Existing Item In Hotbar Position
            local hotbar = getPlayerHotbar(self.character:getPlayerNum());
            if hotbar.attachedItems[slot.idx] then
                hotbar.chr:removeAttachedItem(hotbar.attachedItems[slot.idx]);
                hotbar.attachedItems[slot.idx]:setAttachedSlot(-1);
                hotbar.attachedItems[slot.idx]:setAttachedSlotType(nil);
                hotbar.attachedItems[slot.idx]:setAttachedToModel(nil);
            end

            -- Add New Item In Hotbar Position
            hotbar.chr:setAttachedItem(slot.attachment, item);
            item:setAttachedSlot(slot.idx);
            item:setAttachedSlotType(slot.def.type);
            item:setAttachedToModel(slot.attachment);

            hotbar:reloadIcons();
            ISInventoryPage.renderDirty = true

            --ISTimedActionQueue.add(ISAttachItemHotbar:new(self.character, item, slot.attachment, slot.idx, slot.def))
        end
    end

end

local ISHotbar_refresh = ISHotbar.refresh
ISHotbar.refresh = function(self)
    ISHotbar_refresh(self)
    availableSlots = self.availableSlot
end
