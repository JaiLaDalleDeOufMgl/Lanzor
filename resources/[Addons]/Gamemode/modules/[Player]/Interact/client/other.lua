

local handsup = false
local pointing = false

CreateThread(function()
    while ESX == nil do
		Wait(100)
    end
end)
local handsup = false

function getSurrenderStatus()
	return handsup
end

RegisterCommand('handsup', function()
		if DoesEntityExist(PlayerPedId()) and not IsEntityDead(PlayerPedId()) then
			if not IsPedInAnyVehicle(PlayerPedId(), false) and not IsPedSwimming(PlayerPedId()) and not IsPedShooting(PlayerPedId()) and not IsPedClimbing(PlayerPedId()) and not IsPedCuffed(plyPed) and not IsPedDiving(PlayerPedId()) and not IsPedFalling(PlayerPedId()) and not IsPedJumpingOutOfVehicle(PlayerPedId()) and not IsPedUsingAnyScenario(PlayerPedId()) and not IsPedInParachuteFreeFall(PlayerPedId()) then
				RequestAnimDict("random@mugging3")

				while not HasAnimDictLoaded("random@mugging3") do
					Citizen.Wait(100)
				end

				if not handsup then
					handsup = true
					TaskPlayAnim(PlayerPedId(), "random@mugging3", "handsup_standing_base", 8.0, -8, -1, 49, 0, 0, 0, 0)
					--TriggerServerEvent("esx_thief:update", true)
				elseif handsup then
					handsup = false
					ClearPedSecondaryTask(PlayerPedId())
					--TriggerServerEvent("esx_thief:update", false)
				end
			end
		end
end, false)
RegisterKeyMapping('handsup', 'Lever les mains', 'keyboard', 'H')

local crouched = false
local GUI = {}
GUI.Time = 0

crouch = function()
	RequestAnimSet("move_ped_crouched")

    while not HasAnimSetLoaded("move_ped_crouched") do 
        Citizen.Wait(100)
    end 

    if crouched == true then 
        ResetPedMovementClipset(PlayerPedId(), 0)
        crouched = false 
    elseif crouched == false then
        SetPedMovementClipset(PlayerPedId(), "move_ped_crouched", 0.25)
        crouched = true 
		----pipicaca = true
    end 
    
    GUI.Time = GetGameTimer()
end

Keys.Register('X','S\'accroupir', 's\'accroupir', function()
	crouch()
end)

function startPointing(plyPed)
	ESX.Streaming.RequestAnimDict('anim@mp_point')
	SetPedConfigFlag(plyPed, 36, true)
	TaskMoveNetworkByName(plyPed, 'task_mp_pointing', 0.5, false, 'anim@mp_point', 24)
	RemoveAnimDict('anim@mp_point')
end

function stopPointing(plyPed)
	RequestTaskMoveNetworkStateTransition(plyPed, 'Stop')

	if not IsPedInjured(plyPed) then
		ClearPedSecondaryTask(plyPed)
	end

	SetPedConfigFlag(plyPed, 36, false)
	ClearPedSecondaryTask(plyPed)
end

local function startPointing(plyPed)	
	ESX.Streaming.RequestAnimDict('anim@mp_point', function()
		SetPedConfigFlag(plyPed, 36, 1)
		TaskMoveNetworkByName(plyPed, 'task_mp_pointing', 0.5, 0, 'anim@mp_point', 24)
		RemoveAnimDict('anim@mp_point')
	end)
end

local function stopPointing()
	local plyPed = PlayerPedId()
	RequestTaskMoveNetworkStateTransition(plyPed, 'Stop')

	if not IsPedInjured(plyPed) then
		ClearPedSecondaryTask(plyPed)
	end

	SetPedConfigFlag(plyPed, 36, 0)
	ClearPedSecondaryTask(plyPed)
end

