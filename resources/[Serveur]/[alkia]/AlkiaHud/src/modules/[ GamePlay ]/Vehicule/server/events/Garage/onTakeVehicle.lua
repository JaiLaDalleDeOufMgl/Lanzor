RegisterNetEvent('Gamemode:Garage:TakeVehicle')
AddEventHandler('Gamemode:Garage:TakeVehicle', function(vehiclePlate, positionOut)
    local xPlayer = ESX.GetPlayerFromId(source)
    local vPlate = vehiclePlate

    if xPlayer and vPlate then
        -- Validation de la plaque d'immatriculation
        if not vPlate:match("^[A-Z0-9]+$") then
            xPlayer.showNotification("Erreur: Plaque d'immatriculation invalide.")
            return
        end

        if MOD_Vehicle:GetVehicleByPlate(vPlate) then
            MySQL.Async.execute("UPDATE owned_vehicles SET stored = @stored WHERE plate = @plate", {
                ["@stored"] = 0,
                ["@plate"] = vPlate
            })

            TriggerClientEvent('Gamemode:Garage:RefreshVehicles', xPlayer.source)
            return xPlayer.showNotification(
            "Vous devez aller chercher votre véhicule là où vous l'avez stationné, s'il vous a été volé, merci de contacter les forces de l'ordre.")
        end

        MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND stored = 1", {
            ["@owner"] = xPlayer.getIdentifier(),
            ["@plate"] = vPlate
        }, function(result)
            if #result > 0 then
                local ped = GetPlayerPed(xPlayer.source)
                local props = json.decode(result[1].vehicle)

                if positionOut then
                    TriggerClientEvent('Gamemode:Garage:RefreshVehicles', xPlayer.source)
                    MOD_Vehicle:CreateVehicle(props.model, positionOut, positionOut["heading"], result[1].plate,
                        xPlayer.getIdentifier(), function(vehicle, defaultProperties)
                        if vehicle then
                            vehicle:ServerSideSetProperties(props, xPlayer, function()
                                vehicle:SetLocked(true)
                                SetTimeout(1000, function()
                                    local vehicleHandle = vehicle:GetHandle()
                                    if DoesEntityExist(vehicleHandle) then
                                        SetPedIntoVehicle(ped, vehicleHandle, -1)
                                    else
                                        print(
                                        "Erreur : Le handle du véhicule est invalide après application des propriétés.")
                                    end
                                end)
                            end)

                            MySQL.Async.execute("UPDATE owned_vehicles SET stored = @stored WHERE plate = @plate", {
                                ["@stored"] = 0,
                                ["@plate"] = result[1].plate
                            })
                        else
                            xPlayer.showNotification("Erreur: La création du véhicule a échoué.")
                        end
                    end, xPlayer)
                else
                    TriggerClientEvent('Gamemode:Garage:RefreshVehicles', xPlayer.source)
                    xPlayer.showNotification("Erreur: Position de sortie non valide.")
                end
            else
                TriggerClientEvent('Gamemode:Garage:RefreshVehicles', xPlayer.source)
                xPlayer.showNotification("Erreur: Aucun véhicule trouvé avec cette plaque.")
            end
        end)
    end
end)
