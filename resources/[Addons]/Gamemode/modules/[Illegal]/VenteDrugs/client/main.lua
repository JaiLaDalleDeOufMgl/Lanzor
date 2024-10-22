NearestePed = nil
local DejaVenduPed = {}

DispoVente = false
DrugWlZone = {
    {coords = vector3(1670.459, 4839.072, 42.04803), radius = 1500.0},
    {coords = vector3(-137.4919, 6322.864, 31.63341), radius = 1500.0},
    {coords = vector3(295.0718, 163.9047, 104.176), radius = 1500.0},
    {coords = vector3(2902.695, 4374.5, 50.38405), radius = 1500.0},
    {coords = vector3(-1376.391,-1309.226,4.406867) , radius = 1500.0},
    {coords = vector3 (855.2402,-2238.469, 30.26431) , radius = 1500.0},
}

CreateThread(function()
    while true do 
        if DispoVente then
            DrawMissionText("~y~Vous êtes a la recherche de client...", 2000)
        else
            break
        end
        Wait(1500)
    end
end)

CreateThread(function()
    while ESX == nil do
        print('HERE')
        Wait(100)
    end
    while true do
        local zone = GetZoneDevant()
        local ped = ESX.Game.GetClosestPed(zone, {})
        local model = GetEntityModel(ped)
        if ped ~= PlayerPedId() and not IsPedAPlayer(ped) and not IsPedInAnyVehicle(ped, 1) and not IsPedDeadOrDying(ped, 1) then
            if model ~= GetHashKey("s_f_y_cop_01") and model ~= GetHashKey("S_M_Y_Casino_01") and model ~= GetHashKey("s_m_m_autoshop_02") and model ~= GetHashKey("S_F_Y_Casino_01") and model ~= GetHashKey("a_f_y_femaleagent") and model ~= GetHashKey("s_m_m_dockwork_01")and model ~= GetHashKey("s_m_y_dockwork_01") and model ~= GetHashKey("s_m_y_dealer_01") and model ~= GetHashKey("s_m_y_robber_01") and model ~= GetHashKey("mp_f_boatstaff_01") and model ~= GetHashKey("s_m_y_construct_01") and model ~= GetHashKey("s_m_m_gardener_01") and model ~= GetHashKey("a_f_y_business_02") and model ~= GetHashKey("s_m_y_cop_01") and model ~= GetHashKey("s_m_m_security_01") and model ~= GetHashKey("a_c_boar") and model ~= GetHashKey("a_c_deer") and model ~= GetHashKey("a_c_dolphin") and model ~= GetHashKey("a_c_fish") and model ~= GetHashKey("a_c_hen") and model ~= GetHashKey("a_c_humpback") and model ~= GetHashKey("a_c_husky") and model ~= GetHashKey("a_c_killerwhale") and model ~= GetHashKey("a_c_mtlion") and model ~= GetHashKey("a_c_pig") and model ~= GetHashKey("a_c_poodle") and model ~= GetHashKey("a_c_pug") and model ~= GetHashKey("a_c_rabbit_01") and model ~= GetHashKey("a_c_rat") and model ~= GetHashKey("a_c_retriever") and model ~= GetHashKey("a_c_rhesus") and model ~= GetHashKey("a_c_rottweiler") and model ~= GetHashKey("a_c_seagull") and model ~= GetHashKey("a_c_sharkhammer") and model ~= GetHashKey("a_c_sharktiger") and model ~= GetHashKey("a_c_shepherd") and model ~= GetHashKey("a_c_stingray") and model ~= GetHashKey("a_c_pigeon") and model ~= GetHashKey("a_c_westy") and model ~= GetHashKey("a_c_cat_01") and model ~= GetHashKey("s_m_m_pilot_02") and model ~= GetHashKey("a_c_chickenhawk") and model ~= GetHashKey("a_c_chimp") and model ~= GetHashKey("a_c_chop") and model ~= GetHashKey("a_c_cormorant") and model ~= GetHashKey("a_c_cow") and model ~= GetHashKey("a_c_coyote") and model ~= GetHashKey("a_c_crow") and model ~= GetHashKey("a_c_rat") and model ~= GetHashKey("mp_m_shopkeep_01") and model ~= GetHashKey("mp_m_weapexp_01") and model ~= GetHashKey("csb_burgerdrug") and model ~= GetHashKey("a_f_m_bevhills_02") and model ~= GetHashKey("s_m_m_doctor_01") and model ~= GetHashKey("a_m_m_eastsa_02") and model ~= GetHashKey("ig_hunter") and model ~= GetHashKey("a_m_y_downtown_01") and model ~= GetHashKey("a_m_m_afriamer_01") and model ~= GetHashKey("a_m_y_vindouche_01") and model ~= GetHashKey("s_m_y_sheriff_01") and model ~= GetHashKey("s_m_m_armoured_01") and model ~= GetHashKey("s_m_m_armoured_02") and model ~= GetHashKey("a_m_y_business_02") and model ~= GetHashKey("a_m_y_vinewood_01") and model ~= GetHashKey("s_m_y_factory_01") and model ~= GetHashKey("g_m_y_salvaboss_01") and model ~= GetHashKey("s_m_m_armoured_01") and model ~= GetHashKey("csb_stripper_01") then -- Blacklist des modèles ici, flème de faire une liste
                for k,v in pairs(DrugWlZone) do
                    local coords = GetEntityCoords(ped, true)
                    local pCoords = GetEntityCoords(PlayerPedId())
                    local wldistance = #(v.coords - pCoords)
                    if wldistance <= v.radius then
                        local distance = ESX.Math.Round(GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), coords, true), 0)
                        if distance <= 10 and not exports.Gamemode:IsInSafeZone() then
                            NearestePed = ped
                        else
                            NearestePed = nil
                        end
                    end
                end
            end
        end
        Wait(2500)
    end
