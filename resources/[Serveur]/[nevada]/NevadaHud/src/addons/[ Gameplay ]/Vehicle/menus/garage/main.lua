MOD_Vehicle.Menu.MainGarage = RageUI.CreateMenu("", "Garage")

MOD_Vehicle.Menu.GarageVehicle = require 'src.addons.[ Gameplay ].Vehicle.menus.garage.submenus.index'
MOD_Vehicle.Menu.GarageVehicle:LoadMenu(MOD_Vehicle.Menu.MainGarage)


local function isParked(stored)
    local parked = "~g~Disponible";
    local out = "Sortie";

    if (stored == 1 or stored == 2) then
        return parked, true;
    else
        return out, false;
    end
end

MOD_Vehicle.Menu.MainGarage:IsVisible(function(Items)
    if (not MOD_Vehicle.Garage.vehicles) then
        Items:Separator("Chargement des véhicules")
    else
        if (#MOD_Vehicle.Garage.vehicles > 0) then
            local CurrentGarage = MOD_Vehicle.Garage.Data
            local vehicles = MOD_Vehicle.Garage.vehicles

            for i = 1, #vehicles do
                if (vehicles[i] ~= nil) then
                    vehicles[i].type = MOD_Vehicle:GetTypeFromModel(vehicles[i].model)

                    local vehicle_is_bone = (vehicles[i].type ~= nil and CurrentGarage ~= nil and ((CurrentGarage["Type"] == "vehicle" and vehicles[i].type == "car") or (CurrentGarage["Type"] == vehicles[i].type))) and
                    true or false;

                    if (vehicle_is_bone == true) then
                        local vehicleName = GetDisplayNameFromVehicleModel(vehicles[i].model);
                        local isStored, enabled = isParked(vehicles[i].stored);

                        Items:Button(("%s ~c~[%s%s~c~]~s~"):format(vehicleName, "~g~", vehicles[i].plate),
                            (not enabled and "Appuyez pour ~g~localiser~s~ votre véhicule."),
                            {
                                RightLabel = isStored,
                                RightBadge = (not enabled and RageUI.BadgeStyle.Lock)
                            }, true,
                            {
                                onSelected = function()
                                    if (enabled) then
                                        MOD_Vehicle.Garage.DataVehicle = vehicles[i]
                                    else
                                        -- Shared.Events:ToServer(Enums.Garage.Events.LocateVehicle, vehicles[i].plate)
                                    end
                                end

                            }, (enabled and MOD_Vehicle.Menu.GarageVehicle.Menu))
                    end
                end
            end
        else
            Items:Separator()
            Items:Separator("Aucun véhicule.")
            Items:Separator()
        end
    end
end, nil, function()
    MOD_Vehicle.Garage.Data = {}
end)
