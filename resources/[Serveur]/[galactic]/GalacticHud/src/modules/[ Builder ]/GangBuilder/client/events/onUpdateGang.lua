RegisterNetEvent('Gamemode:GangBuilder:UpdateGang')
AddEventHandler('Gamemode:GangBuilder:UpdateGang', function(type, data)
    MOD_GangBuilder.data[type] = data
end)