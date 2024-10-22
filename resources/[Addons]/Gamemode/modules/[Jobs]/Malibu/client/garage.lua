
OpenMenu = false
local mainMenuGarageMalibu = RageUI.CreateMenu("", "Garage Malibu")
mainMenuGarageMalibu.Closed = function()
    OpenMenu = false
end

function OpenMainMenuGarageMalibu()
    if OpenMenu then
        OpenMenu = false
        RageUI.Visible(mainMenuGarageMalibu, false)
        return
    else
        OpenMenu = true
        RageUI.Visible(mainMenuGarageMalibu, true)
        CreateThread(function()
            while OpenMenu do
                Wait(1)
                RageUI.IsVisible(mainMenuGarageMalibu, function()
                    if inServiceMalibu then
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
                        for k,v in pairs(Config.Jobs.Malibu.Garage.vehicles) do 
                            RageUI.Button(v.label, nil, {RightLabel = "→→→"}, true, {
                                onSelected = function()
                                    ESX.Game.SpawnLocalVehicle(v.model, vector3(-843.06304931641, -1225.4244384766, 6.8788056373596), 59.987186431885, function(vehicle)
                                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                        SetVehicleNumberPlateText(vehicle, "MALIBU")
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
        local distance = #(playerCoords - Config.Jobs.Malibu.Garage.position)
        if distance < 10 and ESX.PlayerData.job.name == "bahamas" then
            timer = 0
            if distance < 3 then
                DrawMarker(22, Config.Jobs.Malibu.Garage.position, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, exports.Tree:serveurConfig().Serveur.colorMarkers.r, exports.Tree:serveurConfig().Serveur.colorMarkers.g, exports.Tree:serveurConfig().Serveur.colorMarkers.b, 255, 55555, false, true, 2, false, false, false, false)
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage")
                if IsControlJustPressed(0, 51) then
                    OpenMainMenuGarageMalibu()
                end
            end
        elseif distance > 5.0 and distance < 15.0 then
            timer = 750
        end
        Wait(timer)
    end
end)
