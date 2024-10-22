RegisterNetEvent('Gamemode:Keys:UnlockVehicle')
AddEventHandler('Gamemode:Keys:UnlockVehicle', function(vehiclePlate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local vehicle = MOD_Vehicle:GetVehicleByPlate(vehiclePlate)

    if (xPlayer) then
        if (vehicle) then
            if (vehicle:IsPlayerHasKey(xPlayer)) then
                vehicle:SetLocked(false)
            end
        end
    end
end)