end)

CreateThread(function()
    while true do
        local count = 0
        local attente = 3000
        for k,v in ipairs(DejaVenduPed) do
            local NetPed = NetworkGetEntityFromNetworkId(v)
            if DoesEntityExist(NetPed) then 
                count = count + 1
                attente = 500
            end
        end
        if count == 0 then
            DejaVenduPed = {}
            attente = 500
        end  
        Wait(attente)
    end
end)

CreateThread(function()
    while ESX == nil do
        Wait(100)
    end
    while true do
        local waitdrogue = 1500
        for k,v in ipairs(DejaVenduPed) do
            local NetPed = NetworkGetEntityFromNetworkId(v)
            if NetPed == NearestePed then 
                NearestePed = nil
            end
        end

        if NearestePed ~= nil then
            if DispoVente == true then
                waitdrogue = 1000
                local ped = NearestePed
                local coords = GetEntityCoords(ped, true)
                local distance = ESX.Math.Round(GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), coords, true), 0)
                if distance <= 10.0 then
                    waitdrogue = 1
                    if distance >= 3.0 then
                        DrawMarker(32, coords.x, coords.y, coords.z+1.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 170, 0, 0, 2, 1, nil, nil, 0)
                    else
                        DrawMarker(32, coords.x, coords.y, coords.z+1.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 170, 0, 0, 2, 1, nil, nil, 0)
                        ESX.ShowHelpNotification('Appuie sur ~INPUT_CONTEXT~ pour intéragir')
                        if IsControlJustReleased(1, 51) then
                            local PedNetId = NetworkGetNetworkIdFromEntity(ped)
                            OpenNpcMenu(PedNetId)
                        end
                    end
                else
                    NearestePed = nil
                end
            end
        end
        Wait(waitdrogue)
    end
end)

function GetZoneDevant()
    local backwardPosition = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, 0.0)
	return backwardPosition
end

