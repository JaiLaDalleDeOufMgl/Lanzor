RegisterNetEvent('Gamemode:Inventory:AddWeaponAmmo')
AddEventHandler('Gamemode:Inventory:AddWeaponAmmo', function(weaponid, ammo, src)
    if (src ~= nil) then 
        source = src 
    end

    print(source, src)

    local xPlayer = ESX.GetPlayerFromId(source)

    if (not weaponid) then
        weaponid = xPlayer.get('currentWeapon')
    end

    local WeaponSelect = xPlayer.getWeaponsById(weaponid)
    local WeaponAmmo = WeaponSelect.args.ammo

    local NewAmmo = (WeaponAmmo + ammo)

    xPlayer.setWeaponsAmmoById(weaponid, NewAmmo)
end)