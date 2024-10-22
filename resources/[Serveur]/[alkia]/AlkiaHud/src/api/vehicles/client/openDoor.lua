---openDoor
---@param vehicleId number
---@param doorId number
---@param canBeClosed boolean
---@param instantly boolean
---@return void
---@public
function API_Vehicles:openDoor(vehicleId, doorId, canBeClosed, instantly)
    if (not (DoesEntityExist(vehicleId))) then
        return print("Target vehicle doesn't exist")
    end
    if (doorId < 0 or doorId > 5) then
        return print("Target door doesn't exist. Put a doorId between 0 and 5")
    end

    return SetVehicleDoorOpen(vehicleId, doorId, canBeClosed or false, instantly or false)
end