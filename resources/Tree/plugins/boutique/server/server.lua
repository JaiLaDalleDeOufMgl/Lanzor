local data = {}

local function GenerateRandomPlate()
    local plate = ""
    local characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local length = 8

    for i = 1, length do
        local randomIndex = math.random(1, #characters)
        local randomChar = characters:sub(randomIndex, randomIndex)
        plate = plate .. randomChar
    end

    return plate
end

CreateThread(function()
    MySQL.Async.fetchAll("SELECT * FROM tree_boutique", {}, function(result)
        if result then
            for k, v in pairs(result) do
                data[v.type] = json.decode(v.data) or {}
            end
        end
    end)
end)

local function getUserData(identifier)
    if identifier == nil then
        return {
            ["identifier"] = "Aucun",
            ["coins"] = 0,
            ["history"] = json.encode({}),
            ["inventory"] = json.encode({}),
            ["vip"] = 0
        }
    else
        local data = MySQL.Sync.fetchAll("SELECT * FROM tree_players_boutique WHERE identifier = @identifier", {
            ["@identifier"] = identifier
        })
        if data[1] == nil then
            MySQL.Async.execute("INSERT INTO tree_players_boutique (identifier, history) VALUES (@identifier, @history)", {
                ["@identifier"] = identifier,
                ["@history"] = json.encode({})
            })
            return getUserData(identifier)
        else
            return data
        end
    end
end

Tree.RegisterServerCallback("Plugins:Boutique:GetOwner", function(source, cb)
    local _source = source
    local player = Tree.getPlayer(_source)
    if Tree.Admin.isOwner(player.getIdentifierByType("license")) then
        cb(true)
    else
        cb(false)
    end
end)

Tree.RegisterServerCallback("Plugins:Boutique:GetInfo", function(source, cb)
    local player = Tree.getPlayer(source)

    if player.getIdentifierByType("fivem") == nil then
        TriggerClientEvent("Plugins:Boutique:ReceiveCoins", player.id, 0)
        TriggerClientEvent("Plugins:Boutique:ReceiveId", player.id, "Aucun")
        TriggerClientEvent("Plugins:Boutique:ReceiveVip", player.id, 0)
        TriggerClientEvent("Plugins:Boutique:ReceiveHistory", player.id, {})
        TriggerClientEvent("Plugins:Boutique:ReceiveInventory", player.id, {})
        TriggerClientEvent("Plugins:Boutique:ReceiveVehicle", player.id, data["vehicle"])
        TriggerClientEvent("Plugins:Boutique:ReceiveLimited", player.id, data["limited"])
        TriggerClientEvent("Plugins:Boutique:ReceiveWeapon", player.id, data["weapon"])
        TriggerClientEvent("Plugins:Boutique:ReceiveMysteryBox", player.id, data["mysterybox"])
        TriggerClientEvent("Plugins:Boutique:ReceivePack", player.id, data["pack"])
        TriggerClientEvent("Plugins:Boutique:ReceiveVipList", player.id, data["vip"])
        cb(true)
    else
        local user = getUserData(player.getIdentifierByType("fivem"))
        Wait(100)
        TriggerClientEvent("Plugins:Boutique:ReceiveCoins", player.id, user[1].coins)
        TriggerClientEvent("Plugins:Boutique:ReceiveId", player.id, user[1].identifier)
        TriggerClientEvent("Plugins:Boutique:ReceiveVip", player.id, user[1].vip)
        TriggerClientEvent("Plugins:Boutique:ReceiveHistory", player.id, json.decode(user[1].history))
        TriggerClientEvent("Plugins:Boutique:ReceiveInventory", player.id, json.decode(user[1].inventory))
        TriggerClientEvent("Plugins:Boutique:ReceiveVehicle", player.id, data["vehicle"])
        TriggerClientEvent("Plugins:Boutique:ReceiveLimited", player.id, data["limited"])
        TriggerClientEvent("Plugins:Boutique:ReceiveWeapon", player.id, data["weapon"])
        TriggerClientEvent("Plugins:Boutique:ReceiveMysteryBox", player.id, data["mysterybox"])
        TriggerClientEvent("Plugins:Boutique:ReceivePack", player.id, data["pack"])
        TriggerClientEvent("Plugins:Boutique:ReceiveVipList", player.id, data["vip"])
        cb(true)
    end
end)

RegisterNetEvent("Plugins:Boutique:BuyVehicle", function(model)
    local _source = source
    local player = Tree.getPlayer(_source)
    local xPlayer = ESX.GetPlayerFromId(_source)
    local user = getUserData(player.getIdentifierByType("fivem"))
    for k, v in pairs(data["vehicle"]) do
        if v.model == model then
            if tonumber(user[1].coins) >= tonumber(v.price) then
                user[1].coins = user[1].coins - v.price
                MySQL.Async.execute("UPDATE tree_players_boutique SET coins = @coins WHERE identifier = @identifier", {
                    ["@coins"] = tonumber(user[1].coins),
                    ["@identifier"] = player.getIdentifierByType("fivem")
                })
                local history = json.decode(user[1].history)
                table.insert(history, {
                    ["type"] = "Vehicle",
                    ["model"] = model,
                    ["price"] = tonumber(v.price)
                })
                MySQL.Async.execute("UPDATE tree_players_boutique SET history = @history WHERE identifier = @identifier",
                    {
                        ["@history"] = json.encode(history),
                        ["@identifier"] = player.getIdentifierByType("fivem")
                    })

                local plate = GenerateRandomPlate()

                MySQL.Async.fetchScalar("SELECT COUNT(*) FROM owned_vehicles WHERE plate = @plate", {
                    ["@plate"] = plate
                }, function(count)
                    if count == 0 then
                        MySQL.Async.execute(
                            "INSERT INTO owned_vehicles (owner, plate, vehicle, type, state, stored, boutique) VALUES (@owner, @plate, @vehicle, @type, @state, @stored, @boutique)",
                            {
                                ["@owner"] = player.getIdentifierByType("license"),
                                ["@plate"] = plate,
                                ["@vehicle"] = json.encode({ model = GetHashKey(model), plate = plate }),
                                ["@type"] = 'car',
                                ["@state"] = 1,
                                ["@stored"] = 1,
                                ["@boutique"] = 1,
                            }, function(rowsAffected)
                                if rowsAffected > 0 then
                                    xPlayer.showNotification(
                                        "Vous avez acheté un véhicule avec une nouvelle plaque d'immatriculation.")
                                end
                            end)
                    else
                        local plateExists = true
                        local newPlate = ""
                        while plateExists do
                            newPlate = GenerateRandomPlate()
                            local count = MySQL.Async.fetchScalar(
                                "SELECT COUNT(*) FROM owned_vehicles WHERE plate = @plate", {
                                    ["@plate"] = newPlate
                                })
                            plateExists = (count > 0)
                        end

                        MySQL.Async.execute(
                            "INSERT INTO owned_vehicles (owner, plate, vehicle, type, state, stored, boutique) VALUES (@owner, @plate, @vehicle, @type, @state, @stored, @boutique)",
                            {
                                ["@owner"] = player.getIdentifierByType("license"),
                                ["@plate"] = newPlate,
                                ["@vehicle"] = json.encode({ model = GetHashKey(model), plate = newPlate }),
                                ["@type"] = 'car',
                                ["@state"] = 1,
                                ["@stored"] = 1,
                                ["@boutique"] = 1,
                            }, function(rowsAffected)
                                if rowsAffected > 0 then
                                    xPlayer.showNotification(
                                        "Vous avez acheté un véhicule avec une nouvelle plaque d'immatriculation.")
                                end
                            end)
                    end
                    xPlayer.showNotification("Vous avez acheté un véhicule avec une nouvelle plaque d'immatriculation.")
                    Tree.Logs.send("Boutique: Achat de vehicule",
                        "Identifier: " .. player.getIdentifierByType("fivem") .. "\nModel: " .. model .. "", "green",
                        Tree.Config.Logs.BoutiqueBuyVehicle)
                end)
            else
                xPlayer.showNotification("Vous n'avez pas assez de coins.")
            end
        end
    end
end)

RegisterNetEvent("Tree:Get:Coins")
AddEventHandler("Tree:Get:Coins", function(price)
    local src = source
    local player = Tree.getPlayer(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    local pl = getUserData(player.getIdentifierByType("fivem"))
    if tonumber(pl[1].coins) >= tonumber(price) then
        pl[1].coins = pl[1].coins - price
        MySQL.Async.execute("UPDATE tree_players_boutique SET coins = @coins WHERE identifier = @identifier", {
            ["@coins"] = tonumber(pl[1].coins),
            ["@identifier"] = player.getIdentifierByType("fivem")
        })
        TriggerClientEvent("Tree:Get:BuyCustom", src, price, true)
    else
        TriggerClientEvent("Tree:Get:BuyCustom", src, price, false)
    end
end)

RegisterNetEvent('Tree:Get:RefreshCustom', function(myCar)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE @plate = plate', {
        ['@plate'] = myCar.plate
    }, function(result)
        if result[1] then
            local props = json.decode(result[1].vehicle);
            if props.model == myCar.model and props.plate == myCar.plate then
                MySQL.Async.execute('UPDATE `owned_vehicles` SET `vehicle` = @vehicle WHERE `plate` = @plate',
                    {
                        ['@plate'] = myCar.plate,
                        ['@vehicle'] = json.encode(myCar)
                    })
            end
        end
    end)
end)


