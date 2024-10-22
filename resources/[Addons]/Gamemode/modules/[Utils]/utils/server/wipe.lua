RegisterCommand("wipe", function(source, args, raw)
    local xPlayer = ESX.GetPlayerFromId(source)

    if source == 0 or ConfigWipe.Autorized[xPlayer.getGroup()] then 
        local tPlayer = ESX.GetPlayerFromIdentifier(args[1])
        if tPlayer ~= nil then 
            DropPlayer(tPlayer.source, ConfigWipe.MessageWipe)
        end

        MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier=@identifier", {
            ["@identifier"] = args[1]
        }, function(result)
            
            if result[1] ~= nil then 
                Accounts = json.decode(result[1].accounts)
                NewAccounts = {}
                for k, v in pairs(Accounts) do 
                    table.insert(NewAccounts, {
                        name = v.name,
                        money = 0
                    })
                end

                Inventory = json.decode(result[1].inventory)
                NewItems = {}
                NewWeapons = {}

                for k, v in pairs(Inventory.main) do 
                    if v.type == "weapons" and v.args and v.args.antiActions == "perma" then
                        table.insert(NewWeapons, v)
                    elseif v.type ~= "weapons" then
                        table.insert(NewItems, v)
                    end
                end

                if Inventory.weapons then
                    for k, v in pairs(Inventory.weapons) do
                        if v.args and v.args.antiActions == "perma" then
                            table.insert(NewWeapons, v)
                        end
                    end
                end
                
                MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner', {
                    ['@owner'] = args[1]
                }, function(result)
                    for i=1, #result, 1 do
                        MySQL.Async.execute('DELETE FROM trunk_inventory WHERE vehiclePlate = @vehiclePlate', {
                            ['@vehiclePlate'] = result[i].plate
                        })
                        if not result[i].boutique == 1 then
                            MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @vehiclePlate', {
                                ['@vehiclePlate'] = result[i].plate
                            })
                            print("Véhicule non boutique supprimé avec succès")
                        else
                            print("Véhicule de boutique non supprimé")
                        end
                    end
                end)
                
                for k, v in pairs(ConfigWipe.TableDelete) do 
                    MySQL.Async.execute("DELETE FROM "..v.name.." WHERE "..v.id.." = @"..v.id.."", {
                        ["@"..v.id] = args[1]
                    })
                end
                for k, v in pairs(ConfigWipe.TableUpdate) do
                    print("UPDATE", args[1], v.id, v.var, v.finalvalue)
                    MySQL.Async.execute("UPDATE "..v.tablename.." SET "..v.var.." = @"..v.var.." WHERE "..v.id.." = @"..v.id.."", {
                        ["@"..v.id] = args[1],
                        ["@"..v.var] = v.finalvalue
                    })
                end

                MySQL.Async.execute("UPDATE users SET accounts=@accounts, inventory=@inventory WHERE identifier=@identifier", {
                    ["@identifier"] = args[1],
                    ["@accounts"] = json.encode(NewAccounts),
                    ["@inventory"] = json.encode({main = NewItems, weapons = NewWeapons})
                })

                Source = source == 0 and "CONSOLE" or xPlayer.getName()
                SendLogs("Wipe", exports.Tree:serveurConfig().Serveur.label.." | Wipe", "La licence **"..args[1].."** vient de se faire wipe par **"..Source.."**", exports.Tree:serveurConfig().Logs.WipePlayers)    

                if source == 0 then 
                    print("Le joueur ^4"..args[1].."^0 à été wipe !")
                else
                    TriggerClientEvent(ConfigWipe.ESX..'esx:showNotification', source, "Le joueur "..exports.Tree:serveurConfig().Serveur.color..""..args[1].."~s~ à été wipe avec succès !")
                end
                
            else
                if source == 0 then 
                    print("Le joueur est introuvable !")
                else
                    TriggerClientEvent(ConfigWipe.ESX..'esx:showNotification', source, "Aucun joueur trouvé !")
                end
            end
        end)

    else
        TriggerClientEvent(ConfigWipe.ESX..'esx:showNotification', source, "Vous ne disposez pas des permissions")
    end
end)
