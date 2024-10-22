function _GamemodeGangBuilder:IsVehicleOut(plate)
    return self.vehicles[plate] and self.vehicles[plate].stored ~= 1 and self:DoesVehicleOutExist(plate)
end