RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT * FROM vdaaccess WHERE license = @license", {
        ["@license"] = xPlayer.identifier
    }, function(result)
        if result[1] then
            TriggerClientEvent('Vda:setAccess', source)
            TriggerClientEvent("Vda:AddBlips", source)
        end
        
    end)
end)

WlLicense = {
    ["license:e17c6cd59fc3e223cca28bb4d1707932ff09c705"] = true, -- Choingt
    ["license:e17c6cd59fc3e223cca28bb4d1707932ff09c705"] = true -- Aiiden
}

RegisterServerEvent("Vda:CheckAccess")
AddEventHandler("Vda:CheckAccess", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll("SELECT * FROM vdaaccess WHERE license = @license", {
        ["@license"] = xPlayer.identifier
    }, function(result)
        if result[1] then
            TriggerClientEvent('Vda:OpenMenu', src,result[1].lvl)
        else
            xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Vous n'avez pas accès à ce menu")
        end
         
    end)
end)

ESX.RegisterServerCallback("Vda:GetVdaCoords", function(source, cb)
    cb(vector3(4448.0703, -4444.8530, 7.2368))
end)

RegisterCommand("AddVdaLicense", function(source, args)
    local src = source
    local text = args[1]
    if src == 0 then
        if args[1] == nil then
            return
        elseif tonumber(args[2]) == 1 or tonumber(args[2]) == 2 then
            if string.sub(text, 1, 8) == "license:" then
                MySQL.Async.fetchAll("SELECT * FROM vdaaccess WHERE license = @license", {
                    ["@license"] = args[1]
                }, function(result)
                    if result[1] then
                        print("^1[VDA] Cette license a déjà accès au menu^7")
                    else
                        MySQL.Async.execute("INSERT INTO vdaaccess (license,lvl) VALUES (@license,@lvl)", {
                            ["@license"] = args[1],
                            ["@lvl"] = args[2]
                        }, function(result)
                            if result then
                                -- print("^1[VDA]^7 Vous avez ajouté l'accès à ^2"..args[1])
                            else
                                -- print("^1[VDA]^7 Une erreur est survenue")
                            end
                        end)
                    end
                end)
            else
                -- print("[VDA] Vous devez spécifier une license")
            end
        else
            -- print("[VDA] Vous devez spécifier un niveau 1 ou 2 ou une license")
        end
       
    else
        local xPlayer = ESX.GetPlayerFromId(source)

        if WlLicense[xPlayer.identifier] then
            if args[1] == nil then
                xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Vous devez spécifier une license")
                return
            elseif tonumber(args[2]) == 1 or tonumber(args[2]) == 2 then
                if string.sub(text, 1, 8) == "license:" then
                    if xPlayer.getGroup() == "fondateur" then
                        MySQL.Async.fetchAll("SELECT * FROM vdaaccess WHERE license = @license", {
                            ["@license"] = args[1]
                        }, function(result)
                            if result[1] then
                                xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Cette license a déjà accès au menu")
                            else
                                MySQL.Async.execute("INSERT INTO vdaaccess (license,lvl) VALUES (@license,@lvl)", {
                                    ["@license"] = args[1],
                                    ["@lvl"] = args[2]
                                }, function(result)
                                    if result then
                                        xPlayer.showNotification("~g~Vous avez ajouté l'accès à "..args[1])
                                    else
                                        xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Une erreur est survenue")
                                    end
                                end)
                            end
                        end)
                    end
                else
                    xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Vous devez spécifier une license")
                end
            else
                xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Vous devez spécifier un niveau 1 ou 2 une license")
            end
        else
            xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Vous n'avez pas accès à cette commande")
        end
    end
end)
RegisterServerEvent("Vda:BuyWeapon")
AddEventHandler("Vda:BuyWeapon", function(weapon,price,weaponlabel)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll("SELECT * FROM vdaaccess WHERE license = @license", {
        ["@license"] = xPlayer.identifier
    }, function(result)
        if result[1] then
            if xPlayer.getWeapon(weapon) then
                xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Vous avez déjà cette arme")
                return
            else
                if xPlayer.getAccount("dirtycash").money >= price then
                    if (xPlayer.canCarryItem(weapon, 1)) then
                        xPlayer.removeAccountMoney("dirtycash", price)
                        xPlayer.addWeapon(weapon)
                        xPlayer.showNotification("~g~Vous avez acheté une "..weaponlabel)
                    else
                        xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Vous n'avez pas de place sur vous !")
                    end
                else
                    xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Vous n'avez pas assez d'argent")
                end
            end
        else
            xPlayer.ban(0,"Vda:BuyWeapon")
        end
         
    end)
    
end)

RegisterServerEvent("Vda:BuyItem")
AddEventHandler("Vda:BuyItem", function(item,price,itemlabel)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll("SELECT * FROM vdaaccess WHERE license = @license", {
        ["@license"] = xPlayer.identifier
    }, function(result)
        if result[1] then
            if not xPlayer.canCarryItem(item, 1) then
                xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Vous ne pouvez pas porter plus de d'objets")
                return
            else
                if xPlayer.getAccount("dirtycash").money >= price then
                    xPlayer.removeAccountMoney("dirtycash",price)
                    xPlayer.addInventoryItem(item, 1)
                    xPlayer.showNotification("~g~Vous avez acheté un "..itemlabel)
                else
                    xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Vous n'avez pas assez d'argent")
                end
            end
        else
            xPlayer.ban(0,"Vda:BuyItem")
        end
         
    end)
    
end)