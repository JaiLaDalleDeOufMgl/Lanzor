RegisterNetEvent('Gamemode:Zones:onRemoveAllZoneJobType')
AddEventHandler('Gamemode:Zones:onRemoveAllZoneJobType', function(jobType)
    MOD_Zones:deleteAllByJobType(jobType)
end)