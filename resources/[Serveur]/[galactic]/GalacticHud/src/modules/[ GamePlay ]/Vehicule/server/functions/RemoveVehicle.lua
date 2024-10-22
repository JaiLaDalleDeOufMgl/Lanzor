function MOD_Vehicle:RemoveVehicle(plate, callback)
    local vPlate = plate

    if (self.list[vPlate]) then
        local vehicle = self.list[vPlate]
        local handle = vehicle:GetHandle()

        if (callback) then callback() end

        if (DoesEntityExist(handle)) then
            DeleteEntity(handle)
        end

        self.list[vPlate] = nil

        return true
    end

    return false
end