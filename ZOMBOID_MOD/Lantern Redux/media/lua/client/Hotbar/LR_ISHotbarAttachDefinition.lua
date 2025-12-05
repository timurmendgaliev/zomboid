----------------------------------------------------
-- Lantern Redux : Hotbar attach definitions
-- Точный порт LTN_SL_ISHotbarAttachDefinition.lua
----------------------------------------------------

require "Hotbar/ISHotbarAttachDefinition"

if not ISHotbarAttachDefinition then
    return
end

local function addAttachment(slotType, key, value)
    for _, def in pairs(ISHotbarAttachDefinition) do
        if def.type == slotType then
            def.attachments = def.attachments or {}
            def.attachments[key] = value
            return
        end
    end
end

-- Пояс (как в оригинале)
addAttachment("SmallBeltLeft",  "Lantern", "Lantern Belt Left")
addAttachment("SmallBeltRight", "Lantern", "Lantern Belt Right")

local function addBackpackSlots()
    local slots = {
        "Schoolbag",
        "Hikingbag",
        "HikingbagLeft",
        "ALICEpackLeft",
        "ALICEpack",
        "ALICEpackRight",
    }
    for _, slot in ipairs(slots) do
        addAttachment(slot, "Lantern", "Lantern " .. slot)
    end
end

local function ActivateModData()
    -- базовые слоты рюкзаков (теперь доступны и без сторонних модов)
    addBackpackSlots()

    -- Noir's backpack attachments / NATT
    if getActivatedMods():contains("noirbackpacksattachments")
    or getActivatedMods():contains("nattachments") then
        if NATTBackpacks then
            for _, v in pairs(NATTBackpacks) do
                addAttachment(v.."Flashlight", "Lantern", v.."Lantern")
            end
        end
    end
end

Events.OnGameStart.Add(ActivateModData)
