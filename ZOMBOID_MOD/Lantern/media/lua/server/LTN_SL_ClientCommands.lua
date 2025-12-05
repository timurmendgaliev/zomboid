
function noise (msg)
	print('ClientCommand: '..msg)
end

function SendServerCommandToClients(module, command, args)
	if not isClient() and not isServer() then
		triggerEvent("OnServerCommand", module, command, args); -- Singleplayer
	else
		sendServerCommand(module, command, args) -- Multiplayer
	end
end

function SendServerCommandToSpecificClient(module, command, player, args)
	if not isClient() and not isServer() then
		triggerEvent("OnServerCommand", module, command, args); -- Singleplayer
	else
		sendServerCommand(player, module, command, args) -- Multiplayer
	end
end

LTN_Client_Commands = {}
Client_Commands = {}

Client_Commands.lantern = {}
Client_Commands.lantern.placed = function(player, args)

	ModData.getOrCreate('LTN_Lanterns')[args.id] = args;
	ModData.transmit('LTN_Lanterns')

end

Client_Commands.lantern.pickup = function(player, args)

	ModData.getOrCreate('LTN_Lanterns')[args.id] = nil
	ModData.transmit('LTN_Lanterns')

	SendServerCommandToClients("lantern", "turnOff", args)
end

Client_Commands.lantern.turnOn = function(player, args)

	ModData.getOrCreate('LTN_Lanterns')[args.id].state = "On"
	ModData.transmit("LTN_Lanterns")

	SendServerCommandToClients("lantern", "turnOn", args)
end

Client_Commands.lantern.turnOff = function(player, args)

	ModData.getOrCreate('LTN_Lanterns')[args.id].state = "Off"
	ModData.transmit("LTN_Lanterns")

	SendServerCommandToClients("lantern", "turnOff", args)
end

Client_Commands.lantern.updateBattery = function(player, args)

	ModData.getOrCreate('LTN_Lanterns')[args.id].battery = args.battery
	ModData.transmit('LTN_Lanterns')

end

function ConsumeBatteries()

	local toTurnOff = {}
	local count = 0

	local lanterns = ModData.get("LTN_Lanterns")
	if lanterns == nil then return end

	for k,v in pairs(lanterns) do

		if v.state == "On" then
			v.battery = v.battery - (v.rate * 4) -- Consume Battery By Rate * 4 ( 4 x To Equal Consumption in 1 Minute)
			if v.battery < 0.0 then
				v.battery = 0.0
				table.insert(toTurnOff, v)
			end
			count = count + 1
		end

	end

	if count > 0 then

		-- Turn Off Client Lanterns
		for _,v in ipairs(toTurnOff) do
			lanterns[v.id].state = "Off"
			SendServerCommandToClients("lantern", "turnOff", lanterns[v.id])
		end

		ModData.transmit("LTN_Lanterns")

	end

end


Events.EveryOneMinute.Add(ConsumeBatteries)

LTN_Client_Commands.OnClientCommand = function(module, command, player, args)
	if Client_Commands[module] and Client_Commands[module][command] then
		local argStr = ''
		if args then
			for k,v in pairs(args) do argStr = argStr..' '..k..'='..tostring(v) end
		end
		noise('received '..module..' '..command..' '..tostring(player)..argStr)
		Client_Commands[module][command](player, args)
	end
end

Events.OnClientCommand.Add(LTN_Client_Commands.OnClientCommand)