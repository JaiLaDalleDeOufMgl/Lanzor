local AllPoses = {
    {x=785.734619140625,y=-182.01893615,z=77.31092071533203-3.5, h=328.62, done = false, code="mdrtutrouvececodetgravechaud"},
    {x=697.255,y=-381.297,z=44.66-3.5, h=18.12, done = false, code="mdrtutrouvececodetgravechaud"},
    {x=303.08,y=7.39,z=84.61-3.5, h=249.12, done = false, code="mdrtutrouvececodetgravechaud"},
    {x=544.88,y=243.96,z=106.48-3.5, h=343.9, done = false, code="mdrtutrouvececodetgravechaud"},
    {x=261.67,y=324.49,z=108.88-3.5, h=70.62, done = false, code="mdrtutrouvececodetgravechaud"},
    {x=12.94,y=248.27,z=112.1-3.5, h=343.12, done = false, code="mdrtutrouvececodetgravechaud"},
}

AddEventHandler("esx:playerLoaded", function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent("gamemode:receiveposesechelles", source, AllPoses)
end)



local ElectricianJobTimeout = {}

RegisterNetEvent("echelle:finish", function(tabl)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if not ElectricianJobTimeout[source] then 
        ElectricianJobTimeout[source] = 0 
    else
        ElectricianJobTimeout[source] = ElectricianJobTimeout[source]+1
    end

    if ElectricianJobTimeout[source] > 3 then 
        TriggerEvent("tF:Protect", source, "(echelle:finish)")
        return
    end
    

    if tabl.x and tabl.y and tabl.z and tabl.code == "mdrtutrouvececodetgravechaud" then
        local argent_win = math.random(210,270)
        xPlayer.addAccountMoney('cash', argent_win)
        xPlayer.showNotification('Félicitation !\nTu as réussi une tâche et reçu :'..argent_win..' $')
    else
        -- ("Possible cheater ", src, xPlayer.name, json.encode(tabl))
    end
end)

Citizen.CreateThread(function()
    while true do 
        Wait(15000)
        ElectricianJobTimeout = {}
    end
 end)
