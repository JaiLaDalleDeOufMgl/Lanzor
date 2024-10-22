function MOD_Vehicle:IsSpawnPointClear(coords, maxDistance)
    local vehicles = self:GetInArea(coords, maxDistance);
    local vehicleCount = 0;
    
    for _, _ in pairs(vehicles) do
        vehicleCount = (vehicleCount + 1);
    end

    return vehicleCount == 0
end