CreateThread(function()
    while ESX == nil do
        Wait(100)
    end
    while ESX.GetPlayerData().job == nil do
        Wait(100)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)

local IsCuffed = false
local isDead = false

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

AddEventHandler('esx:onPlayerDeath', function()
	isDead = true
end)

AddEventHandler('baseevents:onPlayerDied', function()
    isDead = true
end)

-- AddEventHandler('playerSpawned', function()
-- 	isDead = false
-- end)


RegisterNetEvent('fow_handcuff:thecuff')
AddEventHandler('fow_handcuff:thecuff', function(NeedMove, _)
	if NeedMove then
		IsCuffed = true
	elseif not NeedMove then
		IsCuffed = false
	end
end)

-- CreateThread( function()
-- 	local resetCounter = 0
-- 	local jumpDisabled = false
  	
--   	while true do
--         Wait(100);

-- 		if jumpDisabled and resetCounter > 0 and IsPedJumping(PlayerPedId()) and not (GetPedParachuteState(PlayerPedId()) == 1)then
-- 			SetPedToRagdoll(PlayerPedId(), 500, 500, 3, 0, 0, 0)
-- 			ESX.ShowAdvancedNotification('Notification', 'Gamemode', "Pourquoi tu saute autant petit lapin ?")
-- 			resetCounter = 0
-- 		end

-- 		if not jumpDisabled and IsPedJumping(PlayerPedId()) then
-- 			jumpDisabled = true
-- 			resetCounter = 10
-- 			Citizen.Wait(1200)
-- 		end

-- 		if resetCounter > 0 then
-- 			resetCounter = resetCounter - 1
-- 		else
-- 			if jumpDisabled then
-- 				resetCounter = 0
-- 				jumpDisabled = false
-- 			end
-- 		end
-- 	end
-- end)

local piggyBackInProgress = false
local holdingHostageInProgress, beingHeldHostage, holdingHostage = false, false
local takeHostageAnimNamePlaying, takeHostageAnimDictPlaying, takeHostageControlFlagPlaying = '', '', 0

local hostageAllowedWeapons = {
	'WEAPON_PISTOL',
	'WEAPON_PISTOL_MK2',
	'WEAPON_COMBATPISTOL',
	'WEAPON_PISTOL50',
	'WEAPON_SNSPISTOL',
	'WEAPON_SNSPISTOL_MK2',
	'WEAPON_HEAVYPISTOL',
	'WEAPON_VINTAGEPISTOL',
	'WEAPON_REVOLVER',
	'WEAPON_REVOLVER_MK2',
	'WEAPON_DOUBLEACTION',
	'WEAPON_APPISTOL'
}

function releaseHostage()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

	if closestDistance ~= -1 and closestDistance <= 3 then
		local target = GetPlayerServerId(closestPlayer)

		local lib = 'reaction@shove'
		local anim1 = 'shove_var_a'
		local lib2 = 'reaction@shove'
		local anim2 = 'shoved_back'
		local distans = 0.11
		local distans2 = -0.24
		local height = 0.0
		local spin = 0.0
		local length = 100000
		local controlFlagMe = 120
		local controlFlagTarget = 0
		local animFlagTarget = 1
		local attachFlag = false

		TriggerServerEvent('cmg3_animations:sync', lib, lib2, anim1, anim2, distans, distans2, height, target, length, spin, controlFlagMe, controlFlagTarget, animFlagTarget, attachFlag)
	end
end

IsInPorter = function()
	if piggyBackInProgress == true then
		return true
	else
		return false
	end
end


