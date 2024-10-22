

---@author Razzway

RegisterServerEvent(_Prefix..":refreshData")
AddEventHandler(_Prefix..":refreshData", function()
    local playerSrc = source
    local xPlayer = ESX.GetPlayerFromId(playerSrc)

    MySQL.Async.fetchAll('SELECT * FROM clothes_data WHERE identifier = @identifier', {
        ["@identifier"] = xPlayer.identifier
    }, function(result)
        TriggerClientEvent(_Prefix..":sendData", playerSrc, result)
    end)
end)