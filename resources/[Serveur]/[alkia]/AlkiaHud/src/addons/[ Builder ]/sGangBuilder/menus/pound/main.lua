MOD_GangBuilder.Menus.MainPound = RageUI.CreateMenu("", "Fourrières gang / orga")

local function GetNumberOfPoundVehicle()
    local vehicles = {}

    for vehiclePlate, vehicle in pairs(MOD_GangBuilder.data.pound.vehicles or {}) do
        if (vehicle) then
            if (vehicle.stored == 0) then
                table.insert(vehicles, vehiclePlate)
            end
        end
    end

    return #vehicles
end


MOD_GangBuilder.Menus.MainPound:IsVisible(function(Items)
    local vehicles = MOD_GangBuilder.data.pound.vehicles

    if (vehicles) then
        if (GetNumberOfPoundVehicle(vehicles) > 0) then
            for vehiclePlate, vehicle in pairs(vehicles) do
                if (vehicle) then
                    if (vehicle.stored == 0) then
                        local vehicleName = GetDisplayNameFromVehicleModel(vehicle.model)

                        Items:Button(("%s ~c~[%s%s~c~]~s~"):format(vehicleName, "", vehiclePlate), nil, {

                            RightBadge = RageUI.BadgeStyle.Car,
                            RightLabel = ("~g~$%s~s~"):format(Gamemode.enums.Pound.Prices["SpawnVehicle"]),

                        }, true, {
                            onSelected = function()
                                local coordsSpawn = MOD_GangBuilder.data.pound.Data["Spawn"];

                                if (MOD_Vehicle:IsSpawnPointClear(coordsSpawn, 2)) then
                                    TriggerServerEvent('Gamemode:GangBuilder:PoundTakeVehicle', vehiclePlate, coordsSpawn)
                                    RageUI.CloseAll()
                                else
                                    ESX.ShowNotification("L'emplacement est occupé.")
                                end
                            end
                        });
                    end
                end
            end
        else
            Items:Separator()
            Items:Separator("Aucun véhicule dans la fourrière.")
            Items:Separator()
        end
    else
        Items:Separator("Chargement des véhicules...")
    end
end, nil, function()
    MOD_GangBuilder.data.pound = {}
end)
