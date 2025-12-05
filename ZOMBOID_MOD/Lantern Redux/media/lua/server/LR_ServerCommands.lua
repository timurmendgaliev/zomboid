----------------------------------------------------
-- Lantern Redux — серверная логика
----------------------------------------------------

LR_Server_Commands = LR_Server_Commands or {}

local function LR_LR_key(x, y, z)
    return tostring(x) .. "_" .. tostring(y) .. "_" .. tostring(z)
end

-- Обработка команды от клиента
function LR_Server_Commands.Toggle(player, args)
    if not args or not args.x or not args.y or not args.z then return end

    local data = ModData.getOrCreate("LR_Lanterns")
    local k = LR_LR_key(args.x, args.y, args.z)

    data[k] = {
        x      = args.x,
        y      = args.y,
        z      = args.z,
        isOn   = args.isOn and true or false,      -- ВАЖНО: isOn
        radius = args.radius or 10,
        color  = args.color or { r = 1.0, g = 0.95, b = 0.8 },
    }

    ModData.transmit("LR_Lanterns")
end

-- Роутер серверных команд
local function LR_OnClientCommand(module, command, player, args)
    if module ~= "LR" then return end

    local fn = LR_Server_Commands[command]
    if fn then
        fn(player, args)
    end
end

Events.OnClientCommand.Add(LR_OnClientCommand)

print("[LanternRedux] LR_ServerCommands.lua loaded (server)")
