RegisterNetEvent('Gamemode:Labos:RemoveAcces')
AddEventHandler('Gamemode:Labos:RemoveAcces', function(accesName)
    MOD_Labos.LabData.AccesList[accesName] = nil
end)