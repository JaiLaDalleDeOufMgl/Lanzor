function GetPlayerPPA(source)
    MySQL.Async.fetchAll("SELECT * FROM user_licenses WHERE owner = @owner AND type = @type", {
        ['@owner'] = GetPlayerIdentifiers(source)[1],
        ['@type'] = "weapon"
    }, function(result)
        if result[1] then
            return true
        else
            return false
        end
    end)
end

Tree.RegisterServerCallback("tree:shop:getPPA", function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchAll("SELECT * FROM user_licenses WHERE owner = @owner AND type = @type", {
        ['@owner'] = xPlayer.identifier,
        ['@type'] = "weapon"
    }, function(result)
        if result[1] then
            cb(true)
        else
            cb(false)
        end
    end)
end)


RegisterServerEvent("tree:shop:buyItem")
AddEventHandler("tree:shop:buyItem", function(v)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if v.type == "item" then
        if xPlayer.getAccount('cash').money >= v.price then
            xPlayer.removeAccountMoney('cash', v.price)
            xPlayer.addInventoryItem(v.name, 1)
            xPlayer.showNotification("~g~Vous avez acheté un x1 "..v.label)
        else
            xPlayer.showNotification(Tree.Config.Serveur.color.."Vous n'avez pas assez d'argent")
        end
    elseif v.type == "weapon" then
        if v.hasPPA == true then
            if GetPlayerPPA(_source) == true then
                if xPlayer.getAccount('cash').money >= v.price then
                    xPlayer.removeAccountMoney('cash', v.price)
                    xPlayer.addWeapon(v.name, 100)
                    xPlayer.showNotification("~g~Vous avez acheté un x1 "..v.label)
                else
                    xPlayer.showNotification(Tree.Config.Serveur.color.."Vous n'avez pas assez d'argent")
                end
            else
                xPlayer.showNotification(Tree.Config.Serveur.color.."Vous ne possédez pas le PPA !")
            end
        else
            if xPlayer.getAccount('cash').money >= v.price then
                xPlayer.removeAccountMoney('cash', v.price)
                xPlayer.addWeapon(v.name, 100)
                xPlayer.showNotification("~g~Vous avez acheté un x1 "..v.label)
            else
                xPlayer.showNotification(Tree.Config.Serveur.color.."Vous n'avez pas assez d'argent")
            end
        end
    end
end)