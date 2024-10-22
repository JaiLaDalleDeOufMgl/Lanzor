local isLoadoutLoaded, isPaused, isPlayerSpawned, isDead, pickups, IsInPVP = false, false, false, false, {}, false;

ESX.UI = {}
ESX.UI.HUD = {}

CreateThread(function()
    StartAudioScene('CHARACTER_CHANGE_IN_SKY_SCENE')
    SetAudioFlag("PoliceScannerDisabled", true)
end)


CreateThread(function()
	SetGarbageTrucks(0)
	SetRandomBoats(0)
	SetRandomTrains(0)
	SetRelationshipBetweenGroups(0, GetHashKey("CIVMALE"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("CIVFEMALE"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("SECURITY_GUARD"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("PRIVATE_SECURITY"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("DEALER"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("HATES_PLAYER"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("HEN"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("WILD_ANIMAL"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("SHARK"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("COUGAR"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("SPECIAL"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("MISSION2"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("MISSION3"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("MISSION4"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("MISSION5"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("MISSION6"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("MISSION7"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("MISSION8"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("ARMY"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("GUARD_DOG"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("AGGRESSIVE_INVESTIGATE"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("CAT"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("COP"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("MEDIC"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("FIREMAN"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("GANG_1"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("GANG_2"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("GANG_9"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("GANG_10"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("AMBIENT_GANG_LOST"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("AMBIENT_GANG_MEXICAN"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("AMBIENT_GANG_FAMILY"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("AMBIENT_GANG_BALLAS"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("AMBIENT_GANG_MARABUNTE"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("AMBIENT_GANG_CULT"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("AMBIENT_GANG_SALVA"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("AMBIENT_GANG_WEICHENG"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("AMBIENT_GANG_HILLBILLY"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(0, GetHashKey("PRISONER"), GetHashKey("PLAYER"))
end)

local scenarios = {
    'WORLD_VEHICLE_ATTRACTOR',
    'WORLD_VEHICLE_AMBULANCE',
    'WORLD_VEHICLE_BICYCLE_BMX',
    'WORLD_VEHICLE_BICYCLE_BMX_BALLAS',
    'WORLD_VEHICLE_BICYCLE_BMX_FAMILY',
    'WORLD_VEHICLE_BICYCLE_BMX_HARMONY',
    'WORLD_VEHICLE_BICYCLE_BMX_VAGOS',
    'WORLD_VEHICLE_BICYCLE_MOUNTAIN',
    'WORLD_VEHICLE_BICYCLE_ROAD',
    'WORLD_VEHICLE_BIKE_OFF_ROAD_RACE',
    'WORLD_VEHICLE_BIKER',
    'WORLD_VEHICLE_BOAT_IDLE',
    'WORLD_VEHICLE_BOAT_IDLE_ALAMO',
    'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',
    'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',
    'WORLD_VEHICLE_BROKEN_DOWN',
    'WORLD_VEHICLE_BUSINESSMEN',
    'WORLD_VEHICLE_HELI_LIFEGUARD',
    'WORLD_VEHICLE_CLUCKIN_BELL_TRAILER',
    'WORLD_VEHICLE_CONSTRUCTION_SOLO',
    'WORLD_VEHICLE_CONSTRUCTION_PASSENGERS',
    'WORLD_VEHICLE_DRIVE_PASSENGERS',
    'WORLD_VEHICLE_DRIVE_PASSENGERS_LIMITED',
    'WORLD_VEHICLE_DRIVE_SOLO',
    'WORLD_VEHICLE_FIRE_TRUCK',
    'WORLD_VEHICLE_EMPTY',
    'WORLD_VEHICLE_MARIACHI',
    'WORLD_VEHICLE_MECHANIC',
    'WORLD_VEHICLE_MILITARY_PLANES_BIG',
    'WORLD_VEHICLE_MILITARY_PLANES_SMALL',
    'WORLD_VEHICLE_PARK_PARALLEL',
    'WORLD_VEHICLE_PARK_PERPENDICULAR_NOSE_IN',
    'WORLD_VEHICLE_PASSENGER_EXIT',
    'WORLD_VEHICLE_POLICE_BIKE',
    'WORLD_VEHICLE_POLICE_CAR',
    'WORLD_VEHICLE_POLICE',
    'WORLD_VEHICLE_POLICE_NEXT_TO_CAR',
    'WORLD_VEHICLE_QUARRY',
    'WORLD_VEHICLE_SALTON',
    'WORLD_VEHICLE_SALTON_DIRT_BIKE',
    'WORLD_VEHICLE_SECURITY_CAR',
    'WORLD_VEHICLE_STREETRACE',
    'WORLD_VEHICLE_TOURBUS',
    'WORLD_VEHICLE_TOURIST',
    'WORLD_VEHICLE_TANDL',
    'WORLD_VEHICLE_TRACTOR',
    'WORLD_VEHICLE_TRACTOR_BEACH',
    'WORLD_VEHICLE_TRUCK_LOGS',
    'WORLD_VEHICLE_TRUCKS_TRAILERS',
    'WORLD_VEHICLE_DISTANT_EMPTY_GROUND'
  }

for i, v in ipairs(scenarios) do
    SetScenarioTypeEnabled(v, false)
end

local numbers = 0.2

local areaCleared = {
	{coords = vector3(321.48, -2029.72, 20.76), radius = 50.0},
	{coords = vector3(963.2, -135.56, 74.4), radius = 50.0},
	{coords = vector3(225.63, -785.830, 30.87), radius = 50.0},
	{coords = vector3(-2031.09, 3145.10, 32.81), radius = 50.0},
	{coords = vector3(-2130.08, 3257.94, 32.81), radius = 50.0},
	{coords = vector3(-2181.67, 3185.35, 32.81), radius = 50.0},
	{coords = vector3(-2284.56, 3183.05, 32.80), radius = 50.0},
	{coords = vector3(-2241.43, 3242.48, 32.81), radius = 50.0},
	{coords = vector3(-1995.55, 3061.22, 32.81), radius = 50.0},
	{coords = vector3(-2008.47, 2954.21, 32.80), radius = 50.0},
	{coords = vector3(-2139.84, 3031.79, 32.81), radius = 50.0},
	{coords = vector3(-1091.87, -835.80, 19.00), radius = 50.0},
	{coords = vector3(-1075.90, -826.58, 5.47), radius = 50.0},
	{coords = vector3(306.00, -589.16, 57.72), radius = 50.0},
	{coords = vector3(-204.32, -1333.83, 34.86), radius = 20.0},
	{coords = vector3(-1134.72, -2876.73, 13.94), radius = 30.0},
	{coords = vector3(-729.45, -1471.039, 5.00), radius = 40.0},
	{coords = vector3(-473.89, 5990.47, 31.33), radius = 30.0},
	{coords = vector3(-6.28, -1840.38, 23.79), radius = 20.0},
	{coords = vector3(220.53, 210.11, 104.50), radius = 30.0},
	{coords = vector3(-547.35, -186.71, 41.03), radius = 50.0},
	{coords = vector3(-2970.34,483.89,15.79), radius = 20.0},
	{coords = vector3(-2970.34,483.89,15.79), radius = 20.0},
}

local players = 0

RegisterNetEvent("players:update")
AddEventHandler("players:update", function(nbPlayerTotal)
	players = nbPlayerTotal
end)

CreateThread(function()
    while true do -- OPTIMIZED
		local pPed = PlayerPedId()
        local pCoords = GetEntityCoords(pPed)

		if players < 150 then
            numbers = 0.01
        end

		if players >= 150 then
            numbers = 0.0
        end

        for i = 1, #areaCleared, 1 do
			if #(pCoords - areaCleared[i].coords) < 100 then
				ClearAreaOfVehicles(areaCleared[i].coords, areaCleared[i].radius, false, false, false, false, false)
				ClearAreaOfPeds(areaCleared[i].coords, areaCleared[i].radius, 1)
			end
		end

        Wait(3000)
    end
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)

	ESX.PlayerLoaded = true;
	ESX.PlayerData = xPlayer;

end);

RegisterNetEvent('esx:setMaxWeight')
AddEventHandler('esx:setMaxWeight', function(newMaxWeight)
	ESX.PlayerData.maxWeight = newMaxWeight
end)

AddEventHandler('playerSpawned', function(spawn, isFirstSpawn)
	while not ESX.PlayerLoaded do
		Citizen.Wait(10)
	end

	TriggerEvent('esx:restoreLoadout')

	if (isFirstSpawn) then
		TriggerServerEvent('esx:positionSaveReady');
	end

	isLoadoutLoaded, isPlayerSpawned, isDead = true, true, false
	SetCanAttackFriendly(PlayerPedId(), true, true)
	NetworkSetFriendlyFireOption(true)
end)

AddEventHandler('esx:onPlayerDeath', function()
	isDead = true 
	TriggerServerEvent('ambulance:setDeathStatus', 1)
end)
AddEventHandler('skinchanger:loadDefaultModel', function() isLoadoutLoaded = false end)

local function restoreLoadout()

	RemoveAllPedWeapons(PlayerPedId());

	isLoadoutLoaded = true;
end

AddEventHandler('esx:restoreLoadout', restoreLoadout);

AddEventHandler('skinchanger:modelLoaded', function()
	while not ESX.PlayerLoaded do
		Wait(1)
	end

	restoreLoadout();
end);

RegisterNetEvent("esx:refreshLoadout", function(playerLoadout, playerAmmo)

	ESX.PlayerData.loadout = playerLoadout;
	ESX.PlayerData.ammo = playerAmmo;
	restoreLoadout();
end);

AddEventHandler("JustGod:Gamemode:pvpModeUpdated", function(inPVP)
    IsInPVP = inPVP;
end);

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	for i = 1, #ESX.PlayerData.accounts, 1 do
		if ESX.PlayerData.accounts[i].name == account.name then
			ESX.PlayerData.accounts[i] = account
			break
		end
	end

	ESX.UI.HUD.UpdateElement('account_' .. account.name, {
		money = ESX.Math.GroupDigits(account.money)
	});
end)

RegisterNetEvent('esx:addInventoryItem')
AddEventHandler('esx:addInventoryItem', function(item)
	ESX.UI.ShowInventoryItemNotification(true, item.label, item.count)
	table.insert(ESX.PlayerData.inventory, item)
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(item, identifier)
	for i = 1, #ESX.PlayerData.inventory, 1 do
		if ESX.PlayerData.inventory[i].name == item.name and (not identifier or (item.unique and ESX.PlayerData.inventory[i].extra.identifier and ESX.PlayerData.inventory[i].extra.identifier == identifier)) then
			ESX.UI.ShowInventoryItemNotification(false, item.label, item.count)
			table.remove(ESX.PlayerData.inventory, i)
			break
		end
	end
end)

RegisterNetEvent('esx:updateItemCount', function(itemName, count)
	for i = 1, #ESX.PlayerData.inventory, 1 do
		if ESX.PlayerData.inventory[i].name == itemName then

			local itemCount = ESX.PlayerData.inventory[i].count

			ESX.UI.ShowInventoryItemNotification(itemCount > count, ESX.PlayerData.inventory[i].label, add and (count - ESX.PlayerData.inventory[i].count) or (ESX.PlayerData.inventory[i].count - count))
			ESX.PlayerData.inventory[i].count = count
			break
		end
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job

	Citizen.Wait(1000)
	TriggerServerEvent('verifPossible', job.label)

	ESX.UI.HUD.UpdateElement('job', {
		job_label = job.label,
		grade_label = job.grade_label
	})
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	ESX.PlayerData.job2 = job2

	Citizen.Wait(1000)
	TriggerServerEvent('verifPossible2', job2.label)

	ESX.UI.HUD.UpdateElement('job2', {
		job2_label = job2.label,
		grade2_label = job2.grade_label
	})
end)

RegisterNetEvent('esx:setGroup')
AddEventHandler('esx:setGroup', function(group, lastGroup)
	ESX.PlayerData.group = group
	TriggerServerEvent("esx:receivedGroup");
end)

RegisterNetEvent('esx:addWeapon')
AddEventHandler('esx:addWeapon', function(weaponName, weaponAmmo)
	local found = false

	local weaponType = ESX.GetWeaponType(weaponName);

	for i = 1, #ESX.PlayerData.loadout, 1 do
		if ESX.PlayerData.loadout[i].name == weaponName then
			found = true
			break
		end
	end

	if not found then
		local playerPed = PlayerPedId()
		local weaponHash = GetHashKey(weaponName)
		local weaponLabel = ESX.GetWeaponLabel(weaponName)
		ESX.UI.ShowInventoryItemNotification(true, weaponLabel, false)

		table.insert(ESX.PlayerData.loadout, {
			name = weaponName,
			label = weaponLabel,
			components = {}
		})

		GiveWeaponToPed(playerPed, weaponHash, 0, false, false);

		if (weaponType) then

			ESX.PlayerData.ammo[weaponType] = weaponAmmo;
			SetPedAmmo(playerPed, weaponHash, weaponAmmo);

		else
			SetPedAmmo(playerPed, weaponHash, 0);
		end
	end
end)

RegisterNetEvent('esx:addWeaponComponent')
AddEventHandler('esx:addWeaponComponent', function(weaponName, weaponComponent)
	for i = 1, #ESX.PlayerData.loadout, 1 do
		if ESX.PlayerData.loadout[i].name == weaponName then
			local component = ESX.GetWeaponComponent(weaponName, weaponComponent)

			if component then
				local found = false

				for j = 1, #ESX.PlayerData.loadout[i].components, 1 do
					if ESX.PlayerData.loadout[i].components[j] == weaponComponent then
						found = true
						break
					end
				end

				if not found then
					local playerPed = PlayerPedId()
					local weaponHash = GetHashKey(weaponName)

					ESX.UI.ShowInventoryItemNotification(true, component.label, false)
					table.insert(ESX.PlayerData.loadout[i].components, weaponComponent)
					GiveWeaponComponentToPed(playerPed, weaponHash, component.hash)
				end
			end
		end
	end
end)

RegisterNetEvent('esx:setWeaponAmmo', function(weaponName, weaponAmmo)

	local weaponType = ESX.GetWeaponType(weaponName);

	if (weaponType) then

		ESX.PlayerData.ammo[weaponType] = weaponAmmo;
		SetPedAmmo(PlayerPedId(), GetHashKey(weaponName), weaponAmmo);

	end

end)

RegisterNetEvent('esx:removeWeapon')
AddEventHandler('esx:removeWeapon', function(weaponName, ammo)
	for i = 1, #ESX.PlayerData.loadout, 1 do
		if ESX.PlayerData.loadout[i].name == weaponName then
			local weaponType = ESX.GetWeaponType(weaponName);
			local playerPed = PlayerPedId()
			local weaponHash = GetHashKey(weaponName)
			local weaponLabel = ESX.GetWeaponLabel(weaponName)

			ESX.UI.ShowInventoryItemNotification(false, weaponLabel, false)
			table.remove(ESX.PlayerData.loadout, i)

			if (ammo) then

				if (weaponType) then

					ESX.PlayerData.ammo[weaponType] = ammo;
					SetPedAmmo(playerPed, weaponHash, ammo);

				else

					SetPedAmmo(playerPed, weaponHash, 0);

				end

			else
				SetPedAmmo(playerPed, weaponHash, 0);
			end

			break
		end
	end
end)

RegisterNetEvent('esx:removeWeaponComponent')
AddEventHandler('esx:removeWeaponComponent', function(weaponName, weaponComponent)
	for i = 1, #ESX.PlayerData.loadout, 1 do
		if ESX.PlayerData.loadout[i].name == weaponName then
			local component = ESX.GetWeaponComponent(weaponName, weaponComponent)

			if component then
				for j = 1, #ESX.PlayerData.loadout[i].components, 1 do
					if ESX.PlayerData.loadout[i].components[j] == weaponComponent then
						local playerPed = PlayerPedId()
						local weaponHash = GetHashKey(weaponName)

						ESX.UI.ShowInventoryItemNotification(false, component.label, false)
						table.insert(ESX.PlayerData.loadout[i].components, j)
						RemoveWeaponComponentFromPed(playerPed, weaponHash, component.hash)
						break
					end
				end
			end
		end
	end
end)

-- Commands
RegisterNetEvent('esx:teleport')
AddEventHandler('esx:teleport', function(coords)
	ESX.Game.Teleport(PlayerPedId(), coords)
end)


RegisterNetEvent("JustGod:CanFight", function(canFight)
	ESX.PlayerData.canFight = canFight;
end);


RegisterNetEvent('esx:spawnVehicle')
AddEventHandler('esx:spawnVehicle', function(model)
	----BAH ALORS MEC
	while true do end
end)

-- RegisterNetEvent('esx:spawnVehicle')
-- AddEventHandler('esx:spawnVehicle', function(model)
-- 	model = (type(model) == 'number' and model or GetHashKey(model))

-- 	if IsModelInCdimage(model) then
-- 		local playerPed = PlayerPedId()
-- 		local plyCoords = GetEntityCoords(playerPed)

-- 		ESX.Game.SpawnVehicle(model, plyCoords, 90.0, function(vehicle)
-- 			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
-- 		end)
-- 	else
-- 		TriggerEvent('chat:addMessage', { args = { '^1SYSTEM', 'Invalid vehicle model.' } })
-- 	end
-- end)

RegisterNetEvent('esx:deleteVehicle')
AddEventHandler('esx:deleteVehicle', function(radius)
	local playerPed = PlayerPedId()

	if radius and tonumber(radius) then
		radius = tonumber(radius) + 0.01
		local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(playerPed, false), radius)

		for i = 1, #vehicles, 1 do
			local attempt = 0

			while not NetworkHasControlOfEntity(vehicles[i]) and attempt < 100 and DoesEntityExist(vehicles[i]) do
				Citizen.Wait(100)
				NetworkRequestControlOfEntity(vehicles[i])
				attempt = attempt + 1
			end

			if DoesEntityExist(vehicles[i]) and NetworkHasControlOfEntity(vehicles[i]) then
				ESX.Game.DeleteVehicle(vehicles[i])
			end
		end
	else
		local vehicle, attempt = ESX.Game.GetVehicleInDirection(), 0

		if IsPedInAnyVehicle(playerPed, true) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		end

		while not NetworkHasControlOfEntity(vehicle) and attempt < 100 and DoesEntityExist(vehicle) do
			Citizen.Wait(100)
			NetworkRequestControlOfEntity(vehicle)
			attempt = attempt + 1
		end

		if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
			ESX.Game.DeleteVehicle(vehicle)
		end
	end
end)


-- Last position
CreateThread(function()
	while true do -- OPTIMIZED
		Wait(1500)

		local playerPed = PlayerPedId()

		if ESX.PlayerLoaded and isPlayerSpawned then
			if not IsEntityDead(playerPed) then
				ESX.PlayerData.lastPosition = GetEntityCoords(playerPed, false)
			end
		end

		if IsEntityDead(playerPed) and isPlayerSpawned then
			isPlayerSpawned = false
		end
	end
end)


CreateThread(function()
	while not ESX.PlayerLoaded do
		Wait(10)
	end

	local playerPed = PlayerPedId()

	if playerPed and playerPed ~= -1 then
		while GetResourceState('Gamemode') ~= 'started' do
			Wait(10)
		end

		TriggerEvent('spawnmanager:spawnPlayer', {
			model = GetHashKey("mp_m_freemode_01"),
			coords = ESX.PlayerData.lastPosition,
			heading = 0.0
		})

		return
	end
end)

CreateThread(function()
	while true do
		Wait(0)

		if NetworkIsSessionStarted() then
			TriggerServerEvent('esx:firstJoinProper')
			return
		end
	end
end)

------------------------------------COUP DE CROSS
CreateThread(function()
    while true do
		local interval = 1000

        if (not IsPedArmed(PlayerPedId(), 1)) and (GetSelectedPedWeapon(PlayerPedId()) ~= GetHashKey('weapon_unarmed')) then
			interval = 0

			SetPlayerTargetingMode(3);
            DisableControlAction(0, 140, true); 
            DisableControlAction(0, 141, true);
            DisableControlAction(0, 142, true); 
        end
		
        Wait(interval)
    end
end)
