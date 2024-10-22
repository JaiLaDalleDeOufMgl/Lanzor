-- CreateThread(function()
--     while true do
--         interval = 1500

--         local playerPed = PlayerPedId()
--         local playerCoords = GetEntityCoords(playerPed)

--         if (PedSelling ~= nil) then
--             interval = 1000

--             local pnjCoords = GetEntityCoords(PedSelling)

--             local distanceRadius = #(pnjCoords - playerCoords)

--             if (not DoesEntityExist(PedSelling)) then
--                 PedSelling = nil
--             end

--             print(DoesEntityExist(PedSelling), distanceRadius, pnjCoords, playerCoords)

--             if (distanceRadius <= 15) then 
--                 interval = 0

--                 DrawMarker(20, pnjCoords.x, pnjCoords.y, pnjCoords.z + 1.1, 0.0, 0.0, 0.0, 10, 180.0, 0.0, 0.4, 0.4, 0.4, 255, 0, 0, 100, true, true, 2, false, false, false, false)
--             end

--             if (distanceRadius <= 1.5) then
--                 ESX.ShowHelpNotification('HERE TEST')

--                 if IsControlJustPressed(1, 86) then
--                     SetEntityAsMissionEntity(PedSelling)

--                     TaskLookAtCoord(PedSelling, playerCoords.x, playerCoords.y, playerCoords.z, -1, 2048, 3)

--                     Wait(5000)

--                     SetPedAsNoLongerNeeded(PedSelling)

--                     DeleteEntity(PedSelling)

--                     PedSelling = nil
--                 end
--             end
--         end

--         Wait(interval)
--     end
-- end)