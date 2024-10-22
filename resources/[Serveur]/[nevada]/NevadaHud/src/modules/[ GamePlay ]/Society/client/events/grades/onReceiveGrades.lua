RegisterNetEvent('Gamemode:Society:ReceiveGrades')
AddEventHandler('Gamemode:Society:ReceiveGrades', function(grades)
    MOD_Society:SetGrades(grades)
end)