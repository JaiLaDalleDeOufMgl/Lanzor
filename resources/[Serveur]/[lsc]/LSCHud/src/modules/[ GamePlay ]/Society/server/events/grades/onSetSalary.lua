RegisterNetEvent('Gamemode:Society:SetSalary')
AddEventHandler('Gamemode:Society:SetSalary', function(societyName, gradeLevel, newSalary)
    local xPlayer = ESX.GetPlayerFromId(source)
    local society = MOD_Society:getSocietyByName(societyName)

    if (society) then
        if (society:IsPlayerBoss(xPlayer)) then
            society:SetSalary(gradeLevel, tonumber(newSalary))

            society:UpdateBossEvent("Gamemode:Society:ReceiveGrades", society:GetGrades())
        else
            DropPlayer(xPlayer.source, "["..exports.Tree:serveurConfig().Serveur.label.."] : Vous n'êtes pas le patron de cette entreprise.")
        end
    end
end)