exports("SpawnVehicle", function(model, position, heading, plate, locked, xPlayer, owner, callback)
    MOD_Vehicle:CreateVehicle(model, position, heading, plate, owner, function(vehicle)
        vehicle:SetLocked(locked ~= nil and locked or false)

        if (callback) then
            callback(vehicle)
        end
    end, xPlayer)
end)