---@diagnostic disable: trailing-space
local loopType = nil


---@param shadow boolean
---@param air boolean
local function setShadowAndAir(shadow, air)
    RopeDrawShadowEnabled(shadow)
    CascadeShadowsClearShadowSampleType()
    CascadeShadowsSetAircraftMode(air)
end

---@param entity boolean
---@param dynamic boolean
---@param tracker number
---@param depth number
---@param bounds number
local function setEntityTracker(entity, dynamic, tracker, depth, bounds)
    CascadeShadowsEnableEntityTracker(entity)
    CascadeShadowsSetDynamicDepthMode(dynamic)
    CascadeShadowsSetEntityTrackerScale(tracker)
    CascadeShadowsSetDynamicDepthValue(depth)
    CascadeShadowsSetCascadeBoundsScale(bounds)
end

---@param distance number
---@param tweak number
local function setLights(distance, tweak)
    SetFlashLightFadeDistance(distance)
    SetLightsCutoffDistanceTweak(tweak)
end


---@param type string
local function umfpsBooster(type)
    if type == 1 then
        setShadowAndAir(true, true)
        setEntityTracker(true, true, 5.0, 5.0, 5.0)
        setLights(10.0, 10.0)
    elseif type == 2 then
        setShadowAndAir(false, false)
        setEntityTracker(true, false, 0.0, 0.0, 0.0)
        setLights(0.0, 0.0)
    elseif type == 3 then
        setShadowAndAir(false, false)
        setEntityTracker(true, false, 0.0, 0.0, 0.0)
        setLights(5.0, 5.0)
    elseif type == 4 then
        setShadowAndAir(true, false)
        setEntityTracker(true, false, 5.0, 3.0, 3.0)
        setLights(3.0, 3.0)
    end
    loopType = type
end

CreateThread(function()
    while true do
        if loopType == 2 then
            for _, ped in ipairs(GetGamePool('CPed')) do
                if not IsEntityOnScreen(ped) then
                    SetEntityAlpha(ped, 0)
                else
                    if GetEntityAlpha(ped) == 0 then
                        SetEntityAlpha(ped, 255)
                    elseif GetEntityAlpha(ped) ~= 210 then
                        SetEntityAlpha(ped, 210)
                    end
                end
                SetPedAoBlobRendering(ped, false)
                Wait(1)
            end
            for _, obj in ipairs(GetGamePool('CObject')) do
                if not IsEntityOnScreen(obj) then
                    SetEntityAlpha(obj, 0)
                    SetEntityAsNoLongerNeeded(obj)
                else
                    if GetEntityAlpha(obj) == 0 then
                        SetEntityAlpha(obj, 255)
                    elseif GetEntityAlpha(obj) ~= 170 then
                        SetEntityAlpha(obj, 170)
                    end
                end
                Wait(1)
            end
            DisableOcclusionThisFrame()
            SetDisableDecalRenderingThisFrame()
            RemoveParticleFxInRange(GetEntityCoords(PlayerPedId()), 10.0)
        elseif loopType == 3 then
            for _, ped in ipairs(GetGamePool('CPed')) do
                if not IsEntityOnScreen(ped) then
                    SetEntityAlpha(ped, 0)
                else
                    if GetEntityAlpha(ped) == 0 then
                        SetEntityAlpha(ped, 255)
                    elseif GetEntityAlpha(ped) ~= 210 then
                        SetEntityAlpha(ped, 210)
                    end
                end
                SetPedAoBlobRendering(ped, false)
                Wait(1)
            end
            for _, obj in ipairs(GetGamePool('CObject')) do
                if not IsEntityOnScreen(obj) then
                    SetEntityAlpha(obj, 0)
                    SetEntityAsNoLongerNeeded(obj)
                else
                    if GetEntityAlpha(obj) == 0 then
                        SetEntityAlpha(obj, 255)
                    elseif GetEntityAlpha(ped) ~= 210 then
                        SetEntityAlpha(ped, 210)
                    end
                end
                Wait(1)
            end
            SetDisableDecalRenderingThisFrame()
            RemoveParticleFxInRange(GetEntityCoords(PlayerPedId()), 10.0)
        elseif loopType == 4 then
            for _, ped in ipairs(GetGamePool('CPed')) do
                if not IsEntityOnScreen(ped) then
                    SetEntityAlpha(ped, 0)
                else
                    if GetEntityAlpha(ped) == 0 then
                        SetEntityAlpha(ped, 255)
                    end
                end
                SetPedAoBlobRendering(ped, false)
                Wait(1)
            end
            for _, obj in ipairs(GetGamePool('CObject')) do
                if not IsEntityOnScreen(obj) then
                    SetEntityAlpha(obj, 0)
                    SetEntityAsNoLongerNeeded(obj)
                else
                    if GetEntityAlpha(obj) == 0 then
                        SetEntityAlpha(obj, 255)
                    end
                end
                Wait(1)
            end
        else
            Wait(500)
        end
        Wait(8)
    end
end)

CreateThread(function()
    while true do
        if loopType == 2 or loopType == 3 then
            local ped = PlayerPedId()
            ClearAllBrokenGlass()
            ClearAllHelpMessages()
            LeaderboardsReadClearAll()
            ClearBrief()
            ClearGpsFlags()
            ClearPrints()
            ClearSmallPrints()
            ClearReplayStats()
            LeaderboardsClearCacheData()
            ClearFocus()
            ClearPedBloodDamage(ped)
            ClearPedWetness(ped)
            ClearPedEnvDirt(ped)
            ResetPedVisibleDamage(ped)
            ClearExtraTimecycleModifier()
            ClearTimecycleModifier()
            ClearOverrideWeather()
            ClearHdArea()
            DisableVehicleDistantlights(false)
            DisableScreenblurFade()
            SetRainLevel(0.0)
            SetWindSpeed(0.0)
            Wait(300)
        elseif loopType == 3 then
            ClearAllBrokenGlass()
            ClearAllHelpMessages()
            LeaderboardsReadClearAll()
            ClearBrief()
            ClearGpsFlags()
            ClearPrints()
            ClearSmallPrints()
            ClearReplayStats()
            LeaderboardsClearCacheData()
            ClearFocus()
            ClearHdArea()
            SetWindSpeed(0.0)
            Wait(1000)
        else
            Wait(1500)
        end
    end
end)


