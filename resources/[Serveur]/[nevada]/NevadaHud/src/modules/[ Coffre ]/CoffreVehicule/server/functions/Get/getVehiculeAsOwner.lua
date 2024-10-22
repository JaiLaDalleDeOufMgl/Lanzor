function MOD_CoffreVehicule:getVehiculeAsOwner(vehiclePlate, vehicleModel, cb)
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
        ['@plate'] = vehiclePlate
    }, function(result)
        if (not result[1]) then
            -- print('AUCUN PROPRIO')
            cb(false)
        else
            result[1].vehicle = json.decode(result[1].vehicle)
            if (result[1].vehicle["model"] ~= vehicleModel) then
                -- print('AS UN PROPRIO')
                cb(false)
            else
                -- print('AUCUN PROPRIO MODELS')
                cb(true)
            end
        end
    end)
end