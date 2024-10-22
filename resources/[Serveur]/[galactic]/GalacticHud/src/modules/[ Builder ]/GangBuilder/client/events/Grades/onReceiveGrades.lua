RegisterNetEvent('Gamemode:GangBuilder:ReceiveGrades')
AddEventHandler('Gamemode:GangBuilder:ReceiveGrades', function(grades)
    MOD_GangBuilder:SetGrades(grades)
end)