function KeyboardInputAnnoncePerso(TextEntry, ExampleText, MaxStringLength)

	AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end

Player = {
	isDead = false,
	inAnim = false,
	ragdoll = false,
	crouched = false,
	handsup = false,
	pointing = false,
    FPS = false ,
	minimap = true,
	ui = true,
	noclip = false,
	godmode = false,
	ghostmode = false,
	showCoords = false,
	showName = false,
	gamerTags = {}
}

local cinemamode = false
local drift_mode = false
local drift_speed_limit = 1570.0

loadAnimDict = function(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(0)
    end
end

object = {}
local inventaire = false
local status = true
local canChange = true

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

local PersonalMenu = {
    billing = {},
    engineActionList = {
        "Allumer",
        "Éteindre",
    },
    maxSpeedList = {
        "50",
        "80",
        "120",
        "130",
        "Retirer",
    },
    maxSpeedListIndex = 1,
    engineActionIndex = 1,
    FpsActionIndex = 1,
    FpsList ={
        'reset',
        'Ultra Low',
        "Low",
        "Medium"
    }
}

local ItemSelected = {}
local engineCoolDown = false
local bank = nil
local sale = nil
local extraList = {"n°1","n°2","n°3","n°4","n°5","n°6","n°7","n°8","n°9","n°10","n°11","n°12","n°13","n°14","n°15"}
local extraIndex = 1
local extraCooldown = false
local extraStateIndex = 1
local doorActionIndex = 1

function GetCurrentWeight()
	local currentWeight = 0

	for i = 1, #ESX.PlayerData.inventory, 1 do
		if ESX.PlayerData.inventory[i].count > 0 then
			currentWeight = currentWeight + (ESX.PlayerData.inventory[i].weight * ESX.PlayerData.inventory[i].count)
		end
	end

	return currentWeight
end

function getvehicleskey()
    getplayerkeys = {}
    ESX.TriggerServerCallback('esx_vehiclelock:allkey', function(mykey)
        for i = 1, #mykey, 1 do
			if mykey[i].NB == 1 then
				table.insert(getplayerkeys, {label = 'Clés : '.. ' [' .. mykey[i].plate .. ']', value = mykey[i].plate})
			elseif mykey[i].NB == 2 then
				table.insert(getplayerkeys, {label = '[DOUBLE] Véhicule : '.. ' [' .. mykey[i].plate .. ']', value = nil})
			end
		end
    end)
end

function OpenRzInteract()
    if PersonalMenu.Menu then 
        PersonalMenu.Menu = false 
        RageUIv1.Visible(RMenuv1:Get('personalmenu', 'main'), false)
        return
    else
        RMenuv1.Add('personalmenu', 'main', RageUIv1.CreateMenu("", "Crosshair"))
        RMenuv1.Add('personalmenu', 'inventory', RageUIv1.CreateSubMenu(RMenuv1:Get("personalmenu", "main"),"", "Menu d'intéraction"))
        RMenuv1.Add('personalmenu', 'wallet', RageUIv1.CreateSubMenu(RMenuv1:Get("personalmenu", "main"),"", "Menu d'intéraction"))

        RMenuv1.Add('personalmenu', 'gestion', RageUIv1.CreateSubMenu(RMenuv1:Get("personalmenu", "inventory"),"", "Menu d'intéraction"))
        
        RMenuv1.Add('personalmenu', 'gestionveh', RageUIv1.CreateSubMenu(RMenuv1:Get("personalmenu", "main"),"", "Menu d'intéraction"))

        RMenuv1.Add('personalmenu', 'clothes', RageUIv1.CreateSubMenu(RMenuv1:Get("personalmenu", "main"),"", "Menu d'intéraction"))
        

        RMenuv1.Add('personalmenu', 'boss', RageUIv1.CreateSubMenu(RMenuv1:Get('personalmenu', 'inventory'),"", "Menu d'intéraction"))

        RMenuv1.Add('personalmenu', 'billing', RageUIv1.CreateSubMenu(RMenuv1:Get("personalmenu", "inventory"),"", "Menu d'intéraction"))

        RMenuv1.Add('personalmenu', 'autres', RageUIv1.CreateSubMenu(RMenuv1:Get("personalmenu", "main"),"", "Menu d'intéraction"))
        RMenuv1.Add('personalmenu', 'visual', RageUIv1.CreateSubMenu(RMenuv1:Get("personalmenu", "main"),"", "Menu d'intéraction"))
        RMenuv1.Add('personalmenu', 'idproche', RageUIv1.CreateSubMenu(RMenuv1:Get("personalmenu", "main"),"", "Menu d'intéraction"))
        RMenuv1.Add('personalmenu', 'crosshairx', RageUIv1.CreateSubMenu(RMenuv1:Get("personalmenu", "main", "", "Menu Crosshair")))
        RMenuv1:Get('personalmenu', 'main'):SetSubtitle("Menu d'intéraction")
        RMenuv1:Get('personalmenu', 'main').EnableMouse = false
        RMenuv1:Get('personalmenu', 'main').Closed = function()
            PersonalMenu.Menu = false
            refresh()
        end
        PersonalMenu.Menu = true 
        RageUIv1.Visible(RMenuv1:Get('personalmenu', 'main'), true)
        Citizen.CreateThread(function()
			while PersonalMenu.Menu do

                RageUIv1.IsVisible(RMenuv1:Get('personalmenu', 'main'), true, true, true, function()
                    ESX.PlayerData = ESX.GetPlayerData()
                    pGrade = ESX.PlayerData.job.grade_name
                    pGrade2 = ESX.PlayerData.job2.grade_name

                    RageUIv1.ButtonWithStyle("• Poches", nil, { RightLabel = "→" },true, function()
                    end, RMenuv1:Get('personalmenu', 'inventory'))

                    if IsPedSittingInAnyVehicle(PlayerPedId()) then
						RageUIv1.ButtonWithStyle("• Véhicule", nil, {RightLabel = "→"},true, function()
						end, RMenuv1:Get('personalmenu', 'gestionveh'))
					end
                    RageUIv1.ButtonWithStyle("• Visual", nil, { RightLabel = "→" },true, function(h,a,s)
                    end, RMenuv1:Get('personalmenu', 'visual'))

                    RageUIv1.ButtonWithStyle("• Préference", nil, { RightLabel = "→" },true, function(h,a,s)
                    end, RMenuv1:Get('personalmenu', 'autres'))
                end)

                RageUIv1.IsVisible(RMenuv1:Get('personalmenu', 'gestion'), true, true, true, function()
                    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'bossassistantboss' then
                        RageUIv1.ButtonWithStyle("Gestion d'entreprise", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                            if Selected then
                            end
                        end, RMenuv1:Get('personalmenu', 'boss'))
                    else
                        RageUIv1.ButtonWithStyle("Gestion d'entreprise", "Vous devez être patron pour y accéder.", {RightBadge = RageUIv1.BadgeStyle.Lock}, false, function(Hovered, Active, Selected)
                            if Selected then
                            end
                        end)
                    end 
                    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then

                        RageUIv1.ButtonWithStyle("Gestion Organisation", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                            if Selected then
                            end
                        end, RMenuv1:Get('personalmenu', 'boss2'))
                    else
                        RageUIv1.ButtonWithStyle("Gestion Organisation", "Vous devez être jefe pour y accéder.", {RightBadge = RageUIv1.BadgeStyle.Lock}, false, function(Hovered, Active, Selected)
                            if Selected then
                            end
                        end)
                    end 
                end)
                
                RageUIv1.IsVisible(RMenuv1:Get('personalmenu', 'idproche'), true, true, true, function()
                    for _, player in ipairs(GetActivePlayers()) do
                        local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
                        local coords = GetEntityCoords(GetPlayerPed(player))
                        local sta = GetPlayerServerId()
        
                        if IsEntityVisible(GetPlayerPed(player)) then
                            if dst < 3.0 then
                                if sta ~= "me" then
                                    RageUIv1.ButtonWithStyle("ID : ~g~"..GetPlayerServerId(player).. " ~s~|~o~ "..GetPlayerName(player), nil, {}, true, function(h,a,s)      
                                        if a then
                                            DrawMarker(20, coords.x, coords.y, coords.z + 1.1, nil, nil, nil, nil, nil, nil, 0.4, 0.4, 0.4, 255, 255, 255, 100, true, true)
                                        end
                                        if s then
                                            ESX.ShowNotification("L'ID de cette personne est le ~g~"..GetPlayerServerId(player))
                                        end
                                    end)
                                end
                            end
                        end
                    end
                end)

                RageUIv1.IsVisible(RMenuv1:Get('personalmenu', 'visual'), true, true, true, function()
                    RageUIv1.Checkbox('Vue & lumières améliorées', nil, Player.VISUAL1, {}, function(h,a,s)
                        if s then
                            Player.VISUAL1 = not Player.VISUAL1
                            if Player.VISUAL1 == true then
                                SetTimecycleModifier('tunnel')
                            else
                                SetTimecycleModifier('')
                            end
                        end
                    end)

                    RageUIv1.Checkbox('Vue & lumières améliorées x2', nil, Player.VISUAL2, {}, function(h,a,s)
                        if s then
                            Player.VISUAL2 = not Player.VISUAL2
                            if Player.VISUAL2 == true then
                                SetTimecycleModifier('CS3_rail_tunnel')
                            else
                                SetTimecycleModifier('')
                            end
                        end
                    end)

                    RageUIv1.Checkbox('Vue & lumières améliorées x3', nil, Player.VISUAL3, {}, function(h,a,s)
                        if s then
                            Player.VISUAL3 = not Player.VISUAL3
                            if Player.VISUAL3 == true then
                                SetTimecycleModifier('MP_lowgarage')
                            else
                                SetTimecycleModifier('')
                            end
                        end
                    end)

                    RageUIv1.Checkbox('Vue lumineux', nil, Player.VISUAL4, {}, function(h,a,s)
                        if s then
                            Player.VISUAL4 = not Player.VISUAL4
                            if Player.VISUAL4 == true then
                                SetTimecycleModifier('rply_vignette_neg')
                            else
                                SetTimecycleModifier('')
                            end
                        end
                    end)

                    RageUIv1.Checkbox('Vue lumineux x2', nil, Player.VISUAL5, {}, function(h,a,s)
                        if s then
                            Player.VISUAL5 = not Player.VISUAL5
                            if Player.VISUAL5 == true then
                                SetTimecycleModifier('rply_saturation_neg')
                            else
                                SetTimecycleModifier('')
                            end
                        end
                    end)

                    RageUIv1.Checkbox('Couleurs amplifiées', nil, Player.VISUAL6, {}, function(h,a,s)
                        if s then
                            Player.VISUAL6 = not Player.VISUAL6
                            if Player.VISUAL6 == true then
                                SetTimecycleModifier('rply_saturation')
                            else
                                SetTimecycleModifier('')
                            end
                        end
                    end)

                    RageUIv1.Checkbox('Noir & blancs', nil, Player.VISUAL7, {}, function(h,a,s)
                        if s then
                            Player.VISUAL7 = not Player.VISUAL7
                            if Player.VISUAL7 == true then
                                SetTimecycleModifier('rply_saturation_neg')
                            else
                                SetTimecycleModifier('')
                            end
                        end
                    end)

                    RageUIv1.Checkbox('Visual 1', nil, Player.VISUAL8, {}, function(h,a,s)
                        if s then
                            Player.VISUAL8 = not Player.VISUAL8
                            if Player.VISUAL8 == true then
                                SetTimecycleModifier('yell_tunnel_nodirect')
                                TriggerServerEvent('GamemodePass:taskCountAdd:standart', 10, 1)
                            else
                                SetTimecycleModifier('')
                            end
                        end
                    end)

                    RageUIv1.Checkbox('Blanc', nil, Player.VISUAL9, {}, function(h,a,s)
                        if s then
                            Player.VISUAL9 = not Player.VISUAL9
                            if Player.VISUAL9 == true then
                                SetTimecycleModifier('rply_contrast_neg')
                            else
                                SetTimecycleModifier('')
                            end
                        end
                    end)

                    RageUIv1.Checkbox('Dégats', nil, Player.VISUAL10, {}, function(h,a,s)
                        if s then
                            Player.VISUAL10 = not Player.VISUAL10
                            if Player.VISUAL10 == true then
                                SetTimecycleModifier('rply_vignette')
                            else
                                SetTimecycleModifier('')
                            end
                        end
                    end)
                end)

                RageUIv1.IsVisible(RMenuv1:Get('personalmenu', 'crosshairx'), true, true, true, function()
                    RageUIv1.ButtonWithStyle("Activer/Desactiver le réticule personnalisé", nil, {}, true, function(h,a,s)      
                        if s then
                            ExecuteCommand("cross")
                            RageUIv1.CloseAll()
                        end
                    end)



                    RageUIv1.ButtonWithStyle("Modifier le réticule personnalisé", nil, {}, true, function(h,a,s)      
                        if s then
                            ExecuteCommand("crosse")
                            RageUIv1.CloseAll()
                        end
                    end)
                    RageUIv1.ButtonWithStyle("Rénitialiser le réticule personnalisé", nil, {}, true, function(h,a,s)      
                        if s then
                            ExecuteCommand("crossr")
                            RageUIv1.CloseAll()
                        end
                    end)
                end)

                RageUIv1.IsVisible(RMenuv1:Get('personalmenu', 'autres'), true, true, true, function()
                    -- RageUIv1.List("Boost FPS", PersonalMenu.FpsList , PersonalMenu.FpsActionIndex, nil, {}, true, function(h,a,s, Index)
                    --     if s then        
                    --         if Index == 1 then
                    --             umfpsBooster(1)
                    --         elseif Index == 2 then
                    --             umfpsBooster(2)
                    --         elseif Index == 3 then
                    --             umfpsBooster(3)
                    --         elseif Index == 3 then
                    --             umfpsBooster(4)
                    --         end
                    --     end
                    --     PersonalMenu.FpsActionIndex = Index
                    -- end)
                    RageUIv1.Checkbox('Interface GPS', nil, Player.minimap, {}, function(h,a,s)
                        if s then
                            Player.minimap = not Player.minimap
                            DisplayRadar(Player.minimap)
                        end
                    end)
                
                    RageUIv1.Checkbox('Mode Cinématique', nil, cinemamode, {}, function(h,a,s)
                        if s then
                            cinemamode = not cinemamode
                            ExecuteCommand("noir")
                        end
                    end)
                    RageUIv1.Checkbox('Masquer l\'interface', nil, Player.hud, {}, function(h,a,s)
                        if s then
                            Player.hud = not Player.hud
                            if Player.hud == true then
                                TriggerEvent('Gamemode:Hud:StateHud', false)
                            else
                                TriggerEvent('Gamemode:Hud:StateHud', true)
                            end
                        end
                    end)

                    RageUIv1.Checkbox('Désactiver Casque de moto', nil, Player.casque, {}, function(h,a,s)
                        if s then
                            Player.casque = not Player.casque
                            if Player.casque == true then
                                SetPedHelmet(PlayerPedId(), false)
                            else
                                SetPedHelmet(PlayerPedId(), true)
                            end
                        end
                    end)
                    RageUIv1.Checkbox('Activé la vente de drogue', nil, Player.drogue, {}, function(h,a,s)
                        if s then
                            Player.drogue = not Player.drogue
                            if Player.drogue == false then
                                ExecuteCommand("ventedrogue")
                            else
                                ExecuteCommand("ventedrogue")
                            end
                        end
                    end)
                    RageUIv1.Separator("↓ ~c~Autre Option~s~ ↓")
                    RageUIv1.ButtonWithStyle("ID Proche", nil, { RightLabel = "→" },true, function(h,a,s)
                    end, RMenuv1:Get('personalmenu', 'idproche'))

                    RageUIv1.ButtonWithStyle("Entrer dans la zone AFK", nil, {RightLabel = "→"}, true, function(h,a,s)      
                        if s then
                            ExecuteCommand("afk")
                            RageUIv1.CloseAll()
                        end
                    end)

                    RageUIv1.ButtonWithStyle("Personnaliser son Crosshair", nil, { RightLabel = "→" },true, function(h,a,s)
                    end, RMenuv1:Get('personalmenu', 'crosshairx'))      
                    RageUIv1.ButtonWithStyle(exports.Tree:serveurConfig().Serveur.color..'Debug', "Si vous êtes bloqué, ou bugé...",{ RightLabel = "→" }, true, function(_,_,s)
                        if s then
                            if not IsPedSittingInAnyVehicle(PlayerPedId()) then
                                if not isHandcuffed then
                                    ExecuteCommand("stuck")
                                else
                                    ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Impossible quand vous êtes menotter")
                                end
                            else
                                ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Impossible en voiture")
                            end
                        end
                    end)
                end)

                RageUIv1.IsVisible(RMenuv1:Get('personalmenu', 'gestionveh'), true, true, true, function()
                    if IsPedSittingInAnyVehicle(PlayerPedId()) then
                        RageUIv1.List("Action moteur", PersonalMenu.engineActionList, PersonalMenu.engineActionIndex, nil, {}, not engineCoolDown, function(h,a,s, Index)
                            if s then        
                                if Index == 1 then
                                    SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId(),false),true,true,false)
                                else
                                    SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId(),false),false,true,true)
                                end
                                engineCoolDown = true
                                Citizen.SetTimeout(1000, function()
                                    engineCoolDown = false
                                end)
                            end
                
                            PersonalMenu.engineActionIndex = Index
                        end)
                        RageUIv1.List("Limiteur de vitesse", PersonalMenu.maxSpeedList, PersonalMenu.maxSpeedListIndex, nil, {}, true, function(h,a,s, Index)
                            if s then        
                                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                                if Index == 1 then
                                    SetVehicleMaxSpeed(vehicle, 13.7)
                                elseif Index == 2 then
                                    SetVehicleMaxSpeed(vehicle, 22.0)
                                elseif Index == 3 then
                                    SetVehicleMaxSpeed(vehicle, 33.0)
                                elseif Index == 4 then
                                    SetVehicleMaxSpeed(vehicle, 36.0)
                                elseif Index == 5 then
                                    SetVehicleMaxSpeed(vehicle, 0.0)
                                end
                            end
                
                            PersonalMenu.maxSpeedListIndex = Index
                        end)
                        if ESX.PlayerData.job.label == "Police" or ESX.PlayerData.job.label == "B.C.S.O" then
                            RageUIv1.List("Extra du véhicule", extraList, extraIndex, nil, {}, true, function(h,a,s, Index)
                                if s then
                                    if isAllowedToManageVehicle() then
                                        local vehicle = GetVehiclePedIsIn(PlayerPedId(),false)
                                        if not vehicleIsDamaged() then
                                            if Index == 1 then
                                                SetVehicleExtra(vehicle,1)
                                                ESX.Game.SetVehicleProperties(vehicle, {
                                                    modFender = 0
                                                })
                                            elseif Index == 2 then
                                                SetVehicleExtra(vehicle,2)
                                            elseif Index == 3 then
                                                SetVehicleExtra(vehicle,3)
                                            elseif Index == 4 then
                                                SetVehicleExtra(vehicle,4)
                                            elseif Index == 5 then
                                                SetVehicleExtra(vehicle,5)
                                            elseif Index == 6 then
                                                SetVehicleExtra(vehicle,6)
                                            elseif Index == 7 then
                                                SetVehicleExtra(vehicle,7)
                                            elseif Index == 8 then
                                                SetVehicleExtra(vehicle,8)
                                            elseif Index == 9 then
                                                SetVehicleExtra(vehicle,9)
                                            elseif Index == 10 then
                                                SetVehicleExtra(vehicle,10)
                                            elseif Index == 11 then
                                                SetVehicleExtra(vehicle,11)
                                            elseif Index == 12 then
                                                SetVehicleExtra(vehicle,12)
                                            elseif Index == 13 then
                                                SetVehicleExtra(vehicle,13)
                                            elseif Index == 14 then
                                                SetVehicleExtra(vehicle,14)
                                            elseif Index == 15 then
                                                SetVehicleExtra(vehicle,15)
                                            end
                                        end
                                    end
                                end
                                extraIndex = Index
                            end)
                            RageUIv1.ButtonWithStyle("Extra ~g~ON", nil, {}, not extraCooldown, function(_,_,s)
                                if s then
                                    if isAllowedToManageVehicle() then
                                        local vehicle = GetVehiclePedIsIn(PlayerPedId(),false)
                                        if not vehicleIsDamaged() then
                                            SetVehicleExtra(vehicle,extraIndex,0)
                                            ESX.Game.SetVehicleProperties(vehicle, {
                                                modFender = 0
                                            })
                                            extraCooldown = true
                                            Citizen.SetTimeout(150, function()
                                                extraCooldown = false
                                            end)
                                        else
                                            ESX.ShowNotification("Ton véhicule est trop endommagé pour pouvoir y apporter des modificiations.")
                                        end
                                    end  
                                end
                            end)
            
                            RageUIv1.ButtonWithStyle("Extra "..exports.Tree:serveurConfig().Serveur.color.."OFF", nil, {}, not extraCooldown, function(_,_,s)
                                if s then
                                    if isAllowedToManageVehicle() then
                                        local vehicle = GetVehiclePedIsIn(PlayerPedId(),false)
                                        if not vehicleIsDamaged() then
                                            SetVehicleExtra(vehicle,extraIndex,1)
                                            ESX.Game.SetVehicleProperties(vehicle, {
                                                modFender = 1
                                            })
                                            extraCooldown = true
                                            Citizen.SetTimeout(150, function()
                                                extraCooldown = false
                                            end)
                                        else
                                            ESX.ShowNotification("Ton véhicule est trop endommagé pour pouvoir y apporter des modificiations.")
                                        end
                                    end  
                                end
                            end)
                            RageUIv1.List("Tous les extras", {"Activer","Désactiver"}, extraStateIndex, nil, {}, not extraCooldown, function(h,a,s, Index)
                                if s then
                                    if isAllowedToManageVehicle() then
                                        local vehicle = GetVehiclePedIsIn(PlayerPedId(),false)
                                        if not vehicleIsDamaged() then
                                            if Index == 1 then
                                                for index,_ in pairs(extraList) do
                                                    SetVehicleExtra(vehicle,index,0)
                                                end
                                            else
                                                for index,_ in pairs(extraList) do
                                                    SetVehicleExtra(vehicle,index,1)
                                                end
                                            end
                                            extraCooldown = true
                                            Citizen.SetTimeout(150, function()
                                                extraCooldown = false
                                            end)
                                        else
                                            ESX.ShowNotification("Ton véhicule est trop endommagé pour pouvoir y apporter des modificiations.")
                                        end
                                    end
                                end
                                extraStateIndex = Index
                            end)
                            
                        end
                        RageUIv1.List("Action portes", {"Ouvrir","Fermer"}, doorActionIndex, nil, {}, true, function(h,a,s, Index)
                            doorActionIndex = Index
                        end)
        
                        RageUIv1.ButtonWithStyle("Tout le véhicule", nil, {}, not doorCoolDown, function(_,_,s)
                            if s then
                                if isAllowedToManageVehicle() then doorAction(-1) end
                            end
                        end)
        
                        RageUIv1.ButtonWithStyle("Porte avant-gauche", nil, {}, not doorCoolDown, function(_,_,s)
                            if s then
                                if isAllowedToManageVehicle() then doorAction(0) end 
                            end
                        end)
        
                        RageUIv1.ButtonWithStyle("Porte avant-droite", nil, {}, not doorCoolDown, function(_,_,s)
                            if s then
                                if isAllowedToManageVehicle() then doorAction(1) end 
                            end
                        end)
        
                        RageUIv1.ButtonWithStyle("Porte arrière-gauche", nil, {}, not doorCoolDown, function(_,_,s)
                            if s then
                                if isAllowedToManageVehicle() then doorAction(2) end 
                            end
                        end)
        
                        RageUIv1.ButtonWithStyle("Porte arrière-droite", nil, {}, not doorCoolDown, function(_,_,s)
                            if s then
                                if isAllowedToManageVehicle() then doorAction(3) end 
                            end
                        end)
        
                        RageUIv1.ButtonWithStyle("Capot", nil, {}, not doorCoolDown, function(_,_,s)
                            if s then
                                if isAllowedToManageVehicle() then doorAction(4) end 
                            end
                        end)
        
                        RageUIv1.ButtonWithStyle("Coffre", nil, {}, not doorCoolDown, function(_,_,s)
                            if s then
                                if isAllowedToManageVehicle() then doorAction(5) end
                            end
                        end)
                        RageUIv1.ButtonWithStyle("Tableau de bord", nil, {}, not doorCoolDown, function(_,_,s)
                            if s then
                                RageUIv1.CloseAll()
                               ExecuteCommand("carinfo")
                               
                            end
                        end)
                    else
                        RageUIv1.GoBack()
                    end
                end)
                
                RageUIv1.IsVisible(RMenuv1:Get('personalmenu', 'clothes'), true, true, true, function()
                    RageUIv1.Separator("↓ ~c~Votre Tenue~s~ ↓")
                    RageUIv1.ButtonWithStyle("Haut", nil, { RightBadge = RageUIv1.BadgeStyle.Clothes }, true,function(h,a,s)
                        if s then
                            if not exports.Gamemode:IsInStaff() then
                                TriggerEvent("requestClothes", "haut")
                            else
                                ESX.ShowNotification("Action impossible en mode staff !")
                            end
                        end
                    end)                    
                    RageUIv1.ButtonWithStyle("Bas", nil, { RightBadge = RageUIv1.BadgeStyle.Clothes }, true,function(h,a,s)
                        if s then
                            if not exports.Gamemode:IsInStaff() then
                                TriggerEvent("requestClothes", "bas")
                            else
                                ESX.ShowNotification("Action impossible en mode staff !")
                            end
                        end
                    end)
                    RageUIv1.ButtonWithStyle("Chaussures", nil, { RightBadge = RageUIv1.BadgeStyle.Clothes }, true,function(h,a,s)
                        if s then
                            if not exports.Gamemode:IsInStaff() then
                                TriggerEvent("requestClothes", "chaussures")
                            else
                                ESX.ShowNotification("Action impossible en mode staff !")
                            end
                        end
                    end)
                    RageUIv1.ButtonWithStyle("Sac", nil, { RightBadge = RageUIv1.BadgeStyle.Clothes }, true,function(h,a,s)
                        if s then
                            if not exports.Gamemode:IsInStaff() then
                                TriggerEvent("requestClothes", "sac")
                            else
                                ESX.ShowNotification("Action impossible en mode staff !")
                            end
                        end
                    end)
                    RageUIv1.ButtonWithStyle("Gilet par Balles", nil, { RightBadge = RageUIv1.BadgeStyle.Clothes }, true,function(h,a,s)
                        if s then
                            if not exports.Gamemode:IsInStaff() then
                                TriggerEvent("requestClothes", "gilet")
                            else
                                ESX.ShowNotification("Action impossible en mode staff !")
                            end
                        end
                    end)
                    RageUIv1.Separator("↓ ~c~Vos Accessoires~s~ ↓")
                    RageUIv1.ButtonWithStyle("Chapeau/Casque", nil, { RightBadge = RageUIv1.BadgeStyle.Clothes }, true,function(h,a,s)
                        if s then
                            if not exports.Gamemode:IsInStaff() then
                                TriggerEvent("requestClothes", "casque")
                            else
                                ESX.ShowNotification("Action impossible en mode staff !")
                            end
                        end
                    end)
                    RageUIv1.ButtonWithStyle("Masque", nil, { RightBadge = RageUIv1.BadgeStyle.Clothes }, true,function(h,a,s)
                        if s then
                            if not exports.Gamemode:IsInStaff() then
                                TriggerEvent("requestClothes", "masque")
                            else
                                ESX.ShowNotification("Action impossible en mode staff !")
                            end
                        end
                    end)
                    RageUIv1.ButtonWithStyle("Lunette", nil, { RightBadge = RageUIv1.BadgeStyle.Clothes }, true,function(h,a,s)
                        if s then
                            if not exports.Gamemode:IsInStaff() then
                                TriggerEvent("requestClothes", "lunette")
                            else
                                ESX.ShowNotification("Action impossible en mode staff !")
                            end
                        end
                    end)
                    RageUIv1.Separator("↓ ~c~Autre~s~ ↓")
                    RageUIv1.ButtonWithStyle("Sac de poches", nil,{ RightLabel = "→" }, true, function(_,_,s)
                        if s then 
                            ExecuteCommand("outfitbag")
                            RageUIv1.CloseAll()
                        end
                    end)  

                end)
                RageUIv1.IsVisible(RMenuv1:Get('personalmenu', 'inventory'), true, true, true, function()

                    RageUIv1.Separator("↓ ~m~Vos Poche(s)~s~ ↓")

                    RageUIv1.ButtonWithStyle("Information ~s~(~g~Facture~s~)", nil, { RightLabel = "~m~Accéder ~s~→" },true, function(h,a,s)
                        if s then
                            RefreshBilling()
                        end
                    end, RMenuv1:Get('personalmenu', 'billing'))
                    
                    RageUIv1.ButtonWithStyle("Vêtement (~g~Habits~s~)", nil, { RightLabel = "~m~Accéder ~s~→" },true, function()
                    end, RMenuv1:Get('personalmenu', 'clothes'))


                    RageUIv1.Separator("↓ ~m~Management~s~ ↓")

                    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'bossassistantboss' then
                        RageUIv1.ButtonWithStyle("Gestion société ~s~(~g~"..ESX.PlayerData.job.label.."~s~)", nil, {RightLabel = "~m~Accéder~s~ →"}, true, function(Hovered, Active, Selected)
                            if Selected then
                            end
                        end, RMenuv1:Get('personalmenu', 'boss'))
                    else
                        RageUIv1.ButtonWithStyle("Gestion société ~s~(~g~"..ESX.PlayerData.job.label.."~s~)", "Vous devez être patron pour y accéder.", {RightBadge = RageUIv1.BadgeStyle.Lock}, false, function(Hovered, Active, Selected)
                            if Selected then

                            end
                        end)
                    end
                end)

                RageUIv1.IsVisible(RMenuv1:Get('personalmenu', 'billing'), true, true, true, function()
                    if #PersonalMenu.billing == 0 then
                        RageUIv1.Separator("")
                        RageUIv1.Separator("~s~Vous n'avez aucune facture")
                        RageUIv1.Separator("")
                    end
                    for i = 1, #PersonalMenu.billing, 1 do
						RageUIv1.ButtonWithStyle(""..PersonalMenu.billing[i].label, nil, {RightLabel = ESX.Math.GroupDigits(PersonalMenu.billing[i].amount.."~g~$")}, true, function(h,a,s)
							if s then
								ESX.TriggerServerCallback('esx_billing:payBill', function()
								end, PersonalMenu.billing[i].id)
                                ESX.SetTimeout(100, function()
                                    RefreshBilling()
                                    RageUIv1.GoBack()
                                end)
							end
						end)
					end
                end)
                
                RageUIv1.IsVisible(RMenuv1:Get('personalmenu', 'boss'), true, true, true, function()
                    RageUIv1.Separator("Entreprise : "..exports.Tree:serveurConfig().Serveur.color..""..ESX.PlayerData.job.label.."")

                    -- if societymoney ~= nil then
                    --     RageUIv1.Separator("Argent : "..exports.Tree:serveurConfig().Serveur.color..""..societymoney.."$")
                    -- end

                    RageUIv1.ButtonWithStyle('Faire une annonce personaliser', nil, {RightLabel = "→"}, canChange, function(Hovered, Active, Selected)
                        if (Selected) then
                            local msg = KeyboardInputAnnoncePerso("Votre annonce", "", 30)
                            if msg then
                                TriggerServerEvent("babyboy:customAnnonce", msg)
                                RageUI.CloseAll()
                            else 
                                ESX.ShowNotification("~g~Administration\nMessage invalide")
                            end
                        end
                    end)

                    RageUIv1.Separator("")

                    RageUIv1.ButtonWithStyle('Recruter une personne', nil, {RightLabel = "→"}, canChange, function(Hovered, Active, Selected)
                        if (Selected) then
                            canChange = false
                            Citizen.SetTimeout(2000, function()
                                canChange = true
                            end)
                            if ESX.PlayerData.job.grade_name == 'boss' then
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            
                                if closestPlayer == -1 or closestDistance > 3.0 then
                                    ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Aucun joueur proche.')
                                else
                                    exports[exports.Tree:serveurConfig().Serveur.hudScript]:RecruitPlayer("job", GetPlayerServerId(closestPlayer));
                                    TriggerServerEvent('recrutejoueur', GetPlayerServerId(closestPlayer), ESX.PlayerData.job.name, 0)
                                end
                            else
                                ESX.ShowNotification('Vous n\'avez pas les '..exports.Tree:serveurConfig().Serveur.color..'droits')
                            end
                        end
                    end)
        
                    RageUIv1.ButtonWithStyle('Virer une personne', nil, {RightLabel = "→"}, canChange, function(Hovered, Active, Selected)
                        if (Selected) then
                            canChange = false
                            Citizen.SetTimeout(2000, function()
                                canChange = true
                            end)
                            if ESX.PlayerData.job.grade_name == 'boss' then
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            
                                if closestPlayer == -1 or closestDistance > 3.0 then
                                    ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Aucun joueur proche.')
                                else
                                    TriggerServerEvent('virerjoueur', GetPlayerServerId(closestPlayer))
                                end
                            else
                                ESX.ShowNotification('Vous n\'avez pas les '..exports.Tree:serveurConfig().Serveur.color..'droits')
                            end
                        end
                    end)
        
                    RageUIv1.ButtonWithStyle('Promouvoir une personne', nil, {RightLabel = "→"}, canChange, function(Hovered, Active, Selected)
                        if (Selected) then
                            canChange = false
                            Citizen.SetTimeout(2000, function()
                                canChange = true
                            end)
                            if ESX.PlayerData.job.grade_name == 'boss' then
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            
                                if closestPlayer == -1 or closestDistance > 3.0 then
                                    ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Aucun joueur proche.')
                                else
                                    TriggerServerEvent('c26bgdtoklmtbr:{-pp}', GetPlayerServerId(closestPlayer))
                                end
                            else
                                ESX.ShowNotification('Vous n\'avez pas les '..exports.Tree:serveurConfig().Serveur.color..'droits')
                            end
                        end
                    end)
            
                    RageUIv1.ButtonWithStyle('Destituer une personne', nil, {RightLabel = "→"}, canChange, function(Hovered, Active, Selected)
                        if (Selected) then
                            canChange = false

                            Citizen.SetTimeout(2000, function()
                                canChange = true
                            end)

                            if ESX.PlayerData.job.grade_name == 'boss' then
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                                if closestPlayer == -1 or closestDistance > 3.0 then
                                    ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Aucun joueur proche.')
                                else
                                    TriggerServerEvent('f45bgdtj78ql:[tl-yu]', GetPlayerServerId(closestPlayer))
                                end
                            else
                                ESX.ShowNotification('Vous n\'avez pas les '..exports.Tree:serveurConfig().Serveur.color..'droits')
                            end
                        end
                    end)
                end, function()
                end)
            
				Wait(0)
			end
		end)
	end