RegisterNetEvent("Plugins:Boutique:BuyLimited", function(model)
    local _source = source
    local player = Tree.getPlayer(_source)
    local xPlayer = ESX.GetPlayerFromId(_source)
    local user = getUserData(player.getIdentifierByType("fivem"))
    for k, v in pairs(data["limited"]) do
        if v.model == model then
            if tonumber(user[1].coins) >= tonumber(v.price) then
                user[1].coins = user[1].coins - v.price
                MySQL.Async.execute("UPDATE tree_players_boutique SET coins = @coins WHERE identifier = @identifier", {
                    ["@coins"] = tonumber(user[1].coins),
                    ["@identifier"] = player.getIdentifierByType("fivem")
                })
                local history = json.decode(user[1].history)
                table.insert(history, {
                    ["type"] = "Limited",
                    ["model"] = model,
                    ["price"] = tonumber(v.price)
                })
                MySQL.Async.execute("UPDATE tree_players_boutique SET history = @history WHERE identifier = @identifier",
                    {
                        ["@history"] = json.encode(history),
                        ["@identifier"] = player.getIdentifierByType("fivem")
                    })
                xPlayer.showNotification("Vous avez acheté un véhicule limité.")

                local plate = GenerateRandomPlate()

                MySQL.Async.fetchScalar("SELECT COUNT(*) FROM owned_vehicles WHERE plate = @plate", {
                    ["@plate"] = plate
                }, function(count)
                    if count == 0 then
                        MySQL.Async.execute(
                            "INSERT INTO owned_vehicles (owner, plate, vehicle, type, state, stored, boutique) VALUES (@owner, @plate, @vehicle, @type, @state, @stored, @boutique)",
                            {
                                ["@owner"] = player.getIdentifierByType("license"),
                                ["@plate"] = plate,
                                ["@vehicle"] = json.encode({ model = GetHashKey(model), plate = plate }),
                                ["@type"] = 'car',
                                ["@state"] = 1,
                                ["@stored"] = 1,
                                ["@boutique"] = 1,
                            }, function(rowsAffected)
                                if rowsAffected > 0 then
                                    xPlayer.showNotification(
                                        "Vous avez acheté un véhicule limité avec une nouvelle plaque d'immatriculation.")
                                    for i = 1, #data["limited"] do
                                        if data["limited"][i].model == model then
                                            table.remove(data["limited"], i)
                                            break
                                        end
                                    end
                                    MySQL.Async.execute("UPDATE tree_boutique SET data = @data WHERE type = 'limited'", {
                                        ["@data"] = json.encode(data)
                                    })
                                end
                            end)
                    else
                        local plateExists = true
                        local newPlate = ""
                        while plateExists do
                            newPlate = GenerateRandomPlate()
                            local count = MySQL.Async.fetchScalar(
                                "SELECT COUNT(*) FROM owned_vehicles WHERE plate = @plate", {
                                    ["@plate"] = newPlate
                                })
                            plateExists = (count > 0)
                        end

                        MySQL.Async.execute(
                            "INSERT INTO owned_vehicles (owner, plate, vehicle, type, state, stored, boutique) VALUES (@owner, @plate, @vehicle, @type, @state, @stored, @boutique)",
                            {
                                ["@owner"] = player.getIdentifierByType("license"),
                                ["@plate"] = newPlate,
                                ["@vehicle"] = json.encode({ model = GetHashKey(model), plate = newPlate }),
                                ["@type"] = 'car',
                                ["@state"] = 1,
                                ["@stored"] = 1,
                                ["@boutique"] = 1,
                            }, function(rowsAffected)
                                if rowsAffected > 0 then
                                    xPlayer.showNotification(
                                        "Vous avez acheté un véhicule limité avec une nouvelle plaque d'immatriculation.")
                                    for i = 1, #data["limited"] do
                                        if data["limited"][i].model == model then
                                            table.remove(data["limited"], i)
                                            break
                                        end
                                    end
                                    MySQL.Async.execute("UPDATE tree_boutique SET data = @data WHERE type = 'limited'", {
                                        ["@data"] = json.encode(data)
                                    })
                                    Tree.Logs.send("Boutique: Achat de vehicule limité",
                                        "Identifier: " ..
                                        player.getIdentifierByType("fivem") .. "\nModel: " .. model .. "",
                                        "green", Tree.Config.Logs.BoutiqueBuyLimitedVehicle)
                                end
                            end)
                    end
                end)
            else
                xPlayer.showNotification("Vous n'avez pas assez de coins.")
            end
        end
    end
end)

