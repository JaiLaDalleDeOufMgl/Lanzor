local cached_players = {}

AddEventHandler('playerDropped', function (reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    local pCoords = GetEntityCoords(GetPlayerPed(source))
    
    cached_players[source] = {res = reason, date = xPlayer.name, coords = pCoords}

    TriggerClientEvent("utils:playerDisconnect", -1, source, {res = reason, date = xPlayer.name, pos = pCoords})
end)
