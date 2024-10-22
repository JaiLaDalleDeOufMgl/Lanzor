RegisterNetEvent('Gamemode:Society:ReceiveDirtyMoney')
AddEventHandler('Gamemode:Society:ReceiveDirtyMoney', function(number)
    MOD_Society:SetDirtyMoney(number)
end)