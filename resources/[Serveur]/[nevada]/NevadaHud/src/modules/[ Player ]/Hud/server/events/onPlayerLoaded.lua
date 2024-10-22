RegisterServerEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(source, xPlayer)
    TriggerClientEvent('Gamemode:Hud:UpdatePlayersCount', source, GetNumPlayerIndices())
end)