RegisterNetEvent("Plugins:Boutique:BuyWeapon", function(model)
    local _source = source
    local player = Tree.getPlayer(_source)
    local xPlayer = ESX.GetPlayerFromId(_source)
    local user = getUserData(player.getIdentifierByType("fivem"))
    for k, v in pairs(data["weapon"]) do
        if v.model == model then
            if tonumber(user[1].coins) >= tonumber(v.price) then
                user[1].coins = user[1].coins - v.price
                MySQL.Async.execute("UPDATE tree_players_boutique SET coins = @coins WHERE identifier = @identifier", {
                    ["@coins"] = tonumber(user[1].coins),
                    ["@identifier"] = player.getIdentifierByType("fivem")
                })
                local history = json.decode(user[1].history)
                table.insert(history, {
                    ["type"] = "Weapon",
                    ["model"] = model,
                    ["price"] = tonumber(v.price)
                })
                MySQL.Async.execute("UPDATE tree_players_boutique SET history = @history WHERE identifier = @identifier",
                    {
                        ["@history"] = json.encode(history),
                        ["@identifier"] = player.getIdentifierByType("fivem")
                    })
                xPlayer.addWeapon(string.upper(v.model), 0)
                xPlayer.showNotification("Vous avez acheté une arme.")
                Tree.Logs.send("Boutique: Achat d'arme",
                    "Identifier: " .. player.getIdentifierByType("fivem") .. "\nModel: " .. model .. "", "green",
                    Tree.Config.Logs.BoutiqueBuyWeapon)
                break
            else
                xPlayer.showNotification("Vous n'avez pas assez de coins.")
            end
        end
    end
end)



RegisterNetEvent("Plugins:Boutique:BuyMysteryBox", function(model, quantity)
    local _source = source
    local player = Tree.getPlayer(_source)
    local xPlayer = ESX.GetPlayerFromId(_source)
    local user = getUserData(player.getIdentifierByType("fivem"))

    if not quantity or quantity <= 0 then
        xPlayer.showNotification("Quantité invalide.")
        return
    end
    for k, v in pairs(data["mysterybox"]) do
        if v.model == model then
            local totalPrice = 0
            if quantity == 5 then
                totalPrice = tonumber(v.price) * 4
            elseif quantity == 10 then
                totalPrice = tonumber(v.price) * 7
            else
                totalPrice = tonumber(v.price) * quantity
            end

            if tonumber(user[1].coins) >= totalPrice then
                user[1].coins = user[1].coins - totalPrice
                MySQL.Async.execute("UPDATE tree_players_boutique SET coins = @coins WHERE identifier = @identifier", {
                    ["@coins"] = tonumber(user[1].coins),
                    ["@identifier"] = player.getIdentifierByType("fivem")
                })

                local history = json.decode(user[1].history) or {}
                table.insert(history, {
                    ["type"] = "MysteryBox",
                    ["model"] = model,
                    ["price"] = totalPrice,
                    ["quantity"] = quantity
                })
                MySQL.Async.execute("UPDATE tree_players_boutique SET history = @history WHERE identifier = @identifier",
                    {
                        ["@history"] = json.encode(history),
                        ["@identifier"] = player.getIdentifierByType("fivem")
                    })

                MySQL.Async.fetchAll("SELECT * from tree_players_boutique where @identifier = identifier", {
                    ["@identifier"] = player.getIdentifierByType("fivem")
                }, function(result)
                    local inventory = json.decode(result[1].inventory) or {}

                    for i = 1, quantity do
                        local newItem = {
                            label = v.label,
                            model = v.model,
                            type = "MysteryBox",
                        }
                        table.insert(inventory, newItem)
                    end
                    MySQL.Async.execute("UPDATE tree_players_boutique SET inventory = @inventory WHERE identifier = @identifier", {
                        ["@inventory"] = json.encode(inventory),
                        ["@identifier"] = player.getIdentifierByType("fivem")
                    })
                end)
                xPlayer.showNotification("Vous avez acheté " .. quantity .. " boîte(s) mystère(s).")
                Tree.Logs.send("Boutique: Achat de caisse mystère",
                    "Identifier: " ..
                    player.getIdentifierByType("fivem") ..
                    "\nModel: " .. v.model .. "\nQuantité: " .. quantity .. "\nTotal Price: " .. totalPrice, "green",
                    Tree.Config.Logs.BoutiqueBuyMysteryBox)
                break
            else
                xPlayer.showNotification("Vous n'avez pas assez de coins.")
            end
        end
    end
end)


