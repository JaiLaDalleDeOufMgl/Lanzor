---getPlate
---@param vehicleId number
---@return string
---@public
function API_Vehicles:getPlate(vehicleId)
    if (not (DoesEntityExist(vehicleId))) then
        return print("Target vehicle doesn't exist")
    end

    local plate  = (GetVehicleNumberPlateText(vehicleId))
    return (plate)
end

