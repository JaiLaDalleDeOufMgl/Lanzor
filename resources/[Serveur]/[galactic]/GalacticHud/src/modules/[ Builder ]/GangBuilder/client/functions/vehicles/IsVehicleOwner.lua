function MOD_GangBuilder:IsVehicleOwner(plate)
    return self.data.vehicles and self.data.vehicles[plate] and self.data.vehicles[plate].owner == ESX.PlayerData.identifier
end