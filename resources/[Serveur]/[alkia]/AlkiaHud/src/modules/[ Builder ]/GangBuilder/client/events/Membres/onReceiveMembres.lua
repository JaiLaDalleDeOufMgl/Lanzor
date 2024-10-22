RegisterNetEvent('Gamemode:GangBuilder:ReceiveMembres')
AddEventHandler('Gamemode:GangBuilder:ReceiveMembres', function(membres)
    MOD_GangBuilder:SetMembres(membres)
end)