function VenteWeed(npc)
    local ped = NetworkGetEntityFromNetworkId(npc)
    FreezeEntityPosition(ped, true)
    local random = math.random(1,10)

    --if random <= 8 then
        local heading = GetEntityHeading(ped)
        local coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.14, 0.0)

        
        SetEntityHeading(PlayerPedId(), heading - 180.1)
        SetEntityCoordsNoOffset(PlayerPedId(), coords.x, coords.y, coords.z, 0)
        Wait(300)
        while not HasAnimDictLoaded("mp_common") do
            RequestAnimDict("mp_common")
            Citizen.Wait(1)
        end
        TriggerServerEvent('NPC:VenteDrugs', 'Weed')
        TaskPlayAnim(PlayerPedId(), "mp_common", "givetake1_a", 2.0, 2.0, -1, 0, 0, false, false, false)
        TaskPlayAnim(ped, "mp_common", "givetake1_a", 2.0, 2.0, -1, 0, 0, false, false, false)
        Wait(4500)
        FreezeEntityPosition(ped, false)
    
        local NetId = NetworkGetNetworkIdFromEntity(ped)
        table.insert(DejaVenduPed, NetId)
        NearestePed = nil
    -- else
    --     FreezeEntityPosition(ped, false)
    --     ESX.ShowNotification("Non merci, Sa ne m'interesse pas !")
    --     TaskCombatPed(ped, PlayerPedId(), 0, 16)

    --     local chance = math.random(0, 10)
    --     local coords = GetEntityCoords(PlayerPedId(), true)

    --     local NetId = NetworkGetNetworkIdFromEntity(ped)
    --     table.insert(DejaVenduPed, NetId)
    --     NearestePed = nil

    --     if 7 < chance then
    --         local coords = GetEntityCoords(PlayerPedId(), true)
    --         
    --     end
    -- end
end


function VenteXylazine(npc)
    local ped = NetworkGetEntityFromNetworkId(npc)
    FreezeEntityPosition(ped, true)
    local random = math.random(1,10)

    if random <= 8 then
        local pochonBuy = math.random(1,10)
        local heading = GetEntityHeading(ped)
        local coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.14, 0.0)

        
        SetEntityHeading(PlayerPedId(), heading - 180.1)
        SetEntityCoordsNoOffset(PlayerPedId(), coords.x, coords.y, coords.z, 0)
        Wait(300)
        while not HasAnimDictLoaded("mp_common") do
            RequestAnimDict("mp_common")
            Citizen.Wait(1)
        end
        TriggerServerEvent('NPC:VenteDrugs', 'xylazine')
        TaskPlayAnim(PlayerPedId(), "mp_common", "givetake1_a", 2.0, 2.0, -1, 0, 0, false, false, false)
        TaskPlayAnim(ped, "mp_common", "givetake1_a", 2.0, 2.0, -1, 0, 0, false, false, false)
        Wait(4500)
        FreezeEntityPosition(ped, false)
    
        local NetId = NetworkGetNetworkIdFromEntity(ped)
        table.insert(DejaVenduPed, NetId)
        NearestePed = nil
    else
        FreezeEntityPosition(ped, false)
        ESX.ShowNotification("Je ne touche pas a la drogue, Casse toi d'ici ou j'apelle les flics")
        TaskCombatPed(ped, PlayerPedId(), 0, 16)

        local chance = math.random(0, 10)
        local coords = GetEntityCoords(PlayerPedId(), true)

        local NetId = NetworkGetNetworkIdFromEntity(ped)
        table.insert(DejaVenduPed, NetId)
        NearestePed = nil

        if 7 < chance then
            local coords = GetEntityCoords(PlayerPedId(), true)
            
        end
    end
end

function VenteKetamine(npc)
    local ped = NetworkGetEntityFromNetworkId(npc)
    FreezeEntityPosition(ped, true)
    local random = math.random(1,10)

    if random <= 8 then
        local pochonBuy = math.random(1,10)
        local heading = GetEntityHeading(ped)
        local coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.14, 0.0)

        
        SetEntityHeading(PlayerPedId(), heading - 180.1)
        SetEntityCoordsNoOffset(PlayerPedId(), coords.x, coords.y, coords.z, 0)
        Wait(300)
        while not HasAnimDictLoaded("mp_common") do
            RequestAnimDict("mp_common")
            Citizen.Wait(1)
        end
        TriggerServerEvent('NPC:VenteDrugs', 'Ketamine')
        TaskPlayAnim(PlayerPedId(), "mp_common", "givetake1_a", 2.0, 2.0, -1, 0, 0, false, false, false)
        TaskPlayAnim(ped, "mp_common", "givetake1_a", 2.0, 2.0, -1, 0, 0, false, false, false)
        Wait(4500)
        FreezeEntityPosition(ped, false)
    
        local NetId = NetworkGetNetworkIdFromEntity(ped)
        table.insert(DejaVenduPed, NetId)
        NearestePed = nil
    else
        FreezeEntityPosition(ped, false)
        ESX.ShowNotification("Je ne touche pas a la drogue, Casse toi d'ici ou j'apelle les flics")
        TaskCombatPed(ped, PlayerPedId(), 0, 16)

        local chance = math.random(0, 10)
        local coords = GetEntityCoords(PlayerPedId(), true)

        local NetId = NetworkGetNetworkIdFromEntity(ped)
        table.insert(DejaVenduPed, NetId)
        NearestePed = nil

        if 7 < chance then
            local coords = GetEntityCoords(PlayerPedId(), true)
        end
    end
