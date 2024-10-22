RegisterNetEvent('Gamemode:Inventory:InvDeleteItem')
AddEventHandler('Gamemode:Inventory:InvDeleteItem', function(data)
    local xPlayer = ESX.GetPlayerFromId(source)

    local index = data.index
    local count = data.count
    local inventoryType = data.inventoryType

    if (inventoryType == 'main') then
        local PlayerInventory = xPlayer.getInventory()
        local playeritem = json.decode(json.encode(PlayerInventory[index]))

        xPlayer.removeInventoryItemAtSlot(index, count)

        local local_date = os.date('%H:%M:%S', os.time())
        local Content = {
            {
                ["title"] = "**Drop item :**",
                ["fields"] = {
                    { name = "**- Date & Heure :**", value = local_date },
                    { name = "- Qui a jetter :", value = xPlayer.name.." ["..source.."] ["..xPlayer.identifier.."]" },
                    { name = "- item drop :", value = count.." "..playeritem.name },
                },
                ["type"]  = "rich",
                ["color"] = 2061822,
                ["footer"] =  {
                ["text"] = "By Master | "..exports.Tree:serveurConfig().Serveur.label,
                },
            }
        }

        MOD_inventory:sendWebHook('Logs Delete item', Content, exports.Tree:serveurConfig().Logs.JeterItemJoueur)
    end
end)