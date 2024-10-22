

---@author Razzway

RegisterNetEvent(_Prefix..':accessories:pay')
AddEventHandler(_Prefix..':accessories:pay', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = _Config.clotheshop.accessoriesPrice
    if xPlayer.getAccount('cash').money >= price then
        xPlayer.removeAccountMoney('cash', price)
        TriggerClientEvent('esx:showNotification', source,exports.Tree:serveurConfig().Serveur.color.."Nouvel accessoire~s~\n~g~"..price.." $~s~ vous ont été prélevés de votre portefeuille.")
        TriggerClientEvent(_Prefix..':saveSkin', source)
    else
        TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color.."Il semblerait que vous ne possédiez pas l'argent nécessaire.")
    end
end)

RegisterNetEvent(_Prefix..':outfit:pay')
AddEventHandler(_Prefix..':outfit:pay', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = _Config.clotheshop.price
    if xPlayer.getAccount('cash').money >= price then
        xPlayer.removeAccountMoney('cash', price)
        TriggerClientEvent('esx:showNotification', source,exports.Tree:serveurConfig().Serveur.color.."Vêtement - Nouvelle tenue~s~\n~g~"..price.." $~s~ vous ont été prélevés de votre portefeuille.")
        TriggerClientEvent(_Prefix..':saveSkin', source)
    else
        TriggerClientEvent('esx:showNotification', source, exports.Tree:serveurConfig().Serveur.color.."Il semblerait que vous ne possédiez pas l'argent nécessaire.")
    end
end)