end
Keys.Register('F5','F5', 'Menu Personnel ', function()
    PlaySoundFrontend(-1, 'ATM_WINDOW', 'HUD_FRONTEND_DEFAULT_SOUNDSET', 1)
    refresh()
    OpenRzInteract();
end)

function refresh()
    Citizen.CreateThread(function()
        ESX.PlayerData = ESX.GetPlayerData() ------ ca sert a rien de le laisser dans ton button il tourner en boucle et surtout te faire monter en ms
    end)
end

function RefreshBilling()
    ESX.TriggerServerCallback('esx_billing:getBills', function(bills)
        PersonalMenu.billing = bills
        -- print(PersonalMenu.billing)
        -- print(bills)
    end)
end

function doorAction(door)
    if not IsPedInAnyVehicle(PlayerPedId(),false) then return end
    local veh = GetVehiclePedIsIn(PlayerPedId(),false)
    if door == -1 then
        if doorActionIndex == 1 then
            for i = 0, 7 do
                SetVehicleDoorOpen(veh,i,false,false)
            end
        else
            for i = 0, 7 do
                SetVehicleDoorShut(veh,i,false)
            end
        end
        doorCoolDown = true
        Citizen.SetTimeout(500, function()
            doorCoolDown = false
        end)
        return
    end
    if doorActionIndex == 1 then
        SetVehicleDoorOpen(veh,door,false,false)
        doorCoolDown = true
        Citizen.SetTimeout(500, function()
            doorCoolDown = false
        end)
    else
        SetVehicleDoorShut(veh,door,false)
        doorCoolDown = true
        Citizen.SetTimeout(500, function()
            doorCoolDown = false
        end)
    end
