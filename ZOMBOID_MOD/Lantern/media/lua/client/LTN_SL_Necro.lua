
Events.OnGameStart.Add( function ()
	if NecroList then
		print ("Adding SL_Lantern.Lantern to NecroForge");
		NecroList.Items.SL_Lantern = {"Mods", "SL_Lantern", nil, "Lantern", "LTN_SL.Lantern", "media/textures/Item_SL_Lantern.png", nil, nil, nil};
		
		print ("Adding SL_Lantern.GasLantern to NecroForge");
		NecroList.Items.SL_Lantern = {"Mods", "SL_Lantern", nil, "Gas Lantern", "LTN_SL.GasLantern", "media/textures/Item_SL_Lantern.png", nil, nil, nil};

		-- Debug BackpackAttachments
		if getActivatedMods():contains("backpackattachments") then
			print ("Adding BackpackAttachments to NecroForge");
			NecroList.Items.BA_School_One = {"Mods", "BackpackAttachments", nil, "SB One", "Base.Bag_Schoolbag_WithAttachment", "media/textures/Item_AliceBag.png", nil, nil, nil};
			NecroList.Items.BA_Hiking_One = {"Mods", "BackpackAttachments", nil, "HB One", "Base.Bag_NormalHikingBag_WithAttachment", "media/textures/Item_AliceBag.png", nil, nil, nil};
			NecroList.Items.BA_Hiking_Two = {"Mods", "BackpackAttachments", nil, "HB Two", "Base.Bag_NormalHikingBag_With2Attachments", "media/textures/Item_AliceBag.png", nil, nil, nil};
			NecroList.Items.BA_BigHiking_One = {"Mods", "BackpackAttachments", nil, "BHB One", "Base.Bag_BigHikingBag_WithAttachment", "media/textures/Item_AliceBag.png", nil, nil, nil};
			NecroList.Items.BA_BigHiking_Two = {"Mods", "BackpackAttachments", nil, "BHB Two", "Base.Bag_BigHikingBag_With2Attachments", "media/textures/Item_AliceBag.png", nil, nil, nil};
			NecroList.Items.BA_Survivor_One = {"Mods", "BackpackAttachments", nil, "B One", "Base.Bag_SurvivorBag_WithAttachment", "media/textures/Item_AliceBag.png", nil, nil, nil};
			NecroList.Items.BA_Survivor_Two = {"Mods", "BackpackAttachments", nil, "B Two", "Base.Bag_SurvivorBag_With2Attachments", "media/textures/Item_AliceBag.png", nil, nil, nil};
			NecroList.Items.BA_Survivor_Three = {"Mods", "BackpackAttachments", nil, "B Three", "Base.Bag_SurvivorBag_With3Attachments", "media/textures/Item_AliceBag.png", nil, nil, nil};
			NecroList.Items.BA_Large_One = {"Mods", "BackpackAttachments", nil, "LB One", "Base.Bag_ALICEpack_WithAttachment", "media/textures/Item_AliceBag.png", nil, nil, nil};
			NecroList.Items.BA_Large_Two = {"Mods", "BackpackAttachments", nil, "LB Two", "Base.Bag_ALICEpack_With2Attachments", "media/textures/Item_AliceBag.png", nil, nil, nil};
			NecroList.Items.BA_Large_Three = {"Mods", "BackpackAttachments", nil, "LB Three", "Base.Bag_ALICEpack_With3Attachments", "media/textures/Item_AliceBag.png", nil, nil, nil};
			NecroList.Items.Military_One = {"Mods", "BackpackAttachments", nil, "MB One", "Base.Bag_ALICEpack_Army_WithAttachment", "media/textures/Item_AliceBag.png", nil, nil, nil};
			NecroList.Items.Military_Two = {"Mods", "BackpackAttachments", nil, "MB Two", "Base.Bag_ALICEpack_Army_With2Attachments", "media/textures/Item_AliceBag.png", nil, nil, nil};
			NecroList.Items.Military_Three = {"Mods", "BackpackAttachments", nil, "MB Three", "Base.Bag_ALICEpack_Army_With3Attachments", "media/textures/Item_AliceBag.png", nil, nil, nil};
		end

		if getActivatedMods():contains("nattachments") then

			for k,v in pairs(NATTModsBackpacks) do
				for t,z in pairs(v) do
					table.insert(NecroList.Items, {"Mods", "nattachments", nil, z, "Base."..z, "media/textures/Item_AliceBag.png", nil, nil, nil})
				end
			end

		end

		if getActivatedMods():contains("noirbackpacksattachments") then

			for k,v in pairs(NATTBackpacks) do
				table.insert(NecroList.Items, {"Mods", k, nil, v, "Base."..v.."_II", "media/textures/Item_AliceBag.png", nil, nil, nil})
			end

			table.insert(NecroList.Items, {"Mods", "SMUI", nil, "MilitaryMedicalBag", "Base.Bag_MilitaryMedicalBag", "media/textures/Item_AliceBag.png", nil, nil, nil})
			table.insert(NecroList.Items, {"Mods", "SMUI", nil, "CFP90PatrolPack_II", "Base.Bag_CFP90PatrolPack", "media/textures/Item_AliceBag.png", nil, nil, nil})
			table.insert(NecroList.Items, {"Mods", "SLEO", nil, "PoliceUtilityBagGreen_II", "Base.Bag_PoliceUtilityBagGreen", "media/textures/Item_AliceBag.png", nil, nil, nil})

		end

	end
end)