---setFuel
---@param vehicleId number
---@param fuel number
---@public
function API_Vehicles:setFuel(vehicleId, fuel)
    if (not (DoesEntityExist(vehicleId))) then
        return print("Target vehicle doesn't exist")
    end

    return SetVehicleFuelLevel(vehicleId, fuel)
end
