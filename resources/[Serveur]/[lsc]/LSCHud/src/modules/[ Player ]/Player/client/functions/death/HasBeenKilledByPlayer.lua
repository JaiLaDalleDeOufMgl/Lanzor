function MOD_Player:HasBeenKilledByPlayer(killerServerId, killerClientId, deathCause)
    local playerPed = PlayerPedId();
    local victimCoords = GetEntityCoords(playerPed);
    local killerPed = GetPlayerPed(killerClientId);
    local killerCoords = GetEntityCoords(killerPed);
    local distance = #(victimCoords - killerCoords);

    local data = {
        victimCoords = {x = API_Maths:round(victimCoords.x, 1), y = API_Maths:round(victimCoords.y, 1), z = API_Maths:round(victimCoords.z, 1)},
        killerCoords = {x = API_Maths:round(killerCoords.x, 1), y = API_Maths:round(killerCoords.y, 1), z = API_Maths:round(killerCoords.z, 1)},

        killedByPlayer = true,
        deathCause = deathCause,
        distance = API_Maths:round(distance, 1),

        killerServerId = killerServerId,
        killerClientId = killerClientId
    }

    TriggerServerEvent("Gamemode:Player:onDeath", data)
    self:Process();
end