function MOD_CoffreVehicule:openVehiculeByNetId(xPlayer, netId)
    local selectedEntity = NetworkGetEntityFromNetworkId(netId)
    if (selectedEntity == 0) then
        return
    end

    local vehiclePlate = GetVehicleNumberPlateText(selectedEntity)
    local vehicleModel = GetEntityModel(selectedEntity)

    local VehDistWithPlayer = #(GetEntityCoords(selectedEntity) - GetEntityCoords(GetPlayerPed(xPlayer.source)))
    if (VehDistWithPlayer > 5.0) then
        return
    end

    if (GetVehicleDoorLockStatus(selectedEntity) == 2) then
        TriggerClientEvent("esx:showNotification", xPlayer.source, "Ce coffre est fermé.")
    else
        local SelectVehiculeTrunk = MOD_CoffreVehicule:GetVehiculeTrunkByPlate(vehiclePlate)

        if (not SelectVehiculeTrunk) then
            MySQL.Async.fetchAll("SELECT * FROM trunk_inventory WHERE vehiclePlate = @vehiclePlate", {
                ['@vehiclePlate'] = vehiclePlate
            }, function(result)
                if (not result[1]) then
                    MOD_CoffreVehicule:getVehiculeAsOwner(vehiclePlate, vehicleModel, function(hasOwner)
                        if (hasOwner) then
                            SelectVehiculeTrunk = _GamemodeCoffreVehicule(json.encode({}), vehicleModel, vehiclePlate,
                                hasOwner, false)
                        else
                            MOD_CoffreVehicule:getVehiculeAsGangOwner(vehiclePlate, function(inSociety)
                                SelectVehiculeTrunk = _GamemodeCoffreVehicule(json.encode({}), vehicleModel, vehiclePlate,
                                    inSociety, false)
                            end)
                        end
                    end)
                else
                    SelectVehiculeTrunk = _GamemodeCoffreVehicule(result[1].items, result[1].vehicleModel,
                        result[1].vehiclePlate, true, true)
                end
            end)
        end

        while (not SelectVehiculeTrunk) do
            Wait(50)
        end

        if (SelectVehiculeTrunk:getModel() == vehicleModel) then
            SelectVehiculeTrunk.inventoryClass:updateSecondInventory(xPlayer.source)
            SelectVehiculeTrunk.inventoryClass:addPlayer(xPlayer.source)

            xPlayer.set('SecondInvData', SelectVehiculeTrunk)
        else
            return
        end
    end
end
