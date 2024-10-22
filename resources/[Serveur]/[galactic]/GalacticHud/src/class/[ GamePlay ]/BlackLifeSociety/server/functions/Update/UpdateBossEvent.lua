function GamemodeSociety:UpdateBossEvent(eventName, ...)
    local players = GetPlayers()
    local args = {...}

    for i=1, #players do
        local xPlayer = ESX.GetPlayerFromId(players[i])

        if (xPlayer) then
            if (self:IsPlayerBoss(xPlayer)) then
                TriggerClientEvent(eventName, xPlayer.source, #args > 0 and table.unpack(args))
            end
        end
    end
end