RegisterNetEvent('Gamemode:GangBuilder:TakeVehicle')
AddEventHandler('Gamemode:GangBuilder:TakeVehicle', function(gangId, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Gang = MOD_GangBuilder:getGangById(gangId)

    if (Gang) then
        if (Gang:DoesPlayerExist(xPlayer)) then
            local ped = GetPlayerPed(xPlayer.source)
            local vehicleMod = Gang:GetVehicle(plate)

            if (not Gang:IsVehicleOut(plate)) then
                if (vehicleMod) then
                    MOD_Vehicle:CreateVehicle(vehicleMod.data.model, Gang.posSpawnVeh, 0.0, plate, Gang.name,
                        function(vehicle)
                            Gang:RemoveVehicle(plate, vehicle)

                            vehicle:ServerSideSetProperties(vehicleMod.data, xPlayer, function()
                                SetPedIntoVehicle(ped, vehicle:GetHandle(), -1)

                                vehicle:SetLocked(false)
                            end)

                            Gang:UpdateEvent("Gamemode:GangBuilder:ReceiveVehicle", plate, Gang:GetVehicle(plate))
                        end, xPlayer)
                end
            else
                xPlayer.showNotification(
                "Ce véhicule est indisponible, vous devez le retrouver là où vous l'avez laissé.")
            end
        end
    end
end)
