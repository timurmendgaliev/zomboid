require "Hotbar/ISHotbarAttachDefinition"
if not ISHotbarAttachDefinition then
    return
end

function addAttachment(type, key, value)
    for k,v in pairs(ISHotbarAttachDefinition) do
        print(v.type)
        if v.type == type then
            v.attachments[key] = value
            return
        end
    end
end

-- Attachment Type In Table - Key In Attachments - Value In Attachments
addAttachment("SmallBeltLeft", "Lantern", "Lantern Belt Left")
addAttachment("SmallBeltRight", "Lantern", "Lantern Belt Right")

function ActivateModData()
    -- Custom Lantern Attachments for BackpackAttachments Mod
    if getActivatedMods():contains("backpackattachments") then
        addAttachment("Schoolbag", "Lantern", "Lantern Schoolbag")
        addAttachment("Hikingbag", "Lantern", "Lantern Hikingbag")
        addAttachment("HikingbagLeft", "Lantern", "Lantern Hikingbag Left")
        addAttachment("ALICEpackLeft", "Lantern", "Lantern ALICEpack Left")
        addAttachment("ALICEpack", "Lantern", "Lantern ALICEpack")
        addAttachment("ALICEpackRight", "Lantern", "Lantern ALICEpack Right")
    end

    -- Custom Lantern Attachments for Nori's Backpack Attachments Mod
    if getActivatedMods():contains("noirbackpacksattachments") or getActivatedMods():contains("nattachments") then
        for _,v in pairs(NATTBackpacks) do
            addAttachment(v.."Flashlight", "Lantern", v.."Lantern")
        end
    end
end

Events.OnGameStart.Add(ActivateModData);



