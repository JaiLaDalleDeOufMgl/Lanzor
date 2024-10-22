RegisterNetEvent("Gamemode:Player:onDeath")
AddEventHandler("Gamemode:Player:onDeath", function(deathData)
    local xPlayer = ESX.GetPlayerFromId(source)

    --LOGS A METRE

    TriggerEvent("Gamemode:Player:playerDied", xPlayer.source)
end)