function DEN:GiveweaponToPed(ped,weapon,ammo)
    GiveWeaponToPed(ped, GetHashKey(weapon), ammo, false, true)
end