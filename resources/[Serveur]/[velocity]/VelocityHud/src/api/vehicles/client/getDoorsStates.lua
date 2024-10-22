---getDoorsStates
---@param vehicleId number
---@return number
---@public
function API_Vehicles:getDoorsStates(vehicleId)
    if (not (DoesEntityExist(vehicleId))) then
        return print("Target vehicle doesn't exist")
    end

    local state  = (GetVehicleDoorLockStatus(vehicleId))
    return (state)
end