local probabilityLevels = {
    [1] = 55,
    [2] = 25,
    [3] = 10,
    [4] = 7,
    [5] = 3
}

local function playerHasItem(xPlayer, itemName, itemType)
    local inventory = xPlayer.getInventory(false)
    for _, item in pairs(inventory) do
        if item.name == itemName and item.type == itemType then
            return true
        end
    end
    return false
end

local function playerHasVehicle(license, vehicleName)
    local vehicles = MySQL.Sync.fetchAll("SELECT vehicle FROM owned_vehicles WHERE owner = @owner", {
        ["@owner"] = license
    })
    for _, vehicle in pairs(vehicles) do
        local vehicleData = json.decode(vehicle.vehicle)
        if vehicleData.model == GetHashKey(vehicleName) then
            return true
        end
    end
    return false
end

local function selectUniqueItem(xPlayer, items, itemType)
    local availableItems = {}
    local license = xPlayer.getIdentifier("license")
    for _, item in pairs(items) do
        if itemType == "vehicles" then
            if not playerHasVehicle(license, item.name) then
                table.insert(availableItems, item)
            end
        else
            if not playerHasItem(xPlayer, string.lower(item.name), itemType) then
                table.insert(availableItems, item)
            end
        end
    end

    if #availableItems == 0 then
        return nil
    end

    local totalProbability = 0
    local itemProbabilities = {}

    for _, item in pairs(availableItems) do
        local probability = probabilityLevels[tonumber(item.probability)] or 0
        totalProbability = totalProbability + probability
        table.insert(itemProbabilities, { item = item, cumulativeProbability = totalProbability })
    end

    local randomChance = math.random() * totalProbability
    for _, itemProbability in ipairs(itemProbabilities) do
        if randomChance <= itemProbability.cumulativeProbability then
            return itemProbability.item
        end
    end

    return nil
end

