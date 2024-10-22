RegisterNetEvent("tree:carwash:washVehicle", function(price)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getAccount('cash').money >= price then
        xPlayer.removeAccountMoney('cash', price)
        xPlayer.showNotification("~g~Votre véhicule a été lavé pour "..Tree.Config.Serveur.color..price.."$")
        TriggerClientEvent("tree:carwash:cleanVehicle", _source)
    else
        xPlayer.showNotification(Tree.Config.Serveur.color.."Vous n'avez pas assez d'argent")
    end
end)