local menu = {}

function menu:SetData(data)
    menu.DataMenu = data
end

function menu:LoadMenu(parent)
    menu.Menu = RageUI.CreateSubMenu(parent, "", "Garage")

    menu.Menu:IsVisible(function(Items)
        local plate = menu.DataMenu
        local vehicle = MOD_GangBuilder.data.vehicles[plate]

        if (vehicle) then
            Items:Button("Sortir le véhicule", nil, {

                RightBadge = RageUI.BadgeStyle.Car

            }, true, {

                onSelected = function()
                    if (vehicle) then
                        local coords = MOD_GangBuilder.data.infos.spawnPos;

                        if (MOD_Vehicle:IsSpawnPointClear(coords, 2)) then
                            TriggerServerEvent('Gamemode:GangBuilder:TakeVehicle', MOD_GangBuilder.data.infos.id, plate)

                            RageUI.CloseAll()
                        else
                            ESX.ShowNotification("L'emplacement est occupé.");
                        end
                    else
                        ESX.ShowNotification("Une erreur est survenue~s~, Code erreur: " ..
                        exports.Tree:serveurConfig().Serveur.color .. "'Society_Take_Vehicle'");
                    end
                end
            });

            Items:Button("Récupérer mon véhicule", nil, {

                RightBadge = RageUI.BadgeStyle.Car

            }, MOD_GangBuilder:IsVehicleOwner(plate), {

                onSelected = function()
                    if (plate) then
                        TriggerServerEvent('Gamemode:GangBuilder:RetrievePlayerVehicle', MOD_GangBuilder.data.infos.id,
                            plate)

                        RageUI.CloseAll()
                    else
                        ESX.ShowNotification("Une erreur est survenue~s~, Code erreur: " ..
                        exports.Tree:serveurConfig().Serveur.color .. "'Society_Retrieve_Vehicle'");
                    end
                end
            });
        else
            Items:Separator("Chargement du véhicule...")
        end
    end)
end

return menu
