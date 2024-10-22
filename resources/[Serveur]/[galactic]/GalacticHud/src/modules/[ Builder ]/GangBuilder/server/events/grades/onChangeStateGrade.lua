RegisterNetEvent('Gamemode:GangBuilder:ChangeStateGrade')
AddEventHandler('Gamemode:GangBuilder:ChangeStateGrade', function(gradeName, accesName, state, gangId)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Gang = MOD_GangBuilder:getGangById(gangId)

    if (Gang) then
        if (Gang:DoesPlayerExist(xPlayer)) then

            if (not Gang:GetPlayerGradeByLicense(xPlayer.identifier, "BossModifGrade")) then return end

            Gang:ModifGrade(gradeName, accesName, state)

        end
    end
end)