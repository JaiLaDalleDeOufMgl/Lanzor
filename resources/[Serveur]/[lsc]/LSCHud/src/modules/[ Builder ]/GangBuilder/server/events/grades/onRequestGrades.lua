RegisterNetEvent('Gamemode:GangBuilder:RequestGrades')
AddEventHandler('Gamemode:GangBuilder:RequestGrades', function(gangId)
    local xPlayer = ESX.GetPlayerFromId(source)
    local Gang = MOD_GangBuilder:getGangById(gangId)

    if (Gang) then
        if (Gang:DoesPlayerExist(xPlayer)) then
            TriggerClientEvent('Gamemode:GangBuilder:ReceiveGrades', xPlayer.source, Gang:GetAllGrades())
        end
    end
end)