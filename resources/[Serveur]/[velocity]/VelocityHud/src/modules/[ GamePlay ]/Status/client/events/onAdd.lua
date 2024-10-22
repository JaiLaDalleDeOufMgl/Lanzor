RegisterNetEvent('esx_status:add')
AddEventHandler('esx_status:add', function(name, value)
    MOD_Status:addStatus(name, value)
end)