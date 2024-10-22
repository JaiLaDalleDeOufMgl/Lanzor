---

--- Create at [01/11/2022] 20:40:50

--- File name [spawnMenu]
---

function Helipad:spawnMenu()
    local playerData = ESX.GetPlayerData()
    local playerJob = playerData.job
    local playerPed = PlayerPedId()

    local selectedHelipad = Helipad.Config[playerJob.name]
    if (selectedHelipad == nil) then
        return
    end

    local mainMenu = RageUI.CreateMenu("", "Héliport")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while (mainMenu ~= nil) do
        local playerCoords = GetEntityCoords(playerPed)

        RageUI.IsVisible(mainMenu, function()
            RageUI.Separator("Liste des véhicules")
            for i = 1, #selectedHelipad.models do
                local currentModel = selectedHelipad.models[i]
                if (currentModel ~= nil) then
                    RageUI.Button(currentModel, nil, {
                        RightLabel = "Prendre →"
                    }, true, {
                        onSelected = function()
                            local spawnPosition = selectedHelipad.spawnPosition
                            local thepos = vector3(spawnPosition.x, spawnPosition.y, spawnPosition.z)
                            ESX.Game.SpawnVehicle(currentModel, thepos, 128.78, function (vehicle)
                                local newPlate = exports['Gamemode']:GeneratePlate()
                                SetVehicleNumberPlateText(vehicle, newPlate)
                                exports[exports.Tree:serveurConfig().Serveur.hudScript]:SetFuel(vehicle, 100)
                                TriggerServerEvent('babyboy:GiveDoubleKeys', 'no', newPlate)
                                TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                            end)

                            if (spawnPosition ~= nil and not ESX.Game.IsSpawnPointClear(vector3(spawnPosition.x, spawnPosition.y, spawnPosition.z), 2.0)) then
                                return ESX.ShowNotification("Aucune place libre.")
                            end

                            TriggerServerEvent("Helipad:Spawn", i)
                        end
                    })
                end
            end
        end)

        if (not RageUI.Visible(mainMenu) or #(playerCoords-selectedHelipad.menuPosition) > 1.5) then
            mainMenu = RMenu:DeleteType('mainMenu', true)
        end
        Wait(0)
    end
end