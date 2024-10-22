RegisterNetEvent('Gamemode:Society:RequestGrades')
AddEventHandler('Gamemode:Society:RequestGrades', function(societyName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local society = MOD_Society:getSocietyByName(societyName)

    if (society) then
        if (society:IsPlayerBoss(xPlayer)) then
            TriggerClientEvent('Gamemode:Society:ReceiveGrades', xPlayer.source, society:GetGrades())
        else
            DropPlayer(xPlayer.source, "["..exports.Tree:serveurConfig().Serveur.label.."] : Vous n'êtes pas le patron de cette entreprise.")
        end
    end
end)