end

function vehicleIsDamaged()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(),false)
    return GetVehicleEngineHealth(vehicle) < 1000
end

function isAllowedToManageVehicle()
    if IsPedInAnyVehicle(PlayerPedId(),false) then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(),false)
        if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
            return true
        end
        return false
    end
    return false
end

function CheckQuantity(number)
    number = tonumber(number)
  
    if type(number) == 'number' then
      number = ESX.Math.Round(number)
  
      if number > 0 then
        return true, number
      end
    end
  
    return false, number
end

RegisterNetEvent('CloseMenu')
AddEventHandler('CloseMenu', function()
	RageUIv1.Visible(RMenuv1:Get('personalmenu', 'main'), false)
end)

function playerMarker(player)
    local ped = GetPlayerPed(player)
    local pos = GetEntityCoords(ped)
    DrawMarker(2, pos.x, pos.y, pos.z+1.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 170, 0, 1, 2, 0, nil, nil, 0)
end

RegisterNetEvent('esx_addonaccount:setMoney')
AddEventHandler('esx_addonaccount:setMoney', function(society, money)
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' and 'society_' .. ESX.PlayerData.job.name == society then
		societymoney = ESX.Math.GroupDigits(money)
	end
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' and 'society_' .. ESX.PlayerData.job2.name == society then
		societymoney2 = ESX.Math.GroupDigits(money)
    end
end)

