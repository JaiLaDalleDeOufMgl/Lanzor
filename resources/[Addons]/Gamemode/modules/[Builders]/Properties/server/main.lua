MySQL.ready(function()
	MySQL.Async.execute('DELETE FROM properties_list WHERE isBuy = @isBuy', {
		['@isBuy'] = 0
	})
end)





local Properties = {}
local PropertiesLoaded = false
local PlayerInProperties = {}
local local_date = os.date('%H:%M:%S', os.time())

-- Citizen.CreateThread(function()
--     while not PropertiesLoaded do 
--         Wait(100)
--     end
--     local DeleteCount = 0
--     while true do
--         DeleteCount = DeleteCount + 1
--         print("Properties not buyed delete (DeleteId:"..DeleteCount..")")
--         Wait(5*60000)
--         MySQL.Async.execute('DELETE FROM properties_list WHERE isBuy = @isBuy', {
--             ['@isBuy'] = 0
--         })
--     end
-- end)

CreateThread(function()
    Wait(500)
    MySQL.Async.fetchAll('SELECT * FROM properties_list', {}, function(data)
        for k,v in pairs(data) do
            local info = json.decode(v.info)
            if not Properties[info.name] then
                Properties[info.name] = {}
                Properties[info.name].id = v.id
                Properties[info.name].name = info.name
                Properties[info.name].label = info.label 
                Properties[info.name].poids = tonumber(info.poids)
                Properties[info.name].price = tonumber(v.price) 

                local isBuy 
                if tonumber(v.isBuy) == 1 then 
                    isBuy = true
                else 
                    isBuy = false
                end

                Properties[info.name].isBuy = isBuy
                Properties[info.name].positions = json.decode(v.coords)
                Properties[info.name].owner = v.owner

                if v.data ~= nil then
                    Properties[info.name].data = json.decode(v.data)
                else
                    Properties[info.name].data = {}
                end


                Properties[info.name].bucketID = math.random(0,999)
                
                exports[exports.Tree:serveurConfig().Serveur.hudScript]:loadCoffreProperties(Properties[info.name].name, Properties[info.name].data, Properties[info.name].poids)
            end
        end
        PropertiesLoaded = true
    end)
end)

local function SizeOfTable(t)
    local count = 0

    for k,v in pairs(t) do
        count = count + 1
    end

    return count
end

local function GetPlayerProperties(id)
    local _source = id 
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xIdentifier = xPlayer.identifier
    local PlayerProperties = {}

    for k,v in pairs(Properties) do 
        if v.owner == xIdentifier then 
            table.insert(PlayerProperties, v)
        end
    end
    return PlayerProperties
end

local function CheckIsMyProperties(PlayerProperties, propertiesName)
    local itsMyProperties = false
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    for k,v in pairs(PlayerProperties) do 
        if v.name == propertiesName then 
            itsMyProperties = true
        end
    end
    return itsMyProperties
end 

local function GetProperties(propertiesName)
    if Properties[propertiesName] then 
        return true, Properties[propertiesName]
    else 
        return false
    end
end



RegisterNetEvent("Properties:CreatedProperties")
AddEventHandler("Properties:CreatedProperties", function(data) 
    local IdForProperties = math.random(1,999000)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.job.name == "realestateagent" and #(GetEntityCoords(GetPlayerPed(_source)) - data.POSITION.EXIT) < 50 then 

        local info = {
            name = "Propriete n°"..IdForProperties,
            label = data.LABEL,
            poids = data.POIDS
        }

        local coords = data.POSITION

        if not Properties[info.name] then 
            Properties[info.name] = {}

            Properties[info.name].name = "Propriete n°"..IdForProperties
            Properties[info.name].label = info.label 
            Properties[info.name].poids = tonumber(info.poids)
            Properties[info.name].price = tonumber(data.PRICE) 
            Properties[info.name].isBuy = false
            Properties[info.name].positions = coords
            Properties[info.name].owner = nil
            Properties[info.name].data = {}
            Properties[info.name].bucketID = math.random(0,999)

            logsMaison("[Création Properties] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Info propriété : **\n- Nom : "..info.name.."\n**Prix : **"..tonumber(data.PRICE).."\n**ID Maison : **"..IdForProperties, exports.Tree:serveurConfig().Logs.AgentImmoJobLogs)
            
            MySQL.Async.execute('INSERT INTO properties_list (name, info, price, coords) VALUES (@name, @info, @price, @coords)', {
                ['@name'] = info.name,
                ['@info'] = json.encode(info),
                ['@price'] = tonumber(data.PRICE),
                ['@coords'] = json.encode(coords)
            })

            
            exports[exports.Tree:serveurConfig().Serveur.hudScript]:loadCoffreProperties(Properties[info.name].name, Properties[info.name].data, Properties[info.name].poids)
            
            print(GetPlayerName(_source).." viens de cree une proprieter. Nom : ".."Propriete n°"..IdForProperties)
            
            Notification(_source, "~g~Création de Propriete~s~\nVotre Propriete ".."Propriete n°"..IdForProperties.." à bien était crée avec comme prix "..data.PRICE.."$.") 
            TriggerClientEvent("Properties:UpdatePropertiesList", -1, Properties)
        else 
            Notification(_source, "~g~Création de Propriete~s~\nUne Propriete comporte déjé ce nom.") 
        end
    else 
        Propeties.KickOption(_source)
    end
end)

