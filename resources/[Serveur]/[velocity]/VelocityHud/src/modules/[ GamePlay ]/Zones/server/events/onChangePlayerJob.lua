RegisterNetEvent('Gamemode:Zones:ChangePlayerJob')
AddEventHandler('Gamemode:Zones:ChangePlayerJob', function(type, job)
    TriggerClientEvent('Gamemode:Zones:onRemoveAllZoneJobType', source, type)

    MOD_Zones:loadZonesByJob(source, job)
end)