RegisterNetEvent('hostage')
AddEventHandler('hostage', function()
	local plyPed = PlayerPedId()
	local currentWeapon = GetSelectedPedWeapon(plyPed)
	local canTakeHostage, foundWeapon = false, false

	ClearPedSecondaryTask(plyPed)
	DetachEntity(plyPed, true, false)

	for i = 1, #hostageAllowedWeapons do
		if currentWeapon == GetHashKey(hostageAllowedWeapons[i]) then
			canTakeHostage = true
			foundWeapon = GetHashKey(hostageAllowedWeapons[i])
		end
	end

	if not foundWeapon then
		for i = 1, #hostageAllowedWeapons do
			if HasPedGotWeapon(plyPed, hostageAllowedWeapons[i], false) then
				if GetAmmoInPedWeapon(plyPed, hostageAllowedWeapons[i]) > 0 then
					canTakeHostage = true
					foundWeapon = GetHashKey(hostageAllowedWeapons[i])
					break
				end
			end
		end
	end

	if canTakeHostage then
		if not holdingHostageInProgress then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

			if closestDistance ~= -1 and closestDistance <= 3 then
				local target = GetPlayerServerId(closestPlayer)

				if IsPlayerDead(closestPlayer) then
					ESX.ShowNotification('Vous ne pouvez prendre en otage ce joueur !')
				else
					local lib = 'anim@gangops@hostage@'
					local anim1 = 'perp_idle'
					local lib2 = 'anim@gangops@hostage@'
					local anim2 = 'victim_idle'
					local distans = 0.11
					local distans2 = -0.24
					local height = 0.0
					local spin = 0.0
					local length = 100000
					local controlFlagMe = 49
					local controlFlagTarget = 49
					local animFlagTarget = 50
					local attachFlag = true

					SetCurrentPedWeapon(plyPed, foundWeapon, true)
					holdingHostageInProgress = true
					holdingHostage = true
					TriggerServerEvent('cmg3_animations:sync', lib, lib2, anim1, anim2, distans, distans2, height, target, length, spin, controlFlagMe, controlFlagTarget, animFlagTarget, attachFlag)
				end
			else
				ESX.ShowNotification('Aucun joueur à proximité !')
			end
		end
	else
		ESX.ShowNotification("Vous avez besoin d\'un pistolet pour prendre un otage !")
	end
end)

