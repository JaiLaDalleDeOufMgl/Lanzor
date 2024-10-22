RegisterKeyMapping('opencoffre', 'Ouvrir le coffre vehicule', 'keyboard', 'L')
RegisterCommand("opencoffre", function()
    openmenuvehicle()
end)

function openmenuvehicle()
    if (MOD_inventory.class:getPlayerInInventory()) then return end

    local playerCoords = GetEntityCoords(PlayerPedId())

    if IsPedInAnyVehicle(PlayerPedId(), false) then
        ESX.ShowNotification("Vous ne pouvez ouvrir le coffre ici !")
        return
    else
        local closestVehicle, closestDistance = API_Vehicles:getClosest(vector3(playerCoords.x, playerCoords.y,
            playerCoords.z))

        if (closestDistance > 5.0) then
            ESX.ShowNotification("Aucun véhicule à proximité")
            return
        end

        if (GetVehicleDoorLockStatus(closestVehicle) == 2) then
            TriggerEvent("esx:showNotification", "Ce coffre est fermé.")
        else
            if (not closestVehicle or closestVehicle == 0) then
                ESX.ShowNotification("Aucun véhicule à proximité")
            else
                ExecuteCommand("me Ouvre le coffre du véhicule...")

                TriggerServerEvent("Gamemode:Inventory:OpenSecondInventory", "vehicule",
                    NetworkGetNetworkIdFromEntity(closestVehicle))
            end
        end
    end
end

function VehicleInFront()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 4.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10,
        GetPlayerPed(-1), 0)
    local a, b, c, d, result = GetRaycastResult(rayHandle)

    return result
end
