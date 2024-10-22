local finalPrice = 0

RegisterNetEvent('Gamemode:Pound:TakeVehicle')
AddEventHandler('Gamemode:Pound:TakeVehicle', function(vehiclePlate, positionOut)
    local source = source
    local fivem = GetPlayerIdentifierByType(source, "fivem")
    local xPlayer = ESX.GetPlayerFromId(source)
    local vPlate = vehiclePlate


    if (xPlayer) then
        local PoundSpawnV = Gamemode.enums.Pound.Prices['SpawnVehicle']

        if exports.Tree:getVip(fivem).level == 0 then
            finalPrice = PoundSpawnV
        elseif exports.Tree:getVip(fivem).level == 1 then
            finalPrice = PoundSpawnV / 100 * 80
        elseif exports.Tree:getVip(fivem).level == 2 then
            finalPrice = PoundSpawnV / 100 * 60
        elseif exports.Tree:getVip(fivem).level == 3 then
            finalPrice = PoundSpawnV / 100 * 40
        else
            finalPrice = PoundSpawnV
        end

        local Notif = "Vous avez payé " .. ESX.Math.Round(finalPrice) .. "~g~$"

        if (MOD_Vehicle.vehiclesOut[vPlate]) then
            if (DoesEntityExist(MOD_Vehicle.vehiclesOut[vPlate])) then
                TriggerClientEvent('Gamemode:Pound:RefreshVehicles', xPlayer.source)
                return xPlayer.showNotification(
                    "Vous devez aller chercher votre véhicule là où vous l'avez stationné, s'il vous a été voler merci de contacter les forces de l'ordre.")
            end

            MOD_Vehicle.vehiclesOut[vPlate] = nil
        end

        local Account = xPlayer.getAccount("cash");

        if (Account) then
            local HaveMoney = (Account.money >= finalPrice)

            if (HaveMoney) then
                MySQL.Async.fetchAll(
                    "SELECT * FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND stored = 0", {
                        ["@owner"] = xPlayer.getIdentifier(),
                        ["@plate"] = vPlate
                    }, function(result)
                        if (#result > 0) then
                            local ped = GetPlayerPed(xPlayer.source)
                            local props = json.decode(result[1].vehicle)

                            if (positionOut) then
                                TriggerClientEvent('Gamemode:Pound:RefreshVehicles', xPlayer.source)

                                MOD_Vehicle:CreateVehicle(props.model, positionOut, positionOut["heading"],
                                    result[1].plate,
                                    xPlayer.getIdentifier(), function(vehicle, defaultProperties)
                                        MOD_Vehicle.vehiclesOut[result[1].plate] = vehicle:GetHandle()

                                        xPlayer.showNotification(Notif)

                                        vehicle:ServerSideSetProperties(props, xPlayer, function()
                                            SetPedIntoVehicle(ped, vehicle:GetHandle(), -1)

                                            vehicle:SetLocked(false)
                                        end)
                                    end, xPlayer)
                            else
                                TriggerClientEvent('Gamemode:Pound:RefreshVehicles', xPlayer.source)
                                xPlayer.showNotification("Une erreur est survenue")
                            end
                        else
                            TriggerClientEvent('Gamemode:Pound:RefreshVehicles', xPlayer.source)
                            xPlayer.showNotification("Une erreur est survenue")
                        end
                    end)
            else
                TriggerClientEvent('Gamemode:Pound:RefreshVehicles', xPlayer.source)
                xPlayer.showNotification("Vous n'avez pas assez d'argent")
            end
        else
            TriggerClientEvent('Gamemode:Pound:RefreshVehicles', xPlayer.source)
            xPlayer.showNotification("Une erreur est survenue")
        end
    end
end)
