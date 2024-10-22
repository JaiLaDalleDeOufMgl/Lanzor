RegisterCommand('annonceRadius', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() ~= "user" then
        if #args < 2 then
            xPlayer.showNotification("Utilisation: /annonceRadius [radius] [message]")
            return
        end
        local zoneRadius = tonumber(args[1])
        local message = table.concat(args, " ", 2) -- "2" signifie qu'on prend tous les arguments après le premier
        TriggerClientEvent('tree:getPlayerRadius', source, zoneRadius, message)
    else
        xPlayer.showNotification("Vous n'avez pas la permission d'utiliser cette commande.")
    end
end, false)



RegisterNetEvent('tree:sendMessageInZone', function(playerCoords, radius, message)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getGroup() ~= "user" then
        local players = ESX.GetPlayers()
        for _, playerId in ipairs(players) do
            local xPlayer = ESX.GetPlayerFromId(playerId)
            if xPlayer then
                local targetCoords = GetEntityCoords(GetPlayerPed(playerId))
                if #(playerCoords - targetCoords) <= radius then
                    TriggerClientEvent("tree:sendScaleform", playerId, message)
                end
            end
        end
    else
        DropPlayer(_source, "Vous n'avez pas la permission d'utiliser cette commande.")
    end
end)