RegisterNetEvent('NPC:VenteDrugs', function(drugs)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()

	local cops = 0
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' or xPlayer.job.name == 'bcso' then
			cops = cops + 1
		end
	end
	
	if cops >= 0 then
        if drugs == 'Weed' then
            local xPlayer = ESX.GetPlayerFromId(source)
            local QuantityItem = xPlayer.getInventoryItem("weed_pooch")
            local QuantityBuy = math.random(1,10)
            if (QuantityItem) then
                if QuantityItem.count >= QuantityBuy then
                    local PrixWeed = math.random(250,300)
                    local PrixWeedFinal = QuantityBuy * PrixWeed
                    xPlayer.removeInventoryItem("weed_pooch", QuantityBuy)
                    xPlayer.addAccountMoney('dirtycash', PrixWeedFinal)
                    xPlayer.showNotification("Tu as vendu ~y~"..QuantityBuy.. " pochons de Weed pour ~y~"..PrixWeedFinal.."$")
                else
                    xPlayer.showNotification("Le client voulait plus de drogues que ce que tu avais.")
                end
            end
        elseif drugs == 'Coke' then
            local xPlayer = ESX.GetPlayerFromId(source)
            local QuantityItem = xPlayer.getInventoryItem("coke_pooch")
            local QuantityBuy = math.random(1,10)
            if (QuantityItem) then
                if QuantityItem.count >= QuantityBuy then
                    local PrixCoke = math.random(350,400)
                    local PrixCokeFinal = QuantityBuy * PrixCoke
                    xPlayer.removeInventoryItem("coke_pooch", QuantityBuy)
                    xPlayer.addAccountMoney('dirtycash', PrixCokeFinal)
                    xPlayer.showNotification("Tu as vendu ~y~"..QuantityBuy.. " pochons de Coke pour ~y~"..PrixCokeFinal.."$")
                else
                    xPlayer.showNotification("Le client voulait plus de drogues que ce que tu avais.")
                end
            end
        elseif drugs == 'Meth' then
            local xPlayer = ESX.GetPlayerFromId(source)
            local QuantityItem = xPlayer.getInventoryItem("meth_pooch")
            local QuantityBuy = math.random(1,10)
            if (QuantityItem) then
                if QuantityItem.count >= QuantityBuy then
                    local PrixMeth = math.random(400,500)
                    local PrixMethFinal = QuantityBuy * PrixMeth
                    xPlayer.removeInventoryItem("meth_pooch", QuantityBuy)
                    xPlayer.addAccountMoney('dirtycash', PrixMethFinal)
                    xPlayer.showNotification("Tu as vendu ~y~"..QuantityBuy.. " pochons de Meth pour ~y~"..PrixMethFinal.."$")
                else
                    xPlayer.showNotification("Le client voulait plus de drogues que ce que tu avais.")
                end
            end
        elseif drugs == 'Opium' then
            local xPlayer = ESX.GetPlayerFromId(source)
            local QuantityItem = xPlayer.getInventoryItem("opium_pooch")
            local QuantityBuy = math.random(1,10)
            if (QuantityItem) then
                if QuantityItem.count >= QuantityBuy then
                    local PrixMeth = math.random(500,600)
                    local PrixMethFinal = QuantityBuy * PrixMeth
                    xPlayer.removeInventoryItem("opium_pooch", QuantityBuy)
                    xPlayer.addAccountMoney('dirtycash', PrixMethFinal)
                    xPlayer.showNotification("Tu as vendu ~y~"..QuantityBuy.. " pochons d'opium pour ~y~"..PrixMethFinal.."$")
                else
                    xPlayer.showNotification("Le client voulait plus de drogues que ce que tu avais.")
                end
            end
        elseif drugs == 'Ketamine' then
            local xPlayer = ESX.GetPlayerFromId(source)
            local QuantityItem = xPlayer.getInventoryItem("pooch_ketamine")
            local QuantityBuy = math.random(1,10)
            if (QuantityItem) then
                if QuantityItem.count >= QuantityBuy then
                    local PrixMeth = math.random(800,1000)
                    local PrixMethFinal = QuantityBuy * PrixMeth
                    xPlayer.removeInventoryItem("pooch_ketamine", QuantityBuy)
                    xPlayer.addAccountMoney('dirtycash', PrixMethFinal)
                    xPlayer.showNotification("Tu as vendu ~y~"..QuantityBuy.. " pochons de Ketamine pour ~y~"..PrixMethFinal.."$")
                else
                    xPlayer.showNotification("Le client voulait plus de drogues que ce que tu avais.")
                end
            end
        elseif drugs == 'xylazine' then
            local xPlayer = ESX.GetPlayerFromId(source)
            local QuantityItem = xPlayer.getInventoryItem("xylazine_pooch")
            local QuantityBuy = math.random(1,10)
            if (QuantityItem) then
                if QuantityItem.count >= QuantityBuy then
                    local PrixMeth = math.random(1200,1500)
                    local PrixMethFinal = QuantityBuy * PrixMeth
                    xPlayer.removeInventoryItem("xylazine_pooch", QuantityBuy)
                    xPlayer.addAccountMoney('dirtycash', PrixMethFinal)
                    xPlayer.showNotification("Tu as vendu ~y~"..QuantityBuy.. " pochons d'xylazine pour ~y~"..PrixMethFinal.."$")
                else
                    xPlayer.showNotification("Le client voulait plus de drogues que ce que tu avais.")
                end
            end
        end
        else
            TriggerClientEvent('esx:showNotification', _source, 'Il n y a pas assez de ~d~ flics ~s~ en service!')
        end
end)

-- Appel LSPD 
RegisterNetEvent("NPCVente:AppelLSPD", function(coords)
    local xPlayers	= ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' or xPlayer.job.name == 'bcso' then
            TriggerClientEvent('NPCVente:AffichageAppel', xPlayers[i], coords)
        end
    end
end)