local function getUserData(identifier)
    local data = MySQL.Sync.fetchAll("SELECT coins, totaltime FROM tree_afksystem WHERE identifier = @identifier", {
        ['@identifier'] = identifier
    })
    return data
end

Tree.RegisterServerCallback("tree:afkSystem:getCoins", function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then
        return
    end
    local data = getUserData(xPlayer.identifier)
    if data[1] then
        cb(data[1].coins)
    else
        cb(0)
    end
end)

local AfkTime = {}
local inAFK = {}

RegisterNetEvent("tree:afkSystem:enterZone")
AddEventHandler("tree:afkSystem:enterZone", function()
    local _source = source
    local fivem = GetPlayerIdentifierByType(_source, "fivem")
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then
        return
    end
    inAFK[_source] = true
    SetEntityCoords(GetPlayerPed(_source), 483.2, 4810.5, -58.9)
    xPlayer.showNotification("~g~Vous êtes mantenant entré dans la zone AFK")
    while true do
        Wait(60000)
        if not inAFK[_source] then
            break
        end
        local coords = GetEntityCoords(GetPlayerPed(_source))
        local distance = #(coords - vector3(483.2, 4810.5, -58.9))
        if distance > 20 then
            xPlayer.showNotification("~r~Vous etiez trop loin de la zone AFK, vous avez été re-téléporté à la zone AFK")
            SetEntityCoords(GetPlayerPed(_source), 483.2, 4810.5, -58.9)
        end
        ExecuteCommand("heal " .. _source)
        if not AfkTime[xPlayer.identifier] then
            AfkTime[xPlayer.identifier] = 0
        end
        AfkTime[xPlayer.identifier] = AfkTime[xPlayer.identifier] + 1
        MySQL.Async.fetchAll("SELECT * FROM tree_afksystem WHERE identifier = @identifier", {
            ['@identifier'] = xPlayer.identifier
        }, function(result)
            if result[1] then
                local coins = 1

                if exports.Tree:getVip(fivem) == 1 then
                    coins = 1.5
                elseif exports.Tree:getVip(fivem) == 2 then
                    coins = 2
                elseif exports.Tree:getVip(fivem) == 3 then
                    coins = 2.5
                end

                MySQL.Async.execute(
                    "UPDATE tree_afksystem SET totaltime = totaltime + @afkTime, coins = coins + @coins WHERE identifier = @identifier",
                    {
                        ['@afkTime'] = coins,
                        ['@coins'] = coins,
                        ['@identifier'] = xPlayer.identifier
                    })
            else
                MySQL.Async.execute(
                    "INSERT INTO tree_afksystem (identifier, totaltime, coins) VALUES (@identifier, @afkTime, 1)", {
                        ['@identifier'] = xPlayer.identifier,
                        ['@afkTime'] = AfkTime[xPlayer.identifier]
                    })
            end
        end)
        xPlayer.showNotification("~g~Vous avez gagné 1 coins AFK")
    end
end)

RegisterNetEvent("tree:afkSystem:exitZone")
AddEventHandler("tree:afkSystem:exitZone", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then
        return
    end
    if not inAFK[_source] then
        return
    end
    if inAFK[_source] then
        SetEntityCoords(GetPlayerPed(_source), 223.746262, -789.971375, 30.725300)
        xPlayer.showNotification("~g~Vous êtes mantenant sorti de la zone AFK")
    end
    inAFK[_source] = false
end)



RegisterNetEvent("tree:afkSystem:buyItemAFK")
AddEventHandler("tree:afkSystem:buyItemAFK", function(v)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then
        return
    end
    if not inAFK[_source] then
        xPlayer.showNotification(Tree.Config.Serveur.color .. "Vous n'êtes pas dans la zone AFK")
        return
    end
    local data = getUserData(xPlayer.identifier)
    if data[1] then
        if data[1].coins >= v.price then
            MySQL.Async.execute("UPDATE tree_afksystem SET coins = coins - @price WHERE identifier = @identifier", {
                ['@price'] = v.price,
                ['@identifier'] = xPlayer.identifier
            })
            MySQL.Async.fetchAll("SELECT * from tree_players_boutique where @identifier = identifier", {
                ["@identifier"] = GetPlayerIdentifierByType(_source, "fivem")
            }, function(result)
                local inventoryAFK = json.decode(result[1].inventory) or {}
                local quantity = 1
                for i = 1, quantity do
                    local newItemAFK = {
                        label = v.item,
                        model = "afk_case",
                        type = "MysteryBox"
                    }
                    table.insert(inventoryAFK, newItemAFK)
                end
                MySQL.Async.execute(
                    "UPDATE tree_players_boutique SET inventory = @inventory WHERE identifier = @identifier", {
                        ["@inventory"] = json.encode(inventoryAFK),
                        ["@identifier"] = GetPlayerIdentifierByType(_source, "fivem")
                    })
            end)
            xPlayer.showNotification("~g~Vous avez acheté un x1 " .. v.label)
        else
            xPlayer.showNotification(Tree.Config.Serveur.color .. "Vous n'avez pas assez de coins AFK")
        end
    else
        xPlayer.showNotification(Tree.Config.Serveur.color .. "Vous n'avez pas assez de coins AFK")
    end
end)
