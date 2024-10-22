RegisterNetEvent('Gamemode:Keys:LockVehicle')
AddEventHandler('Gamemode:Keys:LockVehicle', function(vehiclePlate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local vehicle = MOD_Vehicle:GetVehicleByPlate(vehiclePlate)

    if (xPlayer) then
        if (vehicle) then
            if (vehicle:IsPlayerHasKey(xPlayer)) then
                vehicle:SetLocked(true)
            end
        end
    end
end)