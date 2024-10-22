RegisterNetEvent('Gamemode:Society:ReceiveEmployees')
AddEventHandler('Gamemode:Society:ReceiveEmployees', function(employees)
    MOD_Society:SetEmployees(employees)
end)