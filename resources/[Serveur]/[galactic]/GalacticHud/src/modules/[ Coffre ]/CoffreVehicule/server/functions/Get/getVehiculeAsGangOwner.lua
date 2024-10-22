function MOD_CoffreVehicule:getVehiculeAsGangOwner(vehiclePlate, cb)
    local results = MySQL.Sync.fetchAll("SELECT vehicules FROM GangBuilder", {})
    local HavePlate = false

    for i=1, #results, 1 do
        if (results[i].vehicles ~= nil) then
            local Vehicles = json.decode(results[i].vehicles)

            if (next(Vehicles) ~= nil) then
                for plate in pairs(Vehicles) do
                    if (vehiclePlate == plate) then
                        HavePlate = true
                    end
                end
            end
        end
    end

    cb(HavePlate)
end