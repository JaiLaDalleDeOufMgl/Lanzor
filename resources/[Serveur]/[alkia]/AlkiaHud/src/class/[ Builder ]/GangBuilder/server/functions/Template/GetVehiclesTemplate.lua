function _GamemodeGangBuilder:GetVehiclesTemplate()
    local payload = {}

    for plate, vehicle in pairs(self.vehicles) do
        payload[plate] = {
            model = vehicle.data.model,
            stored = vehicle.stored,
            owner = vehicle.owner
        }
    end

    return (payload)
end