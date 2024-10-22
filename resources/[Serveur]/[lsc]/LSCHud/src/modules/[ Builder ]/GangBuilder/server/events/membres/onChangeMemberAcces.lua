RegisterNetEvent('Gamemode:GangBuilder:ChangeMemberAcces')
AddEventHandler('Gamemode:GangBuilder:ChangeMemberAcces', function(license, name, gangId)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Gang = MOD_GangBuilder:getGangById(gangId)

    if (Gang) then
        if (Gang:DoesPlayerExist(xPlayer)) then

            if (not Gang:GetPlayerGradeByLicense(xPlayer.identifier, "BossModifMembre")) then return end

            Gang:ModifMembre(license, name)

        end
    end
end)