RegisterNetEvent('DeleteProperties')
AddEventHandler('DeleteProperties', function(info)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == "realestateagent" then
        MySQL.Async.execute('DELETE FROM properties_list WHERE name = @idMaison', {
            ['@idMaison'] = info.name,
        })

        Properties[info.name] = nil
        exports[exports.Tree:serveurConfig().Serveur.hudScript]:deleteTrunkPropertiesList(info.name)

        Notification(source, exports.Tree:serveurConfig().Serveur.color.."Vous avez bien supprimer la Propriete : "..info.name)
        TriggerClientEvent("Properties:DeleteZones", -1, info.name)
        TriggerClientEvent("Properties:UpdatePropertiesList", -1, Properties)
    else
        TriggerEvent("tF:Protect", source, "DeleteProperties")
    end
end)


RegisterNetEvent("Properties:PlayerBuyPropeties")
AddEventHandler("Properties:PlayerBuyPropeties", function(data) 
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if #(GetEntityCoords(GetPlayerPed(_source)) - vector3(data.positions.EXIT.x, data.positions.EXIT.y, data.positions.EXIT.z)) < 50 then 
        local xMoney = xPlayer.getAccount('cash').money 

        if xMoney >= data.price then 
            if Properties[data.name] then
                local moneyForEntreprise = data.price - data.price * 40/100
                xPlayer.removeAccountMoney('cash', data.price)

                logsMaison("[Achat Properties] \n\n**Client :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Montant de la facture : **"..data.price.."$\n\n**Nom propriété : **"..data.label, exports.Tree:serveurConfig().Logs.AgentImmoJobLogs)

                ESX.AddSocietyMoney("realestateagent", moneyForEntreprise);
                Properties[data.name].isBuy = true
                Properties[data.name].owner = xPlayer.identifier
                MySQL.Async.execute('UPDATE properties_list SET isBuy=@isBuy, owner=@owner WHERE name=@name', {
                    ['@name'] = data.name,
                    ["@owner"] = xPlayer.identifier,
                    ['@isBuy'] = 1,
                })
                Notification(_source, "~g~Achat Propriete~s~\nVous avez payer "..data.price.."$ pour la Propriete "..data.label..".") 
                TriggerClientEvent("Properties:UpdatePropertiesBuyed", -1, data.name, true)
                TriggerClientEvent("Properties:RefreshPropertiesBlips", -1, Properties)
            else 
                Notification(_source, exports.Tree:serveurConfig().Serveur.color.."Achat Propriete~s~\nUne erreur est survenue lors de votre achat.") 
            end
        else
            Notification(_source, "~g~Achat Propriete~s~\nVous n'avez pas l'argent nécessaire. (manque "..data.price-xMoney.."$)") 
        end
    else 
        Propeties.KickOption(_source)
    end
end)


RegisterNetEvent("Properties:PlayerHasRenderProperties")
AddEventHandler("Properties:PlayerHasRenderProperties", function(data, priceRender) 
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local PlayerProperties = GetPlayerProperties(_source)
    local itsMyProperties = CheckIsMyProperties(PlayerProperties, data.name)

    if itsMyProperties and #(GetEntityCoords(GetPlayerPed(_source)) - vector3(data.positions.COFFRE.x, data.positions.COFFRE.y, data.positions.COFFRE.z)) < 50 then 
        if Properties[data.name] then
            xPlayer.addAccountMoney('cash', priceRender)
            Properties[data.name].isBuy = false
            Properties[data.name].owner = nil
            MySQL.Async.execute('UPDATE properties_list SET isBuy=@isBuy, owner=@owner, data=@data WHERE name=@name', {
                ['@name'] = data.name,
                ["@owner"] = nil,
                ['@isBuy'] = 0,
                ["@data"] = "[]"
            })
            Notification(_source, "~g~Reprise Propriete~s~\nL'agence a repris votre "..data.label..". Vous avez reéu "..priceRender.."$.") 
            TriggerClientEvent("Properties:UpdatePropertiesBuyed", -1, data.name, false)
            TriggerClientEvent("Properties:ExitProperties", _source, data.name)
            TriggerClientEvent("Properties:RefreshPropertiesBlips", -1, Properties)
        else 
            Notification(_source, exports.Tree:serveurConfig().Serveur.color.."Achat Propriete~s~\nUne erreur est survenue lors de la reprise de votre Propriete.") 
        end
    else 
        Propeties.KickOption(_source)
    end
end)


