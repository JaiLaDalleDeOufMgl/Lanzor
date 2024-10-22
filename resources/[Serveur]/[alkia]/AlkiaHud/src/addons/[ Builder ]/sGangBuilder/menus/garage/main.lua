MOD_GangBuilder.Menus.MainGangGarage = RageUI.CreateMenu("", "Gang garage")

local function SizeOf(table)
    local size = 0;
    for _, data in pairs(table) do
        if (data ~= nil) then
            size = size + 1
        end
    end
    return size;
end

local function IsVehicleOwned(owner)
    if (ESX.PlayerData.identifier == owner) then
        return "~g~POSSÉDÉ";
    else
        return "SOCIÉTÉ";
    end
end

MOD_GangBuilder.Menus.GangGarageSelect = require 'src.addons.[ Builder ].sGangBuilder.menus.garage.submenus.index'
MOD_GangBuilder.Menus.GangGarageSelect:LoadMenu(MOD_GangBuilder.Menus.MainGangGarage)


MOD_GangBuilder.Menus.MainGangGarage:IsVisible(function(Items)
    local vehicles = MOD_GangBuilder.data.vehicles

    if (not vehicles) then
        Items:Separator("Chargement des véhicules")
    else
        if (SizeOf(vehicles) > 0) then
            for plate, vehicle in pairs(vehicles) do
                if (vehicle) then
                    local isStored = false

                    if (vehicle.stored == 1) then
                        isStored = true
                    end

                    local vehicleName = GetDisplayNameFromVehicleModel(vehicle.model);

                    Items:Button(("%s ~c~[%s%s~c~]~s~"):format(vehicleName, "", plate), nil,
                        {
                            RightLabel = isStored and IsVehicleOwned(vehicle.owner) or "SORTIE~s~",
                        }, isStored, {
                            onSelected = function()
                                MOD_GangBuilder.Menus.GangGarageSelect:SetData(plate)
                            end

                        }, MOD_GangBuilder.Menus.GangGarageSelect.Menu)
                end
            end
        else
            Items:Separator()
            Items:Separator("Aucun véhicule.")
            Items:Separator()
        end
    end
end, nil, function()
    MOD_GangBuilder.data = {}
end)


RegisterNetEvent('Gamemode:GangBuilder:OpenGangGarage')
AddEventHandler('Gamemode:GangBuilder:OpenGangGarage', function(gangVehicles, gangInfos)
    MOD_GangBuilder.Menus.MainGangGarage:Toggle()

    MOD_GangBuilder.data.infos = gangInfos
    MOD_GangBuilder:SetVehicles(gangVehicles)
end)
