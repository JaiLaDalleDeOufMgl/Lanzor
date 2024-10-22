PlayerLicense = nil

Citizen.CreateThread(function()
    while not ESXLoaded do
        Wait(50)
    end
	TriggerServerEvent("Properties:GetPlayerLicense")
end)

RegisterNetEvent('Properties:GetPlayerLicense')
AddEventHandler('Properties:GetPlayerLicense', function(license)
    PlayerLicense = license
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)
RegisterNetEvent(Propeties.TriggerEsxPlayerLoaded)
AddEventHandler(Propeties.TriggerEsxPlayerLoaded, function(playerData)
	ESX.PlayerData = playerData
end)


local PropertiesLoaded = false

local CurrentProperties = nil 
local InVisite = false
local BlipsList = {}
local Exited = false

ZonesListe = {}

CreateThread(function()
    while not PropertiesLoaded do 
        Wait(50)
    end

    while true do
        local isProche = false
        for k,v in pairs(ZonesListe) do
            local dist = Vdist2(GetEntityCoords(PlayerPedId(), false), v.Position)

            if dist < 10 then
                isProche = true
                DrawMarker(25, v.Position.x, v.Position.y, v.Position.z-0.90, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.55, 0.55, 0.55, 0,127,255, 255, false, false, 2, false, false, false, false)

                if dist < 2 then
                    ESX.ShowHelpNotification(exports.Tree:serveurConfig().Serveur.color.."Propriete\nAppuyez sur ~INPUT_CONTEXT~ pour intéragir")
                    if IsControlJustPressed(1,51) then
                        v.Action()
                    end
                end
            end
        end
        
        if isProche then
            Wait(0)
        else
            Wait(1000)
        end
    end
end)

local function AddZones(zoneName, data)
    if not ZonesListe[zoneName] then
        ZonesListe[zoneName] = data
        ToConsol("Creation d'une zone (ZoneName:"..zoneName..")")
        return true
    else 
        ToConsol("Tentative de cree une zone qui exise deja (ZoneName:"..zoneName..")")
        return false
    end
end

local function RemoveZone(zoneName)
    if ZonesListe[zoneName] then
        ZonesListe[zoneName] = nil
        ToConsol("Suppression d'une zone (ZoneName:"..zoneName..")")
    else 
        ToConsol("Tentative de supprimer une zone qui exise pas (ZoneName:"..zoneName..")")
    end
end

CreateBlips = function(params)
    if params.type == nil then return end
    if params.scale == nil then return end
    if params.pos == nil then return end
    if params.name == nil then return end
    if params.color == nil then return end

    local addBlip = AddBlipForCoord(params.pos)
    SetBlipSprite(addBlip, params.type)
    SetBlipScale(addBlip, params.scale)
    SetBlipColour(addBlip, params.color)
    SetBlipAsShortRange(addBlip, true)
    SetBlipDisplay(addBlip, 4)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(params.name)
    EndTextCommandSetBlipName(addBlip)

    return addBlip
end

RemoveBlips = function(blip)
    if DoesBlipExist(blip) then
        RemoveBlip(blip)
    end
end

function Init(propertiesList)
    for k,v in pairs(propertiesList) do
        if not ZonesListe[k] then
            ZonesListe[k] = {}
            ZonesListe[k].Position = vector3(v.positions.EXIT.x, v.positions.EXIT.y, v.positions.EXIT.z)
            ZonesListe[k].Public = true 
            ZonesListe[k].Blip = true
            ZonesListe[k].Action = function()
                ActionProperties(k)
            end

            AddBlips(v)
        end
    end

    PropertiesLoaded = true
end

function AddBlips(data)
    CreateThread(function()
        while PlayerLicense == nil do Wait(1) end

        Wait(1000)

        if BlipsList[data.name] then 
            RemoveBlips(BlipsList[data.name])
            BlipsList[data.name] = nil
        end
        
        if not BlipsList[data.name] then

            if not data.isBuy then 
                BlipsList[data.name] = CreateBlips({
                    type = 375,
                    scale = 0.6,
                    pos = vector3(data.positions.EXIT.x, data.positions.EXIT.y, data.positions.EXIT.z),
                    name = "Propriete libre",
                    color = 0
                })
            else 
                local prefix, value = PlayerLicense:match("([^:]+):([^:]+)")

                if PlayerLicense == data.owner then
                    BlipsList[data.name] = CreateBlips({
                        type = 357,
                        scale = 0.6,
                        pos = vector3(data.positions.EXIT.x, data.positions.EXIT.y, data.positions.EXIT.z),
                        name = "Propriete acquise",
                        color = 0
                    })
                end

            end

        end
    end)
