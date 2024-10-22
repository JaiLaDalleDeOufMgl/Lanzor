AddEventHandler("esx:playerLoaded", function(playerSrc)
    local xPlayer = ESX.GetPlayerFromId(playerSrc);

    if (xPlayer) then
        local ipHost = GetPlayerEndpoint(xPlayer.source);

        API_Logs:Success(string.format("Player ^7[^0id: ^4%s^0, ^0identifier: ^4%s^0, ^0name: ^4%s^0, ^0ip: ^4%s^7]^0 has been loaded. ^7(^0Group: ^4%s^7)^0",                xPlayer.source,
            xPlayer.identifier,
            xPlayer.name,
            ipHost,
            xPlayer.getGroup()
        ))
    end
end);