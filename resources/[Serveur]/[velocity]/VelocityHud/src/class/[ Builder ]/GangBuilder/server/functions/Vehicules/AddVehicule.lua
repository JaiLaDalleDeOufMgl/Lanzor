function _GamemodeGangBuilder:AddVehicle(plate, properties, owner)
    if (not plate) then return false end
    if (not properties) then return false end

    if (not self.vehicles[plate]) then
        self.vehicles[plate] = {}
    end

    self.vehicles[plate].data = properties
    self.vehicles[plate].stored = 1

    if (owner) then
        self.vehicles[plate].owner = owner
    end

    self:StoreVehicle(plate)
    self:UpdateBdd("vehicules", json.encode(self.vehicles))

    return true
end