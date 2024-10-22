RegisterNetEvent('Gamemode:Labo:ExitLabo')
AddEventHandler('Gamemode:Labo:ExitLabo', function(laboType)

    MOD_Labos.LabData = {}

    if (laboType == "weed") then
        MOD_Weed:ExitWeedLabo()
    end
end)