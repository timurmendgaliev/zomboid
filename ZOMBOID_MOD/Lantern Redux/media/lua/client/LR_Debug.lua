local function dbg(msg)
    print("[LR_DEBUG] " .. tostring(msg))
end

Events.OnFillWorldObjectContextMenu.Add(function(player, context, worldobjects, test)
    if test then return end

    dbg("=== WORLDOBJECTS ===")

    for i,obj in ipairs(worldobjects) do
        dbg(i .. ") OBJ = " .. tostring(obj))

        if instanceof(obj, "IsoWorldInventoryObject") then
            dbg("   -> IsoWorldInventoryObject ✔")
            local item = obj:getItem()
            if item then
                dbg("      item fullType = " .. item:getFullType())
            else
                dbg("      item = NIL")
            end
        else
            dbg("   -> NOT IsoWorldInventoryObject ❌")
        end
    end

    dbg("====================")
end)
