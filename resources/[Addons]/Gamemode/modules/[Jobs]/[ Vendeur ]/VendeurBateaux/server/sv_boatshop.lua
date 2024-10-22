

local outsideBoat = {};

ESX.RegisterServerCallback('BoatShop:getBoatCategories', function(source, cb)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then 

        if xPlayer.job.name ~= 'boatseller' then
            TriggerEvent("tF:Protect", source, '(BoatShop:getBoatCategories)')
            return
        end

        MySQL.Async.fetchAll('SELECT * FROM vehicle_categories', {}, function(result)
            cb(result)
        end)
    end
end)

ESX.RegisterServerCallback('BoatShop:getAllVehicles', function(source, cb)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then 

        if xPlayer.job.name ~= 'boatseller' then
            TriggerEvent("tF:Protect", source, '(BoatShop:getAllVehicles)')
            return
        end

        MySQL.Async.fetchAll('SELECT * FROM vehicles', {
        }, function(result)
            cb(result)
        end)
    end
end)

ESX.RegisterServerCallback('BoatShop:getSocietyMoney', function(source, cb)
    cb(ESX.GetSocietyMoney("boatseller"));
end)

ESX.RegisterServerCallback('BoatShop:getSocietyVehicles', function(source, cb)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then 

        if xPlayer.job.name ~= 'boatseller' then
            TriggerEvent("tF:Protect", source, '(BoatShop:getSocietyVehicles)')
            return
        end

        MySQL.Async.fetchAll('SELECT * FROM cardealer_vehicles WHERE society = @a', {
            ['@a'] = 'society_boatseller'
        }, function(result)
            cb(result)
        end)
    end
end)

RegisterServerEvent('BoatShop:changeBucket')
AddEventHandler('BoatShop:changeBucket', function(reason)
    local source = source
    if reason == "enter" then
        SetPlayerRoutingBucket(source, source+1)
    else
        SetPlayerRoutingBucket(source, 0)
    end
end)

RegisterServerEvent('BoatShop:buyVehicle')
AddEventHandler('BoatShop:buyVehicle', function(props, name, price)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= "boatseller" then
        TriggerEvent("tF:Protect", source, '(BoatShop:buyVehicle)');
        return
    end

    local society = ESX.DoesSocietyExist("boatseller");

    if (society) then

        MySQL.Async.execute('INSERT INTO cardealer_vehicles (vehicle, name, price, society) VALUES (@a, @b, @c, @d)', {
            ['@a']   = props,
            ['@b']   = name,
            ['@c']   = price,
            ['@d']   = 'society_boatseller'
        }, function()

            ESX.RemoveSocietyMoney("boatseller", tonumber(price));
            
        end);

    else

        xPlayer.showNotification("Une erreur est survenue, Code erreur "..exports.Tree:serveurConfig().Serveur.color.."'boatseller_buyVehicle_error'~s~. Veuillez contacter un "..exports.Tree:serveurConfig().Serveur.color.."administrateur~s~.");

    end

end);

cachedTemporedBateau = {}
cachedTempPricePlateBateau = {}

