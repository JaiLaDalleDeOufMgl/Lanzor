---clean
---@param vehicleId number
---@public
function API_Vehicles:clean(vehicleId)
    if (not (DoesEntityExist(vehicleId))) then
        return print("Target vehicle doesn't exist")
    end

    SetVehicleDirtLevel(vehicleId, 0.0)
    WashDecalsFromVehicle(vehicleId, 1.0)
end