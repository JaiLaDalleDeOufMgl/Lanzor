function MOD_inventory:getWeaponIsPerma(name)
    for i=1, #ConfigGamemodeHud.permanentWeapons, 1 do
        if (string.lower(ConfigGamemodeHud.permanentWeapons[i]) == name) then
            return true
        end
    end

    return false
end