

RegisterCommand("openCatalogueBuilder", function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then
        return
    end
    if xPlayer.getGroup() == "fondateur" then
        TriggerClientEvent("tree:openMenuBuilderCardealer", _source)
    else
        xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Vous n'avez pas la permission d'ouvrir ce menu !")
    end
end)

Tree.RegisterServerCallback("tree:cardealer:getCategories", function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM vehicle_categories', {}, function(result)
        if result then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

Tree.RegisterServerCallback("tree:cardealer:getVehicles", function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM vehicles', {}, function(result)
        if result then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

RegisterNetEvent("tree:cardealer:addVehicle", function(labelVehicle, modelVehicle, priceVehicle, categoryVehicle)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then
        return
    end
    if xPlayer.getGroup() == "fondateur" then
        MySQL.Async.execute('INSERT INTO vehicles (name, model, price, category) VALUES (@name, @model, @price, @category)', {
            ['@name'] = labelVehicle,
            ['@model'] = modelVehicle,
            ['@price'] = priceVehicle,
            ['@category'] = categoryVehicle
        }, function(rowsChanged)
            if rowsChanged > 0 then
                xPlayer.showNotification("~g~Véhicule ajouté avec succès !")
            else
                xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Erreur lors de l'ajout du véhicule !")
            end
        end)
    else
        xPlayer.ban(0, "Tu crois bypass kabylee toi mtn?")
    end
end)

RegisterNetEvent("tree:cardealer:editlabelVehicle", function(name, editLabelName)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then
        return
    end
    if xPlayer.getGroup() == "fondateur" then
        MySQL.Async.execute('UPDATE vehicles SET name = @name WHERE name = @editLabelName', {
            ['@name'] = editLabelName,
            ['@editLabelName'] = name
        }, function(rowsChanged)
            if rowsChanged > 0 then
                xPlayer.showNotification("~g~Label du véhicule modifié avec succès !")
            else
                xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Erreur lors de la modification du label du véhicule !")
            end
        end)
    else
        xPlayer.ban(0, "Tu crois bypass kabylee toi mtn?")
    end
end)

RegisterNetEvent("tree:cardealer:editPriceVehicle", function(name, editPriceVehicle)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then
        return
    end
    if xPlayer.getGroup() == "fondateur" then
        MySQL.Async.execute('UPDATE vehicles SET price = @price WHERE name = @name', {
            ['@price'] = editPriceVehicle,
            ['@name'] = name
        }, function(rowsChanged)
            if rowsChanged > 0 then
                xPlayer.showNotification("~g~Prix du véhicule modifié avec succès !")
            else
                xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Erreur lors de la modification du prix du véhicule !")
            end
        end)
    else
        xPlayer.ban(0, "Tu crois bypass kabylee toi mtn?")
    end
end)

RegisterNetEvent("tree:cardealer:editCategoryVehicle", function(name, editCategoryVehicle)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then
        return
    end
    if xPlayer.getGroup() == "fondateur" then
        MySQL.Async.execute('UPDATE vehicles SET category = @category WHERE name = @name', {
            ['@category'] = editCategoryVehicle,
            ['@name'] = name
        }, function(rowsChanged)
            if rowsChanged > 0 then
                xPlayer.showNotification("~g~Catégorie du véhicule modifié avec succès !")
            else
                xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Erreur lors de la modification de la catégorie du véhicule !")
            end
        end)
    else
        xPlayer.ban(0, "Tu crois bypass kabylee toi mtn?")
    end
end)

RegisterNetEvent("tree:cardealer:deleteVehicle", function(name)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then
        return 
    end
    if xPlayer.getGroup() == "fondateur" then
        MySQL.Async.execute('DELETE FROM vehicles WHERE name = @name', {
            ['@name'] = name
        }, function(rowsChanged)
            if rowsChanged > 0 then
                xPlayer.showNotification("~g~Véhicule supprimé avec succès !")
            else
                xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Erreur lors de la suppression du véhicule !")
            end
        end)
    else
        xPlayer.ban(0, "Tu crois bypass kabylee toi mtn?")
    end
end)