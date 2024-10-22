function MOD_Vehicle:SetFuel(entity, fuel)
    if (entity == nil or not DoesEntityExist(entity)) then
        return
    end
    
    if (type(fuel) ~= "number") then return end

    if (fuel < 0) then fuel = 0 end
    if (fuel > 100) then fuel = 100 end

    fuel = (fuel + 0.0)

    DecorSetFloat(entity, "vehicle.fuel", fuel)
    SetVehicleFuelLevel(entity, fuel)
end