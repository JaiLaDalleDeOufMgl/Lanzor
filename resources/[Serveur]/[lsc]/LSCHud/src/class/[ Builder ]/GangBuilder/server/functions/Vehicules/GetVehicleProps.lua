function _GamemodeGangBuilder:GetVehicleProps(plate)
    return self.vehicles[plate] and self.vehicles[plate].data
end