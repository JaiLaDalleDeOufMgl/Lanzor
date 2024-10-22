RegisterCommand("vdabuilder", function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then return end
    if xPlayer.getGroup() == "fondateur" then
        TriggerClientEvent("tree:vdabuilder:openMenu", _source)
    else
        xPlayer.showNotification("~r~Vous n'avez pas la permission d'utiliser cette commande.")
    end
end, false)

tableVDA = {}


function refreshAllVDA()
    MySQL.Async.fetchAll("SELECT * FROM tree_vdabuilder", {}, function(result)
        if result then
            tableVDA = {}
            for k, v in pairs(result) do
                local data = json.decode(v.info)
                table.insert(tableVDA, { id = v.id, type = v.type, owner = v.owner, coords = data.coords, data = data.data })
            end
            TriggerClientEvent("tree:vda:refreshAllVDA", -1, tableVDA)
        else
            print("Aucune VDA trouvé dans la base de données")
        end
    end)
end

RegisterNetEvent("tree:sendVDA:toClient", function()
    TriggerClientEvent("tree:vda:refreshAllVDA", source, tableVDA)
end)

RegisterNetEvent("tree:vda:requestVDA", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then return end
    if xPlayer.getGroup() == "fondateur" then
        ListOfAllVDA = {}
        for k, v in pairs(tableVDA) do
            table.insert(ListOfAllVDA, { id = v.id, type = v.type, owner = v.owner, coords = v.coords, data = v.data })
        end
        TriggerClientEvent("tree:vda:getAllList", _source, ListOfAllVDA)
    else
        DropPlayer(_source, "Vous n'avez pas la permission de faire cela !")
    end
end)

RegisterNetEvent("tree:vdabuilder:deleteVDA", function(id)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then return end
    if xPlayer.getGroup() == "fondateur" then 
        MySQL.Async.execute("DELETE FROM tree_vdabuilder WHERE id = @id", {
            ["@id"] = id
        }, function(rowsChanged)
            if rowsChanged > 0 then
                xPlayer.showNotification("~g~VDA supprimé avec succès !")
                refreshAllVDA()
                Tree.Logs.send("Suppression d'un VDA", "Un VDA a été supprimé avec l'ID : "..id.." par : "..xPlayer.identifier, "red", Tree.Config.Logs.VDA)
            else
                xPlayer.showNotification("~r~Erreur lors de la suppression du VDA")
            end
        end)
    else
        DropPlayer(_source, "Kabyle t'adore quand tu fais des conneries")
    end
end)

RegisterNetEvent("tree:vdabuilder:createVDA", function(typeVDA, coordsVDA, accessOwnerVDA, dataVDA)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xTarget = ESX.GetPlayerFromId(accessOwnerVDA)
    if not xPlayer then return end 
    if xPlayer.getGroup() == "fondateur" then 
        if typeVDA == "public" then
            MySQL.Async.execute("INSERT INTO tree_vdabuilder (type, owner, info) VALUES (@type, @owner, @info)",
            {
                ["@type"] = typeVDA,
                ["@owner"] = "public",
                ["@info"] = json.encode({ coords = coordsVDA, data = dataVDA })
            }, function(rowsChanged)
                if rowsChanged > 0 then
                    xPlayer.showNotification("~g~VDA créé avec succès !")
                    refreshAllVDA()
                    Tree.Logs.send("Création d'un VDA public", "Un VDA public a été créé aux coordonnées : " .. coordsVDA.x .. " | " .. coordsVDA.y .. " | " .. coordsVDA.z.." par : "..xPlayer.identifier, "green", Tree.Config.Logs.VDA)
                else
                    xPlayer.showNotification("~r~Erreur lors de la création du VDA")
                end
            end)
        elseif typeVDA == "private" then
            MySQL.Async.execute("INSERT INTO tree_vdabuilder (type, owner, info) VALUES (@type, @owner, @info)",
            {
                ["@type"] = typeVDA,
                ["@owner"] = xTarget.identifier,
                ["@info"] = json.encode({ coords = coordsVDA, data = dataVDA })
            }, function(rowsChanged)
                if rowsChanged > 0 then
                    xPlayer.showNotification("~g~VDA créé avec succès !")
                    refreshAllVDA()
                    Tree.Logs.send("Création d'un VDA privée", "Un VDA privée a été créé aux coordonnées : " .. coordsVDA.x .. " | " .. coordsVDA.y .. " | " .. coordsVDA.z.." par : "..xPlayer.identifier, "green", Tree.Config.Logs.VDA)
                else
                    xPlayer.showNotification("~r~Erreur lors de la création du VDA")
                end
            end)
        end
    else
        DropPlayer(_source, "Kabyle t'adore quand tu fais des conneries")
    end
end)

RegisterNetEvent("tree:vda:enterVDA", function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then return end
    if not id then return end
    MySQL.Async.fetchAll("SELECT * FROM tree_vdabuilder WHERE id = @id", {
        ["@id"] = id
    }, function(result)
        if result then
            local data = json.decode(result[1].info)
            if result[1].type == "public" then
                TriggerClientEvent("tree:vda:OpenMenuVDA", _source, data.data)
            elseif result[1].type == "private" then
                if xPlayer.identifier == result[1].owner then
                    TriggerClientEvent("tree:vda:OpenMenuVDA", _source, data.data)
                else
                    xPlayer.showNotification("~r~Vous n'avez pas la permission d'accéder à cette VDA elle ne vous appartient pas !")
                end
            end
        else
            xPlayer.showNotification("Erreur lors de la récupération des données de la VDA")
        end
    end)
end)


local pass = false


RegisterNetEvent("tree:vdaBuilder:Paid", function(v)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then
        return
    end
    for k,v in pairs(tableVDA) do
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
    if v.type == "item" then 
        if xPlayer.getAccount('dirtycash').money >= tonumber(v.price) then
            xPlayer.removeAccountMoney('dirtycash', v.price)
            xPlayer.addInventoryItem(v.name, 1)
            xPlayer.showNotification("~g~Vous venez d'acheter un(e) "..v.label.." pour "..v.price.."$")
            pass = false
        else
            xPlayer.showNotification("~r~Vous n'avez pas assez d'argent sale pour acheter ceci !")
        end
    elseif v.type == "weapon" then
        if xPlayer.getAccount('dirtycash').money >= tonumber(v.price) then
            xPlayer.removeAccountMoney('dirtycash', v.price)
            xPlayer.addWeapon(v.name, 250)
            xPlayer.showNotification("~g~Vous venez d'acheter un(e) "..v.label.." pour "..v.price.."$")
            pass = false
        else
            xPlayer.showNotification("~r~Vous n'avez pas assez d'argent sale pour acheter ceci !")
        end
    end
end)


CreateThread(function()
    refreshAllVDA()
end)