RegisterNetEvent("Plugins:Boutique:ConsumeMysteryBox", function(model)
    local _source = source
    local player = Tree.getPlayer(_source)
    local xPlayer = ESX.GetPlayerFromId(_source)
    for k, v in pairs(data["mysterybox"]) do
        if v.model == model then
            local availableCategories = {}

            if v.items.vehicles and #v.items.vehicles > 0 then
                table.insert(availableCategories, "vehicles")
            end
            if v.items.weapons and #v.items.weapons > 0 then
                table.insert(availableCategories, "weapons")
            end
            if v.items.items and #v.items.items > 0 then
                table.insert(availableCategories, "items")
            end

            if #availableCategories > 0 then
                local randomCategory = availableCategories[math.random(#availableCategories)]
                local randomItems = v.items[randomCategory]

                local chosenItem = selectUniqueItem(xPlayer, randomItems, randomCategory)

                if chosenItem then
                    local rarityName = "Inconnue"
                    for _, level in pairs(Tree.Config.MysteryBoxRarityLevel) do
                        if tonumber(chosenItem.probability) == level.probabilityID then
                            rarityName = level.name
                            break
                        end
                    end

                    TriggerClientEvent("Plugins:Boutique:OnOpenCase", _source,
                        GetConvar("gameType", "") .. "_crate_" .. v.color,
                        GetConvar("gameType", "") .. "_crate_" .. v.color .. "_open", randomCategory, chosenItem.name,
                        chosenItem.label)

                    if chosenItem.name == "cash" then
                        xPlayer.addInventoryItem("cash", tonumber(chosenItem.quantity))
                    elseif chosenItem.name == "sempre_rtxdev_jacuzzi_modern" then
                        xPlayer.addInventoryItem("hottub1", 1)
                    elseif randomCategory == "items" then
                        xPlayer.addInventoryItem(chosenItem.name, chosenItem.quantity)
                    elseif randomCategory == "weapons" then
                        xPlayer.addWeapon(chosenItem.name, 100)
                    elseif randomCategory == "vehicles" then
                        local plate = GenerateRandomPlate()

                        MySQL.Async.fetchScalar("SELECT COUNT(*) FROM owned_vehicles WHERE plate = @plate", {
                            ["@plate"] = plate
                        }, function(count)
                            local newPlate = plate
                            while count > 0 do
                                newPlate = GenerateRandomPlate()
                                count = MySQL.Sync.fetchScalar(
                                    "SELECT COUNT(*) FROM owned_vehicles WHERE plate = @plate", {
                                        ["@plate"] = newPlate
                                    })
                            end

                            MySQL.Async.execute(
                                "INSERT INTO owned_vehicles (owner, plate, vehicle, type, state, stored, boutique) VALUES (@owner, @plate, @vehicle, @type, @state, @stored, @boutique)",
                                {
                                    ["@owner"] = xPlayer.getIdentifier(),
                                    ["@plate"] = newPlate,
                                    ["@vehicle"] = json.encode({ model = GetHashKey(chosenItem.name), plate = newPlate }),
                                    ["@type"] = 'car',
                                    ["@state"] = 1,
                                    ["@stored"] = 1,
                                    ["@boutique"] = 1,
                                }, function(rowsAffected)
                                    if rowsAffected > 0 then
                                        Tree.Logs.send("Boutique: véhicule reçu dans une caisse",
                                            "Identifier: " ..
                                            player.getIdentifierByType("fivem") .. "\nModel: " .. chosenItem.name .. "",
                                            "green", Tree.Config.Logs.BoutiqueBuyVehicle)
                                    end
                                end)
                        end)
                    end

                    MySQL.Async.fetchAll("SELECT * from tree_players_boutique where @identifier = identifier", {
                        ["@identifier"] = player.getIdentifierByType("fivem")
                    }, function(result)
                        local inventory = json.decode(result[1].inventory) or {}
                        for i = 1, #inventory do
                            if inventory[i].model == model then
                                table.remove(inventory, i)
                                break
                            end
                        end

                        MySQL.Async.execute(
                            "UPDATE tree_players_boutique SET inventory = @inventory WHERE identifier = @identifier", {
                                ["@inventory"] = json.encode(inventory),
                                ["@identifier"] = player.getIdentifierByType("fivem")
                            })
                    end)
                else
                    xPlayer.showNotification(
                        "Vous avez déjà tous les items possibles, veuillez attendre une prochaine mise a jour de la caisse.")
                end
            else
            end

            break
        end
    end
end)

function giveVehicle(source, model, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local license = xPlayer.getIdentifier("license")
    MySQL.Async.fetchScalar("SELECT COUNT(*) FROM owned_vehicles WHERE plate = @plate", {
        ["@plate"] = plate
    }, function(count)
        if count == 0 then
            MySQL.Async.execute(
                "INSERT INTO owned_vehicles (owner, plate, vehicle, type, state, stored, boutique) VALUES (@owner, @plate, @vehicle, @type, @state, @stored, @boutique)",
                {
                    ["@owner"] = license,
                    ["@plate"] = plate,
                    ["@vehicle"] = json.encode({ model = GetHashKey(model), plate = plate }),
                    ["@type"] = 'car',
                    ["@state"] = 1,
                    ["@stored"] = 1,
                    ["@boutique"] = 1,
                }, function(rowsAffected)
                    if rowsAffected > 0 then
                        xPlayer.showNotification(
                        "Vous avez acheté un véhicule avec une nouvelle plaque d'immatriculation.")
                    end
                end)
        else
            local plateExists = true
            local newPlate = ""
            while plateExists do
                newPlate = GenerateRandomPlate()
                local count = MySQL.Async.fetchScalar("SELECT COUNT(*) FROM owned_vehicles WHERE plate = @plate", {
                    ["@plate"] = newPlate
                })
                plateExists = (count > 0)
            end

            MySQL.Async.execute(
                "INSERT INTO owned_vehicles (owner, plate, vehicle, type, state, stored, boutique) VALUES (@owner, @plate, @vehicle, @type, @state, @stored, @boutique)",
                {
                    ["@owner"] = license,
                    ["@plate"] = newPlate,
                    ["@vehicle"] = json.encode({ model = GetHashKey(model), plate = newPlate }),
                    ["@type"] = 'car',
                    ["@state"] = 1,
                    ["@stored"] = 1,
                    ["@boutique"] = 1,
                }, function(rowsAffected)
                    if rowsAffected > 0 then
                        xPlayer.showNotification(
                        "Vous avez acheté un véhicule avec une nouvelle plaque d'immatriculation.")
                    end
                end)
        end
    end)
end

RegisterNetEvent("Plugins:Boutique:receiveStarterPack", function(model)
    local _source = source
    local player = Tree.getPlayer(_source)
    local xPlayer = ESX.GetPlayerFromId(_source)
    local user = getUserData(player.getIdentifierByType("fivem"))
    if model == "illegal" then
        if tonumber(user[1].coins) >= 3500 then
            user[1].coins = user[1].coins - 3500
            MySQL.Async.execute("UPDATE tree_players_boutique SET coins = @coins WHERE identifier = @identifier", {
                ["@coins"] = tonumber(user[1].coins),
                ["@identifier"] = player.getIdentifierByType("fivem")
            })
            local history = json.decode(user[1].history)
            table.insert(history, {
                ["type"] = "StarterPack",
                ["model"] = model,
                ["price"] = 3500
            })
            MySQL.Async.execute("UPDATE tree_players_boutique SET history = @history WHERE identifier = @identifier", {
                ["@history"] = json.encode(history),
                ["@identifier"] = player.getIdentifierByType("fivem")
            })
            xPlayer.addInventoryItem("dirtycash", 1500000, nil, true)
            xPlayer.addInventoryItem("coca", 50, nil, true)
            xPlayer.addInventoryItem("bread", 50, nil, true)
            xPlayer.addInventoryItem("pooch_ketamine", 50, nil, true)
            xPlayer.addWeapon("weapon_pistol", 100, nil, true)
            xPlayer.addWeapon("weapon_knife", 100, nil, true)
            giveVehicle(_source, "speedo", GenerateRandomPlate())
            giveVehicle(_source, "revolter", GenerateRandomPlate())
            xPlayer.showNotification(
                "Vous avez reçu votre pack de départ. (1500000$ d'argent sale, 50 coca, 50 burger, 50 ketamine, 1 beretta, 1 couteau, 1 speedo, 1 revolter)")
            Tree.Logs.send("Boutique: Achat de starter pack",
                "Identifier: " .. player.getIdentifierByType("fivem") .. "\nModel: " .. model .. "", "green",
                Tree.Config.Logs.BoutiqueBuyPack)
        else
            xPlayer.showNotification("Vous n'avez pas assez de coins.")
        end
    elseif model == "legal" then
        if tonumber(user[1].coins) >= 3000 then
            user[1].coins = user[1].coins - 3000
            MySQL.Async.execute("UPDATE tree_players_boutique SET coins = @coins WHERE identifier = @identifier", {
                ["@coins"] = tonumber(user[1].coins),
                ["@identifier"] = player.getIdentifierByType("fivem")
            })
            local history = json.decode(user[1].history)
            table.insert(history, {
                ["type"] = "StarterPack",
                ["model"] = model,
                ["price"] = 3000
            })
            MySQL.Async.execute("UPDATE tree_players_boutique SET history = @history WHERE identifier = @identifier", {
                ["@history"] = json.encode(history),
                ["@identifier"] = player.getIdentifierByType("fivem")
            })
            xPlayer.addInventoryItem("cash", 1500000, nil, true)
            xPlayer.addInventoryItem("coca", 50, nil, true)
            xPlayer.addInventoryItem("bread", 50, nil, true)
            xPlayer.addInventoryItem("reparkit", 10, nil, true)
            giveVehicle(_source, "panto", GenerateRandomPlate())
            giveVehicle(_source, "jugular", GenerateRandomPlate())
            xPlayer.showNotification(
                "Vous avez reçu votre pack de départ. (1500000$ d'argent, 50 coca, 50 pain, 10 kit de réparation, une panto et une jugular)")
            Tree.Logs.send("Boutique: Achat de starter pack",
                "Identifier: " .. player.getIdentifierByType("fivem") .. "\nModel: " .. model .. "", "green",
                Tree.Config.Logs.BoutiqueBuyPack)
        else
            xPlayer.showNotification("Vous n'avez pas assez de coins.")
        end
    end
end)

RegisterNetEvent("Plugins:Boutique:BuyPack", function(model)
    local _source = source
    local player = Tree.getPlayer(_source)
    local xPlayer = ESX.GetPlayerFromId(_source)
    local user = getUserData(player.getIdentifierByType("fivem"))
    for k, v in pairs(data["pack"]) do
        if v.model == model then
            if tonumber(user[1].coins) >= tonumber(v.price) then
                user[1].coins = user[1].coins - v.price
                MySQL.Async.execute("UPDATE tree_players_boutique SET coins = @coins WHERE identifier = @identifier", {
                    ["@coins"] = tonumber(user[1].coins),
                    ["@identifier"] = player.getIdentifierByType("fivem")
                })
                local history = json.decode(user[1].history)
                table.insert(history, {
                    ["type"] = "Pack",
                    ["model"] = model,
                    ["price"] = tonumber(v.price)
                })
                MySQL.Async.execute("UPDATE tree_players_boutique SET history = @history WHERE identifier = @identifier",
                    {
                        ["@history"] = json.encode(history),
                        ["@identifier"] = player.getIdentifierByType("fivem")
                    })
                xPlayer.showNotification("Vous avez acheté un pack.")
                if model == "sempre_rtxdev_jacuzzi_modern" then
                    xPlayer.addInventoryItem("hottub1", 1)
                end
                Tree.Logs.send("Boutique: Achat de pack",
                    "Identifier: " .. player.getIdentifierByType("fivem") .. "\nModel: " .. model .. "", "green",
                    Tree.Config.Logs.BoutiqueBuyPack)
            else
                xPlayer.showNotification("Vous n'avez pas assez de coins.")
            end
        end
    end
end)

exports('getCoins', function(identifier)
    local user = getUserData(identifier)
    if user == nil then
        return 0
    else
        return user[1].coins
    end
end)

exports('getVip', function(identifier)
    local user = getUserData(identifier)
    if user == nil then
        return {
            label = Tree.Config.VipRanks[0],
            level = 0
        }
    else
        return {
            label = Tree.Config.VipRanks[user[1].vip],
            level = user[1].vip
        }
    end

end)

exports('removeCoins', function(identifier, amount)
    local user = getUserData(identifier)
    user[1].coins = user[1].coins - amount
    MySQL.Async.execute("UPDATE tree_players_boutique SET coins = @coins WHERE identifier = @identifier", {
        ["@coins"] = tonumber(user[1].coins),
        ["@identifier"] = identifier
    })
    Tree.Logs.send("Boutique: Retrait de coins", "Identifier: " .. identifier .. "\nCoins: " .. amount .. "", "green",
        Tree.Config.Logs.BoutiqueRemoveCoins)
end)

exports('addCoins', function(identifier, amount)
    local user = getUserData(identifier)
    user[1].coins = user[1].coins + amount
    MySQL.Async.execute("UPDATE tree_players_boutique SET coins = @coins WHERE identifier = @identifier", {
        ["@coins"] = tonumber(user[1].coins),
        ["@identifier"] = identifier
    })
    Tree.Logs.send("Boutique: Ajout de coins", "Identifier: " .. identifier .. "\nCoins: " .. amount .. "", "green",
        Tree.Config.Logs.BoutiqueAddCoins)
end)

RegisterCommand('addPoints', function(source, args)
    local _source = source
    if source == 0 then
        local targetSource = tonumber(args[1])
        if GetPlayerName(targetSource) then
            local player = Tree.getPlayer(targetSource)
            local identifier = player.getIdentifierByType("fivem")
            local amount = tonumber(args[2])
            local user = getUserData(identifier)
            user[1].coins = user[1].coins + amount
            MySQL.Async.execute("UPDATE tree_players_boutique SET coins = @coins WHERE identifier = @identifier", {
                ["@coins"] = tonumber(user[1].coins),
                ["@identifier"] = identifier
            })
            Tree.Logs.send("Boutique: Ajout de coins", "Identifier: " .. identifier .. "\nCoins: " .. amount .. "",
                "green", Tree.Config.Logs.BoutiqueAddCoins)
        else
        end
    end
end)

RegisterCommand('addPointsTebex', function(source, args)
    local _source = source
    if source == 0 then
        local fivem = "fivem:"..tostring(args[1])
        local user = getUserData(fivem)
        local amount = tonumber(args[2])
        user[1].coins = user[1].coins + amount
        MySQL.Async.execute("UPDATE tree_players_boutique SET coins = @coins WHERE identifier = @identifier", {
            ["@coins"] = tonumber(user[1].coins),
            ["@identifier"] = fivem
        })
        Tree.Logs.send("Boutique: Ajout de coins", "Identifier: " .. fivem .. "\nCoins: " .. amount .. "",
            "green", Tree.Config.Logs.BoutiqueAddCoins)
    end
end)

RegisterCommand('setVip', function(source, args)
    local _source = source
    if source == 0 then
        local targetSource = tonumber(args[1])
        if GetPlayerName(targetSource) then
            local player = Tree.getPlayer(targetSource)
            local identifier = player.getIdentifierByType("fivem")
            local vip = tonumber(args[2])
            if vip >= 0 and vip <= 3 then
                MySQL.Async.execute("UPDATE tree_players_boutique SET vip = @vip WHERE identifier = @identifier", {
                    ["@vip"] = vip,
                    ["@identifier"] = identifier
                })
                Tree.Logs.send("Boutique: Ajout de vip", "Identifier: " .. identifier .. "\nVip: " .. vip .. "", "green",
                    Tree.Config.Logs.BoutiqueAddVip)
            end
        end
    end
end)

RegisterCommand('addVip', function(source, args)
    local _source = source
    if source == 0 then
        local fivem = "fivem:"..tostring(args[1])
        MySQL.Async.execute("UPDATE tree_players_boutique SET vip = @vip WHERE identifier = @identifier", {
            ["@vip"] = args[2],
            ["@identifier"] = fivem
        })
        Tree.Logs.send("Boutique: Remove vip", "Identifier: " .. fivem .. "\nVip: " .. vip .. "", "red",
            Tree.Config.Logs.BoutiqueAddVip)
    end
end)

RegisterCommand('removeVip', function(source, args)
    local _source = source
    if source == 0 then
        local fivem = "fivem:"..tostring(args[1])
        MySQL.Async.execute("UPDATE tree_players_boutique SET vip = @vip WHERE identifier = @identifier", {
            ["@vip"] = 0,
            ["@identifier"] = fivem
        })
        Tree.Logs.send("Boutique: Remove vip", "Identifier: " .. fivem .. "\nVip: " .. vip .. "", "red",
            Tree.Config.Logs.BoutiqueAddVip)
    end
end)

RegisterNetEvent("Plugins:Boutique:addOffreBoutique", function(type, label, model, price, description)
    local _source = source
    local player = Tree.getPlayer(_source)
    local xPlayer = ESX.GetPlayerFromId(_source)
    if Tree.Admin.isOwner(player.getIdentifierByType("license")) then
        local newOffre = {
            label = label,
            model = model,
            price = price,
            description = description
        }
        data[type] = data[type] or {}
        table.insert(data[type], newOffre)
        MySQL.Async.execute("UPDATE tree_boutique SET data = @data WHERE type = @type", {
            ["@type"] = type,
            ["@data"] = json.encode(data[type])
        })
        Tree.Logs.send("Boutique: Ajout d'offre", "Type: " .. type .. "\nModel: " .. model .. "", "green",
            Tree.Config.Logs.BoutiqueaddOffreBoutique)
    end
end)

RegisterNetEvent("Plugins:Boutique:removeOffreBoutique", function(type, model)
    local _source = source
    local player = Tree.getPlayer(_source)
    local xPlayer = ESX.GetPlayerFromId(_source)
    if Tree.Admin.isOwner(player.getIdentifierByType("license")) then
        for i = 1, #data[type] do
            if data[type][i].model == model then
                table.remove(data[type], i)
                MySQL.Async.execute("UPDATE tree_boutique SET data = @data WHERE type = @type", {
                    ["@type"] = type,
                    ["@data"] = json.encode(data[type])
                })
                Tree.Logs.send("Boutique: Retrait d'offre", "Type: " .. type .. "\nModel: " .. model .. "", "green",
                    Tree.Config.Logs.BoutiqueremoveOffreBoutique)
                break
            end
        end
    end
end)

RegisterNetEvent("Plugins:Boutique:changeLabelMode", function(type, model, label)
    local _source = source
    local player = Tree.getPlayer(_source)
    local xPlayer = ESX.GetPlayerFromId(_source)
    if Tree.Admin.isOwner(player.getIdentifierByType("license")) then
        for i = 1, #data[type] do
            if data[type][i].model == model then
                data[type][i].label = label
                MySQL.Async.execute("UPDATE tree_boutique SET data = @data WHERE type = @type", {
                    ["@type"] = type,
                    ["@data"] = json.encode(data[type])
                })
                Tree.Logs.send("Boutique: Changement de label",
                    "Type: " .. type .. "\nModel: " .. model .. "\nLabel: " .. label .. "", "green",
                    Tree.Config.Logs.BoutiquechangeLabelMode)
                break
            end
        end
    end
end)

RegisterNetEvent("Plugins:Boutique:changePriceMode", function(type, model, price)
    local _source = source
    local player = Tree.getPlayer(_source)
    local xPlayer = ESX.GetPlayerFromId(_source)
    if Tree.Admin.isOwner(player.getIdentifierByType("license")) then
        for i = 1, #data[type] do
            if data[type][i].model == model then
                data[type][i].price = price
                MySQL.Async.execute("UPDATE tree_boutique SET data = @data WHERE type = @type", {
                    ["@type"] = type,
                    ["@data"] = json.encode(data[type])
                })
                Tree.Logs.send("Boutique: Changement de prix",
                    "Type: " .. type .. "\nModel: " .. model .. "\nPrix: " .. price .. "", "green",
                    Tree.Config.Logs.BoutiquechangePriceMode)
                break
            end
        end
    end
end)

RegisterNetEvent("Plugins:Boutique:changeModelMode", function(type, model, newModel)
    local _source = source
    local player = Tree.getPlayer(_source)
    local xPlayer = ESX.GetPlayerFromId(_source)
    if Tree.Admin.isOwner(player.getIdentifierByType("license")) then
        for i = 1, #data[type] do
            if data[type][i].model == model then
                data[type][i].model = newModel
                MySQL.Async.execute("UPDATE tree_boutique SET data = @data WHERE type = @type", {
                    ["@type"] = type,
                    ["@data"] = json.encode(data[type])
                })
                Tree.Logs.send("Boutique: Changement de model", "Type: " .. type .. "\nModel: " .. model .. "", "green",
                    Tree.Config.Logs.BoutiquechangeModelMode)
                break
            end
        end
    end
end)

RegisterNetEvent("Plugins:Boutique:changeDescriptionMode", function(type, model, description)
    local _source = source
    local player = Tree.getPlayer(_source)
    if Tree.Admin.isOwner(player.getIdentifierByType("license")) then
        for i = 1, #data[type] do
            if data[type][i].model == model then
                data[type][i].description = description
                MySQL.Async.execute("UPDATE tree_boutique SET data = @data WHERE type = @type", {
                    ["@type"] = type,
                    ["@data"] = json.encode(data[type])
                })
                Tree.Logs.send("Boutique: Changement de description",
                    "Type: " .. type .. "\nModel: " .. model .. "\nDescription: " .. description .. "", "green",
                    Tree.Config.Logs.BoutiquechangeDescriptionMode)
                break
            end
        end
    end
end)

RegisterNetEvent("Plugins:Boutique:addItemToCase", function(model, category, itemName, probability, label)
    local _source = source
    local player = Tree.getPlayer(_source)
    if Tree.Admin.isOwner(player.getIdentifierByType("license")) then
        for i = 1, #data["mysterybox"] do
            if data["mysterybox"][i].model == model then
                local newItem = {
                    name = itemName,
                    probability = probability,
                    label = label
                }

                if category == "vehicles" then
                    table.insert(data["mysterybox"][i].items["vehicles"], newItem)
                elseif category == "weapons" then
                    table.insert(data["mysterybox"][i].items["weapons"], newItem)
                elseif category == "items" then
                    table.insert(data["mysterybox"][i].items["items"], newItem)
                else
                    return
                end

                MySQL.Async.execute("UPDATE tree_boutique SET data = @data WHERE type = 'mysterybox'", {
                    ["@data"] = json.encode(data["mysterybox"])
                })

                Tree.Logs.send("Boutique: Ajout d'item à la caisse mystère",
                    "Model: " ..
                    model ..
                    "\nCategory: " ..
                    category .. "\nItem: " .. itemName .. "\nProbability: " .. probability .. "\nLabel: " .. label,
                    "blue", Tree.Config.Logs.BoutiqueAddItemToCase)
                break
            end
        end
    end
end)


RegisterNetEvent("Plugins:Boutique:removeItemFromCase", function(model, itemName)
    local _source = source
    local player = Tree.getPlayer(_source)
    if Tree.Admin.isOwner(player.getIdentifierByType("license")) then
        for i = 1, #data["mysterybox"] do
            if data["mysterybox"][i].model == model then
                for j = #data["mysterybox"][i].items["vehicles"], 1, -1 do
                    if data["mysterybox"][i].items["vehicles"][j].name == itemName then
                        table.remove(data["mysterybox"][i].items["vehicles"], j)
                        break
                    end
                end

                for j = #data["mysterybox"][i].items["weapons"], 1, -1 do
                    if data["mysterybox"][i].items["weapons"][j].name == itemName then
                        table.remove(data["mysterybox"][i].items["weapons"], j)
                        break
                    end
                end

                for j = #data["mysterybox"][i].items["items"], 1, -1 do
                    if data["mysterybox"][i].items["items"][j].name == itemName then
                        table.remove(data["mysterybox"][i].items["items"], j)
                        break
                    end
                end

                MySQL.Async.execute("UPDATE tree_boutique SET data = @data WHERE type = 'mysterybox'", {
                    ["@data"] = json.encode(data["mysterybox"])
                })

                Tree.Logs.send("Boutique: Retrait d'item de caisse mystère",
                    "Model: " .. model .. "\nItem: " .. itemName .. "", "green",
                    Tree.Config.Logs.BoutiqueremoveItemFromCase)
                break
            end
        end
    end
end)

RegisterNetEvent("Plugins:Boutique:modifyItemInCase", function(model, itemName, newProbability, newName, newLabel)
    local _source = source
    local player = Tree.getPlayer(_source)
    if Tree.Admin.isOwner(player.getIdentifierByType("license")) then
        for i = 1, #data["mysterybox"] do
            if data["mysterybox"][i].model == model then
                for j = 1, #data["mysterybox"][i].items["vehicles"] do
                    if data["mysterybox"][i].items["vehicles"][j].name == itemName then
                        data["mysterybox"][i].items["vehicles"][j].probability = newProbability
                        data["mysterybox"][i].items["vehicles"][j].name = newName
                        data["mysterybox"][i].items["vehicles"][j].label = newLabel
                        break
                    end
                end

                for j = 1, #data["mysterybox"][i].items["weapons"] do
                    if data["mysterybox"][i].items["weapons"][j].name == itemName then
                        data["mysterybox"][i].items["weapons"][j].probability = newProbability
                        data["mysterybox"][i].items["weapons"][j].name = newName
                        data["mysterybox"][i].items["weapons"][j].label = newLabel
                        break
                    end
                end

                for j = 1, #data["mysterybox"][i].items["items"] do
                    if data["mysterybox"][i].items["items"][j].name == itemName then
                        data["mysterybox"][i].items["items"][j].probability = newProbability
                        data["mysterybox"][i].items["items"][j].name = newName
                        data["mysterybox"][i].items["items"][j].label = newLabel
                        break
                    end
                end

                MySQL.Async.execute("UPDATE tree_boutique SET data = @data WHERE type = 'mysterybox'", {
                    ["@data"] = json.encode(data["mysterybox"])
                })

                Tree.Logs.send("Boutique: Modification d'item de caisse mystère",
                    "Model: " ..
                    model ..
                    "\nItem: " ..
                    itemName ..
                    "\nNew Probability: " .. newProbability .. "\nNew Name: " .. newName .. "\nNew Label: " .. newLabel,
                    "yellow", Tree.Config.Logs.BoutiqueModifyItemInCase)
                break
            end
        end
    end
end)

RegisterNetEvent("Plugins:Boutique:addMysteryBox", function(label, color, props, model, price, mysteryBoxItems)
    local _source = source
    local player = Tree.getPlayer(_source)
    local xPlayer = ESX.GetPlayerFromId(_source)
    if Tree.Admin.isOwner(player.getIdentifierByType("license")) then
        local newOffre = {
            label = label,
            color = color,
            props = props,
            model = model,
            price = price,
            items = mysteryBoxItems
        }
        table.insert(data["mysterybox"], newOffre)
        MySQL.Async.execute("UPDATE tree_boutique SET data = @data WHERE type = 'mysterybox'", {
            ["@data"] = json.encode(data["mysterybox"])
        })
        Tree.Logs.send("Boutique: Ajout de caisse mystère", "Label: " .. label .. "", "green",
            Tree.Config.Logs.BoutiqueaddMysteryBox)
        TriggerClientEvent("Plugins:Boutique:ReceiveMysteryBox", player.id, data["mysterybox"])
    end
end)
