function _GamemodeGangBuilder:RemoveVehicle(plate, vehicle)
    if (self.vehicles[plate]) then
        self.vehicles[plate].stored = 0

        self:SetVehicleOut(plate, vehicle)

        self:UpdateBdd("vehicules", json.encode(self.vehicles))
    end
end