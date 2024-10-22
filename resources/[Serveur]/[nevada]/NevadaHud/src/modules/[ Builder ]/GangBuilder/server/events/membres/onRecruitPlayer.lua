RegisterNetEvent('Gamemode:GangBuilder:RecruitPlayer')
AddEventHandler('Gamemode:GangBuilder:RecruitPlayer', function(targetId, gangId, gangName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(targetId)
    local Gang = MOD_GangBuilder:getGangById(gangId) or MOD_GangBuilder:getGangByName(gangName)

    if (Gang) then
        if (Gang:DoesPlayerExist(xPlayer)) then

            if (not Gang:GetPlayerGradeByLicense(xPlayer.identifier, "BossAddMembre")) then return end

            targetPlayer.setJob2(Gang.name, 0)
            targetPlayer.showNotification(string.format(Gamemode.enums.GangBuilder.Notification['PlayerRecruit'], Gang.name))

            Gang:SaveOnBdd()
        end
    end
end)