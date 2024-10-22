RegisterNetEvent('Gamemode:Society:RequestEmployees')
AddEventHandler('Gamemode:Society:RequestEmployees', function(societyName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local society = MOD_Society:getSocietyByName(societyName)

    if (society) then
        if (society:IsPlayerBoss(xPlayer)) then
            TriggerClientEvent('Gamemode:Society:ReceiveEmployees', xPlayer.source, society:GetEmployees())
        else
            DropPlayer(xPlayer.source, ""..exports.Tree:serveurConfig().Serveur.label.." : Vous n'êtes pas le patron de cette entreprise.")
        end
    end
end)