end


function ActionProperties(propertiesId)
    if Properties[propertiesId] then 
        if not Properties[propertiesId].isBuy then 
            OpenMenuBuyPropreties(Properties[propertiesId])
        else 
            ESX.TriggerServerCallback("Properties:GetPlayerProperties", function(personalPropertiesList) 
                local PlayerProperties = json.decode(personalPropertiesList)
                for k,v in pairs(PlayerProperties) do 
                    if Properties[propertiesId].name == v.name then 
                        EnterProperties("myproperties", v)
                        return
                    end
                end
                OpenMenuSonnerProperties(Properties[propertiesId])
            end)
        end
    end
end



RegisterNetEvent("Properties:RefreshPropertiesBlips")
AddEventHandler("Properties:RefreshPropertiesBlips", function(propertiesList)
    for k,v in pairs(propertiesList) do
        AddBlips(v)
    end
end)

RegisterNetEvent("Properties:UpdatePropertiesBuyed")
AddEventHandler("Properties:UpdatePropertiesBuyed", function(propertiesId, isBuy)
    if Properties[propertiesId] and ZonesListe[propertiesId] then 
        Properties[propertiesId].isBuy = isBuy
        ZonesListe[propertiesId].isBuy = isBuy
    end
end)

RegisterNetEvent("Properties:EnterPropertiesBySonnet")
AddEventHandler("Properties:EnterPropertiesBySonnet", function(propreties, bucketID)
    if Properties[propreties.name] then 
        EnterProperties("bysonnet", propreties, bucketID)
    end
end)

RegisterNetEvent("Properties:ExitProperties")
AddEventHandler("Properties:ExitProperties", function(propertiesId)
    if Properties[propertiesId] then 
        ExitProperties("myproperties")
    end
end)

RegisterNetEvent("Properties:DeleteZones")
AddEventHandler("Properties:DeleteZones", function(zone)
    RemoveZone(zone)
end)

function AntiBucketUseBug(firstpos)
    while true do
        local pPed = PlayerPedId()
        local pCoords = GetEntityCoords(pPed)
        local dist = #(pCoords - firstpos)
        if Exited == false then
            if dist > 30 then
                ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Propriete~s~\nVous êtes trop loin de la Propriete !")
                ExitProperties("myproperties")
                break
            end
        else
            Exited = false
            -- print("Exited")
            break
        end
        Wait(1)
    end
end



