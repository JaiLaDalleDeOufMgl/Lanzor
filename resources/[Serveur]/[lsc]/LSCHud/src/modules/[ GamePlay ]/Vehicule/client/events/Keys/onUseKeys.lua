local function playerIsInVehicle()
    if (IsPedInAnyVehicle(PlayerPedId())) then
        return true
    end
end

local function getVehicleAndPlayer()
    local isInVehicle = false;
    local vehicle;
    local distance;

    if (playerIsInVehicle()) then
        vehicle = GetVehiclePedIsIn(PlayerPedId());
        isInVehicle = true;
    else
        vehicle, distance = API_Vehicles:getClosest(GetEntityCoords(PlayerPedId()));;

        if (distance ~= -1 and distance < 5) then
            isInVehicle = true;
        else
            vehicle = nil;
        end
    end

    return vehicle, isInVehicle;
end

RegisterKeyMapping('+UseKeys', "Ouvrir/Fermer Véhicule", 'keyboard', 'U')
RegisterCommand("+UseKeys", function()
    local vehicle = getVehicleAndPlayer();

    if (vehicle) then
        TriggerServerEvent("Gamemode:Keys:RequestPlayerKey", GetVehicleNumberPlateText(vehicle))
    else
        ESX.ShowNotification("Aucun véhicule à proximité.")
    end
end)
