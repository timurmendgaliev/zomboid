

function onLoadGridsquare(square)

  local objects = square:getObjects()
  for index=0, objects:size()-1 do
      local object = objects:get(index)
      if instanceof(object, "IsoWorldInventoryObject") then
          local item = object:getItem()
          if item:getType() == "Lantern" or item:getType() == "GasLantern" then

              if(ClientLanterns[item:getID()]) then
                  ClientLanterns[item:getID()]:destroy()
                  ClientLanterns[item:getID()] = nil
              end

              local lanterns = ModData.getOrCreate("LTN_Lanterns")
              if lanterns[item:getID()] and lanterns[item:getID()].state == "On" then
                  ClientLanterns[item:getID()] = ISLanternLightObject:new(square:getX(), square:getY(), square:getZ(), 10, { r = 1, g = 1, b = .75})
              end

          end
      end
  end

end

Events.LoadGridsquare.Add(onLoadGridsquare)


local function OnGameStart()

    local lanterns = ModData.getOrCreate("LTN_Lanterns")

    for k,v in pairs(lanterns) do
        local square = getSquare(v.x, v.y, v.z)
        if square and v.state == "On" then
            if ClientLanterns[v.id] == nil then
                ClientLanterns[v.id] = ISLanternLightObject:new(v.x, v.y, v.z, 10, { r = 1, g = 1, b = .75})
            end
        end
    end

end

Events.OnGameStart.Add(OnGameStart)