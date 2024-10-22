RegisterNetEvent('Gamemode:Society:ReceiveMoney')
AddEventHandler('Gamemode:Society:ReceiveMoney', function(number)
    MOD_Society:SetMoney(number)
end)