RegisterServerEvent('BoatShop:removesocietyboat', function(id, model, plate, menuData)
    local src = source;
    local xPlayer = ESX.GetPlayerFromId(src);
    if (xPlayer.job.name == "boatseller") then
        MySQL.Async.execute('DELETE FROM cardealer_vehicles WHERE id = @id', {
            ['@id'] = id
        }, function()
            local vehicleModel = type(model) == 'number' and model or GetHashKey(model);
            ESX.SpawnVehicle(vehicleModel, vector3(-704.72, -1339.36, -0.58), 159.81, plate, true, xPlayer, false, function(handle, props)
                --CreateThread(function()

                    --while not (DoesEntityExist(handle)) do
                        --Wait(100);
                    --end

                    table.insert(cachedTemporedBateau, {entity = handle.handle, model = handle.model, plate = handle.plate, price = menuData.price})
                    table.insert(cachedTempPricePlateBateau, {plate = handle.plate, price = menuData.price})
                    Wait(20)
                    TriggerClientEvent("BoatShop:onSpawnVehicle", src, cachedTemporedBateau)
                    outsideBoat[#outsideBoat + 1] = {handle = handle, plate = plate, model = model, price = menuData.price, name = menuData.name};
                    cachedTemporedBateau = {}
                --end);
            end);
        end);
    end
end)

RegisterServerEvent('BoatShop:recupvehicle')
AddEventHandler('BoatShop:recupvehicle', function(vehicle, name, price, society)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= 'boatseller' then
        TriggerEvent("tF:Protect", source, '(BoatShop:recupvehicle)');
        return
    end
    MySQL.Async.execute('INSERT INTO cardealer_vehicles (vehicle, name, price, society) VALUES (@a, @b, @c, @d)', {
        ['@a']   = vehicle,
        ['@b']   = name,
        ['@c']   = price,
        ['@d']   = 'society_boatseller'
    }, function(rowsChange)
    end)
end)

RegisterServerEvent('BoatShop:sellthevehicle5614651651651')
AddEventHandler('BoatShop:sellthevehicle5614651651651', function(player, props, price, model)
    local xPlayer = ESX.GetPlayerFromId(source)
    local tPlayer = ESX.GetPlayerFromId(player)
    local theprice = math.ceil(props[1].price * 1.3)

    if xPlayer.job.name ~= "boatseller" then
        TriggerEvent("tF:Protect", source, '(BoatShop:sellthevehicle)');
    elseif (theprice <= tPlayer.getAccount("bank").money) then

        local society = ESX.DoesSocietyExist("boatseller");
        tPlayer.removeAccountMoney('bank', theprice);
        ESX.AddSocietyMoney("boatseller", theprice);
        MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, state) VALUES (@owner, @plate, @vehicle, @type, @state)', {
            ['@owner']   = tPlayer.identifier,
            ['@plate']   = props[1].plate,
            ['@vehicle'] = json.encode({
                model = props[1].model,
                plate = props[1].plate
            }),
            ['@type']   = 'boat',
            ['@state']   = 0
        }, function()
            ESX.GiveCarKey(tPlayer, props[1].plate);
            for i = 1, #outsideBoat do
                local vehicle = outsideBoat[i];
                if (vehicle.plate == props[1].plate) then
                    table.remove(outsideBoat, i);
                    break;
                end
            end
        end)

        SetVehicleDoorsLocked(props[1].entity, 0)

        local linkJob = "linkJob"
        local xPlayer = ESX.GetPlayerFromId(source)
        local tPlayer = ESX.GetPlayerFromId(player)

        local local_date = os.date('%H:%M:%S', os.time())
        local content = {
            {
                ["title"] = "**Achat Concess :**",
                ["fields"] = {
                    { name = "**- Date & Heure :**", value = local_date },
                    { name = "- Acheteur :", value = tPlayer.getFirstName().." "..tPlayer.getLastName().." ["..tPlayer.name.."]" },
                    { name = "- Vendeur :", value = xPlayer.getFirstName().." "..xPlayer.getLastName().." ["..xPlayer.name.."]" },
                    { name = "- Information facture :", value = "Voiture : "..props[1].model.."\nMontant payer : "..theprice.."$\nPlaque : "..props[1].plate },
                },
                ["type"]  = "rich",
                ["color"] = 16711680,
                ["footer"] =  {
                ["text"] = "By Master | "..exports.Tree:serveurConfig().Serveur.label,
                },
            }
        }
        PerformHttpRequest(linkJob, function(err, text, headers) end, 'POST', json.encode({username = "Logs Vente Voiture", embeds = content}), { ['Content-Type'] = 'application/json' })


        local link = exports.Tree:serveurConfig().Logs.BoatShopJobLogs
        local buyerName  = tPlayer.getName(player)
        local buyerLicense = tPlayer.identifier

        local sellerName  = xPlayer.getName(source)
        local sellerLicense = xPlayer.identifier

        local local_date = os.date('%H:%M:%S', os.time())
        local content = {
            {
                ["title"] = "**Achat Bateau :**",
                ["fields"] = {
                    { name = "**- Date & Heure :**", value = local_date },
                    { name = "- Acheteur :", value = buyerName.." ["..buyerLicense.."]" },
                    { name = "- Vendeur :", value = sellerName.." ["..sellerLicense.."]" },
                    { name = "- Information facture : :", value = "Bateau : "..props[1].model.."\nMontant payer : "..theprice.."$\nPlaque : "..props[1].plate },
                },
                ["type"]  = "rich",
                ["color"] = 16711680,
                ["footer"] =  {
                ["text"] = "By Master | "..exports.Tree:serveurConfig().Serveur.label,
                },
            }
        }
        PerformHttpRequest(link, function(err, text, headers) end, 'POST', json.encode({username = "Logs Vente Bateau", embeds = content}), { ['Content-Type'] = 'application/json' })

        xPlayer.showNotification("~g~Bateau vendu pour "..theprice.."$ à "..tPlayer.getName(player));
    else
        xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Le client n'a pas assez d'argent !");
        tPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Vous n'avez pas assez d'argent !");
    end
end)

local function storeBoat(vehicleModel, vehicleName, price)
    MySQL.Async.execute('INSERT INTO cardealer_vehicles (vehicle, name, price, society) VALUES (@a, @b, @c, @d)', {
        ['@a']   = vehicleModel,
        ['@b']   = vehicleName,
        ['@c']   = price,
        ['@d']   = 'society_boatseller'
    }, function(rowsChange)
    end)
end

RegisterNetEvent("boatseller:deleteAllVehicles", function()
    local src = source;
    local xPlayer = ESX.GetPlayerFromId(src);
    if (xPlayer.job.name == "boatseller") then
        for i = 1, #outsideBoat do
            local vehicle = outsideBoat[i];
            ESX.RemoveVehicle(vehicle.plate, function()
                storeBoat(vehicle.model, vehicle.name, vehicle.price);
            end);
        end
        outsideBoat = {};
    end
end);

local TimeoutJob2 = {};

RegisterServerEvent('Ouvre:BoatShop')
AddEventHandler('Ouvre:BoatShop', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob2[xPlayer.identifier] or GetGameTimer() - TimeoutJob2[xPlayer.identifier] > 600000) then
		TimeoutJob2[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "boatseller" then
            TriggerEvent("tF:Protect", source, '(Ouvre:BoatShop)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Bateau', 'Annonce', 'Le concessionnaire Bateau est désormais Ouvert~s~ !', 'CHAR_CARSITE2', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Ferme:BoatShop')
AddEventHandler('Ferme:BoatShop', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob2[xPlayer.identifier] or GetGameTimer() - TimeoutJob2[xPlayer.identifier] > 600000) then
		TimeoutJob2[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "boatseller" then
            TriggerEvent("tF:Protect", source, '(Ferme:BoatShop)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Bateau', 'Annonce', 'Le concessionnaire Bateau est désormais Fermer~s~ !', 'CHAR_CARSITE2', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Recrutement:BoatShop')
AddEventHandler('Recrutement:BoatShop', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob2[xPlayer.identifier] or GetGameTimer() - TimeoutJob2[xPlayer.identifier] > 600000) then
		TimeoutJob2[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "boatseller" then
            TriggerEvent("tF:Protect", source, '(Recrutement:BoatShop)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Bateau', 'Annonce', 'Les Recrutement en cours, rendez-vous au concessionnaire Bateau !', 'CHAR_CARSITE2', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)