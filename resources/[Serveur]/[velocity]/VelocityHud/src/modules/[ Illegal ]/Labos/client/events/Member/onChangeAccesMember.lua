RegisterNetEvent('Gamemode:Labos:ChangeAccesMember')
AddEventHandler('Gamemode:Labos:ChangeAccesMember', function(license, accesName)
    MOD_Labos.LabData.memberList[license].accesName = accesName
end)