funcP = function()
	if pointing then
		stopPointing()
		pointing = false
	else
		startPointing(PlayerPedId())
		pointing = true
		Citizen.Wait(100)
		Citizen.CreateThread(function()
			while pointing do
				local ped = PlayerPedId()
				local camPitch = GetGameplayCamRelativePitch()
				if camPitch < -70.0 then
					camPitch = -70.0
				elseif camPitch > 42.0 then
					camPitch = 42.0
				end
		
				camPitch = (camPitch + 70.0) / 112.0
		
				local camHeading = GetGameplayCamRelativeHeading()
				local cosCamHeading = Cos(camHeading)
				local sinCamHeading = Sin(camHeading)
		
				if camHeading < -180.0 then
					camHeading = -180.0
				elseif camHeading > 180.0 then
					camHeading = 180.0
				end
		
				camHeading = (camHeading + 180.0) / 360.0
				local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
				local rayHandle, blocked = GetShapeTestResult(StartShapeTestCapsule(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7))
		
				SetTaskMoveNetworkSignalFloat(ped, 'Pitch', camPitch)
				SetTaskMoveNetworkSignalFloat(ped, 'Heading', (camHeading * -1.0) + 1.0)
				SetTaskMoveNetworkSignalBool(ped, 'isBlocked', blocked)
				SetTaskMoveNetworkSignalBool(ped, 'isFirstPerson', N_0xee778f8c7e1142e2(N_0x19cafa3c87f7c2ff()) == 4)
				Citizen.Wait(0)
			end
		end)
	end
end

Keys.Register('B','pointing', 'pointer du doigt', function()
	funcP()
end)

local noir = false
RegisterCommand('noir', function()
    noir = not noir
    if noir then 
		TriggerEvent('Gamemode:Hud:StateHud', false)
        DisplayRadar(false) 
    end
    while noir do
        if not HasStreamedTextureDictLoaded('revolutionbag') then
            RequestStreamedTextureDict('revolutionbag')
            while not HasStreamedTextureDictLoaded('revolutionbag') do
                Citizen.Wait(50)
            end
        end

        DrawSprite('revolutionbag', 'cinema', 0.5, 0.5, 1.0, 1.0, 0.0, 255, 255, 255, 255)
        Citizen.Wait(0)
    end
	TriggerEvent('Gamemode:Hud:StateHud', true)
    DisplayRadar(true)
    SetStreamedTextureDictAsNoLongerNeeded('revolutionbag')
end)

XD = {}


function XD.ShowHelpNotification(msg)
	AddTextEntry('esxHelpNotification', msg)
	BeginTextCommandDisplayHelp('esxHelpNotification')
	EndTextCommandDisplayHelp(0, false, true, -1)
end

local crosshairParameters =
{	
	["width"] =
	{
		["label"] = "Largeur",
		["allValues"] = {0.002, 0.0025, 0.003, 0.0035, 0.004, 0.0045, 0.005, 0.0055, 0.006, 0.0065, 0.007, 0.0075, 0.008, 0.0085, 0.009, 0.0095, 0.010, 
		0.0105, 0.011, 0.0115, 0.012, 0.0125, 0.013, 0.0135, 0.014, 0.0145, 0.015, 0.0155, 0.016, 0.0165, 0.017, 0.0175, 0.018, 0.0185, 0.019, 0.0195, 0.02},
		["currentValue"] = 3,
	},
	["gap"] =
	{
		["label"] = "Écart",
		["allValues"] = {0.0, 0.0005, 0.001, 0.0015, 0.002, 0.0025, 0.003, 0.0035, 0.004, 0.0045, 0.005, 0.0055, 0.006, 0.0065, 0.007, 0.0075, 0.008, 0.0085, 0.009, 0.0095, 0.01},
		["currentValue"] = 3,
	},
	["dot"] =
	{
		["label"] = "Point",
		["allValues"] = {false, true},
		["currentValue"] = 2,
	},
	["thickness"] =
	{
		["label"] = "Épaisseur",
		["allValues"] = {0.002, 0.004, 0.006, 0.008, 0.01, 0.012, 0.014, 0.016, 0.018, 0.02},
		["currentValue"] = 1,
	},
	["gtacross"] =
	{
		["label"] = "Activé par défaut (1 = Désactivé)",
		["allValues"] = {false, true},
		["currentValue"] = 2,
	},
	["color"] =
	{
		["label"] = "Couleur",
		["allValues"] = {
			{R = 255,	G = 255,	B = 255},{R = 0,	G = 0,	B = 0},{R = 255,	G = 0,	B = 0},{R = 0,	G = 255,	B = 0},{R = 0,	G = 0,	B = 255},{R = 255,	G = 255,	B = 0},
			{R = 255,	G = 0,	B = 255},{R = 0,	G = 255,	B = 255},{R = 255,	G = 165,	B = 0},{R = 0,	G = 128,	B = 0},{R = 128,	G = 0,	B = 128},
		},
		["currentValue"] = 1,
	},
	["opacity"] =
	{
		["label"] = "Opacité",
		["allValues"] = {25, 50, 75, 100, 125, 150, 175, 200, 225, 255},
		["currentValue"] = 10,
	},
}

