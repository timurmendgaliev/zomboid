-- Lantern Redux: логика рецептов разборки фонарей

local function LR_GiveItemSafe(inv, fullType)
    if not inv or not fullType then return end
    inv:AddItem(fullType)
end

function LR_OnCreate_DisassembleBatteryLantern(items, result, player)
    if not player then return end
    local inv = player:getInventory()
    if not inv then return end

    -- батарейный фонарь → батарейка + лампочка + электрохлам
    LR_GiveItemSafe(inv, "Base.Battery")
    LR_GiveItemSafe(inv, "Base.LightBulb")
    LR_GiveItemSafe(inv, "Base.ElectronicsScrap")
end

function LR_OnCreate_DisassembleGasLantern(items, result, player)
    if not player then return end
    local inv = player:getInventory()
    if not inv then return end

    -- газовый фонарь → металлолом + электрохлам
    LR_GiveItemSafe(inv, "Base.ScrapMetal")
    LR_GiveItemSafe(inv, "Base.ElectronicsScrap")
end
