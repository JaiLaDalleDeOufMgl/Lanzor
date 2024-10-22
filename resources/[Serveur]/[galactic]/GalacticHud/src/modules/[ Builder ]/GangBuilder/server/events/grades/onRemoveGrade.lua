RegisterNetEvent('Gamemode:GangBuilder:RemoveGrade')
AddEventHandler('Gamemode:GangBuilder:RemoveGrade', function(gradeName, gangId)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Gang = MOD_GangBuilder:getGangById(gangId)

    if (Gang) then
        if (Gang:DoesPlayerExist(xPlayer)) then

            if (not Gang:GetPlayerGradeByLicense(xPlayer.identifier, "BossRemoveGrade")) then return end

            Gang:RemoveGrade(gradeName)

        end
    end
end)