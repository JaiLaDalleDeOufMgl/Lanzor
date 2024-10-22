RegisterNetEvent('Gamemode:Labos:AddMember')
AddEventHandler('Gamemode:Labos:AddMember', function(license, data)
    MOD_Labos.LabData.memberList[license] = data
end)