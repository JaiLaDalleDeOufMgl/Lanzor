
function SetWeaponDrops()
	local handle, ped = FindFirstPed()
	local finished = false

	repeat
		if not IsEntityDead(ped) then
			SetPedDropsWeaponsWhenDead(ped, false)
		end
		finished, ped = FindNextPed(handle)
	until not finished

	EndFindPed(handle)
end

CreateThread(function()
	while true do
        SetWeaponDrops()
		NetworkSetFriendlyFireOption(true)
		SetCanAttackFriendly(PlayerPedId(), true, true)
	
		SetPedConfigFlag(PlayerPedId(), 149, true)
		SetPedConfigFlag(PlayerPedId(), 438, true)
		ClearPlayerWantedLevel(GetPlayerIndex())
		RemoveAllPickupsOfType(0xDF711959) -- carbine rifle
    	RemoveAllPickupsOfType(0xF9AFB48F) -- pistol
		RemoveAllPickupsOfType(0xA9355DCD) -- pumpshotgun
		DisablePlayerVehicleRewards(PlayerId())

		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.35)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_KNUCKLE"), 0.45)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"), 0.40)
		RestorePlayerStamina(PlayerId(), 1.0)

		SetPedSuffersCriticalHits(PlayerPedId(), false)
		Wait(2000)
	end

    SetFlashLightKeepOnWhileMoving(true)
    SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
    SetSwimMultiplierForPlayer(PlayerId(), 1.0)
    SetAmbientZoneStatePersistent("collision_ybmrar", false, true)
    SetWeaponsNoAutoswap(1)
end)

Citizen.CreateThread(function()
    SetWeaponsNoAutoswap(true)
end)

local scenarios = {
    'WORLD_VEHICLE_ATTRACTOR',
    'WORLD_VEHICLE_AMBULANCE',
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

local ListVehicleBlacklistPNJ = {
    'armytanker',
    'armytrailer',
    'armytrailer2',
    'baletrailer',
    'boattrailer',
    'cablecar',
    'docktrailer',
    'freighttrailer',
    'graintrailer',
    'proptrailer',
    'raketrailer',
    'tr2',
    'tr3',
    'tr4',
    'trflat',
    'tvtrailer',
    'tanker',
    'tanker2',
    'trailerlarge',
    'trailerlogs',
    'trailersmall',
    'trailers',
    'trailers2',
    'trailers3',
    'trailers4',
    'airbus',
    'freight',
    'freightcar',
    'freightcont1',
    'freightcont2',
    'freightgrain',
    'metrotrain',
    'tankercar',
    'tug',
    'submersible',
    'submersible2',
    'lazer',
    'cargobob',
    'buzzard',
    'blimp',
    'blimp2',
    'blimp3',
}

CreateThread(function()
    while true do
        Wait(1)

        -- descativer les tete
        SetPedSuffersCriticalHits(PlayerPedId(),false)

        HideHudComponentThisFrame(3)        --CASH
        HideHudComponentThisFrame(4)        --MP_CASH
        HideHudComponentThisFrame(6)        --VEHICLE_NAME
        HideHudComponentThisFrame(7)        --AREA_NAME
        HideHudComponentThisFrame(9)        --STREET_NAME
        HideHudComponentThisFrame(8)       --VEHICLE_NAME
        HideHudComponentThisFrame(13)       --CASH_CHANGE

        -- -- Gestion NPC
        -- local npvehMultiplier   = 0.1
        -- local pvehMultiplier    = 0.1

        local DensityMultiplier2 = 0.2
	    SetPedDensityMultiplierThisFrame(DensityMultiplier2)
	    SetScenarioPedDensityMultiplierThisFrame(DensityMultiplier2, DensityMultiplier2)
        
        -- SetVehicleDensityMultiplierThisFrame(npvehMultiplier)
        -- SetRandomVehicleDensityMultiplierThisFrame(npvehMultiplier)
        -- SetParkedVehicleDensityMultiplierThisFrame(pvehMultiplier)

        -- Désactive les gains des voiture
        -- DisablePlayerVehicleRewards(PlayerId())

        --Liste des dispatchService sur FivemNative description de la native (EnableDispatchService)
        for dispatchService = 1, 15 do
            EnableDispatchService(dispatchService, false)
        end
        
        -- Désactiver la police 
        -- local myPed = GetPlayerPed(-1)
        -- local myPedCoord = GetEntityCoords(myPed)
        -- ClearAreaOfCops(myPedCoord.x, myPedCoord.y, myPedCoord.z, 100.0)
    end
end)


DisableVehicleDistantlights(true)
SetPedPopulationBudget(3) -- 0 - 3
SetVehiclePopulationBudget(0) -- 0 - 3
SetRandomEventFlag(false)

-- Supposedly disables all vehicles 
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