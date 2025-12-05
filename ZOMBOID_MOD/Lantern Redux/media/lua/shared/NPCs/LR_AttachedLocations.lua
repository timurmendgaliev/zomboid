----------------------------------------------------
-- Lantern Redux : AttachedLocations
-- Порт из оригинального LTN_SL_AttachedLocations.lua
----------------------------------------------------

local group = AttachedLocations.getGroup("Human")

-- Пояс
group:getOrCreateLocation("Lantern Belt Right"):setAttachmentName("lantern_belt_right")
group:getOrCreateLocation("Lantern Belt Left"):setAttachmentName("lantern_belt_left")

-- Рюкзаки (доступны и без BackpackAttachments)
group:getOrCreateLocation("Lantern Schoolbag"):setAttachmentName("lantern_schoolbag")
group:getOrCreateLocation("Lantern Hikingbag"):setAttachmentName("lantern_hikingbag")
group:getOrCreateLocation("Lantern Hikingbag Left"):setAttachmentName("lantern_hikingbag_left")
group:getOrCreateLocation("Lantern ALICEpack Left"):setAttachmentName("lantern_alicepack_left")
group:getOrCreateLocation("Lantern ALICEpack"):setAttachmentName("lantern_alicepack")
group:getOrCreateLocation("Lantern ALICEpack Right"):setAttachmentName("lantern_alicepack_right")

-- Noir's Backpack Attachments / NATT
if getActivatedMods():contains("noirbackpacksattachments")
or getActivatedMods():contains("nattachments") then
    if NATTBackpacks then
        for _, v in pairs(NATTBackpacks) do
            local locName = v .. " Lantern"
            local attachName = "AA_lantern_noir_" .. v
            group:getOrCreateLocation(locName):setAttachmentName(attachName)
        end
    end
end
