function _GamemodeCoffreVehicule:getMaxWeight()
    local vehicleModel = self:getModel()
    if (vehicleModel) then
        return ConfigGamemodeHud.VehiculeMaxWeight[vehicleModel] or 150.0
    end
end