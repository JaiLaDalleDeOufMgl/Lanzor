RegisterNetEvent('Gamemode:GangBuilder:ParkVehicule')
AddEventHandler('Gamemode:GangBuilder:ParkVehicule', function(plate, gangId, properties)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Gang = MOD_GangBuilder:getGangById(gangId)

    if (Gang) then
        if (Gang:DoesPlayerExist(xPlayer)) then
            MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE plate = @plate", {
                ["@plate"] = plate
            }, function(result)
                local isOwned = #result > 0;

                if (isOwned) then
                    if (result[1].boutique ~= nil and (result[1].boutique == 1 or result[1].boutique == true)) then
                        xPlayer.showNotification("Ce véhicule provient de la boutique. Impossible de le stocker ici.")
                    else
                        local vehicle = MOD_Vehicle:GetVehicleByPlate(plate)

                        if (vehicle) then
                            if (result[1].owner == xPlayer.getIdentifier()) then
                                MySQL.Async.fetchAll("DELETE FROM owned_vehicles WHERE plate=@plate AND owner=@owner", {
                                    ["@plate"] = plate,
                                    ["@owner"] = xPlayer.getIdentifier()
                                }, function()
                                    if (Gang:AddVehicle(plate, properties, xPlayer.getIdentifier())) then
                                        MOD_Vehicle:RemoveVehicle(plate)

                                        Gang:UpdateEvent("Gamemode:GangBuilder:ReceiveVehicle", plate,
                                            Gang:GetVehicle(plate))
                                    end
                                end)
                            else
                                xPlayer.showNotification("Ce véhicule ne vous appartient pas.")
                            end
                        end
                    end
                else
                    local vehicle = MOD_Vehicle:GetVehicleByPlate(plate)

                    if (vehicle) then
                        local societyVehicle = Gang:GetVehicle(plate)

                        if (societyVehicle) then
                            if (Gang:AddVehicle(plate, properties, societyVehicle.owner)) then
                                MOD_Vehicle:RemoveVehicle(plate)

                                Gang:UpdateEvent("Gamemode:GangBuilder:ReceiveVehicle", plate, Gang:GetVehicle(plate))
                            end
                        else
                            xPlayer.showNotification("Ce véhicule n'appartient pas à votre société.")
                        end
                    else
                        xPlayer.showNotification("Ce véhicule ne vous appartient pas.")
                    end
                end
            end);
        end
    end
end)
