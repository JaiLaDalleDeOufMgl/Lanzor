RegisterNetEvent('Gamemode:Society:RequestMoney')
AddEventHandler('Gamemode:Society:RequestMoney', function(societyName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local society = MOD_Society:getSocietyByName(societyName)

    if (society) then
        if (society:IsPlayerBoss(xPlayer)) then
            TriggerClientEvent('Gamemode:Society:ReceiveMoney', xPlayer.source, society:GetMoney())
        else
            DropPlayer(xPlayer.source, ""..exports.Tree:serveurConfig().Serveur.label.." : Vous n'êtes pas le patron de cette entreprise.")
        end
    end

end)