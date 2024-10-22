local BLIPS = {}
local BLIPS_ZONE = {}
local PLAYER_CREW = nil
local is_in_menu = false

local PlayerData = {}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

-- General Blips and NPC 
local function CreateZonesOnMap()
    for line, zone in pairs(CONFIG.TERRITOIRES) do
        BLIPS_ZONE[line] = AddBlipForRadius(zone.POS, zone.RADIUS)

        SetBlipHighDetail(BLIPS_ZONE[line], true)
        SetBlipHighDetail(BLIPS_ZONE[line], true)
        SetBlipColour(BLIPS_ZONE[line], 1)
        SetBlipAlpha (BLIPS_ZONE[line], 128)
    end
    ESX.ShowNotification("~g~Les territoires de ventes sont désormais affichés sur votre carte !")
end

local function RemoveZonesOnMap()
    for line, zone in pairs(BLIPS_ZONE) do
        RemoveBlip(zone)
        BLIPS_ZONE[line] = nil
    end
    ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Vous avez enlever les territoires de ventes de votre carte.")
end

local function CreateSellingBlip(zone, pos)
    if BLIPS[zone] then
        RemoveBlip(BLIPS[zone])
        BLIPS[zone] = nil
    end
    if not DoesBlipExist(BLIPS[zone]) then
        BLIPS[zone] = AddBlipForCoord(pos)
        SetBlipSprite(BLIPS[zone], 409)
        SetBlipDisplay(BLIPS[zone], 4)
        SetBlipScale(BLIPS[zone], 0.7)
        SetBlipColour(BLIPS[zone], 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Vente de drogue")
        EndTextCommandSetBlipName(BLIPS[zone])
    end
end

local function RequestModels(modelHash)
	if not HasModelLoaded(modelHash) and IsModelInCdimage(modelHash) then
		RequestModel(modelHash)

        while not HasModelLoaded(modelHash) do
			Citizen.Wait(1)
		end
	end
end

function OpenBuyWeaponsMenu(zone, weapnpc_coords, player_coords)
    CreateThread(function()
        local weaponsMenu = RageUI.CreateMenu("", "Choisir")

        RageUI.Visible(weaponsMenu, not RageUI.Visible(weaponsMenu))
        is_in_menu = true
    
        while weaponsMenu do
            RageUI.IsVisible(weaponsMenu, function()
                RageUI.Separator("↓ "..exports.Tree:serveurConfig().Serveur.color.."Armes ~s~↓")
                for line, weap in pairs(CONFIG.TERRITOIRES[zone].ARMES) do
                    if weap.type == "weapon" then
                        RageUI.Button(weap.label, "Appuyez sur ~y~entrer~s~ pour acheter cette arme", {RightLabel = "~g~$"..weap.price.."~s~".."~s~ | "..exports.Tree:serveurConfig().Serveur.color..""..weap.points_retirer.." points"}, true, {
                            onSelected = function()
                                TriggerServerEvent('Piwel_Territoires:BuyArme', zone, PLAYER_CREW, weap)
                                is_in_menu = false
                                weaponsMenu = RMenu:DeleteType('weaponsMenu', true)
                                RageUI.CloseAll()
                            end,
                        }, weaponsMenu)
                    end
                end
                RageUI.Separator("↓ ~o~Objets ~s~↓")
                for line, weap in pairs(CONFIG.TERRITOIRES[zone].ARMES) do
                    if weap.type == "item" then
                        RageUI.Button(weap.label, "Appuyez sur ~y~entrer~s~ pour acheter cette objet", {RightLabel = "~g~$"..weap.price.."~s~".."~s~ | "..exports.Tree:serveurConfig().Serveur.color..""..weap.points_retirer.." points"}, true, {
                            onSelected = function()
                                TriggerServerEvent('Piwel_Territoires:BuyArme', zone, PLAYER_CREW, weap)
                                is_in_menu = false
                                weaponsMenu = RMenu:DeleteType('weaponsMenu', true)
                                RageUI.CloseAll()
                            end,
                        }, weaponsMenu)
                    end
                end
            end)
    
            if #(weapnpc_coords - GetEntityCoords(PlayerPedId())) > 2.0 then
                weaponsMenu = RMenu:DeleteType('weaponsMenu', true)
                RageUI.CloseAll()
                is_in_menu = false
            end
    
            if not RageUI.Visible(weaponsMenu) then
                weaponsMenu = RMenu:DeleteType('weaponsMenu', true)
                RageUI.CloseAll()
                is_in_menu = false
            end
            Citizen.Wait(0)
        end
    end)
end

local NPCs = {}
local function CreatePedPos(zone)
    local lastNPC = false
    if NPCs[zone] then
        DeletePed(NPCs[zone])
        NPCs[zone] = nil
        lastNPC = true
    end
    RequestModels(GetHashKey(CONFIG.TERRITOIRES[zone].SELLER_NPC.MODEL))

    local POS = CONFIG.TERRITOIRES[zone].SELL_POS[math.random(1, #CONFIG.TERRITOIRES[zone].SELL_POS)]

    local NPC = CreatePed(4, GetHashKey(CONFIG.TERRITOIRES[zone].SELLER_NPC.MODEL), POS, false, false)
    SetEntityCoords(NPC, GetEntityCoords(NPC).x, GetEntityCoords(NPC).y, GetEntityCoords(NPC).z-2.0, true, true, true, false)
    NPCs[zone] = NPC

    SetPedDefaultComponentVariation(NPCs[zone])
    if CONFIG.TERRITOIRES[zone].SELLER_NPC.Dict then
        ChargeAnimDict(CONFIG.TERRITOIRES[zone].SELLER_NPC.Dict)
        TaskPlayAnim(NPCs[zone], CONFIG.TERRITOIRES[zone].SELLER_NPC.Dict, CONFIG.TERRITOIRES[zone].SELLER_NPC.Anim, 1.0, -1.0, -1, 1, 1, true, true, true)
    elseif CONFIG.TERRITOIRES[zone].SELLER_NPC.Scena then
        TaskStartScenarioInPlace(NPCs[zone], CONFIG.TERRITOIRES[zone].SELLER_NPC.Scena, 0, false)
    end

    SetEntityInvincible(NPCs[zone], true)
    SetBlockingOfNonTemporaryEvents(NPCs[zone], true)
    FreezeEntityPosition(NPCs[zone], true)
    SetModelAsNoLongerNeeded(GetHashKey(CONFIG.TERRITOIRES[zone].SELLER_NPC.MODEL))

    if lastNPC then
        CreateSellingBlip(zone, POS)
    end
    CONFIG.TERRITOIRES[zone].CURRENT_SELLER_POS = POS
    return POS
end

local WEAPONS_NPCs = {}
local function CreateWeaponsNPC(zone)
    RequestModels(GetHashKey(CONFIG.TERRITOIRES[zone].WEAPONS_NPC.MODEL))

    local NPC = CreatePed(4, GetHashKey(CONFIG.TERRITOIRES[zone].WEAPONS_NPC.MODEL), CONFIG.TERRITOIRES[zone].WEAPONS_NPC_POS, false, false)
    SetEntityCoords(NPC, GetEntityCoords(NPC).x, GetEntityCoords(NPC).y, GetEntityCoords(NPC).z-2.0, true, true, true, false)
    WEAPONS_NPCs[zone] = NPC

    SetPedDefaultComponentVariation(WEAPONS_NPCs[zone])
    SetEntityInvincible(WEAPONS_NPCs[zone], true)
    SetBlockingOfNonTemporaryEvents(WEAPONS_NPCs[zone], true)
    FreezeEntityPosition(WEAPONS_NPCs[zone], true)
    SetModelAsNoLongerNeeded(GetHashKey(CONFIG.TERRITOIRES[zone].WEAPONS_NPC.MODEL))
end

local function RemoveNPCs(onlyWeapon)
    if not onlyWeapon then
        for line, npc in pairs(NPCs) do
            DeletePed(NPCs[line])
            NPCs[line] = nil
        end
    end
    if next(WEAPONS_NPCs) ~= nil then
        for line, npc in pairs(WEAPONS_NPCs) do
            DeletePed(WEAPONS_NPCs[line])
            WEAPONS_NPCs[line] = nil
        end
    end
end

local function ShowHelpNotification(msg, thisFrame, beep, duration)
	AddTextEntry('esxHelpNotification', msg)

	if thisFrame then
		DisplayHelpTextThisFrame('esxHelpNotification', false)
	else
		if beep == nil then beep = true end
		BeginTextCommandDisplayHelp('esxHelpNotification')
		EndTextCommandDisplayHelp(0, false, beep, duration or -1)
	end
end

--

local BLIP_CREATED = false
local IS_SELLING = false
local CURRENT_ZONE_IN = nil
local CURRENT_ZONE_INFOS = nil
local function PositionAction()
    while true do
        local sleepThread = 1000
        local playerPed = PlayerPedId()
        local player_coords = GetEntityCoords(playerPed)

        if not CURRENT_ZONE_IN and not CURRENT_ZONE_INFOS then
            for line, zone_in in pairs(CONFIG.TERRITOIRES) do
                if type(player_coords) == 'vector3' and type(zone_in.POS) == 'vector3' then
                    if #(player_coords - zone_in.POS) <= zone_in.RADIUS then
                        CURRENT_ZONE_IN, CURRENT_ZONE_INFOS = line, zone_in
                    end
                end
            end
        end

        if CURRENT_ZONE_IN and CURRENT_ZONE_INFOS then
            if not BLIP_CREATED and CURRENT_ZONE_IN then
                local BLIP_POS = CreatePedPos(CURRENT_ZONE_IN)
                if ESX.PlayerData.name ~= 'police' and ESX.PlayerData.name ~= 'spdr' then
                    CreateSellingBlip(CURRENT_ZONE_IN, BLIP_POS)
                end
                BLIP_CREATED = true
                if PLAYER_CREW ~= nil then
                    ESX.TriggerServerCallback('Piwel_Territoires:IsZoneOwner', function(cb)
                        if cb then
                            CreateWeaponsNPC(CURRENT_ZONE_IN)
                        end
                    end, CURRENT_ZONE_IN)
                end
            end
            if #(player_coords - vector3(CURRENT_ZONE_INFOS.CURRENT_SELLER_POS.x, CURRENT_ZONE_INFOS.CURRENT_SELLER_POS.y, CURRENT_ZONE_INFOS.CURRENT_SELLER_POS.z)) <= 2.0 and not IS_SELLING then
                sleepThread = 3
                ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour commencer à ~b~vendre de la drogue~s~")
                if IsControlJustPressed(0, 38) then
                    IS_SELLING = true
                    TriggerEvent('zModules:AddProgressBar', "Vente de drogue en cours", 90, 150, 90, 200, CURRENT_ZONE_INFOS.SELL_TIME)
                    Wait(CURRENT_ZONE_INFOS.SELL_TIME)
                    TriggerServerEvent('Piwel_Territoires:Sell', CURRENT_ZONE_IN, PLAYER_CREW)
                    --TriggerServerEvent('Piwel_Territoires:Sell', CURRENT_ZONE_IN, PLAYER_CREW)
                    TriggerEvent('zModules:DeleteProgressBar')
                end
            end
            if next(WEAPONS_NPCs) ~= nil then
                local weapnpc_coords = GetEntityCoords(WEAPONS_NPCs[CURRENT_ZONE_IN])
                if #(player_coords - weapnpc_coords) <= 1.5 and not is_in_menu then
                    sleepThread = 3
                    ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour acheter des ~b~armes~s~")
                    if IsControlJustPressed(0, 51) then
                        OpenBuyWeaponsMenu(CURRENT_ZONE_IN, weapnpc_coords, player_coords)
                    end
                end
            end
            if #(player_coords - CURRENT_ZONE_INFOS.POS) > CURRENT_ZONE_INFOS.RADIUS then
                RemoveNPCs(false)
                if ESX.PlayerData.name ~= 'police' and ESX.PlayerData.name ~= 'spdr' then
                    RemoveBlip(BLIPS[CURRENT_ZONE_IN])
                end
                CONFIG.TERRITOIRES[CURRENT_ZONE_IN].CURRENT_SELLER_POS = nil
                CURRENT_ZONE_IN = nil
                CURRENT_ZONE_INFOS = nil
                Wait(500)
                BLIP_CREATED = false
            end
        end

        Wait(sleepThread)
    end
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    -- ESX.TriggerServerCallback('InfosCrew', function(crew)
    --     if crew and crew[1] then
    --         PLAYER_CREW = crew[1].id_crew
    --     end
    -- end)
    ESX.PlayerData = xPlayer
    if ESX.PlayerData.job2.name ~= "unemployed" and ESX.PlayerData.job2.name ~= "unemployed2" then 
        PLAYER_CREW = ESX.PlayerData.job2.name
    end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	ESX.PlayerData.job2 = job2
    if ESX.PlayerData.job2.name ~= "unemployed" and ESX.PlayerData.job2.name ~= "unemployed2" then 
        PLAYER_CREW = ESX.PlayerData.job2.name
    end
end)

RegisterNetEvent('Piwel_Territoires:UpdateZoneOwned')
AddEventHandler('Piwel_Territoires:UpdateZoneOwned', function(zone, bool)
    if zone == CURRENT_ZONE_IN then
        if bool then
            CreateWeaponsNPC(CURRENT_ZONE_IN)
        else
            RageUI.CloseAll()
            RemoveNPCs(true)
        end
    end
end)

RegisterNetEvent('Piwel_Territoires:SoldUpdatePos')
AddEventHandler('Piwel_Territoires:SoldUpdatePos', function(zone)
    CreatePedPos(zone)
end)

zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }
RegisterNetEvent('Piwel_Territoires:SendAnimations')
AddEventHandler('Piwel_Territoires:SendAnimations', function(bool, zone)
    if bool then
        if DoesEntityExist(NPCs[zone]) then
            RequestAnimDict("mp_common")            
            while not HasAnimDictLoaded("mp_common") do                
                Citizen.Wait(0)            
            end
            
            --local cCreate = CreateObject(GetHashKey('p_meth_bag_01_s'), 0, 0, 0, true)
            --AttachEntityToEntity(cCreate, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)
            TaskPlayAnim(PlayerPedId(), "mp_common", "givetake2_a", 8.0, 4.0, -1, 48, 0, 0, 0, 0)
            --local oCreate = CreateObject(GetHashKey('hei_prop_heist_cash_pile'), 0, 0, 0, true)
            --AttachEntityToEntity(oCreate, NPCs[zone], GetPedBoneIndex(NPCs[zone], 57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)
            TaskPlayAnim(NPCs[zone], "mp_common", "givetake2_a", 8.0, 4.0, -1, 48, 0, 0, 0, 0)
            Citizen.Wait(1500)
            ClearPedTasks(PlayerPedId())
            DeleteObject(cCreate)
            ClearPedTasks(NPCs[zone])
            DeleteObject(oCreate)
            Wait(1000)
            local locationName = zones[GetNameOfZone(GetEntityCoords(PlayerPedId()))]
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                local sex = nil
                if skin.sex == 0 then
                    sex = "par un homme"
                else
                    sex = "par une femme"
                end
                local poukie = math.random(1,3)
                if poukie == 2 then
                    TriggerServerEvent("DealDeDrogueEnCours", GetEntityCoords(PlayerPedId()), sex, locationName)
                end
                Wait(1500)
            end)
        end
    end

    CreatePedPos(zone) -- Update de la position après vente
    IS_SELLING = false
end)


RegisterNetEvent('Piwel_Territoires:ShowTerritoires')
AddEventHandler('Piwel_Territoires:ShowTerritoires', function(bool)
    if bool then
        CreateZonesOnMap()
    else
        RemoveZonesOnMap()
    end
end)

Citizen.CreateThread(function()
    while not ESX.IsPlayerLoaded() do
        Wait(500)
    end
    Wait(5000)
    PositionAction()
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(100)
        end
        -- ESX.TriggerServerCallback('InfosCrew', function(crew)
        --     if crew and crew[1] then
        --         PLAYER_CREW = crew[1].id_crew
        --     end
        -- end)
        ESX.PlayerData = ESX.GetPlayerData()
        if ESX.PlayerData.job2.name ~= "unemployed" and ESX.PlayerData.job2.name ~= "unemployed2" then 
            PLAYER_CREW = ESX.PlayerData.job2.name
        end
	end
end)

-- MENU F7
local CrewOptions = {
    InfosCrew = {},
    InfosTerritoires = {},
    InfosStatsPanel = {},
    ServerCrews = {},
    ShowTerritoires = false
}