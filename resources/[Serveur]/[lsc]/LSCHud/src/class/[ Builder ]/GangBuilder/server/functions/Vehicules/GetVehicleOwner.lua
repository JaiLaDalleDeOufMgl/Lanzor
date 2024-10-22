function _GamemodeGangBuilder:GetVehicleOwner(plate)
    return self.vehicles[plate] ~= nil and self.vehicles[plate].owner
end