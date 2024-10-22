function MOD_Vehicle:CreateVehicle(model, position, heading, plate, owner, callback, xPlayer)
    local vehicle = _GamemodeVehicule(model, position, heading, plate, owner)

    vehicle:Spawn(function(handle)
        local vPlate = vehicle:GetPlate()

        if (self.list[vPlate]) then
            self.list[vPlate] = nil
        end

        self.list[vPlate] = vehicle

        if callback then 
            callback(vehicle) 
        end
    end)
end