local allDefaultValues = {
	{param = "thickness", value = 1},
	{param = "width", value = 3},
	{param = "gap", value = 3},
	{param = "dot", value = 2},
	{param = "gtacross", value = 2},
	{param = "color", value = 1},
	{param = "opacity", value = 10},
}

local parameters = {"width", "gap", "dot", "thickness", "gtacross", "color", "opacity"}

local currentParamIndex = 1
local isEditing = false
local customCrosshairState = true

local function GetInitialDatas()
	local customCrosshairData = GetResourceKvpInt("crosshair_custom")
	if not customCrosshairData or customCrosshairData == 0 then
		customCrosshairData = 1
		SetResourceKvpInt("crosshair_custom", 1)
	end

	if customCrosshairData == 1 then
		customCrosshairState = false
	else
		customCrosshairState = true
	end

	for k,v in pairs(allDefaultValues) do
		local currentData = GetResourceKvpInt("crosshair_" .. v.param)
		if not currentData or currentData == 0 then
			SetResourceKvpInt("crosshair_" .. v.param, v.value)
		else
			crosshairParameters[v.param]["currentValue"] = currentData
		end
	end
end

local function SaveDatas()
	for k,v in pairs(allDefaultValues) do
		SetResourceKvpInt("crosshair_" .. v.param, crosshairParameters[v.param]["currentValue"])
	end

	ESX.ShowNotification("<C>~g~Crosshair sauvegardé")
end

local function ResetDatas()
	local allSettings =
	{
		{param = "thickness", value = 1},
		{param = "width", value = 3},
		{param = "gap", value = 3},
		{param = "dot", value = 2},
		{param = "gtacross", value = 2},
		{param = "color", value = 1},
		{param = "opacity", value = 10},
	}

	for k,v in pairs(allSettings) do
		SetResourceKvpInt("crosshair_" .. v.param, v.value)
	end

	ESX.ShowNotification("<C>"..exports.Tree:serveurConfig().Serveur.color.."Crosshair rénitialisé")

	GetInitialDatas()
end

