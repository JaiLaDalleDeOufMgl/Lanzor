tableBlanchiment = {}


function refreshAllBlanchiment()
    MySQL.Async.fetchAll("SELECT * FROM tree_blanchimentbuilder", {}, function(result)
        if result then
            tableBlanchiment = {}
            for k, v in pairs(result) do
                local data = json.decode(v.info)
                table.insert(tableBlanchiment, { id = v.id, type = v.type, owner = v.owner, coords = data.coords, pourcentage = data.pourcentage })
            end
            TriggerClientEvent("tree:blanchiment:syncBlanch", -1, tableBlanchiment)
        else
            print("Aucun blanchiment trouvé dans la base de données")
        end
    end)
end

RegisterNetEvent("tree:sendBlanchiment:toClient", function()
    TriggerClientEvent("tree:blanchiment:syncBlanch", source, tableBlanchiment)
end)


RegisterCommand("createBlanchiment", function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if not xPlayer then
        return
    end

    if xPlayer.getGroup() == "fondateur" or xPlayer.getGroup() == "gerant" then
        TriggerClientEvent("tree:openMenu:blanchiment", _source)
    else
        xPlayer.showNotification("Vous n'avez pas la permission de faire cela")
    end
end)

RegisterNetEvent("tree:blanchiment:createBlanch")
AddEventHandler("tree:blanchiment:createBlanch", function(typeBlanch, coordsBlanch, accessOwner, pourcentageBlanch)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xTarget = ESX.GetPlayerFromId(accessOwner)

    if not xPlayer then
        return
    end

    if xPlayer.getGroup() == "fondateur" then
        if typeBlanch == "public" then
            MySQL.Async.execute("INSERT INTO tree_blanchimentbuilder (type, owner, info) VALUES (@type, @owner, @info)",
                {
                    ["@type"] = typeBlanch,
                    ["@owner"] = "public",
                    ["@info"] = json.encode({ coords = coordsBlanch, pourcentage = pourcentageBlanch })
                }, function(rowsChanged)
                    if rowsChanged > 0 then
                        xPlayer.showNotification("~g~Blanchiment créé avec succès !")
                        refreshAllBlanchiment()
                        Tree.Logs.send("Création d'un blanchiment public", "Un blanchiment public a été créé aux coordonnées : " .. coordsBlanch.x .. " | " .. coordsBlanch.y .. " | " .. coordsBlanch.z.." par : "..xPlayer.identifier.." avec un pourcentage de blanchiment de : "..pourcentageBlanch.." %", "green", Tree.Config.Logs.Blanchiment)
                    else
                        xPlayer.showNotification("~r~Erreur lors de la création du blanchiment")
                    end
                end)
        elseif typeBlanch == "private" then
            MySQL.Async.execute("INSERT INTO tree_blanchimentbuilder (type, owner, info) VALUES (@type, @owner, @info)",
                {
                    ["@type"] = typeBlanch,
                    ["@owner"] = xTarget.identifier,
                    ["@info"] = json.encode({ coords = coordsBlanch, pourcentage = pourcentageBlanch })
                }, function(rowsChanged)
                    if rowsChanged > 0 then
                        xPlayer.showNotification("~g~Blanchiment créé avec succès !")
                        refreshAllBlanchiment()
                        Tree.Logs.send("Création d'un blanchiment privée", "Un blanchiment privée a été créé aux coordonnées : " .. coordsBlanch.x .. " | " .. coordsBlanch.y .. " | " .. coordsBlanch.z.." par : "..xPlayer.identifier.." avec un pourcentage de blanchiment de : "..pourcentageBlanch.." %", "green", Tree.Config.Logs.Blanchiment)
                    else
                        xPlayer.showNotification("~r~Erreur lors de la création du blanchiment")
                    end
                end)
        end
    else
        xPlayer.showNotification("Vous n'avez pas la permission de faire cela")
    end
end)