angle = function(veh)
    if not veh then return false end
    local vx,vy,vz = table.unpack(GetEntityVelocity(veh))
    local modV = math.sqrt(vx*vx + vy*vy)
    local rx,ry,rz = table.unpack(GetEntityRotation(veh,0))
    local sn,cs = -math.sin(math.rad(rz)), math.cos(math.rad(rz))

    if GetEntitySpeed(veh)* 3.6 < 5 or GetVehicleCurrentGear(veh) == 0 then return 0,modV end --speed over 30 km/h
    
    local cosX = (sn*vx + cs*vy)/modV
    if cosX > 0.966 or cosX < 0 then return 0,modV end
    return math.deg(math.acos(cosX))*0.5, modV
end

Citizen.CreateThread(function()
    while true do
        local sleep_drift = 1000
        if drift_mode then
            local ped        = GetPlayerPed(-1)
            local car        = GetVehiclePedIsUsing(ped)
            local ang, speed = angle(car)

            if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                sleep_drift = 0
                local CarSpeed = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1),false)) * speed
                if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1),false), -1) == GetPlayerPed(-1) then
                    if CarSpeed <= drift_speed_limit then 
                        if IsControlPressed(1, 21) then
                            SetVehicleReduceGrip(GetVehiclePedIsIn(GetPlayerPed(-1),false), true)
                        else
                            SetVehicleReduceGrip(GetVehiclePedIsIn(GetPlayerPed(-1),false), false)
                        end
                    end
                end
            end
        end

        Wait(sleep_drift)
    end
