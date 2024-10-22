RegisterNetEvent('Gamemode:Labos:AddNewAcces')
AddEventHandler('Gamemode:Labos:AddNewAcces', function(accesName, data)
    MOD_Labos.LabData.AccesList[accesName] = data
end)