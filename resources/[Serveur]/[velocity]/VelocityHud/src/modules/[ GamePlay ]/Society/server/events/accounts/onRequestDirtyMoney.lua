RegisterNetEvent('Gamemode:Society:RequestDirtyMoney')
AddEventHandler('Gamemode:Society:RequestDirtyMoney', function(societyName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local society = MOD_Society:getSocietyByName(societyName)

    if (society) then
        if (society:IsPlayerBoss(xPlayer)) then
            TriggerClientEvent('Gamemode:Society:ReceiveDirtyMoney', xPlayer.source, society:GetDirtyMoney())
        else
            DropPlayer(xPlayer.source, ""..exports.Tree:serveurConfig().Serveur.label.." : Vous n'êtes pas le patron de cette entreprise.")
        end
    end

end)