end)

local stuck_cooldown = false
RegisterCommand('stuck', function(source, args, rawCommand)
    
    if not stuck_cooldown then
        
        stuck_cooldown = true

        RageUI.CloseAll()
        SetEntityCoords(GetPlayerPed(-1), GetEntityCoords(GetPlayerPed(-1)).x, GetEntityCoords(GetPlayerPed(-1)).y, GetEntityCoords(GetPlayerPed(-1)).z + 1.0)
        FreezeEntityPosition(GetPlayerPed(-1), false)
        Wait(5000)
        stuck_cooldown = false
    else
        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Veuillez patienter entre chaque utilisation de cette commande")
    end
end)

RegisterNetEvent('view:idcard')
AddEventHandler("view:idcard", function(source)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestDistance ~= -1 and closestDistance <= 1.5 then
	 	TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))
	else
		TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
	end
end)

RegisterNetEvent('view:ppa')
AddEventHandler("view:ppa", function(source)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestDistance ~= -1 and closestDistance <= 1.5 then
	 	TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), 'weapon')
	else
		TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
	end
end)

RegisterNetEvent('view:permis')
AddEventHandler("view:permis", function(source)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestDistance ~= -1 and closestDistance <= 1.5 then
	 	TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), 'driver')
	else
		TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
	end
end)


