function _GamemodeGangBuilder:DeleteVehicle(plate)
    if (self.vehicles[plate]) then
        self.vehiclesOut[plate] = nil
        self.vehicles[plate] = nil

        self:UpdateBdd('vehicules', json.encode(self.vehicles))
    end
end