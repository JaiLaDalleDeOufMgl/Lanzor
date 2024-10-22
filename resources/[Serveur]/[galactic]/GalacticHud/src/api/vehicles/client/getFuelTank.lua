---getFuelTank
---@param vehicleId number
---@return number
---@public
function API_Vehicles:getFuelTank(vehicleId)
    if (not (DoesEntityExist(vehicleId))) then
        return print("Target vehicle doesn't exist")
    end

    ---@type number
    local fuel  = GetVehicleHandlingFloat(vehicleId, "CHandlingData", "fPetrolTankVolume")
    return (fuel)
end