-- Loops
Citizen.CreateThread(function()
	GetInitialDatas()

	Citizen.Wait(2000)

    local toWait = 250

	while true do
		-- Manage default reticle
		if not crosshairParameters["gtacross"]["allValues"][crosshairParameters["gtacross"]["currentValue"]] then
			HideHudComponentThisFrame(14)
		end

        if customCrosshairState then
            toWait = 0
			local ratio = GetAspectRatio()

			-- Get values
			local thickness = crosshairParameters["thickness"]["allValues"][crosshairParameters["thickness"]["currentValue"]]
			local width		= crosshairParameters["width"]["allValues"][crosshairParameters["width"]["currentValue"]]
			local gap		= crosshairParameters["gap"]["allValues"][crosshairParameters["gap"]["currentValue"]]
			local dot		= crosshairParameters["dot"]["allValues"][crosshairParameters["dot"]["currentValue"]]
			--
			local colorSelected = crosshairParameters["color"]["currentValue"]
			local colorR = crosshairParameters["color"]["allValues"][colorSelected].R
			local colorG = crosshairParameters["color"]["allValues"][colorSelected].G
			local colorB = crosshairParameters["color"]["allValues"][colorSelected].B
			--
			local colorOpacity	= crosshairParameters["opacity"]["allValues"][crosshairParameters["opacity"]["currentValue"]]
			--

			-- Left
			DrawRect(0.5 - gap - width / 2, 0.5, width, thickness, colorR, colorG, colorB, colorOpacity)
			-- Right
			DrawRect(0.5 + gap + width / 2, 0.5, width, thickness, colorR, colorG, colorB, colorOpacity)
			-- Top
			DrawRect(0.5, 0.5 - (gap*ratio) - (width*ratio) / 2, thickness / ratio, width * ratio, colorR, colorG, colorB, colorOpacity)
			-- Bottom
			DrawRect(0.5, 0.5 + (gap*ratio) + (width*ratio) / 2, thickness / ratio, width * ratio, colorR, colorG, colorB, colorOpacity)
			-- Dot
			if dot then
				DrawRect(0.5, 0.5, (thickness/2), (thickness/2) * ratio, colorR, colorG, colorB, colorOpacity)
			end
		end

		--
        if isEditing then
            toWait = 0
			local currentParameter = parameters[currentParamIndex]

			-- Display
			XD.ShowHelpNotification("~INPUT_CELLPHONE_UP~ " .. crosshairParameters[currentParameter]["label"] .. "\n~INPUT_REPLAY_ADVANCE~ " .. crosshairParameters[currentParameter]["currentValue"] .. "\n~INPUT_CONTEXT~ Sauvegarder")
			--

			-- Switch currentValue
			if IsControlJustPressed(1, 172) then
				currentParamIndex = currentParamIndex + 1
				if currentParamIndex > #parameters then currentParamIndex = 1 end
			elseif IsControlJustPressed(1, 173) then
				currentParamIndex = currentParamIndex - 1
				if currentParamIndex < 1 then currentParamIndex = #parameters end
			-- Increase currentValue
			elseif IsControlJustPressed(1, 307) then
				local currentValue = crosshairParameters[currentParameter]["currentValue"] + 1
				if currentValue > #crosshairParameters[currentParameter]["allValues"] then currentValue = 1 end
				crosshairParameters[currentParameter]["currentValue"] = currentValue
			-- Reduce currentValue
			elseif IsControlJustPressed(1, 308) then
				local currentValue = crosshairParameters[currentParameter]["currentValue"] - 1
				if currentValue < 1 then currentValue = #crosshairParameters[currentParameter]["allValues"] end
				crosshairParameters[currentParameter]["currentValue"] = currentValue
			elseif IsControlJustPressed(1, 51) then
				SaveDatas()
				isEditing = false
			end
		end

		Citizen.Wait(toWait)
	end
end)

AddEventHandler("crosshair:active", function()
	customCrosshairState = not customCrosshairState
	if customCrosshairState then
		SetResourceKvpInt("crosshair_custom", 2)
	else
		SetResourceKvpInt("crosshair_custom", 1)
	end
end)

AddEventHandler("crosshair:edit", function()
	isEditing = true
end)

AddEventHandler("crosshair:reset", function()
	ResetDatas()
end)

-- Commands
RegisterCommand('crosse', function(source, args)
	-- Crosshair edit
	TriggerEvent("crosshair:edit")
end, false)

RegisterCommand('crossr', function(source, args)
	-- Crosshair reset
	TriggerEvent("crosshair:reset")
end, false)

RegisterCommand('cross', function(source, args)
	-- Crosshair active
	TriggerEvent("crosshair:active")
end, false)


openUi = function()
    local mainMenu = RageUI.CreateMenu("", "Rockstar Editor")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while mainMenu do
        RageUI.IsVisible(mainMenu, function()
            RageUI.Button("Se rendre dans le Rockstar Editor", nil, {}, true, {
                onSelected = function()
                    ActivateRockstarEditor()
                    while IsPauseMenuActive() do
                        Citizen.Wait(0)
                    end
                    DoScreenFadeIn(1)
                end
            })
            RageUI.Button("Rockstar Editor | record", nil, {}, true, {
                onSelected = function()
                    if IsRecording() then
                        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Vous enregistrez déjà")
                    else
                        StartRecording(1)
                    end
                end
            })
            RageUI.Button("Rockstar Editor | Stop record", nil, {}, true, {
                onSelected = function()
                    if not IsRecording() then
                        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Vous devez d'abord démarrer le record")
                    else
                        StopRecordingAndSaveClip()
                    end
                end
            })
        end)
        Citizen.Wait(0)
    end
end

Keys.Register('F4','Editor', 'Rockstar Editor', function()
    PlaySoundFrontend(-1, 'ATM_WINDOW', 'HUD_FRONTEND_DEFAULT_SOUNDSET', 1)
    openUi()
end)