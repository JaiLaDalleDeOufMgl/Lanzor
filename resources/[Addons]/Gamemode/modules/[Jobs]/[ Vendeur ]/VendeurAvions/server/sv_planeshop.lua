
local local_date = os.date('%H:%M:%S', os.time())


local outsidePlane = {};

ESX.RegisterServerCallback('PlaneShop:getPlaneCategories', function(source, cb)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then 

        -- if xPlayer.job.name ~= 'planeseller' then
        --     TriggerEvent("tF:Protect", source, '(PlaneShop:getPlaneCategorie)')
        --     return
        -- end

        MySQL.Async.fetchAll('SELECT * FROM vehicle_categories', {}, function(result)
            cb(result)
        end)
    end
end)

ESX.RegisterServerCallback('PlaneShop:getAllVehicles', function(source, cb)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then 

        -- if xPlayer.job.name ~= 'planeseller' then
        --     TriggerEvent("tF:Protect", source, '(PlaneShop:getAllVehicles)')
        --     return
        -- end

        MySQL.Async.fetchAll('SELECT * FROM vehicles', {
        }, function(result)
            cb(result)
        end)
    end
end)

ESX.RegisterServerCallback('PlaneShop:getSocietyVehicles', function(source, cb)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then 

        if xPlayer.job.name ~= 'planeseller' then
            TriggerEvent("tF:Protect", source, '(PlaneShop:getSocietyVehicles)')
            return
        end

        MySQL.Async.fetchAll('SELECT * FROM cardealer_vehicles WHERE society = @a', {
            ['@a'] = 'society_planeseller'
        }, function(result)
            cb(result)
        end)
    end
end)

ESX.RegisterServerCallback('PlaneShop:getSocietyMoney', function(source, cb)
    local society = ESX.DoesSocietyExist("planeseller");

    if (society) then

        cb(ESX.GetSocietyMoney("planeseller"));

    else
        cb(0);
    end
end)

RegisterServerEvent('PlaneShop:buyVehicle')
AddEventHandler('PlaneShop:buyVehicle', function(props, name, price)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name ~= "planeseller" then
        TriggerEvent("tF:Protect", source, '(PlaneShop:buyVehicle)');
        return
    end

    local society = ESX.DoesSocietyExist("planeseller");

    if (society) then

        MySQL.Async.execute('INSERT INTO cardealer_vehicles (vehicle, name, price, society) VALUES (@a, @b, @c, @d)', {
            ['@a']   = props,
            ['@b']   = name,
            ['@c']   = price,
            ['@d']   = 'society_planeseller'
        }, function()

            ESX.RemoveSocietyMoney("planeseller", tonumber(price));
            
        end);

    else

        xPlayer.showNotification("Une erreur est survenue, Code erreur "..exports.Tree:serveurConfig().Serveur.color.."'planeseller_buyVehicle_error'~s~. Veuillez contacter un "..exports.Tree:serveurConfig().Serveur.color.."administrateur~s~.");

    end

end);

RegisterServerEvent('PlaneShop:changeBucket')
AddEventHandler('PlaneShop:changeBucket', function(reason)
    local source = source
    if reason == "enter" then
        SetPlayerRoutingBucket(source, source+1)
    else
        SetPlayerRoutingBucket(source, 0)
    end
end)

ESX.RegisterServerCallback('PlaneShop:getSocietyVehicles', function(source, cb)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then 

        if xPlayer.job.name ~= 'planeseller' then
            TriggerEvent("tF:Protect", source, '(PlaneShop:getSocietyVehicles)')
            return
        end

        MySQL.Async.fetchAll('SELECT * FROM cardealer_vehicles WHERE society = @a', {
            ['@a'] = 'society_planeseller'
        }, function(result)
            cb(result)
        end)
    end
end)

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end

cachedTemporedAvion = {}
cachedTempPricePlate = {}

