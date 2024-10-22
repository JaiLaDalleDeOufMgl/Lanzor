local function removeFromTable(plate, xPlayer)
    if (MOD_Vehicle.vehiclesOut[plate]) then
        MOD_Vehicle.vehiclesOut[plate] = nil;
    end

    xPlayer.showNotification("~g~Vous avez rangé votre véhicule.");
end

RegisterNetEvent('Gamemode:Garage:ParkVehicle')
AddEventHandler('Gamemode:Garage:ParkVehicle', function(vehiclePlate, properties)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner AND plate = @plate", {
        ["@owner"] = xPlayer.getIdentifier(),
        ["@plate"] = vehiclePlate,
    }, function(result)
        if (result[1] ~= nil) then
            local vehicle = MOD_Vehicle:GetVehicleByPlate(vehiclePlate)

            if (vehicle) then
                TaskLeaveVehicle(GetPlayerPed(xPlayer.source), vehicle:GetHandle(), 0)

                MySQL.Async.execute("UPDATE owned_vehicles SET stored = 1, vehicle = @props WHERE plate = @plate", {
                    ["@plate"] = vehiclePlate,
                    ["@props"] = json.encode(properties),
                });

                SetTimeout(1500, function()
                    removeFromTable(vehiclePlate, xPlayer);
                    MOD_Vehicle:RemoveVehicle(vehiclePlate);
                end);
            else
                xPlayer.showNotification("Une erreur est survenue")
            end
        else
            xPlayer.showNotification("Vous ne posséder pas ce véhicule.")
        end
    end)
end)
