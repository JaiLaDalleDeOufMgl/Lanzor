RegisterNetEvent('Gamemode:GangBuilder:PoundTakeVehicle')
AddEventHandler('Gamemode:GangBuilder:PoundTakeVehicle', function(vehiclePlate, spanwCoord)
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then
        local playerGang = xPlayer.job2.name

        if (playerGang ~= "unemployed2") then
            local Gang = MOD_GangBuilder:getGangByName(playerGang)

            if (Gang) then
                if (Gang:DoesPlayerExist(xPlayer)) then
                    local ped = GetPlayerPed(xPlayer.source)
                    local vehicleData = Gang:GetVehicle(vehiclePlate)

                    if (not Gang:IsVehicleOut(vehiclePlate)) then
                        local playerMoney = xPlayer.getAccount("cash")
                        local pricePound = Gamemode.enums.Pound.Prices['SpawnVehicle']

                        if (playerMoney and pricePound) then
                            if (playerMoney.money >= pricePound) then
                                xPlayer.removeAccountMoney("cash", pricePound)

                                if (vehicleData) then
                                    MOD_Vehicle:CreateVehicle(vehicleData.data.model,
                                        vector3(spanwCoord.x, spanwCoord.y, spanwCoord.z), spanwCoord.h or 0.0,
                                        vehiclePlate, Gang.name, function(vehicle)
                                        Gang:RemoveVehicle(vehiclePlate, vehicle)

                                        vehicle:ServerSideSetProperties(vehicleData.data, xPlayer, function()
                                            SetPedIntoVehicle(ped, vehicle:GetHandle(), -1)

                                            vehicle:SetLocked(false)
                                        end)

                                        Gang:UpdateEvent("Gamemode:GangBuilder:ReceiveVehicle", vehiclePlate,
                                            Gang:GetVehicle(vehiclePlate))
                                    end, xPlayer)
                                end
                            else
                                xPlayer.showNotification("Vous n'avez pas assez d'argent pour sortir ce véhicule.")
                            end
                        end
                    else
                        xPlayer.showNotification(
                        "Ce véhicule est indisponible, vous devez le retrouver là où vous l'avez laissé.")
                    end
                end
            end
        end
    end
end)
