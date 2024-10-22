RegisterServerEvent("tree:location:buyVehicleLocation")
AddEventHandler("tree:location:buyVehicleLocation", function(v)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getAccount('cash').money >= v.price then
        xPlayer.removeAccountMoney('cash', v.price)
        TriggerClientEvent("tree:location:spawnVehicleLocation", _source, v.model, v.spawnVehicle)
    else
        xPlayer.showNotification(Tree.Config.Serveur.color.."Vous n'avez pas assez d'argent")
    end
end)