function MOD_Player:HasBeenKilled(deathCause)
    local playerPed = PlayerPedId();
    local victimCoords = GetEntityCoords(playerPed);

    local data = {
        victimCoords = {x = API_Maths:round(victimCoords.x, 1), y = API_Maths:round(victimCoords.y, 1), z = API_Maths:round(victimCoords.z, 1)},

        killedByPlayer = false,
        deathCause = deathCause
    }

    TriggerServerEvent("Gamemode:Player:onDeath", data)
    self:Process();
end