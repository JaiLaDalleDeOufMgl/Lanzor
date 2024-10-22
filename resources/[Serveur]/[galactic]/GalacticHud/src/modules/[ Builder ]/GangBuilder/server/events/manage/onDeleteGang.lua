RegisterNetEvent('Gamemode:GangBuilder:DeleteGang')
AddEventHandler('Gamemode:GangBuilder:DeleteGang', function(gangId)
    local Gang = MOD_GangBuilder:getGangById(gangId)
    local xPlayer = ESX.GetPlayerFromId(source)

    if (MOD_GangBuilder:GetPlayerHasAccesAdmin(xPlayer)) then
        return
    end

    if (Gang) then
        for license in pairs(Gang:GetAllMembre()) do
            Gang:RemoveMembre(license, true)
        end

        MOD_GangBuilder:deleteGangById(Gang.id)
    end
end)