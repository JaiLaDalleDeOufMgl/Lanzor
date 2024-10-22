function _GamemodeGangBuilder:UpdateEvent(eventName, ...)
    local players = ESX.GetPlayers();

    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i]);

        if (player) then
            if (player.job2.name == self.name) then
                TriggerClientEvent(eventName, player.source, ...)
            end
        end
    end
end