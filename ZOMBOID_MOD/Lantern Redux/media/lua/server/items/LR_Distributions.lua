require "Items/Distributions"
require "Items/SuburbsDistributions"
require "Items/ProceduralDistributions"

-- Добавление предмета в SuburbsDistributions
local function LR_AddToSuburbs(containerName, itemFullType, weight)
    local container = SuburbsDistributions[containerName]
    if not container or not container.items then return end

    table.insert(container.items, itemFullType)
    table.insert(container.items, weight)
end

-- Добавление предмета в ProceduralDistributions
local function LR_AddToProcedural(listName, itemFullType, weight)
    local list = ProceduralDistributions.list[listName]
    if not list or not list.items then return end

    table.insert(list.items, itemFullType)
    table.insert(list.items, weight)
end

local function LR_AddLanternsToDistributions()
    -- Battery Lantern
    LR_AddToSuburbs("camping",             "LanternRedux.LR_BatteryLantern", 1.5)
    LR_AddToSuburbs("all",                 "LanternRedux.LR_BatteryLantern", 0.01)
    LR_AddToSuburbs("toolstore",           "LanternRedux.LR_BatteryLantern", 1)
    LR_AddToSuburbs("storageunit",         "LanternRedux.LR_BatteryLantern", 0.5)

    LR_AddToProcedural("CampingStoreGear", "LanternRedux.LR_BatteryLantern", 2)
    LR_AddToProcedural("ToolStoreGear",    "LanternRedux.LR_BatteryLantern", 1)

    -- Gas Lantern
    LR_AddToSuburbs("camping",             "LanternRedux.LR_GasLantern", 0.8)
    LR_AddToSuburbs("shed",                "LanternRedux.LR_GasLantern", 0.3)

    LR_AddToProcedural("CampingStoreGear", "LanternRedux.LR_GasLantern", 1)
end

-- ВАЖНО: Минимально правильное событие загрузки дистрибуций
Events.OnDistributionMerge.Add(LR_AddLanternsToDistributions)
