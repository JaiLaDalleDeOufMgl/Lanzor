local menu = {}
local finalPrice = Gamemode.enums.Pound.Prices['SpawnVehicle']

local PoundSpawnV = Gamemode.enums.Pound.Prices['SpawnVehicle']

function menu:LoadMenu(parent)
    menu.Menu = RageUI.CreateSubMenu(parent, "", "Fourrières")

    menu.Menu:IsVisible(function(Items)
        local vehicle = MOD_Vehicle.Pound.DataVehicle
        local CurrentPound = MOD_Vehicle.Pound.Data

        if (not vehicle) then
            Items:Separator("Chargement du véhicule")
        else
            print(type(exports.Tree:getVip().level))

            if exports.Tree:getVip().level == 0 then
                Items:Separator("Vous n'avez pas d'assurance.")
                finalPrice = PoundSpawnV
            elseif exports.Tree:getVip().level == 1 then
                Items:Separator("Vous avez une assurance " .. exports.Tree:getVip().label .. ".")
                finalPrice = PoundSpawnV / 100 * 80
            elseif exports.Tree:getVip().level == 2 then
                Items:Separator("Vous avez une assurance " .. exports.Tree:getVip().label .. ".")
                finalPrice = PoundSpawnV / 100 * 60
            elseif exports.Tree:getVip().level == 3 then
                Items:Separator("Vous avez une assurance " .. exports.Tree:getVip().label .. ".")
                finalPrice = PoundSpawnV / 100 * 40
            else
                finalPrice = PoundSpawnV
            end

            Items:Separator("Véhicule: " .. vehicle.plate)
            Items:Button("Sortir le véhicule", nil,
                { RightLabel = "Prix: " .. ESX.Math.Round(finalPrice) .. " ~g~$" }, true, {
                    onSelected = function()
                        local position = CurrentPound['Spawn']

                        if (MOD_Vehicle:IsSpawnPointClear(position, 2)) then
                            TriggerServerEvent('Gamemode:Pound:TakeVehicle', vehicle.plate, position)

                            MOD_Vehicle.Pound.vehicles = nil

                            RageUI.CloseAll()
                        else
                            ESX.ShowNotification(GetConvar("Color", "") .. "L'emplacement est occupé.")
                        end
                    end
                });
        end
    end, nil, function()
        MOD_Vehicle.Garage.DataVehicle = {}
    end)
end

return menu
