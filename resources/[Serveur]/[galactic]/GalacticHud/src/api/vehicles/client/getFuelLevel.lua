---getFuelLevel
---@param vehicleId number
---@public
function API_Vehicles:getFuelLevel(vehicleId)
    if (not (DoesEntityExist(vehicleId))) then
        return print("Target vehicle doesn't exist")
    end

    return GetVehicleFuelLevel(vehicleId)
end