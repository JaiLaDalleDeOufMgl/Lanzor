function MOD_Vehicle:GetFuel(entity)
    if (entity == nil or not DoesEntityExist(entity)) then
        return
    end

    if (not DecorExistOn(entity, "vehicle.fuel")) then
        DecorSetFloat(entity, "vehicle.fuel", GetVehicleFuelLevel(entity))
    end

    return DecorGetFloat(entity, "vehicle.fuel")
end