RegisterNetEvent('Gamemode:GangBuilder:RemoveMembre')
AddEventHandler('Gamemode:GangBuilder:RemoveMembre', function(gangId, license)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Gang = MOD_GangBuilder:getGangById(gangId)

    if (Gang) then
        if (Gang:DoesPlayerExist(xPlayer)) then

            if (not Gang:GetPlayerGradeByLicense(xPlayer.identifier, "BossRemoveMembre")) then return end

            Gang:RemoveMembre(license, true)

        end
    end
end)