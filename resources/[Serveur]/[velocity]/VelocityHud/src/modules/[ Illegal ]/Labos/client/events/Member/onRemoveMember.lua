RegisterNetEvent('Gamemode:Labos:RemoveMember')
AddEventHandler('Gamemode:Labos:RemoveMember', function(license)
    MOD_Labos.LabData.memberList[license] = nil
end)