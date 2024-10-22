ESX.RegisterServerCallback('catalogue:getCatalogue', function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM vehicle_categories', {}, function(result)
        cb(result)
    end)
end)

ESX.RegisterServerCallback('catalogue:getAllVehicles', function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM vehicles', {
    }, function(result)
        cb(result)
    end)
end)

RegisterServerEvent('catalogue:changeBucket')
AddEventHandler('catalogue:changeBucket', function(reason)
    local source = source
    if reason == "enter" then
        SetPlayerRoutingBucket(source, source+1)
    else
        SetPlayerRoutingBucket(source, 0)
    end
end)