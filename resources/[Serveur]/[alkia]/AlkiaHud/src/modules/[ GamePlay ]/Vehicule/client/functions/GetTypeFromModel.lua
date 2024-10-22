function MOD_Vehicle:GetTypeFromModel(model)
    model = (type(model) == "string" and GetHashKey(model)) or model

    if (IsModelAVehicle(model)) then
        local vehicle_class = GetVehicleClassFromName(model)
        return (vehicle_class == 14 and "boat") or ((vehicle_class == 15 or vehicle_class == 16) and "plane") or "car"
    end
end