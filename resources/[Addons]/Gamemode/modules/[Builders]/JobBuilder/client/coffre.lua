local jobsData = {};

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)

	ESX.PlayerData = xPlayer
    PlayerData = xPlayer

    ESX.TriggerServerCallback('JobBuilder:getAllJobs', function(result)
        jobsData = result;
    end);

end)

RegisterNetEvent('jobbuilder:restarted', function(player)

    ESX.PlayerData = player
    PlayerData = xPlayer

    ESX.TriggerServerCallback('JobBuilder:getAllJobs', function(result)
        jobsData = result;
    end);

end);

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job

    ESX.TriggerServerCallback('JobBuilder:getAllJobs', function(result)
        jobsData = result;
    end);

end)

local function JobBuilderKeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end

local JobBuilder = {
    Coffre = {}
};



Citizen.CreateThread(function()
    while true do
        local Timer = 500
        for k,v in pairs(jobsData) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == v.Name then
                local plyPos = GetEntityCoords(PlayerPedId())
                local Coffre = vector3(json.decode(v.PosCoffre).x, json.decode(v.PosCoffre).y, json.decode(v.PosCoffre).z)
                local dist = #(plyPos-Coffre)
                if dist <= 20.0 then
                    Timer = 0
                    DrawMarker(2, Coffre, 0, 0, 0, 0.0, nil, nil, 0.2, 0.2, 0.2, 0, 129, 211, 255, 0, 1, 0, 0, nil, nil, 0)
                end
                if dist <= 3.0 then
                    Timer = 0
                    ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour accéder au coffre")
                    if IsControlJustPressed(1,51) then
                        JobBuilder.Coffre = v
                        ESX.OpenSocietyChest(v.Name);
                    end
                end
            end
        end
        Citizen.Wait(Timer)
    end
end)

CreateThread(function()
    ESX.TriggerServerCallback('JobBuilder:getAllJobs', function(result)
        while true do
            local Timer = 500
            for k,v in pairs(result) do
                local NameOfBlips = v.Label
                local blip = AddBlipForCoord(vector3(json.decode(v.PosCoffre).x, json.decode(v.PosCoffre).y, json.decode(v.PosCoffre).z))  
                SetBlipSprite (blip, 514)
                SetBlipDisplay(blip, 4)
                SetBlipScale  (blip, 0.6)
                SetBlipColour (blip, 20)
                SetBlipAsShortRange(blip, true)
                
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentSubstringPlayerName("Entreprise "..NameOfBlips)
                EndTextCommandSetBlipName(blip)
            end
            break
            Wait(Timer)
        end
    end)
end)