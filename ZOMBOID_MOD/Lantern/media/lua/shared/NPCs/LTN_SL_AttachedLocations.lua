--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

local group = AttachedLocations.getGroup("Human")

group:getOrCreateLocation("Lantern Belt Right"):setAttachmentName("lantern_belt_right")
group:getOrCreateLocation("Lantern Belt Left"):setAttachmentName("lantern_belt_left")

-- Custom Lantern Attachments for BackpackAttachments Mod
if getActivatedMods():contains("backpackattachments") then
    group:getOrCreateLocation("Lantern Schoolbag"):setAttachmentName("lantern_schoolbag")
    group:getOrCreateLocation("Lantern Hikingbag"):setAttachmentName("lantern_hikingbag")
    group:getOrCreateLocation("Lantern Hikingbag Left"):setAttachmentName("lantern_hikingbag_left")
    group:getOrCreateLocation("Lantern ALICEpack Left"):setAttachmentName("lantern_alicepack_left")
    group:getOrCreateLocation("Lantern ALICEpack"):setAttachmentName("lantern_alicepack")
    group:getOrCreateLocation("Lantern ALICEpack Right"):setAttachmentName("lantern_alicepack_right")
end

-- Custom Lantern Attachments for Noir's BackpackAttachments Mod
if getActivatedMods():contains("noirbackpacksattachments") or getActivatedMods():contains("nattachments") then
    for _,v in pairs(NATTBackpacks) do
        group:getOrCreateLocation(v.."Lantern"):setAttachmentName("AA_lantern_noir_"..v)
    end
end