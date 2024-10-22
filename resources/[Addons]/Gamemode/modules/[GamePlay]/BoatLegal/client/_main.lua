
BoatLegal = BoatLegal or {}
BoatLegal.Config = nil

local function initPlayer()
    if (ESX.GetPlayerData().job ~= nil and BoatLegal.Config[ESX.GetPlayerData().job["name"]] ~= nil) then
        local selectedBoatLegal = BoatLegal.Config[ESX.GetPlayerData().job["name"]]
        local currentJob = ESX.GetPlayerData().job
        while (ESX.GetPlayerData().job ~= nil and ESX.GetPlayerData().job["name"] == currentJob.name and BoatLegal.Config[ESX.GetPlayerData().job["name"]] ~= nil) do
            local loopInterval = 1000

            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            if (selectedBoatLegal.menuPosition ~= nil and (#(playerCoords-selectedBoatLegal.menuPosition) < 1.5)) then
                loopInterval = 0
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage.")
                if IsControlJustPressed(0, 51) then
                    BoatLegal:spawnMenu()
                end
            elseif (selectedBoatLegal.menuPosition ~= nil and (#(playerCoords-selectedBoatLegal.menuPosition) < 10.0)) then
                loopInterval = 0
                DrawMarker(Config.Get.Marker.Type, selectedBoatLegal.menuPosition, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
            end

            Wait(loopInterval)
        end
    end
end

CreateThread(function()
	while ESX == nil do
		Wait(5000)
	end
    while ESX.GetPlayerData().job == nil do
        Wait(100)
    end
    ESX.PlayerData = ESX.GetPlayerData()

    if ESX.PlayerData.job.name == "police" or ESX.PlayerData.job.name == "fib" or ESX.PlayerData.job.name == "ambulance" or ESX.PlayerData.job.name == "bcso" then 
        FunBlipsBoat()
    end

    
    TriggerServerEvent("BoatLegal:Request:LoadConfig")
    
    while (BoatLegal.Config == nil) do
        Wait(0)
    end

    initPlayer()
end)

AddEventHandler('esx:setJob', function(job)
    while (ESX.GetPlayerData().job["name"] ~= job.name) do
        Wait(0)
    end

    initPlayer()
end)

RegisterNetEvent("BoatLegal:ClientReturn:Config", function(BoatLegalConfig)
    BoatLegal.Config = BoatLegalConfig or {};
end)


function FunBlipsBoat()
    if ESX.PlayerData.job.name == "police" then
        local blipBoat = AddBlipForCoord(-1005.05, -1398.90, 1.59)  
        blipsBoat = blipBoat
        SetBlipSprite (blipBoat, 404) -- Model du blip
        SetBlipDisplay(blipBoat, 4)
        SetBlipScale  (blipBoat, 0.6) -- Taille du blip
        SetBlipColour (blipBoat, 18) -- Couleur du blip
        SetBlipAsShortRange(blipBoat, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Bateau LSPD') -- Nom du blip
        EndTextCommandSetBlipName(blip)
    elseif ESX.PlayerData.job.name == "ambulance" then
        local blipBoat = AddBlipForCoord(-1204.78, -1794.74, 3.90)  
        blipsBoat = blipBoat
        SetBlipSprite (blipBoat, 404) -- Model du blip
        SetBlipDisplay(blipBoat, 4)
        SetBlipScale  (blipBoat, 0.6) -- Taille du blip
        SetBlipColour (blipBoat, 18) -- Couleur du blip
        SetBlipAsShortRange(blipBoat, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Bateau EMS') -- Nom du blip
        EndTextCommandSetBlipName(blipBoat)
    elseif ESX.PlayerData.job.name == "fib" then
        local blipBoat = AddBlipForCoord(2831.16, -671.11, 1.43)  
        blipsBoat = blipBoat
        SetBlipSprite (blipBoat, 404) -- Model du blip
        SetBlipDisplay(blipBoat, 4)
        SetBlipScale  (blipBoat, 0.6) -- Taille du blip
        SetBlipColour (blipBoat, 18) -- Couleur du blip
        SetBlipAsShortRange(blipBoat, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Bateau FIB') -- Nom du blip
        EndTextCommandSetBlipName(blipBoat)
    elseif ESX.PlayerData.job.name == "bcso" then
        local blipBoat = AddBlipForCoord(1586.185, 3900.34, 32.05)  
        blipsBoat = blipBoat
        SetBlipSprite (blipBoat, 404) -- Model du blip
        SetBlipDisplay(blipBoat, 4)
        SetBlipScale  (blipBoat, 0.6) -- Taille du blip
        SetBlipColour (blipBoat, 18) -- Couleur du blip
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Bateau BCSO') -- Nom du blip
        EndTextCommandSetBlipName(blip)
    end
end


RegisterNetEvent('esx:setJob') --- Verification du job
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
    Wait(2000)

    if ESX.PlayerData.job.name == "police" or ESX.PlayerData.job.name == "fib" or ESX.PlayerData.job.name == "ambulance" or ESX.PlayerData.job.name == "bcso" then
        RemoveBlip(blipsBoat) 
        FunBlipsBoat()
    else
        RemoveBlip(blipsBoat) 
    end
end)