function EnterProperties(enterType, info, bucketID)
    RageUI.CloseAll()
    CurrentProperties = info
    local pPed = PlayerPedId()
    if enterType == "visite" then 
        InVisite = true
        Citizen.CreateThread(function()
            DoScreenFadeOut(800)

            while not IsScreenFadedOut() do
                Wait(0)
            end

            SetEntityCoords(pPed, vector3(info.positions.ENTER.x, info.positions.ENTER.y, info.positions.ENTER.z))
            DoScreenFadeIn(800)
            AntiBucketUseBug(GetEntityCoords(pPed))
            Wait(1000)
        end)
    elseif enterType == "myproperties" then 
        ESX.ShowNotification("~g~Propriete~s~\nVous entrez ...")
        Citizen.CreateThread(function()
            DoScreenFadeOut(800)

            while not IsScreenFadedOut() do
                Wait(0)
            end

            TriggerServerEvent("Properties:SetBucket", "solo")
            TriggerServerEvent("Properties:PlayerEntrerOrExitThisProperties", info, "enter")
            SetEntityCoords(pPed, vector3(info.positions.ENTER.x, info.positions.ENTER.y, info.positions.ENTER.z))
            DoScreenFadeIn(800)
            AntiBucketUseBug(GetEntityCoords(pPed))
            Wait(1000)
        end)
        local succes = AddZones("propertiesExit", {
            Position = vector3(info.positions.ENTER.x, info.positions.ENTER.y, info.positions.ENTER.z),
            Public = true,
            Blip = false,
            Action = function()
                ExitProperties("myproperties")
            end
        })
        local succes2 = AddZones("propertiesCoffre", {
            Position = vector3(info.positions.COFFRE.x, info.positions.COFFRE.y, info.positions.COFFRE.z+1),
            Public = true,
            Blip = false,
            Action = function()
                OpenMenuCoffreProperties(info)
            end
        })
        if not succes and not succes2 then 
            ExitProperties("error")
        end
    elseif enterType == "bysonnet" then 
        ESX.ShowNotification("~g~Propriete~s~\nVous entrez ...")
        Citizen.CreateThread(function()
            DoScreenFadeOut(800)

            while not IsScreenFadedOut() do
                Wait(0)
            end

            TriggerServerEvent("Properties:SetBucket", "group", bucketID)
            TriggerServerEvent("Properties:PlayerEntrerOrExitThisProperties", info, "enter")
            SetEntityCoords(pPed, vector3(info.positions.ENTER.x, info.positions.ENTER.y, info.positions.ENTER.z))
            DoScreenFadeIn(800)
            AntiBucketUseBug(GetEntityCoords(pPed))
            Wait(1000)
        end)
        local succes = AddZones("propertiesExit", {
            Position = vector3(info.positions.ENTER.x, info.positions.ENTER.y, info.positions.ENTER.z),
            Public = true,
            Blip = false,
            Action = function()
                ExitProperties("myproperties")
            end
        })
        local succes2 = AddZones("propertiesCoffre", {
            Position = vector3(info.positions.COFFRE.x, info.positions.COFFRE.y, info.positions.COFFRE.z+1),
            Public = true,
            Blip = false,
            Action = function()
                OpenMenuCoffreProperties(info, true)
            end
        })
        if not succes and not succes2 then 
            ExitProperties("error")
        end
    end
end

function ExitProperties(exitType)
    RageUI.CloseAll()
    Exited = true
    local pPed = PlayerPedId()
    Exited = false
    if exitType == "visite" then 
        InVisite = false
        Citizen.CreateThread(function()
            DoScreenFadeOut(800)

            while not IsScreenFadedOut() do
                Wait(0)
            end

            SetEntityCoords(pPed, vector3(CurrentProperties.positions.EXIT.x, CurrentProperties.positions.EXIT.y, CurrentProperties.positions.EXIT.z))
            DoScreenFadeIn(800)
            Wait(1000)
            CurrentProperties = nil
        end)
    elseif exitType == "myproperties" then 
        ESX.ShowNotification("~g~Propriete~s~\nVous sortez ...")
        CreateThread(function()
            DoScreenFadeOut(800)

            while not IsScreenFadedOut() do
                Wait(0)
            end

            TriggerServerEvent("Properties:SetBucket", "remettre")
            TriggerServerEvent("Properties:PlayerEntrerOrExitThisProperties", CurrentProperties, "exit")
            SetEntityCoords(pPed, vector3(CurrentProperties.positions.EXIT.x, CurrentProperties.positions.EXIT.y, CurrentProperties.positions.EXIT.z))
            DoScreenFadeIn(800)
            Wait(1000)
            CurrentProperties = nil
        end)
        RemoveZone("propertiesExit")
        RemoveZone("propertiesCoffre")
    elseif exitType == "error" then 
        Wait(2000)
        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Propriete~s~\nUne erreur est survenu. Reconnectez-vous.")
        Citizen.CreateThread(function()
            DoScreenFadeOut(800)

            while not IsScreenFadedOut() do
                Wait(0)
            end

            TriggerServerEvent("Properties:SetBucket", "remettre")
            SetEntityCoords(pPed, vector3(CurrentProperties.positions.EXIT.x, CurrentProperties.positions.EXIT.y, CurrentProperties.positions.EXIT.z))
            DoScreenFadeIn(800)
            CurrentProperties = nil
            Wait(1000)
        end)
    end
end

