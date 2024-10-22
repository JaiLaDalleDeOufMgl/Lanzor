local vv = true

RegisterNetEvent("stop")
AddEventHandler("stop", function()
    vv = false
end)

function recolte(source)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local pos = xPlayer.getCoords(true)
    local dist = #(pos - ConfigBurgerShotFarm.Recolte.recolte)
    local item = "carton__ingredient_burgershot"
    local burger = xPlayer.getInventoryItem(item)
    if xPlayer.getJob().name == "burgershot" then 
        if dist >= 10 then
            TriggerClientEvent("ShowNotif", src, "~g~Vous avez arrêté la récolte avec succès", 4000, src)
            TriggerClientEvent("rcverif", src)
        else
            if xPlayer.canCarryItem(item, 1) then
                TriggerClientEvent("ShowNotif", src, "~g~ +1 Carton de ingrédient BurgerShot", 4000, src)
                Wait(1000)
                TriggerClientEvent("ShowNotif", src, exports.Tree:serveurConfig().Serveur.color.."INFO : Pour arrêter la récolte veuillez sortir de la zone", 9000, src)

                xPlayer.addInventoryItem(item, 1)
                xPlayer.showNotification("+1")
                Wait(5000)
                recolte(src)
            else
                xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Vous n'avez pas assez de place sur vous !")
                return
            end
        end
    else
        xPlayer.ban(0, '(brecolte)');
    end
end

function trait(source)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local pos = xPlayer.getCoords(true)
    local dist = #(pos - ConfigBurgerShotFarm.Traitement.traitement)
    local item = "carton_aliment_burgershot"
    local aitem = "carton__ingredient_burgershot"
    local verif = xPlayer.getInventoryItem(aitem)
    if xPlayer.getJob().name == "burgershot" then 
        if dist >= 10 then
            TriggerClientEvent("ShowNotif", src, "~g~Vous avez arrêté le traitement avec succès", 4000, src)
            TriggerClientEvent("transverif", src)
        else
            if verif then
                if xPlayer.canCarryItem(item, 1) then
                    TriggerClientEvent("ShowNotif", src,
                    "~g~ +1Carton alimentaire BurgerShot", 4000, src)
                    Wait(1000)
                    --print(dist)
                    TriggerClientEvent("ShowNotif", src, exports.Tree:serveurConfig().Serveur.color.."INFO : Pour arrêter le traitement veuillez sortir de la zone",
                    9000, src)
                    xPlayer.removeInventoryItem(aitem, 1)
                    xPlayer.addInventoryItem(item, 1)
                    xPlayer.showNotification("+1 " .. item)
                    Wait(5000)
                    trait(src)
                else
                    xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Vous n'avez pas assez de place sur vous !")
                    TriggerClientEvent("transverif", src)
                    return
                end
            else
                xPlayer.showNotification("Vous n'avez pas assez de Carton de ingrédient BurgerShot sur vous")
                TriggerClientEvent("transverif", src)
            end
        end
    else
        xPlayer.ban(0, '(btransform)');
    end
end

function vente(source)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local pos = xPlayer.getCoords(true)
    local dist = #(pos - ConfigBurgerShotFarm.Vente.vente)
    local item = "carton_aliment_burgershot"
    local itemget = xPlayer.getInventoryItem(item)
    local moneyre = ConfigBurgerShotFarm.Vente.entrepriseprice
    if xPlayer.getJob().name == "burgershot" then 
        if dist >= 10 then
            TriggerClientEvent("ShowNotif", src, "~g~Vous avez arrêté la vente avec succès", 4000, src)
            TriggerClientEvent("sverif", src)
        else
            if itemget then
                xPlayer.removeInventoryItem(item, 1)
                xPlayer.addAccountMoney('cash', ConfigBurgerShotFarm.Vente.playerprice)
                ESX.AddSocietyMoney("burgershot", moneyre)
                TriggerClientEvent("ShowNotif", src, "~g~Vous avez gagné +" .. ConfigBurgerShotFarm.Vente.playerprice .. "$",
                4000, src)
                Wait(1000)
                TriggerClientEvent("ShowNotif", src, exports.Tree:serveurConfig().Serveur.color.."INFO : Pour arrêter la vente veuillez sortir de la zone", 9000, src)
                Wait(5000)
                vente(src)
            else
                xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Vous n'avez plus assez d'items sur vous !")
                TriggerClientEvent("sverif", src)
                return
            end
        end
    else
        xPlayer.ban(0, '(bsell)');
    end
end

RegisterServerEvent("brecolte")
AddEventHandler("brecolte", function()
    local src = source
    vv = true
    recolte(src)
end)

RegisterServerEvent("btransform")
AddEventHandler("btransform", function()
    local src = source
    trait(src)
end)

RegisterServerEvent("bsell")
AddEventHandler("bsell", function()
    local src = source
    vente(src)
end)

RegisterServerEvent("burgers:spawnveh")
AddEventHandler("burgers:spawnveh", function(model, coord, head)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local itsOk = false
    local price = nil
    local label = nil

	for i = 1, #ConfigBurgerShotFarm.Veh, 1 do
		if ConfigBurgerShotFarm.Veh[i].name == model then
			itsOk = true
		end
	end
    if xPlayer.getJob().name == "burgershot" then 
        if itsOk then 
            TriggerClientEvent("burger:spawnveh", src, model, coord, head)
        else
            xPlayer.ban(0, '(burger:spawnveh)');
        end
    else
        xPlayer.ban(0, '(burger:spawnveh)');
    end
end)