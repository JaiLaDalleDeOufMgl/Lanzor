

CreateThread(function()
    while true do
        local pCoords = GetEntityCoords(PlayerPedId())        
        local distance1 = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, 4840.571, -5174.425, 3.0, false)

        if distance1 < 3000.0 then
            Citizen.InvokeNative("0x9A9D1BA639675CF1", "HeistIsland", true)  -- load the map and removes the city
            Citizen.InvokeNative("0x5E1460624D194A38", true) -- load the minimap/pause map and removes the city minimap/pause map
        else
            Citizen.InvokeNative("0x9A9D1BA639675CF1", "HeistIsland", false)
            Citizen.InvokeNative("0x5E1460624D194A38", false)
        end

        Wait(1000)
    end
end)

CreateThread(function()
    while true do
        local Interval = 1000

        if (IsPauseMenuActive()) then
            Interval = 0

            SetRadarAsExteriorThisFrame()
            SetRadarAsInteriorThisFrame(GetHashKey("h4_fake_islandx"), vec(4700.0, -5145.0), 0, 0)
        end
        
        Wait(Interval)
    end
end)