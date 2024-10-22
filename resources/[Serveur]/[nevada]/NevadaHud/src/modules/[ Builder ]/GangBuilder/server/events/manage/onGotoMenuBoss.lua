RegisterNetEvent('Gamemode:GangBuilder:GotoMenuBoss')
AddEventHandler('Gamemode:GangBuilder:GotoMenuBoss', function(gangId)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Gang = MOD_GangBuilder:getGangById(gangId)

    if (MOD_GangBuilder:GetPlayerHasAccesAdmin(xPlayer)) then
        return
    end

    if (Gang) then
        if (xPlayer) then
            SetEntityCoords(GetPlayerPed(xPlayer.source), Gang.posBoss.coords.x, Gang.posBoss.coords.y, Gang.posBoss.coords.z)
        end
    end
end)