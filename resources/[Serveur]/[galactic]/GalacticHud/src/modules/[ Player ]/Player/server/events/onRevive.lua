RegisterNetEvent('Gamemode:Player:onRevive')
AddEventHandler('Gamemode:Player:onRevive', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    
    TriggerEvent("Gamemode:Player:playerRevived", xPlayer.source)
end)