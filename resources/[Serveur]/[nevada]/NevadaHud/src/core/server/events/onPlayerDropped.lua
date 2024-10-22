AddEventHandler("playerDropped", function(reason)
    local src = source;
    local xPlayer = ESX.GetPlayerFromId(src);

    if (xPlayer) then

        API_Logs:Info(string.format("Player ^7[^0id: ^4%s^0, identifier: ^4%s^0, name: ^4%s^7]^0 disconnected. Reason: ^7[^4%s^7]^0", xPlayer.source, xPlayer.identifier, xPlayer.name, reason))
    end
end)