RegisterNetEvent("Properties:SetBucket")
AddEventHandler("Properties:SetBucket", function(interact, number)
    local _source = source
    
    if interact == "solo" then
        SetPlayerRoutingBucket(_source, _source)
    elseif interact == "group" then 
        SetPlayerRoutingBucket(source, number)
    elseif interact == "remettre" then 
        SetPlayerRoutingBucket(source, 0)
    else
        Propeties.KickOption(_source)
    end
end)

RegisterNetEvent("Properties:PlayerEntrerOrExitThisProperties")
AddEventHandler("Properties:PlayerEntrerOrExitThisProperties", function(data, exitOrEnter) 
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local PlayerProperties = GetPlayerProperties(_source)
    local itsMyProperties = CheckIsMyProperties(PlayerProperties, data.name)

    if itsMyProperties then 
        if exitOrEnter == "enter" then 
            if not PlayerInProperties[data.name] then 
                PlayerInProperties[data.name] = {}
                table.insert(PlayerInProperties[data.name], _source)
            else 
                for k,v in pairs(PlayerInProperties[data.name]) do 
                    if v == _source then
                        table.remove(PlayerInProperties[data.name], k)
                    end
                end
            end
        elseif exitOrEnter == "exit" then 
            if PlayerInProperties[data.name] then
                for k,v in pairs(PlayerInProperties[data.name]) do 
                    if v == _source then
                        table.remove(PlayerInProperties[data.name], k)
                    end
                end
            end
        end
    -- else 
    --     Propeties.KickOption(_source)
    end
end)





RegisterNetEvent("Properties:PlayerSonnedToPropreties")
AddEventHandler("Properties:PlayerSonnedToPropreties", function(data)
    local _source = source
    local waitTime = math.random(5000, 10000)

    if not ESX.Jobs[data.owner] then 
        if PlayerInProperties[data.name] then 
            if SizeOfTable(PlayerInProperties[data.name]) > 0 then 
                for k,v in pairs(PlayerInProperties[data.name]) do 
                    TriggerClientEvent("Properties:NotificationSonnedProperties", v, data.name, _source)
                end
            else 
                Wait(waitTime)
                Notification(_source, exports.Tree:serveurConfig().Serveur.color.."Sonnette Propriete~s~\nIl y a l'air d'y avoir personne dans cette Propriete.") 
            end
        else 
            Wait(waitTime)
            Notification(_source, exports.Tree:serveurConfig().Serveur.color.."Sonnette Propriete~s~\nIl y a l'air d'y avoir personne dans cette Propriete.") 
        end
    else 

    end
end)
RegisterNetEvent("Properties:ReturnPlayerSonnedProperties")
AddEventHandler("Properties:ReturnPlayerSonnedProperties", function(interact, id, data, isLonguer)
    local _source = source
    
    if interact == "accept" then
        Notification(_source, "~g~Sonnette Propriete~s~\nVous avez accepté la sonnerie.") 
        TriggerClientEvent("Properties:EnterPropertiesBySonnet", id, data, _source)
    elseif interact == "decline" then 
        if not isLonguer then
            Notification(_source, exports.Tree:serveurConfig().Serveur.color.."Sonnette Propriete~s~\nVous avez déclinner la sonnerie.")
        end 
        Notification(id, exports.Tree:serveurConfig().Serveur.color.."Sonnette Propriete~s~\nLa personne a déclinner votre sonnerie.") 
    else 
        Propeties.KickOption(_source)
    end
end)




ESX.RegisterServerCallback("Properties:GetProperties", function(source, cb)
    cb(Properties)
end)

ESX.RegisterServerCallback("Properties:GetPlayerProperties", function(source, cb)
    local _source = source 
    local PlayerProperties = GetPlayerProperties(_source)
    cb(json.encode(PlayerProperties))
end)







-- OTHERS
RegisterNetEvent('Properties:GetPlayerLicense')
AddEventHandler('Properties:GetPlayerLicense', function()
    local _source = source 
    local xLicense = nil
    for k,v in pairs(GetPlayerIdentifiers(_source))do            
        if string.sub(v, 1, string.len("license:")) == "license:" then
            xLicense = v
        end
    end

    TriggerClientEvent("Properties:GetPlayerLicense", _source, xLicense)
end)


function logsMaison(message,url)
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] = 2061822,
            ["footer"]=  {
                ["text"]= "By Master | "..exports.Tree:serveurConfig().Serveur.label,
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs ", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end