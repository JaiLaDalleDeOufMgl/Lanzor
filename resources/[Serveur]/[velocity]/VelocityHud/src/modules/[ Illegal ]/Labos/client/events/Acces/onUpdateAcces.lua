RegisterNetEvent('Gamemode:Labos:UpdateAcces')
AddEventHandler('Gamemode:Labos:UpdateAcces', function(accesName, data)
    MOD_Labos.LabData.AccesList[accesName] = data
end)