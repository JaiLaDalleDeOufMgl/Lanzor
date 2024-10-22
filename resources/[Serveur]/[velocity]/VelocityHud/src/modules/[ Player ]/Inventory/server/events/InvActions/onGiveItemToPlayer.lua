RegisterNetEvent('Gamemode:Inventory:GiveItemToPlayer')
AddEventHandler('Gamemode:Inventory:GiveItemToPlayer', function(targetId, data)
    local xPlayer = ESX.GetPlayerFromId(source)

    local tPlayer = ESX.GetPlayerFromId(targetId)
    
    local index = data.index
    local count = data.count

    local targetInv = MOD_inventory:getInventoryPlayerByLicense(tPlayer.identifier)

    if (not targetInv) then
        print('Error, secondary inventory not exists ! Event: GiveToPlayer')
        return
    end

    if (xPlayer and targetInv) then
        local PlayerInventory = xPlayer.getInventory()
        local TargetInventory = targetInv.inventoryItems

        if (not PlayerInventory or not TargetInventory or not PlayerInventory[index]) then
            print('Error, items are not exist in player or secondary inventory ! Event: GiveToPlayer')
            return
        end

        ------HERE CHECK ITEM IS TREDABLE

        local playeritem = json.decode(json.encode(PlayerInventory[index]))

        if (playeritem == "empty") then return end

        if (not count or count > playeritem.count) then count = playeritem.count end

        local ItemInfos = MOD_Items:getItem(playeritem.name)
        if (not ItemInfos) then return end


        -- if (SecondInv.inventoryClass:) then     HERE CHECK ITEM TRADABLE

        if (MOD_inventory:getWeaponIsPerma(playeritem.name)) then return end ---GET WEAPON IS PERMA

        if (MOD_inventory:getItemSecurActions(playeritem)) then return end ---GET ITEM IS PROTECTED


        local SecondMaxWeight = targetInv:getInventoryMaxWeight()
        local SecondWeight = targetInv:getInventoryWeight()

        if (ItemInfos.weight == 0 or SecondMaxWeight >= (SecondWeight + (ItemInfos.weight * count))) then
            local AvailableSlot = targetInv:availableSlot()
            if (AvailableSlot) then
                local RemoveSucces = xPlayer.removeInventoryItemAtSlot(index, count)
                if (RemoveSucces) then
                    if (playeritem.id == xPlayer.get('currentWeapon')) then
                        RemoveAllPedWeapons(GetPlayerPed(xPlayer.source))
                    end

                    targetInv:addItemToSlot(AvailableSlot, count, playeritem)

                    tPlayer.showNotification("Vous avez reçu x"..count.." "..playeritem.name)
                    xPlayer.showNotification("Vous avez donner x"..count.." "..playeritem.name)


                    local IdShow = ""
                    if (playeritem.id ~= nil and type(playeritem.id) ~= 'boolean') then
                        IdShow = ' ( '..playeritem.id..' )'
                    end
                
                    local content = {
                        {
                            ["title"] = "**Don d'item :**",
                            ["fields"] = {
                                { name = "**- Date & Heure :**", value = os.date('%H:%M:%S', os.time()) },
                                { name = "- Qui a donner :", value = xPlayer.name.." ["..xPlayer.source.."] ["..xPlayer.identifier.."]" },
                                { name = "- Item donner :", value = playeritem.name.." x"..count..IdShow },
                                { name = "- Qui a reçu :", value = tPlayer.name.." ["..tPlayer.source.."] ["..tPlayer.identifier.."]" },
                            },
                            ["type"]  = "rich",
                            ["color"] = 2061822,
                            ["footer"] =  {
                            ["text"] = exports.Tree:serveurConfig().Serveur.label,
                            },
                        }
                    }
                    MOD_inventory:sendWebHook(exports.Tree:serveurConfig().Serveur.label.." - LOGS", content, "https://achanger/webhooks/1266363607470575739/PS20AGQKPBDjBFFR06s7EwkGnEdzunvWA0KtFqYYJZAkNfQgjSYjK7HaMsXCS7IHEh0-")
                end
            else
                xPlayer.showNotification("Le joueur n'a plus de place !")
            end
        else
            xPlayer.showNotification("Le joueur est trop lourd !")
        end
    end
end)