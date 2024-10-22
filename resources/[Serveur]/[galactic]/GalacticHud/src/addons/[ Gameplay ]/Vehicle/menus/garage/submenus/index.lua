local menu = {}

function menu:LoadMenu(parent)
    menu.Menu = RageUI.CreateSubMenu(parent, "", "Garage")

    menu.Menu:IsVisible(function(Items)
        Items:Button("Conduire", nil, {}, true, {
            onSelected = function()
                local vehicle = MOD_Vehicle.Garage.DataVehicle
                local position = MOD_Vehicle.Garage.Data['Out']
                if (MOD_Vehicle:IsSpawnPointClear(position, 2)) then
                    print(json.encode(vehicle))
                    TriggerServerEvent('Gamemode:Garage:TakeVehicle', vehicle.plate, position)
                    MOD_Vehicle.Garage.vehicles = nil
                    RageUI.CloseAll()
                else
                    ESX.ShowNotification("L'emplacement est occupé.")
                end
            end
        });
    end, nil, function()
        MOD_Vehicle.Garage.DataVehicle = {}
    end)
end

return menu
