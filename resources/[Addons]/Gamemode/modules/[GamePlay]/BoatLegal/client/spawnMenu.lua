

Citizen.CreateThread(function()
    while ESX == nil do
        Wait(500)
    end
    while ESX.GetPlayerData().job == nil do
        Wait(500)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

function BoatLegal:spawnMenu()
    local playerData = ESX.GetPlayerData()
    local playerJob = playerData.job
    local playerPed = PlayerPedId()

    local selectedBoatLegal = BoatLegal.Config[playerJob.name]
    if (selectedBoatLegal == nil) then
        return
    end

    local mainMenu = RageUI.CreateMenu("", "Garage Bateau")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while (mainMenu ~= nil) do
        local playerCoords = GetEntityCoords(playerPed)

        RageUI.IsVisible(mainMenu, function()
            RageUI.Separator("Liste des véhicules")
            for i = 1, #selectedBoatLegal.models do
                local currentModel = selectedBoatLegal.models[i]
                if (currentModel ~= nil) then
                    RageUI.Button(currentModel, nil, {
                        RightLabel = "Prendre →"
                    }, true, {
                        onSelected = function()
                            local spawnPosition = selectedBoatLegal.spawnPosition
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

                            TriggerServerEvent("BoatLegal:Spawn", i)
                        end
                    })
                end
            end
        end)

        if (not RageUI.Visible(mainMenu) or #(playerCoords-selectedBoatLegal.menuPosition) > 1.5) then
            mainMenu = RMenu:DeleteType('mainMenu', true)
        end
        Wait(0)
    end
end