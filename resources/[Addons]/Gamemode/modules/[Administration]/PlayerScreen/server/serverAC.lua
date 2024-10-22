local webhook = exports.Tree:serveurConfig().Logs.StaffScreenPlayers

ESX.RegisterServerCallback('screenshot:getwebhook', function(source, cb)
    cb(exports.Tree:serveurConfig().Logs.StaffScreenPlayers)
end)

RegisterNetEvent("GameCore:TakeScreen")
AddEventHandler("GameCore:TakeScreen", function(source)
    TriggerClientEvent('GameCore:GetScreen', source)
end)

ESX.AddGroupCommand('screen', 'helpeur', function(source, args, user)
    local xPlayer = ESX.GetPlayerFromId(args[1])
    local sourcePlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Screen Joueurs", content = "----Début des screen du joueur "..xPlayer.name.." demander par "..sourcePlayer.name.."----"}), { ['Content-Type'] = 'application/json' })
        Citizen.Wait(2000)
	    TriggerEvent('GameCore:TakeScreen', args[1])
        Citizen.Wait(4000)
        TriggerEvent('GameCore:TakeScreen', args[1])
        Citizen.Wait(4000)
        TriggerEvent('GameCore:TakeScreen', args[1])
        Citizen.Wait(4000)
        TriggerEvent('GameCore:TakeScreen', args[1])
        Citizen.Wait(4000)
        TriggerEvent('GameCore:TakeScreen', args[1])
        Citizen.Wait(4000)
        TriggerEvent('GameCore:TakeScreen', args[1])
        Citizen.Wait(2000)
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Screen Joueurs", content = "----Fin des screen du joueur "..xPlayer.name.." demander par "..sourcePlayer.name.."----"}), { ['Content-Type'] = 'application/json' })
    else
        ESX.ChatMessage(source, "Le joueur n'est pas en ligne.")
    end
end, {help = "screen", params = {
    {name = "screen", help = "ID du joueurs"}
}})