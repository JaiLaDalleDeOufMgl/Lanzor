RegisterNetEvent('Gamemode:Labo:EnterLabo')
AddEventHandler('Gamemode:Labo:EnterLabo', function(laboType, accesList, memberList, drugData)

    MOD_Labos.LabData.AccesList = accesList
    MOD_Labos.LabData.memberList = memberList

    if (laboType == "weed") then
        MOD_Labos.LabData.DrugType = "weed"
        MOD_Weed:EnterWeedLabo(drugData)
    end
end)