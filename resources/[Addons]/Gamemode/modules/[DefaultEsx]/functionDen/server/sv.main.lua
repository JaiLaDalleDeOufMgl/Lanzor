ESX.RegisterServerCallback("DEN:GetFirstName", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
   cb(xPlayer.getFirstName())
end)
ESX.RegisterServerCallback("'DEN:GetLastName", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
   cb(xPlayer.getLastName())
end)