local LTN_Server_Commands = {}
local Server_Commands = {}

ClientLanterns = {}

local noise = function(msg)
    print('ServerCommand: '..msg)
end

Server_Commands.lantern = {}
Server_Commands.lantern.turnOn = function(args)

    local lanterns = ModData.getOrCreate("LTN_Lanterns")
    if lanterns[args.id] then
        lanterns[args.id].state = "On"
        if ClientLanterns[args.id] == nil then
            if args.isGas ~= nil and args.isGas == true then
                ClientLanterns[args.id] = ISLanternLightObject:new(args.x, args.y, args.z, 7, { r = 0.95, g = 0.65, b = 0.3})
            else
                ClientLanterns[args.id] = ISLanternLightObject:new(args.x, args.y, args.z, 10, { r = 1, g = 1, b = 0.75})
            end
        end
    end

end

Server_Commands.lantern.turnOff = function(args)

    local lanterns = ModData.getOrCreate("LTN_Lanterns")
    if lanterns[args.id] then
        lanterns[args.id].state = "Off"
    end

    if ClientLanterns[args.id] then
        ClientLanterns[args.id]:destroy()
    end
    ClientLanterns[args.id] = nil

end


LTN_Server_Commands.OnServerCommand = function(module, command, args)
    if Server_Commands[module] and Server_Commands[module][command] then
        local argStr = ''
        if args then
            for k,v in pairs(args) do argStr = argStr..' '..k..'='..tostring(v) end
        end
        noise('received '..module..' '..command..' '..argStr)
        Server_Commands[module][command](args)
    end
end

Events.OnServerCommand.Add(LTN_Server_Commands.OnServerCommand)


function OnReceiveGlobalModData(key, modData)

    if key == "LTN_Lanterns" then
        ModData.add(key, modData)
    end

end

Events.OnReceiveGlobalModData.Add(OnReceiveGlobalModData)