RegisterServerEvent('PlaneShop:removesocietyplane', function(id, model, plate, menuData)
    local src = source;
    local xPlayer = ESX.GetPlayerFromId(src);
    if (xPlayer.job.name == "planeseller") then
        MySQL.Async.execute('DELETE FROM cardealer_vehicles WHERE id = @id', {
            ['@id'] = id
        }, function()
            local vehicleModel = type(model) == 'number' and model or GetHashKey(model);
            ESX.SpawnVehicle(vehicleModel, vector3(-961.7, -3001.5, 13.9), 349.06, plate, true, xPlayer, false, function(handle, props)
                --print(dump(handle, props))

                table.insert(cachedTemporedAvion, {entity = handle.handle, model = handle.model, plate = handle.plate, price = menuData.price})
                table.insert(cachedTempPricePlate, {plate = handle.plate, price = menuData.price})
              --  xPlayer.triggerEvent("planeseller:onSpawnVehicle", menuData, NetworkGetNetworkIdFromEntity(handle), props);
                Wait(20)
                TriggerClientEvent("planeseller:onSpawnVehicle", src, cachedTemporedAvion)
                outsidePlane[#outsidePlane + 1] = {handle = handle, plate = plate, model = model, price = menuData.price, name = menuData.name};
                cachedTemporedAvion = {}
            end);
        end);
    end
end)

RegisterServerEvent('PlaneShop:recupvehicle')
AddEventHandler('PlaneShop:recupvehicle', function(vehicle, name, price, society)
    MySQL.Async.execute('INSERT INTO cardealer_vehicles (vehicle, name, price, society) VALUES (@a, @b, @c, @d)', {
        ['@a']   = vehicle,
        ['@b']   = name,
        ['@c']   = price,
        ['@d']   = 'society_planeseller'
    }, function(rowsChange)
    end)
end)
--[[
    ['@owner']   = tPlayer.getIdentifier(),
    ['@plate']   = vehicle.plate,
    ['@vehicle'] = json.encode({
        model = vehicle.model,
        plate = vehicle.plate
    }),
    ['@type']   = 'car',
    ['@state']   = 0
]]

local getPricePlane = function(plate)
    for k,v in pairs(cachedTempPricePlate) do
        if v.plate == plate then
            return v.price * 2
        end
    end
end

RegisterServerEvent('selltheplane')
AddEventHandler('selltheplane', function(player, props, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    local tPlayer = ESX.GetPlayerFromId(player)

    ---local theprice = props.price * 2
    local theprice = math.ceil(props[1].price * 1.3)

    if xPlayer.job.name ~= "planeseller" then
        TriggerEvent("tF:Protect", source, '(selltheplane)');
    elseif (theprice <= tPlayer.getAccount("bank").money) then
        local society = ESX.DoesSocietyExist("planeseller");
        tPlayer.removeAccountMoney('bank', theprice);
        ESX.AddSocietyMoney("planeseller", theprice);
        MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, state) VALUES (@owner, @plate, @vehicle, @type, @state)', {
            ['@owner']   = tPlayer.identifier,
            ['@plate']   = props[1].plate,
          --  ['@vehicle'] = json.encode(props),
            ['@vehicle'] = json.encode({
                model = props[1].model,
                plate = props[1].plate
            }),
            ['@type']   = 'Plane',
            ['@state']   = 0
        }, function()
            ESX.GiveCarKey(tPlayer, props[1].plate);
            for i = 1, #outsidePlane do
                local vehicle = outsidePlane[i];
                if (vehicle.plate == props[1].plate) then
                    table.remove(outsidePlane, i);
                    break;
                end
            end
        end)

        SetVehicleDoorsLocked(props[1].entity, 0)


        local linkAvion = exports.Tree:serveurConfig().Logs.PlaneShopJobLogs
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
        PerformHttpRequest(linkAvion, function(err, text, headers) end, 'POST', json.encode({username = "Logs Vente Voiture", embeds = content}), { ['Content-Type'] = 'application/json' })

        ---

        local link = exports.Tree:serveurConfig().Logs.PlaneShopJobLogs
        local buyerName  = tPlayer.getName(player)
        local buyerLicense = tPlayer.identifier

        local sellerName  = xPlayer.getName(source)
        local sellerLicense = xPlayer.identifier

        local local_date = os.date('%H:%M:%S', os.time())
        local content = {
            {
                ["title"] = "**Achat Avion :**",
                ["fields"] = {
                    { name = "**- Date & Heure :**", value = local_date },
                    { name = "- Acheteur :", value = buyerName.." ["..buyerLicense.."]" },
                    { name = "- Vendeur :", value = sellerName.." ["..sellerLicense.."]" },
                    { name = "- Information facture : :", value = "Avion : "..props[1].model.."\nMontant payer : "..theprice.."$\nPlaque : "..props[1].plate },
                },
                ["type"]  = "rich",
                ["color"] = 16711680,
                ["footer"] =  {
                ["text"] = "By Master | "..exports.Tree:serveurConfig().Serveur.label,
                },
            }
        }
        PerformHttpRequest(link, function(err, text, headers) end, 'POST', json.encode({username = "Logs Vente Avion", embeds = content}), { ['Content-Type'] = 'application/json' })

        xPlayer.showNotification("~g~Avion vendu pour "..theprice.."$ à "..tPlayer.getName(player));
    else
        xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Le client n'a pas assez d'argent !");
        tplayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Vous n'avez pas assez d'argent !");
    end
end)

local function storePlane(vehicleModel, vehicleName, price)
    MySQL.Async.execute('INSERT INTO cardealer_vehicles (vehicle, name, price, society) VALUES (@a, @b, @c, @d)', {
        ['@a']   = vehicleModel,
        ['@b']   = vehicleName,
        ['@c']   = price,
        ['@d']   = 'society_planeseller'
    }, function(rowsChange)
    end)
end