end

function VenteOpium(npc)
    local ped = NetworkGetEntityFromNetworkId(npc)
    FreezeEntityPosition(ped, true)
    local random = math.random(1,10)

    if random <= 8 then
        local pochonBuy = math.random(1,10)
        local heading = GetEntityHeading(ped)
        local coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.14, 0.0)

        
        SetEntityHeading(PlayerPedId(), heading - 180.1)
        SetEntityCoordsNoOffset(PlayerPedId(), coords.x, coords.y, coords.z, 0)
        Wait(300)
        while not HasAnimDictLoaded("mp_common") do
            RequestAnimDict("mp_common")
            Citizen.Wait(1)
        end
        TriggerServerEvent('NPC:VenteDrugs', 'Opium')
        TaskPlayAnim(PlayerPedId(), "mp_common", "givetake1_a", 2.0, 2.0, -1, 0, 0, false, false, false)
        TaskPlayAnim(ped, "mp_common", "givetake1_a", 2.0, 2.0, -1, 0, 0, false, false, false)
        Wait(4500)
        FreezeEntityPosition(ped, false)
    
        local NetId = NetworkGetNetworkIdFromEntity(ped)
        table.insert(DejaVenduPed, NetId)
        NearestePed = nil
    else
        FreezeEntityPosition(ped, false)
        ESX.ShowNotification("Je ne touche pas a la drogue, Casse toi d'ici ou j'apelle les flics")
        TaskCombatPed(ped, PlayerPedId(), 0, 16)

        local chance = math.random(0, 10)
        local coords = GetEntityCoords(PlayerPedId(), true)

        local NetId = NetworkGetNetworkIdFromEntity(ped)
        table.insert(DejaVenduPed, NetId)
        NearestePed = nil

        if 7 < chance then
            local coords = GetEntityCoords(PlayerPedId(), true)
            
        end
    end
end

function VentePochon(npc)
    local ped = NetworkGetEntityFromNetworkId(npc)
    FreezeEntityPosition(ped, true)
    local random = math.random(1,10)

    if random <= 8 then
        local pochonBuy = math.random(1,10)
        local heading = GetEntityHeading(ped)
        local coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.14, 0.0)

        
        SetEntityHeading(PlayerPedId(), heading - 180.1)
        SetEntityCoordsNoOffset(PlayerPedId(), coords.x, coords.y, coords.z, 0)
        Wait(300)
        while not HasAnimDictLoaded("mp_common") do
            RequestAnimDict("mp_common")
            Citizen.Wait(1)
        end
        TriggerServerEvent('NPC:VenteDrugs', 'Meth')
        TaskPlayAnim(PlayerPedId(), "mp_common", "givetake1_a", 2.0, 2.0, -1, 0, 0, false, false, false)
        TaskPlayAnim(ped, "mp_common", "givetake1_a", 2.0, 2.0, -1, 0, 0, false, false, false)
        Wait(4500)
        FreezeEntityPosition(ped, false)
    
        local NetId = NetworkGetNetworkIdFromEntity(ped)
        table.insert(DejaVenduPed, NetId)
        NearestePed = nil
    else
        FreezeEntityPosition(ped, false)
        ESX.ShowNotification("Je ne touche pas a la drogue, Casse toi d'ici ou j'apelle les flics")
        TaskCombatPed(ped, PlayerPedId(), 0, 16)

        local chance = math.random(0, 10)
        local coords = GetEntityCoords(PlayerPedId(), true)

        local NetId = NetworkGetNetworkIdFromEntity(ped)
        table.insert(DejaVenduPed, NetId)
        NearestePed = nil

        if 7 < chance then
            local coords = GetEntityCoords(PlayerPedId(), true)
            
        end
    end
