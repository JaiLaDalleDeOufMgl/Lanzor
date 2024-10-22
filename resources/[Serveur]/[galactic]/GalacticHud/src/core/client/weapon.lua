local CurrentWeapon = {}

RegisterNetEvent('Gamemode:Inventory:WeaponSet')
AddEventHandler('Gamemode:Inventory:WeaponSet', function(data)
    CurrentWeapon = data
end)


local QueueSaveAmmo = {}

local WaitShoot = false
AddEventHandler('CEventGunShot', function(entities, eventEntity, args)
    if (eventEntity ~= PlayerPedId()) then return end

    if (not WaitShoot) then
        WaitShoot = true

        if (QueueSaveAmmo[CurrentWeapon.id] == nil) then
            QueueSaveAmmo[CurrentWeapon.id] = 0 
        end

        QueueSaveAmmo[CurrentWeapon.id] += 1

        CreateThread(function()
            Wait(20)
            WaitShoot = false
        end)
    end
end)

CreateThread(function()
    while true do

        for id,ammo in pairs(QueueSaveAmmo) do
            print('AMMO REMOVE FROM ID:', id, " AMMO:", ammo)

            TriggerServerEvent('Gamemode:Inventory:RemoveWeaponAmmo', id, ammo)

            QueueSaveAmmo[id] = nil
        end

        
        local ped = PlayerPedId()
        if (GetSelectedPedWeapon(ped) ~= -1569615261) then
            local _, weaponHash = GetCurrentPedWeapon(ped, true);

            if (CurrentWeapon.hash ~= weaponHash) then
                RemoveAllPedWeapons(PlayerPedId())
            end

            if (CurrentWeapon == nil and weaponHash) then
                RemoveAllPedWeapons(PlayerPedId())
            end

        end


        Wait(1000)
    end
end)