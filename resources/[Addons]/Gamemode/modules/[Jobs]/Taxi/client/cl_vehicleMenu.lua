---

--- Create at [31/10/2022] 12:18:11

--- File name [vehicleMenu]
---

function Taxi:vehicleMenu()
    local menuPosition = Taxi.Config.vehicle.menuPosition
    local mainMenu = RageUI.CreateMenu("", "Garage")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while (mainMenu) do
        local playerCoords = GetEntityCoords(PlayerPedId())

        RageUI.IsVisible(mainMenu, function()
             if ServiceTaxi then
                RageUI.Separator("Liste des véhicules")

                for k,v in pairs(Taxi.Config.vehicle.model) do
                    RageUI.Button(GetLabelText(GetDisplayNameFromVehicleModel(k)), nil, {
                        RightLabel = "Prendre →"
                    }, true, {
                        onSelected = function()
                            if ServiceTaxi then 
                                ESX.Game.SpawnVehicle(v.name, vector3(-1603.0594482422, -817.96423339844, 9.9909610748291), 314.66, function (vehicle)
                                    local newPlate = exports['Gamemode']:GeneratePlate()
                                    SetVehicleNumberPlateText(vehicle, newPlate)
                                    exports[exports.Tree:serveurConfig().Serveur.hudScript]:SetFuel(vehicle, 100)
                                    TriggerServerEvent('babyboy:GiveDoubleKeys', 'no', newPlate)
                                    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                end)
                                TriggerServerEvent("Taxi:Spawn:Vehicle")
                                RageUI.CloseAll()
                            else
                                ESX.ShowNotification("~r~Vous devez etre en service pour prendre un véhicule de service !")
                            end
                        end
                    })
                end
            else
                RageUI.Separator("Vous devez etre en service !")
            end
        end)

        Wait(0)
    end
end