end

function VenteCoke(npc)
    local ped = NetworkGetEntityFromNetworkId(npc)
    FreezeEntityPosition(ped, true)
    local random = math.random(1,10)

    --if random <= 6 then
        local cokeBuy = math.random(1,15)
        local heading = GetEntityHeading(ped)
        local coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.14, 0.0)

        
        SetEntityHeading(PlayerPedId(), heading - 180.1)
        SetEntityCoordsNoOffset(PlayerPedId(), coords.x, coords.y, coords.z, 0)
        Wait(300)
        while not HasAnimDictLoaded("mp_common") do
            RequestAnimDict("mp_common")
            Citizen.Wait(1)
        end
        TriggerServerEvent('NPC:VenteDrugs', 'Coke')
        TaskPlayAnim(PlayerPedId(), "mp_common", "givetake1_a", 2.0, 2.0, -1, 0, 0, false, false, false)
        TaskPlayAnim(ped, "mp_common", "givetake1_a", 2.0, 2.0, -1, 0, 0, false, false, false)
        Wait(4500)
        FreezeEntityPosition(ped, false)

        local NetId = NetworkGetNetworkIdFromEntity(ped)
        table.insert(DejaVenduPed, NetId)
        NearestePed = nil
    -- else
    --     FreezeEntityPosition(ped, false)
    --     ESX.ShowNotification("Non merci, Sa ne m'interesse pas !")
    --     TaskCombatPed(ped, PlayerPedId(), 0, 16)
        
    --     local chance = math.random(0, 10)
    --     local coords = GetEntityCoords(PlayerPedId(), true)

    --     local NetId = NetworkGetNetworkIdFromEntity(ped)
    --     table.insert(DejaVenduPed, NetId)
    --     NearestePed = nil

    --     if 7 < chance then
    --         local coords = GetEntityCoords(PlayerPedId(), true)
    --         
    --     end
    -- end
end

RegisterNetEvent("NPCVente:AffichageAppel", function(coords)

    ESX.ShowNotification('~g~Y~s~ Accepter "..exports.Tree:serveurConfig().Serveur.color.."X~s~ Refuser')
    ESX.ShowAdvancedNotification("LSPD CENTRAL", "~y~Vente de drogue", "Des citoyens ont vu des gens vendre de la drogue.", "CHAR_CHAT_CALL", 8)

    while true do
        Wait(0)
        if IsControlJustPressed(0, 246) then
            local blip = AddBlipForCoord(coords)
            SetBlipSprite(blip, 51)
            SetBlipScale(blip, 0.85)
            SetBlipColour(blip, 47)
            SetBlipShrink(blip, true)
            local blipZone = AddBlipForCoord(coords)
            SetBlipSprite(blipZone, 161)
            SetBlipScale(blipZone, 3.0)
            SetBlipColour(blipZone, 8)
            SetBlipShrink(blipZone, true)
            Wait(1000)
            Citizen.Wait(60*1000)
            RemoveBlip(blip)
            RemoveBlip(blipZone)
            return
        end

        if IsControlJustPressed(0, 73) then 
            return
        end
    end
end)


