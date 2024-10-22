

RegisterServerEvent('barbershop:pay')
AddEventHandler('barbershop:pay', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
  local price = 15
  if price <= xPlayer.getAccount('cash').money then
    xPlayer.removeAccountMoney('cash', 15)
    TriggerClientEvent('esx:showNotification', _source, "Vous avez payé "..exports.Tree:serveurConfig().Serveur.color.."15$")
  else
    xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Vous n'avez pas assez d'argent !");
  end
end)