RegisterNetEvent("planeseller:deleteAllVehicles", function()
    local src = source;
    local xPlayer = ESX.GetPlayerFromId(src);
    if (xPlayer.job.name == "planeseller") then
        for i = 1, #outsidePlane do
            local vehicle = outsidePlane[i];
            ESX.RemoveVehicle(vehicle.plate, function()
                storePlane(vehicle.model, vehicle.name, vehicle.price);
            end);
        end
        outsidePlane = {};
    end
end);

local TimeoutJob = {};

RegisterServerEvent('Ouvre:PlaneShop')
AddEventHandler('Ouvre:PlaneShop', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob[xPlayer.identifier] or GetGameTimer() - TimeoutJob[xPlayer.identifier] > 600000) then
		TimeoutJob[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "planeseller" then
            TriggerEvent("tF:Protect", source, '(Ouvre:PlaneShop)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Avion', 'Annonce', 'Le concessionnaire Avion est désormais Ouvert~s~ !', 'CHAR_CARSITE2', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Ferme:PlaneShop')
AddEventHandler('Ferme:PlaneShop', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob[xPlayer.identifier] or GetGameTimer() - TimeoutJob[xPlayer.identifier] > 600000) then
		TimeoutJob[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "planeseller" then
            TriggerEvent("tF:Protect", source, '(Ferme:PlaneShop)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Avion', 'Annonce', 'Le concessionnaire Avion est désormais Fermer~s~ !', 'CHAR_CARSITE2', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Recrutement:PlaneShop')
AddEventHandler('Recrutement:PlaneShop', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob[xPlayer.identifier] or GetGameTimer() - TimeoutJob[xPlayer.identifier] > 600000) then
		TimeoutJob[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "planeseller" then
            TriggerEvent("tF:Protect", source, '(Recrutement:PlaneShop)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Avion', 'Annonce', 'Les Recrutement en cours, rendez-vous au concessionnaire Avion !', 'CHAR_CARSITE2', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Ouvre:Mecano')
AddEventHandler('Ouvre:Mecano', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob[xPlayer.identifier] or GetGameTimer() - TimeoutJob[xPlayer.identifier] > 600000) then
		TimeoutJob[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "mecano" then
            TriggerEvent("tF:Protect", source, '(Ouvre:Mecano)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], "Benny's", "Annonce", "Le Benny's est désormais Ouvert~s~ !", 'CHAR_CARSITE3', 8)
        end
    else
		xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Ferme:Mecano')
AddEventHandler('Ferme:Mecano', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob[xPlayer.identifier] or GetGameTimer() - TimeoutJob[xPlayer.identifier] > 600000) then
		TimeoutJob[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "mecano" then
            TriggerEvent("tF:Protect", source, '(Ferme:Mecano)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], "Benny's",  "Annonce", "Le Benny's est désormais Fermer~s~ !", 'CHAR_CARSITE3', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Recrutement:Mecano')
AddEventHandler('Recrutement:Mecano', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob[xPlayer.identifier] or GetGameTimer() - TimeoutJob[xPlayer.identifier] > 600000) then
		TimeoutJob[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "mecano" then
            TriggerEvent("tF:Protect", source, '(Recrutement:Mecano)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], "Benny's", 'Annonce', "Les Recrutement en cours, rendez-vous au Benny's !", 'CHAR_CARSITE3', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Ouvre:Mecano2')
AddEventHandler('Ouvre:Mecano2', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob[xPlayer.identifier] or GetGameTimer() - TimeoutJob[xPlayer.identifier] > 600000) then
		TimeoutJob[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "mecano2" then
            TriggerEvent("tF:Protect", source, '(Ouvre:Mecano)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], "Ls Custom", "Annonce", "Le Ls Custom est désormais Ouvert~s~ !", 'CHAR_LS_CUSTOMS', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Ferme:Mecano2')
AddEventHandler('Ferme:Mecano2', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob[xPlayer.identifier] or GetGameTimer() - TimeoutJob[xPlayer.identifier] > 600000) then
		TimeoutJob[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "mecano2" then
            TriggerEvent("tF:Protect", source, '(Ferme:Mecano)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], "Ls Custom", "Annonce", "Le Ls Custom est désormais Fermer~s~ !", 'CHAR_LS_CUSTOMS', 8)
	    end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)

RegisterServerEvent('Recrutement:Mecano2')
AddEventHandler('Recrutement:Mecano2', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
    if (not TimeoutJob[xPlayer.identifier] or GetGameTimer() - TimeoutJob[xPlayer.identifier] > 600000) then
		TimeoutJob[xPlayer.identifier] = GetGameTimer();
        if xPlayer.job.name ~= "mecano2" then
            TriggerEvent("tF:Protect", source, '(Recrutement:Mecano)');
            return
        end
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], "Ls Custom", 'Annonce', "Les Recrutement en cours, rendez-vous au Ls Custom !", 'CHAR_LS_CUSTOMS', 8)
        end
    else
        xPlayer.showNotification("Vous devez attendre 10 minutes avant de pouvoir faire une annonce à nouveau.");
    end
end)