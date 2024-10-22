function _GamemodeGangBuilder:SetVehicleOut(plate, vehicle)
    self.vehiclesOut[plate] = vehicle:GetHandle()
end