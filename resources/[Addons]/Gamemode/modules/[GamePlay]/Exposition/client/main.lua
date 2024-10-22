local LesVoitureSontSpawn = false
local VehicleSpawned = {}
local ExpositionConcess = {
    {model = 'argento', position = vector3(-794.72, -228.08, 37.16)},
    {model = 'revolter', position = vector3(-790.55, -235.71, 37.16)},
    {model = 'cliffhanger', position = vector3(-786.25, -243.17, 37.16)},
    {model = 'streiter2', position = vector3(-803.17, -214.53, 37.16)},
    {model = 'sunrise1', position = vector3(-769.84, -234.08, 41.99)},
    {model = 'scharmann', position = vector3(-774.40, -225.93, 41.99)},
    {model = 'sultanrs', position = vector3(-778.26, -218.91, 41.99)},
    {model = 'astron', position = vector3(-782.07, -212.26, 41.99)},
    {model = 'thrax', position = vector3(-805.71, -201.09, 37.16)}
}

Citizen.CreateThread(function()
    while not ESXLoaded do Wait(1) end
    while true do
        local isProche = false
            local dist = Vdist2(GetEntityCoords(PlayerPedId(), false), vector3(-794.72, -228.08, 37.16))

            if dist < 1500 then
                if not LesVoitureSontSpawn then 
                    LesVoitureSontSpawn = true
                    for k,v in pairs(ExpositionConcess) do 
                        ESX.Game.SpawnLocalVehicle(v.model, v.position, 304.51, function(vehicle)
                            FreezeEntityPosition(vehicle, true)
                            SetVehicleDoorsLocked(vehicle, 2)
                            SetEntityInvincible(vehicle, true)
                            SetVehicleFixed(vehicle)
                            SetVehicleDirtLevel(vehicle, 0.0)
                            SetVehicleEngineOn(vehicle, true, true, true)
                            SetVehicleLights(vehicle, 2)
                            SetVehicleCustomPrimaryColour(vehicle, 33,33,33)
                            SetVehicleCustomSecondaryColour(vehicle, 33,33,33)
                            table.insert(VehicleSpawned, {model = vehicle})
                        end)
                    end
                end
                isProche = true
            end
            if dist > 1500 and dist < 1600 then 
                for k,v in pairs(VehicleSpawned) do 
                    if DoesEntityExist(v.model) then
                        DeleteEntity(v.model)
                        LesVoitureSontSpawn = false
                        -- print(v.model..' despawn')
                    end
                end
            end
		if isProche then
			Wait(0)
		else
			Wait(2000)
		end
	end
end)