CreateThread(function()
    while true do
        local interval = 1000

        if InVisite then
            interval = 1
            --RageUI.Text({
              --  message = "Vous êtes en pleine visite.\nAppuyez sur ["..exports.Tree:serveurConfig().Serveur.color.."E~s~] pour sortir de la visite",
             --   time_display = 100,
            --})
            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour sortir de la visite")
            if IsControlJustPressed(0, 51) then
                ExitProperties("visite")
            end
        end

        Wait(interval)
    end
end)

RegisterNetEvent("Properties:NotificationSonnedProperties")
AddEventHandler("Properties:NotificationSonnedProperties", function(propertiesId, id)
    local timed = 0
    if Properties[propertiesId] then 
        ESX.ShowNotification("~g~Propriete\n~s~Une personne viens de sonner à votre Propriete.")
        ESX.ShowNotification("~g"..exports.Tree:serveurConfig().Serveur.color.."s~ : Ouvrir\n"..exports.Tree:serveurConfig().Serveur.color.."N~s~ : Décliner")
    
        while true do 
            timed = timed + 1 
            if timed > 2000 then 
                ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Sonnette Propriete~s~\nVous avez mis trop de temps à repondre.")
                TriggerServerEvent("Properties:ReturnPlayerSonnedProperties", "decline", id, Properties[propertiesId], true)
                break
            end
            if IsControlJustPressed(0, 246) then -- Accept "Y"
                TriggerServerEvent("Properties:ReturnPlayerSonnedProperties", "accept", id, Properties[propertiesId])
                break
            end
            if IsControlJustPressed(0, 306) then -- Decline "N"
                TriggerServerEvent("Properties:ReturnPlayerSonnedProperties", "decline", id, Properties[propertiesId])
                break
            end
            Wait(1)
        end
    end
end)

function OpenMenuBuyPropreties(info)
    local label, price = info.label, info.price
    local menu = RageUI.CreateMenu(label, "Que voulez-vous faire ?")

    RageUI.Visible(menu, not RageUI.Visible(menu))

    while menu do
        Wait(0)
        RageUI.IsVisible(menu, function()

            if exports.Tree:getVip().level ~= 0 then
                RageUI.Separator(exports.Tree:serveurConfig().Serveur.color.."Prix :~s~ "..price.."$")
                RageUI.Button('Visitez cette Propriete', nil, { RightLabel = "→" }, true, {
                    onSelected = function()
                        EnterProperties("visite", info)
                    end
                })
                RageUI.Button('Acheter cette Propriete', nil, { RightLabel = "~g~"..price.."$~s~" }, true, {
                    onSelected = function()
                        TriggerServerEvent("Properties:PlayerBuyPropeties", info)
                        RageUI.CloseAll()
                    end
                })
            else
                RageUI.Separator("Propriete réserver au "..exports.Tree:serveurConfig().Serveur.color.."VIP")
                RageUI.Button('Visitez cette Propriete', nil, { RightLabel = "→" }, false, {
                })
                RageUI.Button('Acheter cette Propriete', nil, { RightLabel = "→" }, false, {
                })
            end


            if ESX.PlayerData.job.name == "realestateagent" then 
                RageUI.Button(exports.Tree:serveurConfig().Serveur.color..'Supprimer la Propriete', nil, { RightLabel = "→" }, true, {
                    onSelected = function()
                        TriggerServerEvent("DeleteProperties", info)
                        RageUI.CloseAll()
                    end
                })
            end

        end, function()
        end)

        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType('menu', true)
        end
    end
end






local hasSonned = {}

function OpenMenuSonnerProperties(info)
    local label = info.label
    local menu = RageUI.CreateMenu(label, "Tu es chez quelqu'un !")
    
    RageUI.Visible(menu, not RageUI.Visible(menu))

    while menu do
        Wait(0)
        RageUI.IsVisible(menu, function()

            RageUI.Separator("Il semble que cette Propriete")
            RageUI.Separator("appartient déjà à quelqu'un.")
            RageUI.Button("Sonner à la porte", nil, { RightLabel = "→" }, not hasSonned[info.name], {
                onSelected = function()
                    TriggerServerEvent("Properties:PlayerSonnedToPropreties", info)
                    hasSonned[info.name] = true
                    Citizen.SetTimeout(60000, function()
                        hasSonned[info.name] = false
                    end)
                end
            })

        end, function()
        end)

        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType('menu', true)
        end
    end
end