RegisterNetEvent("tree:blanchiment:enterBlanch", function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then
        return
    end
    MySQL.Async.fetchAll("SELECT * FROM tree_blanchimentbuilder WHERE id = @id", {
        ["@id"] = id
    }, function(result)
        if result then
            local data = json.decode(result[1].info)
            if result[1].type == "public" then
                TriggerClientEvent("tree:blanchiment:OpenMenuBlanch", _source, data.pourcentage)
            elseif result[1].type == "private" then
                if xPlayer.identifier == result[1].owner then
                    TriggerClientEvent("tree:blanchiment:OpenMenuBlanch", _source, data.pourcentage)
                else
                    xPlayer.showNotification("~r~Vous n'avez pas la permission d'accéder à ce blanchiment il ne vous appartient pas !")
                end
            end
        else
            xPlayer.showNotification("Erreur lors de la récupération du blanchiment")
        end
    end)
end)

RegisterNetEvent("tree:blanchiment:requestBlanch", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then
        return
    end
    if xPlayer.getGroup() == "fondateur" or xPlayer.getGroup() == "gerant" then
        local dataBlanch = {}
        for k, v in pairs(tableBlanchiment) do
            table.insert(dataBlanch, { id = v.id, type = v.type, owner = v.owner, coords = v.coords, pourcentage = v.pourcentage })
        end
        TriggerClientEvent("tree:blanchiment:getList", _source, dataBlanch)
    else
        DropPlayer(_source, "Vous n'avez pas la permission de faire cela !")
    end
end)


RegisterNetEvent("tree:blanchiment:deleteBlanchiment", function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then
        return
    end
    if xPlayer.getGroup() == "fondateur" or xPlayer.getGroup() == "gerant" then
        MySQL.Async.execute("DELETE FROM tree_blanchimentbuilder WHERE id = @id", {
            ["@id"] = id
        }, function(rowsChanged)
            if rowsChanged > 0 then
                xPlayer.showNotification("~g~Blanchiment supprimé avec succès !")
                refreshAllBlanchiment()
                Tree.Logs.send("Suppression d'un blanchiment", "Un blanchiment a été supprimé par : "..xPlayer.identifier.." l'id du blanchiment : "..id, "red", Tree.Config.Logs.Blanchiment)
            else
                xPlayer.showNotification("~r~Erreur lors de la suppression du blanchiment")
            end
        end)
    else
        DropPlayer(_source, "Vous n'avez pas la permission de faire cela !")
    end
end)

local pass = false


RegisterNetEvent("tree:blanchiment:washMoney", function(amount, pourcentage)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then
        return
    end
    for k, v in pairs(tableBlanchiment) do
        local playerCoords = GetEntityCoords(GetPlayerPed(_source))
        local targetCoords = vector3(v.coords.x, v.coords.y, v.coords.z)
        local distance = #(vector3(math.floor(targetCoords.x * 100) / 100, math.floor(targetCoords.y * 100) / 100, math.floor(targetCoords.z * 100) / 100) - playerCoords)
        if distance < 2.0 then
            pass = true
        else
            pass = false
        end
    end
    if not pass then
        return
    end
    if xPlayer.getAccount('dirtycash').money >= amount then
        xPlayer.removeAccountMoney('dirtycash', amount)
        xPlayer.addAccountMoney('cash', amount * (pourcentage / 100))
        xPlayer.showNotification("Vous venez de blanchir ~r~" ..amount .. "$~s~ et vous avez reçu ~g~" .. ESX.Math.Round(amount * (pourcentage / 100)) .. "$")
    else
        xPlayer.showNotification("~r~Vous n'avez pas assez d'argent sale sur vous")
    end
    Tree.Logs.send("Blanchiment d'argent", "Un joueur a blanchi de l'argent sale pour un montant de : "..amount.." $ et a reçu : "..ESX.Math.Round(amount * (pourcentage / 100)).." $", "green", Tree.Config.Logs.Blanchiment)
    pass = false
end)

CreateThread(function()
    refreshAllBlanchiment()
end)
