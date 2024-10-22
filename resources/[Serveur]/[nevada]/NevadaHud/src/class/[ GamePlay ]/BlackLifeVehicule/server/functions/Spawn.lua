function _GamemodeVehicule:Spawn(callback)

    local vehicle
    local event

    event = AddEventHandler('entityCreated', function(entity)
        if (entity == vehicle) then
            RemoveEventHandler(event)
            self.handle = vehicle
            SetEntityDistanceCullingRadius(self.handle, 25000)
            self.networkId = NetworkGetNetworkIdFromEntity(self.handle)

            if (self.plate ~= nil) then
                SetVehicleNumberPlateText(self.handle, self.plate)
            else
                self.plate = GetVehicleNumberPlateText(self.handle)
            end

            if (callback) then 
                callback(self.handle) 
            end

            while (GetVehicleNumberPlateText(self.handle) ~= self.plate) do
                SetVehicleNumberPlateText(self.handle, self.plate)
                Wait(1000)
            end
        end
    end)

    vehicle = CreateVehicle(self.model, self.position.x or 0, self.position.y or 0, self.position.z or 0, self.heading or 0, true, true);
end