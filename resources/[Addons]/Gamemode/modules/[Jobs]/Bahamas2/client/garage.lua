OpenMenu = false
local mainMenuGarageBahamas = RageUI.CreateMenu("", "Garage Bahamas")
mainMenuGarageBahamas.Closed = function()
    OpenMenu = false
end

function OpenMainMenuGarageBahamas()
    if OpenMenu then
        OpenMenu = false
        RageUI.Visible(mainMenuGarageBahamas, false)
        return
    else
        OpenMenu = true
        RageUI.Visible(mainMenuGarageBahamas, true)
        CreateThread(function()
            while OpenMenu do
                Wait(1)
                RageUI.IsVisible(mainMenuGarageBahamas, function()
                    if inServiceBahamas then
                        RageUI.Button("Ranger le véhicule", nil, {RightLabel = "→→→"}, true, {
                            onSelected = function()
                                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                                if DoesEntityExist(vehicle) then
                                    ESX.Game.DeleteVehicle(vehicle)
                                    ESX.ShowNotification("~g~Véhicule rangé avec succès.")
                                    RageUI.CloseAll()
                                else
                                    ESX.ShowNotification("~r~Aucun véhicule à proximité ou à ranger.")
                                end
                            end
                        })
                        RageUI.Line()
                        for k,v in pairs(Config.Jobs.Bahamas2.Garage.vehicles) do 
                            RageUI.Button(v.label, nil, {RightLabel = "→→→"}, true, {
                                onSelected = function()
                                    ESX.Game.SpawnLocalVehicle(v.model, vector3(-1394.5545654297, -582.36444091797, 30.164253234863), 298.08413696289, function(vehicle)
                                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                        SetVehicleNumberPlateText(vehicle, "BAHAMAS2")
                                        SetVehicleFuelLevel(vehicle, 100.0)
                                        RageUI.CloseAll()
                                    end)
                                end
                            })
                        end
                    else
                        RageUI.Separator("~r~Vous devez être en service !")
                    end
                end)
            end
        end)
    end
end


CreateThread(function()
    while true do
        timer = 750
        local playerCoords = GetEntityCoords(PlayerPedId())
        local distance = #(playerCoords - Config.Jobs.Bahamas2.Garage.position)
        if distance < 10 and ESX.PlayerData.job.name == "bahamas2" then
            timer = 0
            if distance < 3 then
                DrawMarker(22, Config.Jobs.Bahamas2.Garage.position, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, exports.Tree:serveurConfig().Serveur.colorMarkers.r, exports.Tree:serveurConfig().Serveur.colorMarkers.g, exports.Tree:serveurConfig().Serveur.colorMarkers.b, 255, 55555, false, true, 2, false, false, false, false)
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage")
                if IsControlJustPressed(0, 51) then
                    OpenMainMenuGarageBahamas()
                end
            end
        elseif distance > 5.0 and distance < 15.0 then
            timer = 750
        end
        Wait(timer)
    end
end)
