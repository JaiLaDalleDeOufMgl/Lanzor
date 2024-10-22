PedSelling = nil


function MOD_DrugSell:ZoneSell()
    CreateThread(function()
        while true do
            local interval = 1500

            for i=1, #self.ZoneList do
                local Area = self.ZoneList[i]

                if (self.zoneInfos.curPedSelling) then
                    goto PedOnSelling
                end

                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                local distance = #(playerCoords - Area.coords)

                if (distance <= Area.radius) then
                    print('PLAYER ON THE ZONE')
                else
                    -- print('PLAYER NOT ON THE ZONE')
                end

                :: PedOnSelling ::
            end

            Wait(interval)
        end
    end)
end

-- CreateThread(function()
--     while true do
--         interval = 1000

--         for i=1, #_GamemodeEnums.Labos.SellDrugs.AreaSell do
--             local Area = _GamemodeEnums.Labos.SellDrugs.AreaSell[i]

--             if (PedSelling == nil) then
--                 local playerPed = PlayerPedId()
--                 local playerCoords = GetEntityCoords(playerPed)
--                 local distance = #(playerCoords - Area.position)
    
--                 if (distance <= Area.radius) then
--                     local handle, ped = FindFirstPed()
    
--                     repeat
--                         success, ped = FindNextPed(handle)
    
--                         local pnjCoords = GetEntityCoords(ped)
--                         local distanceRadius = #(pnjCoords - Area.position)
    
--                         if (distanceRadius <= Area.radius) and (PedSelling == nil) then
--                             if (DoesEntityExist(ped) and not IsPedAPlayer(ped)) then
--                                 PedSelling = ped

--                                 TaskSetBlockingOfNonTemporaryEvents(PedSelling, true)
--                                 TaskStandStill(PedSelling, 60000)

--                                 AddBlipForEntity(PedSelling)
--                             end
--                         end
--                     until not success
    
--                     EndFindPed(handle)
--                 end
--             end
--         end

--         Wait(interval)
--     end
-- end)