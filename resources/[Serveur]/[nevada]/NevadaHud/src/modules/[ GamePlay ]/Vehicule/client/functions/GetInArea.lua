function MOD_Vehicle:GetInArea(coords, distance)
    local vehiclesInPool = GetGamePool("CVehicle")
    local vehicles = {}

    for _, vehicle in pairs(vehiclesInPool) do
        local vehicleDist = #(vector3(coords.x, coords.y, coords.z) - GetEntityCoords(vehicle))

        if vehicleDist <= distance then
            vehicles[#vehicles + 1] = vehicle
        end
    end
    
    return vehicles
end