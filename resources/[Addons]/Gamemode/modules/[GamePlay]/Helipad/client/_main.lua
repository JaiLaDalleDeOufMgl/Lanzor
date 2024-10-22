

---

--- Create at [01/11/2022] 20:26:55

--- File name [_main]
---
Helipad = Helipad or {}
Helipad.Config = nil

-- local function initPlayer()
--     if (ESX.GetPlayerData().job ~= nil and Helipad.Config[ESX.GetPlayerData().job["name"]] ~= nil) then
--         local selectedHelipad = Helipad.Config[ESX.GetPlayerData().job["name"]]
--         local currentJob = ESX.GetPlayerData().job
--         while (ESX.GetPlayerData().job ~= nil and ESX.GetPlayerData().job["name"] == currentJob.name and Helipad.Config[ESX.GetPlayerData().job["name"]] ~= nil) do
--             local loopInterval = 1000

--             local playerPed = PlayerPedId()
--             local playerCoords = GetEntityCoords(playerPed)

--             if (selectedHelipad.menuPosition ~= nil and (#(playerCoords-selectedHelipad.menuPosition) < 1.5)) then
--                 loopInterval = 0
--                 ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir l'héliport.")
--                 if IsControlJustPressed(0, 51) then
--                     Helipad:spawnMenu()
--                 end
--             elseif (selectedHelipad.menuPosition ~= nil and (#(playerCoords-selectedHelipad.menuPosition) < 10.0)) then
--                 loopInterval = 0
--                 DrawMarker(Config.Get.Marker.Type, selectedHelipad.menuPosition, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
--             end

--             Wait(loopInterval)
--         end
--     end
-- end

CreateThread(function()
    Wait(5000)

    while (Helipad.Config == nil) do
        TriggerServerEvent("Helipad:Request:LoadConfig")
        Wait(1000)
    end

    -- initPlayer()
end)

-- AddEventHandler('esx:setJob', function(job)
--     initPlayer()
-- end)

RegisterNetEvent("Helipad:ClientReturn:Config", function(helipadConfig)
    Helipad.Config = helipadConfig or {};
end)


CreateThread(function()
    while true do
        local Loop = 2000

        if (Helipad.Config ~= nil) then
            if (Helipad.Config[ESX.GetPlayerData().job["name"]] ~= nil) then
                Loop = 1000

                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)

                local selectedHelipad = Helipad.Config[ESX.GetPlayerData().job["name"]]

                if (selectedHelipad.menuPosition ~= nil and (#(playerCoords-selectedHelipad.menuPosition) < 1.5)) then
                    Loop = 0
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir l'héliport.")
                    if IsControlJustPressed(0, 51) then
                        Helipad:spawnMenu()
                    end
                elseif (selectedHelipad.menuPosition ~= nil and (#(playerCoords-selectedHelipad.menuPosition) < 10.0)) then
                    Loop = 0
                    DrawMarker(Config.Get.Marker.Type, selectedHelipad.menuPosition, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                end
            end
        end

        Wait(Loop)
    end
end)