RegisterNetEvent('cmg2_animations:syncTarget')
AddEventHandler('cmg2_animations:syncTarget', function(targetId, animationLib, animation2, distans, distans2, height, length, spin, controlFlag)
	local target = GetPlayerFromServerId(targetId)

	if target == PlayerId() or target < 1 then
		return
	end

	local plyPed = PlayerPedId()
	local targetPed = GetPlayerPed(target)

	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end

	spin = spin or 180.0

	AttachEntityToEntity(plyPed, targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)

	if controlFlag == nil then
		controlFlag = 0
	end

	TaskPlayAnim(plyPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
end)

RegisterNetEvent('cmg2_animations:syncMe')
AddEventHandler('cmg2_animations:syncMe', function(animationLib, animation, length, controlFlag, animFlag)
	local plyPed = PlayerPedId()
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Wait(10)
	end

	Wait(500)

	if controlFlag == nil then
		controlFlag = 0
	end

	TaskPlayAnim(plyPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)
	Wait(length)
end)

RegisterNetEvent('cmg2_animations:cl_stop')
AddEventHandler('cmg2_animations:cl_stop', function()
	local plyPed = PlayerPedId()
	ClearPedSecondaryTask(plyPed)
	DetachEntity(plyPed, true, false)
end)

RegisterNetEvent('cmg3_animations:syncTarget')
AddEventHandler('cmg3_animations:syncTarget', function(target, animationLib, animation2, distans, distans2, height, length, spin, controlFlag, animFlagTarget, attach)
	local plyPed = PlayerPedId()
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

	if holdingHostageInProgress then
		holdingHostageInProgress = false
	else
		holdingHostageInProgress = true
	end

	beingHeldHostage = true
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end

	if spin == nil then
		spin = 180.0
	end

	if attach then
		AttachEntityToEntity(plyPed, targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
	end

	if controlFlag == nil then
		controlFlag = 0
	end

	if animation2 == 'victim_fail' then
		SetEntityHealth(plyPed, 0)
		DetachEntity(plyPed, true, false)
		TaskPlayAnim(plyPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
		beingHeldHostage = false
		holdingHostageInProgress = false
	elseif animation2 == 'shoved_back' then
		holdingHostageInProgress = false
		DetachEntity(plyPed, true, false)
		TaskPlayAnim(plyPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
		beingHeldHostage = false
	else
		TaskPlayAnim(plyPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
	end

	takeHostageAnimNamePlaying = animation2
	takeHostageAnimDictPlaying = animationLib
	takeHostageControlFlagPlaying = controlFlag
end)

RegisterNetEvent('cmg3_animations:syncMe')
AddEventHandler('cmg3_animations:syncMe', function(animationLib, animation, length, controlFlag, animFlag)
	local plyPed = PlayerPedId()

	ClearPedSecondaryTask(plyPed)
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end

	if controlFlag == nil then
		controlFlag = 0
	end

	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)

	takeHostageAnimNamePlaying = animation
	takeHostageAnimDictPlaying = animationLib
	takeHostageControlFlagPlaying = controlFlag

	if animation == 'perp_fail' then
		SetPedShootsAtCoord(plyPed, 0.0, 0.0, 0.0, 0)
		holdingHostageInProgress = false
	elseif animation == 'shove_var_a' then
		Citizen.Wait(900)
		ClearPedSecondaryTask(plyPed)
		holdingHostageInProgress = false
	end
end)

RegisterNetEvent('cmg3_animations:cl_stop')
AddEventHandler('cmg3_animations:cl_stop', function()
	local plyPed = PlayerPedId()

	holdingHostageInProgress = false
	beingHeldHostage = false
	holdingHostage = false

	ClearPedSecondaryTask(plyPed)
	DetachEntity(plyPed, true, false)
end)

CreateThread(function()
	while true do
		local Interval = 1000
		if (holdingHostage or beingHeldHostage) and takeHostageAnimDictPlaying ~= '' and takeHostageAnimNamePlaying ~= '' then
			Interval = 0
			while not IsEntityPlayingAnim(PlayerPedId(), takeHostageAnimDictPlaying, takeHostageAnimNamePlaying, 3) do
				TaskPlayAnim(PlayerPedId(), takeHostageAnimDictPlaying, takeHostageAnimNamePlaying, 8.0, -8.0, 100000, takeHostageControlFlagPlaying, 0, false, false, false)
				Wait(0)
			end
		end

        -- if (not IsPedArmed(PlayerPedId(), 1)) and (GetSelectedPedWeapon(PlayerPedId()) ~= GetHashKey('weapon_unarmed')) then
		-- 	SetPlayerTargetingMode(3);
        --     DisableControlAction(0, 140, true); 
        --     DisableControlAction(0, 141, true);
        --     DisableControlAction(0, 142, true); 
        -- end

		Wait(Interval)
	end
end)

CreateThread(function()
	while true do
		local Interval = 1000
		if piggyBackInProgress then
			Interval = 0
			DisableControlAction(0, 21, true) -- INPUT_SPRINT
			DisableControlAction(2, 37, true) -- INPUT_weapon
			DisableControlAction(0, 22, true) -- INPUT_JUMP
			DisableControlAction(0, 24, true) -- INPUT_ATTACK
			DisableControlAction(0, 44, true) -- INPUT_COVER
			DisableControlAction(0, 45, true) -- INPUT_RELOAD
			DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
			DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
			DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
			DisableControlAction(0, 143, true) -- INPUT_MELEE_BLOCK
			DisableControlAction(0, 144, true) -- PARACHUTE DEPLOY
			DisableControlAction(0, 145, true) -- PARACHUTE DETACH
			DisableControlAction(0, 243, true) -- INPUT_ENTER_CHEAT_CODE
			DisableControlAction(0, 257, true) -- INPUT_ATTACK2
			DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
			DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
			DisableControlAction(0, 73, true) -- INPUT_X
		end

		Wait(Interval)
	end
end)

local function AddLongString(txt)
	for i = 100, string.len(txt), 99 do
		local sub = string.sub(txt, i, i + 99)
		AddTextComponentSubstringPlayerName(sub)
	end
end

function FloatingHelpText(text, sound, loop)
	BeginTextCommandDisplayHelp("jamyfafi")
	AddTextComponentSubstringPlayerName(text)
	if string.len(text) > 99 then
		AddLongString(text)
	end
	EndTextCommandDisplayHelp(0, loop or 0, sound or true, -1)
end

RegisterCommand('porter', function()

	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

	if (IsPedInAnyVehicle(PlayerPedId())) then return ESX.ShowNotification("Vous ne pouvez pas faire ceci en voiture"); end
	
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

	if closestDistance ~= -1 and closestDistance <= 3 then
		if (holdingHostage) then return; end
		if (beingHeldHostage) then return; end
		if (holdingHostageInProgress) then return; end

		local plyPed = PlayerPedId()
		if not (SafeZone:playerIsIn())then
			if not (IsCuffed) then
				if not piggyBackInProgress and not exports.Gamemode:IsInTrunk() then

					if isDead == false then
						piggyBackInProgress = true
						local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		
						if closestDistance ~= -1 and closestDistance <= 3 then
							local target = GetPlayerServerId(closestPlayer)
		
							local lib = 'anim@arena@celeb@flat@paired@no_props@'
							local anim1 = 'piggyback_c_player_a'
							local anim2 = 'piggyback_c_player_b'
							local distans = -0.07
							local distans2 = 0.0
							local height = 0.45
							local length = 100000
							local spin = 0.0
							local controlFlagMe = 49
							local controlFlagTarget = 33
							local animFlagTarget = 1
		
							TriggerServerEvent('cmg2_animations:sync', lib, anim1, anim2, distans, distans2, height, target, length, spin, controlFlagMe, controlFlagTarget, animFlagTarget)
						end
					end
				else
					ESX.ShowNotification("Vous ne pouvez pas faire cela en etant porter.")
			end
				else
				ESX.ShowNotification("Vous ne pouvez pas faire cela en etant menotter.")
			end
		else
			ESX.ShowNotification("Vous ne pouvez pas porter en SafeZone")
		end
	else
		ESX.ShowNotification('Aucun joueur à proximité !')
	end
end)

RegisterCommand('otage', function()

	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

	if not (IsCuffed) then
		-- if isDead == false then
			if not (SafeZone:playerIsIn())then
				if (IsPedInAnyVehicle(PlayerPedId())) then return ESX.ShowNotification("Vous ne pouvez pas faire ceci en voiture"); end
				if (closestDistance ~= -1 and closestDistance >= 3) then return ESX.ShowNotification("Aucun joueur à proximité"); end
				if (piggyBackInProgress) then return; end
				if (beingHeldHostage) then return; end
				TriggerEvent('hostage');
			else
				ESX.ShowNotification("Pas en safe zone !")
			end
		-- else
		-- 	ESX.ShowNotification('Action impossible dans le coma !')
		-- end
	else
		ESX.ShowNotification('Action impossible en étant menotter')
	end
end)

local function StopSynced(closestPlayer, isOnGround, z, vehicle)
	piggyBackInProgress = false
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
	local target = GetPlayerServerId(closestPlayer);
	if (vehicle or isOnGround) then
		TriggerServerEvent('cmg2_animations:stop', target, 1, z);
	else
		TriggerServerEvent('cmg2_animations:stop', target, 0, z);
	end
end

CreateThread(function()
	while true do
		local Interval = 1000

		if (piggyBackInProgress) then
			Interval = 0
			
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer();
			local ped = PlayerPedId();

			local coords = GetEntityCoords(ped);
			local _, z = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, true, false);
			local isOnGround = coords.z - z < 5.0 and coords.z - z > -5.0;

			if (IsPedInAnyVehicle(ped)) then StopSynced(closestPlayer, isOnGround, z, true); end

			if closestDistance ~= -1 and closestDistance <= 3 then

				FloatingHelpText("Appuyez sur ~INPUT_CONTEXT~ pour lacher l'individue.", true);
				if (IsControlJustPressed(0, 51) or IsDisabledControlPressed(0, 51)) then
					StopSynced(closestPlayer, isOnGround, z);
				end
				
			else
				StopSynced(closestPlayer, isOnGround, z);
			end
		end
		if (holdingHostage) then
			Interval = 0
			local plyPed = PlayerPedId()
			local plyCoords = GetEntityCoords(plyPed);
			local vehicle = GetVehiclePedIsTryingToEnter(plyPed);

			if (vehicle ~= 0) then 
				SetPlayerMayNotEnterAnyVehicle(PlayerId());
				holdingHostage = false
				holdingHostageInProgress = false

				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if closestDistance ~= -1 and closestDistance <= 3 then
					local target = GetPlayerServerId(closestPlayer)
					TriggerServerEvent('cmg3_animations:stop', target)
				end

				Citizen.Wait(100);
				releaseHostage();
			end

			if IsEntityDead(plyPed) then
				holdingHostage = false
				holdingHostageInProgress = false

				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if closestDistance ~= -1 and closestDistance <= 3 then
					local target = GetPlayerServerId(closestPlayer)
					TriggerServerEvent('cmg3_animations:stop', target)
				end

				Citizen.Wait(100)
				releaseHostage()
			end

			DisableControlAction(0, 24, true) -- disable attack
			DisableControlAction(0, 25, true) -- disable aim
			DisableControlAction(0, 47, true) -- disable weapon
			DisableControlAction(0, 58, true) -- disable weapon
			DisablePlayerFiring(plyPed, true)

			FloatingHelpText("Appuyer sur ~INPUT_CONTEXT~ pour relâcher.")
			if (IsControlJustPressed(0, 51) or IsDisabledControlPressed(0, 51)) then
				holdingHostage = false
				holdingHostageInProgress = false

				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if closestDistance ~= -1 and closestDistance <= 3 then
					local target = GetPlayerServerId(closestPlayer)
					TriggerServerEvent('cmg3_animations:stop', target)
				end

				Citizen.Wait(100)
				releaseHostage()
			end
		end

		if (beingHeldHostage) then
			Interval = 0
			DisableControlAction(0, 21, true) -- disable sprint
			DisableControlAction(0, 24, true) -- disable attack
			DisableControlAction(0, 25, true) -- disable aim
			DisableControlAction(0, 47, true) -- disable weapon
			DisableControlAction(0, 58, true) -- disable weapon
			DisableControlAction(0, 263, true) -- disable melee
			DisableControlAction(0, 264, true) -- disable melee
			DisableControlAction(0, 257, true) -- disable melee
			DisableControlAction(0, 140, true) -- disable melee
			DisableControlAction(0, 141, true) -- disable melee
			DisableControlAction(0, 142, true) -- disable melee
			DisableControlAction(0, 143, true) -- disable melee
			DisableControlAction(0, 75, true) -- disable exit vehicle
			DisableControlAction(27, 75, true) -- disable exit vehicle
			DisableControlAction(0, 22, true) -- disable jump
			DisableControlAction(0, 32, true) -- disable move up
			DisableControlAction(0, 268, true)
			DisableControlAction(0, 33, true) -- disable move down
			DisableControlAction(0, 269, true)
			DisableControlAction(0, 34, true) -- disable move left
			DisableControlAction(0, 270, true)
			DisableControlAction(0, 35, true) -- disable move right
			DisableControlAction(0, 271, true)
		end

		Wait(Interval)
	end
end)

exports("IsInPorter", function()
	return piggyBackInProgress
end)

exports("IsInOtage", function()
	return holdingHostageInProgress
end)

function _DeleteEntity(entity)
	Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(entity))
end

carblacklist = {
	"rhino",
	"lazer",
	"besra",
	"titan",
}

CreateThread(function()
	while true do
		Wait(15000)

		playerPed = PlayerPedId()
		if playerPed then
			checkCar(GetVehiclePedIsIn(playerPed, false))
		end
	end
end)

function checkCar(car)
	if car then
		carModel = GetEntityModel(car)
		carName = GetDisplayNameFromVehicleModel(carModel)

		if isCarBlacklisted(carModel) then
			_DeleteEntity(car)
		end
	end
end

function isCarBlacklisted(model)
	for _, blacklistedCar in pairs(carblacklist) do
		if model == GetHashKey(blacklistedCar) then
			return true
		end
	end

	return false
end

local vehicleForBenny = {
	"flatbed",
	"flatbed3",
	"flatbed2",
}

AddEventHandler("gameEventTriggered", function(name, args)
	if name == "CEventNetworkPlayerEnteredVehicle" then
		if (args[1] == PlayerId()) then
			local ped = PlayerPedId();
			local veh = GetVehiclePedIsIn(ped, false);
			local playerVehBenny = veh ~= 0 and veh or false;
			if (args[2] == playerVehBenny) then
				local playerData = ESX.GetPlayerData()
				for i = 1, #vehicleForBenny,1 do
					if IsVehicleModel(GetVehiclePedIsIn(PlayerPedId(), true), GetHashKey(vehicleForBenny[i])) then
						if (GetPedInVehicleSeat(playerVehBenny, -1) == ped) then
							if playerData.job ~= nil and playerData.job.name == 'mecano' or playerData.job.name == 'mecano2' then
								SetVehicleUndriveable(playerVehBenny, false)
							else
								ESX.ShowNotification("Un système de sécurité t'empêche de démarrer")
								while (GetVehiclePedIsIn(ped, false) ~= 0 and GetVehiclePedIsIn(ped, false) == playerVehBenny) do
									local LOOP_INTERVAL = 0
									SetVehicleUndriveable(playerVehBenny, true)
									Wait(LOOP_INTERVAL)
								end
							end
						end
					end
				end
			end
		end
	end
end)

local vehicle = {
	"riot",
	"ambulance",
	"emsstalker",
	"ambulance2",
	"polalamor",
	"polalamor2",
	"polbisonr",
	"polbuffalor",
	"polbuffalor2",
	"polcarar",
	"polcoquetter",
	"poldmntr",
	"polfugitiver",
	"rmodrs6police",
	"polgresleyr",
	"polscoutr",
	"polspeedor",
	"polstalkerr",
	"polstanierr",
	"poltorencer", --
	"apoliceu14",
	"apoliceu15",
	"apoliceu9",
	"lspdbuffalostxum",
	"lspdbuffsumk",
	"cat",
	"halfback",
	"hazard2",
	"inaugural2",
	"roadrunner",
	"roadrunner2",
	"ussssuv2",
	"usssvan2",
	"watchtower2",
	"police6f",
	"polalamo",
	"polalamonew",
	"polthrust",
	"lspdcara",
	"police2b",
	"LSPDbus",
	"LSPDraiden",
	"LSPDscorcher",
	"LSPDtorrence",
	"LSPDumkscoutgnd",
	"LSPDumktorrence",

	
	----POLICE
	'LSPDscorcher',
	'nkcruiser',
	'nkbuffalos',
	'nkstx',
	'nktorrence',
	'code3bmw',
	'nkscout',
	'nkfugitive',
	'nkgranger2',
	'lspdbuffsumk',
	'lspdbuffalostxum',
	'poltaxi',
	'LSPDbus',
	'riot',
	'nkcaracara2',
	'nkcoquette',
	'nkomnisegt',
}

AddEventHandler("gameEventTriggered", function(name, args)
	if name == "CEventNetworkPlayerEnteredVehicle" then
		if (args[1] == PlayerId()) then
			local ped = PlayerPedId();
			local veh = GetVehiclePedIsIn(ped, false);
			local playerVeh = veh ~= 0 and veh or false;
			if (args[2] == playerVeh) then
				local playerData = ESX.GetPlayerData()
				for i = 1, #vehicle,1 do
					if IsVehicleModel(GetVehiclePedIsIn(PlayerPedId(), true), GetHashKey(vehicle[i])) then
						if (GetPedInVehicleSeat(playerVeh, -1) == ped) then
							if playerData.job ~= nil and playerData.job.name == 'police' or playerData.job.name == 'ambulance' or playerData.job.name == 'bcso' or playerData.job.name == 'gouv' or playerData.job.name == 'fib' then
								SetVehicleUndriveable(playerVeh, false)
							else
								ESX.ShowNotification("Un système de sécurité t'empêche de démarrer")
								while (GetVehiclePedIsIn(ped, false) ~= 0 and GetVehiclePedIsIn(ped, false) == playerVeh) do
									local LOOP_INTERVAL = 0
									SetVehicleUndriveable(playerVeh, true)
									Wait(LOOP_INTERVAL)
								end
							end
						end
					end
				end
			end
		end
	end
end)

CreateThread(function()
    local hash = GetHashKey("a_m_m_eastsa_02")
    while not HasModelLoaded(hash) do
		RequestModel(hash)
		Wait(20)
    end
    ped = CreatePed(1, "a_m_m_eastsa_02", -1024.398, -1526.952, 4.594745, 322.353, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
end)