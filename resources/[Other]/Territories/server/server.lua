LOADED_TERRITOIRES = {}
NEW_TERRITOIRES = {}

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

local function TableLenght(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

MySQL.ready(function()
    local territoires = MySQL.Sync.fetchAll("SELECT * FROM `piwel_territoires`")
    local TEMP_ARRAY  = {}

    if territoires then
        for line, zone in pairs(CONFIG.TERRITOIRES) do
            for _, sql in pairs(territoires) do
                if line == sql.zone then
                    TEMP_ARRAY[line] = sql
                end
            end
        end
        -- Create in database if doesn't exist
        if TableLenght(TEMP_ARRAY) ~= TableLenght(CONFIG.TERRITOIRES) then
            for line, zone in pairs(CONFIG.TERRITOIRES) do
                if not TEMP_ARRAY[line] then
                    print("^8ERROR: A Territory was missing in the database. Creating territory named "..line.." in the database.^0")
                    MySQL.Async.execute('INSERT INTO `piwel_territoires` (zone) VALUES (@zone)', {['@zone'] = line})
                    table.insert(territoires, {zone = line, id_crew_owner = nil, crews_points = "{}"})
                else
                    if TEMP_ARRAY[line].id_crew_owner then CONFIG.TERRITOIRES[line].id_crew_owner = TEMP_ARRAY[line].id_crew_owner end
                    if TEMP_ARRAY[line].crews_points then CONFIG.TERRITOIRES[line].crews_points = TEMP_ARRAY[line].crews_points end
                    LOADED_TERRITOIRES[line] = {id_crew_owner = TEMP_ARRAY[line].id_crew_owner, crews_points = json.decode(TEMP_ARRAY[line].crews_points)}
                    NEW_TERRITOIRES[line] = {id_crew_owner = TEMP_ARRAY[line].id_crew_owner, crews_points = json.decode(TEMP_ARRAY[line].crews_points)}
                end
            end
        else
            for line, zone in pairs(CONFIG.TERRITOIRES) do
                if TEMP_ARRAY[line].id_crew_owner then CONFIG.TERRITOIRES[line].id_crew_owner = TEMP_ARRAY[line].id_crew_owner end
                if TEMP_ARRAY[line].crews_points then CONFIG.TERRITOIRES[line].crews_points = TEMP_ARRAY[line].crews_points end

                LOADED_TERRITOIRES[line] = {id_crew_owner = TEMP_ARRAY[line].id_crew_owner, crews_points = json.decode(TEMP_ARRAY[line].crews_points)}
                NEW_TERRITOIRES[line] = {id_crew_owner = TEMP_ARRAY[line].id_crew_owner, crews_points = json.decode(TEMP_ARRAY[line].crews_points)}
            end
        end
        --
    else
        print("An error occured, there's no territories in `piwel_territoires` sql table.")
    end

    if TableLenght(territoires) > 0 then
        print("^2Success: Loaded all the territories !^0")
    else
        print("^8CRITICAL ERROR: Could not load any terrotories.^0")
    end
end)

ESX.RegisterServerCallback('Piwel_Territoires:GetAllTerritoires', function(source, cb)
    cb(LOADED_TERRITOIRES)
end)

ESX.RegisterServerCallback('Piwel_Territoires:IsZoneOwner', function(source, cb, zone)
    local _source = source
    local Player = ESX.GetPlayerFromId(_source)
    if Player then
        if LOADED_TERRITOIRES[zone] then
            if LOADED_TERRITOIRES[zone].id_crew_owner then
                if string.upper(LOADED_TERRITOIRES[zone].id_crew_owner) == string.upper(Player.job2.name) then
                    if Player.job2.grade_name == "boss" then
                        cb(true)
                    else
                        cb(false)
                    end
                else
                    cb(false)
                end
            else
                cb(false)
            end
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('Territories:WipeTerritoire', function(source, cb, zone)
    if LOADED_TERRITOIRES[zone] then
        TriggerClientEvent('Piwel_Territoires:UpdateZoneOwned', -1, zone, false)

        LOADED_TERRITOIRES[zone].id_crew_owner = nil
        LOADED_TERRITOIRES[zone].crews_points = {}

        NEW_TERRITOIRES[zone].id_crew_owner = nil
        NEW_TERRITOIRES[zone].crews_points = {}

        CONFIG.TERRITOIRES[zone].OWNED_BY = nil
        CONFIG.TERRITOIRES[zone].CREWS_POINTS = {}

        MySQL.Async.execute("UPDATE piwel_territoires SET `id_crew_owner` = NULL, `crews_points` = '{}' WHERE zone = @zone", {
            ['@zone'] = tostring(zone),
        })
        cb(true)
    else
        cb(false)
    end
end)

local function UpdateSQL(zone, crew, leader, points, playerId, wipe)
    for line, new in pairs(NEW_TERRITOIRES) do
        for _, old in pairs(LOADED_TERRITOIRES) do
            if (new.id_crew_owner ~= old.id_crew_owner) or (new.crews_points ~= old.crews_points) then
                MySQL.Async.execute("UPDATE piwel_territoires SET id_crew_owner = @id_crew_owner, crews_points = @crews_points WHERE zone = @zone", {
                    ['@zone'] = tostring(line),
                    ['@id_crew_owner'] = new.id_crew_owner, 
                    ['crews_points'] = json.encode(new.crews_points),
                })
                if LOADED_TERRITOIRES[zone].crews_points[crew] ~= points then
                    LOADED_TERRITOIRES[zone].crews_points[crew] = points
                end

                local PLAYERS = ESX.GetPlayers()

                if ((LOADED_TERRITOIRES[zone] and LOADED_TERRITOIRES[zone].id_crew_owner) and string.upper(LOADED_TERRITOIRES[zone].id_crew_owner)) ~= string.upper(leader) then
                    if LOADED_TERRITOIRES[zone].id_crew_owner ~= nil then
                        for i = 1, #PLAYERS do
                            local xPlayer = ESX.GetPlayerFromId(PLAYERS[i])
                            if xPlayer then
                                if xPlayer.job2.name == LOADED_TERRITOIRES[zone].id_crew_owner then
                                    if xPlayer.job2.grade_name == "boss" then
                                        TriggerClientEvent('Piwel_Territoires:UpdateZoneOwned', xPlayer.source, zone, false)
                                    end
                                    xPlayer.showNotification("Votre crew à "..exports.Tree:serveurConfig().Serveur.color.."perdu un territoire~s~ ! ~b~["..zone.."]~s~")
                                end
                            end
                        end
                    end
                    LOADED_TERRITOIRES[zone].id_crew_owner = leader

                    local GANG_NAME = nil
                    for i = 1, #PLAYERS do
                        local xPlayer = ESX.GetPlayerFromId(PLAYERS[i])
                        if xPlayer then
                            if xPlayer.job2.name == leader then
                                if xPlayer.job2.grade_name == "boss" then
                                    if GANG_NAME == nil then GANG_NAME = xPlayer.job2.label end
                                    TriggerClientEvent('Piwel_Territoires:UpdateZoneOwned', xPlayer.source, zone, true)
                                end
                                xPlayer.showNotification("Votre crew à obtenu un ~g~nouveau territoire~s~ ! ~b~["..zone.."]~s~")
                            end
                        end
                    end
                    TriggerClientEvent('esx:showNotification', -1, "La zone ~b~"..zone.."~s~ a été reprise par le groupe : ~g~"..((GANG_NAME and GANG_NAME) or leader))
                end
            end
        end
    end
end

local function AddPointsToCrew(zone, playerId, PLAYER_CREW, points, add)
    local _source = playerId
    local PLAYER_CREW = tostring(PLAYER_CREW)

    if LOADED_TERRITOIRES[zone] then
        if LOADED_TERRITOIRES[zone].crews_points[PLAYER_CREW] then
            if add then
                NEW_TERRITOIRES[zone].crews_points[PLAYER_CREW] = NEW_TERRITOIRES[zone].crews_points[PLAYER_CREW] + points
            else
                NEW_TERRITOIRES[zone].crews_points[PLAYER_CREW] = NEW_TERRITOIRES[zone].crews_points[PLAYER_CREW] - points
            end
        else
            NEW_TERRITOIRES[zone].crews_points[PLAYER_CREW] = points
        end
        local last_crew_points = {points = 0, crew = nil}
        if next(NEW_TERRITOIRES[zone].crews_points) ~= nil then
            for line, crew_points in pairs(NEW_TERRITOIRES[zone].crews_points) do
                if crew_points > last_crew_points.points then
                    last_crew_points = {points = crew_points, crew = line}
                end
            end
            NEW_TERRITOIRES[zone].id_crew_owner = last_crew_points.crew 
        end
        UpdateSQL(zone, PLAYER_CREW, NEW_TERRITOIRES[zone].id_crew_owner, NEW_TERRITOIRES[zone].crews_points[PLAYER_CREW])
    end
end

local function WipeCrew(crew_id)
    local PLAYER_CREW = tostring(crew_id)
    local any_edit = false
    for zone, data in pairs(LOADED_TERRITOIRES) do
        if LOADED_TERRITOIRES[zone].crews_points[PLAYER_CREW] then
            NEW_TERRITOIRES[zone].crews_points[PLAYER_CREW] = 0
            any_edit = true
        end
        -- Définir le nouveau leader de la zone
        if LOADED_TERRITOIRES[zone].id_crew_owner == PLAYER_CREW then
            local last_crew_points = {points = 0, crew = nil}
            if next(NEW_TERRITOIRES[zone].crews_points) ~= nil then
                for line, crew_points in pairs(NEW_TERRITOIRES[zone].crews_points) do
                    if crew_points > last_crew_points.points then
                        last_crew_points = {points = crew_points, crew = line}
                    end
                end
                NEW_TERRITOIRES[zone].id_crew_owner = last_crew_points.crew 
            end
            any_edit = true
        end
        if any_edit then
            UpdateSQL(zone, PLAYER_CREW, NEW_TERRITOIRES[zone].id_crew_owner, NEW_TERRITOIRES[zone].crews_points[PLAYER_CREW])
        end
    end
end

RegisterServerEvent('Territories:WipeCrew')
AddEventHandler('Territories:WipeCrew', function(crew_id, key)
    if key == "54784784875erzgfui817478151" then
        WipeCrew(crew_id)
    end
end)

local function NotifyCrewOnline(zone, PLAYER_CREW)
    if LOADED_TERRITOIRES[zone].id_crew_owner ~= nil then
        if ((PLAYER_CREW ~= nil and string.upper(PLAYER_CREW)) or "") ~= string.upper(LOADED_TERRITOIRES[zone].id_crew_owner) then
            local PLAYERS = ESX.GetPlayers()
            for i = 1, #PLAYERS do
                local xPlayer = ESX.GetPlayerFromId(PLAYERS[i])
                if xPlayer then
                    if xPlayer.job2.name == LOADED_TERRITOIRES[zone].id_crew_owner then
                        xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Quelqu'un vend vend sur ton territoire ! ["..zone.."]")
                    end
                end
            end
        end
    end
end

RegisterServerEvent('Piwel_Territoires:Sell')
AddEventHandler("Piwel_Territoires:Sell", function(zone, PLAYER_CREW)
    local _source = source
    local Player = ESX.GetPlayerFromId(_source)

    local DRUGS_ON_PLAYER = {}
    local RANDOM_SELLING = math.random(1, 3)

    if Player then
        for line, drug in pairs(CONFIG.TERRITOIRES[zone].DRUG_PRICES) do
            local amount = ((Player.getInventoryItem(drug.name) and Player.getInventoryItem(drug.name).count) or 0)
            if amount > 0 then
                table.insert(DRUGS_ON_PLAYER, {name = drug.name, label = drug.label, price = drug.price, points_gagner = drug.points_gagner, count = amount})
            end
        end
        if #DRUGS_ON_PLAYER > 0 then
            local RANDOM_DRUG = math.random(1, #DRUGS_ON_PLAYER)
            if Player.getInventoryItem(DRUGS_ON_PLAYER[RANDOM_DRUG].name).count >= RANDOM_SELLING then
                local SELLING_PRICE = (RANDOM_SELLING * DRUGS_ON_PLAYER[RANDOM_DRUG].price)
                TriggerClientEvent('Piwel_Territoires:SendAnimations', Player.source, true, zone)
                Player.removeInventoryItem(DRUGS_ON_PLAYER[RANDOM_DRUG].name, RANDOM_SELLING)
                Player.addAccountMoney('dirtycash', SELLING_PRICE)
                Player.showNotification("Vous avez ~y~vendu~s~ ~b~x"..RANDOM_SELLING.." "..DRUGS_ON_PLAYER[RANDOM_DRUG].label.."~s~ pour ~g~$"..SELLING_PRICE..".")
                if PLAYER_CREW ~= nil then
                    AddPointsToCrew(zone, _source, PLAYER_CREW, DRUGS_ON_PLAYER[RANDOM_DRUG].points_gagner, true)
                    Player.showNotification("~g~"..DRUGS_ON_PLAYER[RANDOM_DRUG].points_gagner.." points gagnés sur cette zone.")
                end
                NotifyCrewOnline(zone, PLAYER_CREW)
            else
                TriggerClientEvent('Piwel_Territoires:SendAnimations', Player.source, false, zone)
                Player.showNotification("J'avais besoin de ~y~x"..RANDOM_SELLING.." ~b~"..DRUGS_ON_PLAYER[RANDOM_DRUG].label.."~s~, "..exports.Tree:serveurConfig().Serveur.color.."tu n'en a pas assez !")
            end
        else
            TriggerClientEvent('Piwel_Territoires:SendAnimations', Player.source, false, zone)
            Player.showNotification(exports.Tree:serveurConfig().Serveur.color.."Tu te fou de ma gueule ? T'as rien à vendre, dégage de là !")
        end
    end
end)

RegisterServerEvent('Piwel_Territoires:BuyArme')
AddEventHandler('Piwel_Territoires:BuyArme', function(zone, PLAYER_CREW, data)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local PLAYER_CREW = tostring(PLAYER_CREW)

	if xPlayer then
		local money = xPlayer.getAccount('dirtycash').money
        if money >= tonumber(data.price) then
            if LOADED_TERRITOIRES[zone].crews_points[PLAYER_CREW] then
                if LOADED_TERRITOIRES[zone].crews_points[PLAYER_CREW] >= data.points_retirer then
                    if xPlayer.canCarryItem(data.hash, 1) or data.type == "weapon" then
                        xPlayer.removeAccountMoney('dirtycash', tonumber(data.price))
                        if data.type == "weapon" then
                            xPlayer.addWeapon(data.hash, 0, nil, true);
                        else
                            xPlayer.addInventoryItem(data.hash, 1)
                        end
                        AddPointsToCrew(zone, _source, PLAYER_CREW, data.points_retirer, false)
                        xPlayer.showNotification("Tu as acheté un(e) ~y~"..data.label.."~s~ pour ~g~$"..tonumber(data.price).."~s~ et "..exports.Tree:serveurConfig().Serveur.color.."-"..data.points_retirer.." points de zone~s~.")
                    else
                        TriggerClientEvent('esx:showNotification', source, '~p~Vous n\'avez pas assez de place dans votre inventaire')
                    end
                else
                    xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Ton crew n'a pas assez de points de zone.")
                end
            else
                xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Ton crew n'a pas assez de points de zone.")
            end
        else
            xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Tu n'as pas assez d'argent sale.")
		end
	end
end)