function openVenteDrogue(npc)
	local menu = RageUI.CreateMenu("", "Vente de drogue en cours...")

    RageUI.Visible(menu, not RageUI.Visible(menu))

	while menu do
		Citizen.Wait(0)
        RageUI.IsVisible(menu, function()
            RageUI.Button('Vendre de la Weed', nil, {}, true, {onSelected = function()
                if not codesCooldown then
                    codesCooldown = true
                    RageUI.CloseAll()
                    VenteWeed(npc)
                    Citizen.SetTimeout(2000, function() codesCooldown = false end)
                else
                    RageUI.CloseAll()
                    ESX.ShowNotification("Merci de patentier avant de vendre votre "..exports.Tree:serveurConfig().Serveur.color.."Weed~s~ !")
                end
            end});
            RageUI.Button('Vendre de la cocaÎne', nil, {}, true, {onSelected = function()
                if not codesCooldown then
                    codesCooldown = true
                    RageUI.CloseAll()
                    VenteCoke(npc)
                    Citizen.SetTimeout(2000, function() codesCooldown = false end)
                else
                    RageUI.CloseAll()
                    ESX.ShowNotification("Merci de patentier avant de vendre votre "..exports.Tree:serveurConfig().Serveur.color.."CocaÎne~s~ !")
                end
            end});
            RageUI.Button('Vendre de la méthamphétamine', nil, {}, true, {onSelected = function()
                if not codesCooldown then
                    codesCooldown = true
                    RageUI.CloseAll()
                    VentePochon(npc)
                    Citizen.SetTimeout(2000, function() codesCooldown = false end)
                else
                    ESX.ShowNotification("Merci de patentier avant de vendre votre "..exports.Tree:serveurConfig().Serveur.color.."Méthamphétamine~s~ !")
                end
            end});
            RageUI.Button('Vendre de l\'opium', nil, {}, true, {onSelected = function()
                if not codesCooldown then
                    codesCooldown = true
                    RageUI.CloseAll()
                    VenteOpium(npc)
                    Citizen.SetTimeout(2000, function() codesCooldown = false end)
                else
                    RageUI.CloseAll()
                    ESX.ShowNotification("Merci de patentier avant de vendre votre "..exports.Tree:serveurConfig().Serveur.color.."Opium~s~ !")
                end
            end});
            RageUI.Button('Vendre de la Ketamine', nil, {}, true, {onSelected = function()
                if not codesCooldown then
                    codesCooldown = true
                    RageUI.CloseAll()
                    VenteKetamine(npc)
                    Citizen.SetTimeout(2000, function() codesCooldown = false end)
                else
                    RageUI.CloseAll()
                    ESX.ShowNotification("Merci de patentier avant de vendre votre "..exports.Tree:serveurConfig().Serveur.color.."Ketamine~s~ !")
                end
            end});
            RageUI.Button('Vendre de la Xylazine', nil, {}, true, {onSelected = function()
                if not codesCooldown then
                    codesCooldown = true
                    RageUI.CloseAll()
                    VenteXylazine(npc)
                    Citizen.SetTimeout(2000, function() codesCooldown = false end)
                else
                    RageUI.CloseAll()
                    ESX.ShowNotification("Merci de patentier avant de vendre votre "..exports.Tree:serveurConfig().Serveur.color.."Xylazine~s~ !")
                end
            end});
        end)

        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType('menu', true)
        end
    end
end

local TargetNpc = nil
local count = 0

function OpenNpcMenu(npc)
    openVenteDrogue(npc)
    Wait(100)
    PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", 1)
    local ped = NetworkGetEntityFromNetworkId(npc)
    TaskTurnPedToFaceEntity(ped, PlayerPedId(), 5000)
    TargetNpc = npc
end

function DrawMissionText(msg, time)
	ClearPrints()
	BeginTextCommandprint('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandprint(time, 1)
end

RegisterCommand('ventedrogue', function(sourec, args, rawCommand)
    for k,v in pairs(DrugWlZone) do
       local dist = #(v.coords - GetEntityCoords(PlayerPedId()))
        print(dist)
        if dist <= v.radius then
            droguezeubi = not droguezeubi

            if droguezeubi then
        
                DispoVente = true
        
                ESX.ShowNotification("Vous avez activé la vente de drogue")
        
            else
        
                DispoVente = false
        
                ESX.ShowNotification("Vous avez désactivé la vente de drogue")
                
            end
            return
        else
            if k == #DrugWlZone then
                if DispoVente == true then
                    DispoVente = false
                    ESX.ShowNotification("Vous avez désactivé la vente de drogue")
                else
    
                    ESX.ShowNotification("Vous n'êtes pas dans la zone de vente de drogue")
                end
            end
            
        end
    end
    
end)