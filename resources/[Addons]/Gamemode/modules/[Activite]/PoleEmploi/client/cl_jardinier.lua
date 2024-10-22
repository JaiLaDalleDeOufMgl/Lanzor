

CreateThread(function()
    while ESX == nil do
        Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Wait(0)
    end
    if ESX.IsPlayerLoaded() then
        ESX.PlayerData = ESX.GetPlayerData()
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

local open = false
local Jardinier = RageUI.CreateMenu("", "Interaction")
Jardinier.Display.Header = true
Jardinier.Closed = function ()
    open = false
end

function FortniteJardinier()
    if open then
        open = false
        RageUI.Visible(Jardinier, false)
        return
    else
        open = true
        RageUI.Visible(Jardinier, true)
        CreateThread(function ()
            while open do
                RageUI.IsVisible(Jardinier,function ()
                    
                    for k, v in pairs(FreeJobConfig.JardinierRecolte) do
                    RageUI.Button("Point GPS vers la récolte", nil, {RightLabel = exports.Tree:serveurConfig().Serveur.color.."→→"}, true, {
                        onSelected = function ()
                            SetNewWaypoint(v.x, v.y)
                            ESX.ShowNotification("Point GPS défini vers la récolte")
                        end
                    })
                end
                    RageUI.Button("Vendre des plantes", nil, {RightLabel = exports.Tree:serveurConfig().Serveur.color.."→→"}, true, {
                        onSelected = function ()
                            TriggerServerEvent("Gamemode:VenteJardinier")
                            ClearGpsMultiRoute()
                        end
                    })
                end)
                Wait(0)
            end
        end)
    end
end

RegisterNetEvent("JustGod:BonToutou", RageUI.CloseAll);

Citizen.CreateThread(function ()
    Citizen.Wait(100)
  if FreeJobConfig.BlipsJardinier then

        for k, v in pairs(FreeJobConfig.BlipsJardinierPosition) do
            local Blips = AddBlipForCoord(v.x, v.y, v.z)
  
            SetBlipSprite (Blips, FreeJobConfig.BlipsJardinierId)
            SetBlipScale  (Blips, FreeJobConfig.BlipsJardinierTaille)
            SetBlipColour (Blips, FreeJobConfig.BlipsJardinierCouleur)
            SetBlipAsShortRange(Blips, true)
  
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(FreeJobConfig.BlipsJardinierName)
            EndTextCommandSetBlipName(Blips)
        end
    end
end)

---- Marker ----

Citizen.CreateThread(function()
    while true do
    local wait = 1000
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'jardinier' then
      for k, v in pairs(FreeJobConfig.Jardinier) do
        local playerCoords = GetEntityCoords(PlayerPedId())
                local distance = GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true)

                if distance <= FreeJobConfig.TextDistance then
                    wait = 0
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour parler au jardinier.")
                    if IsControlJustPressed(1,51) then
                        FortniteJardinier()
                    end
                end
            end
        end
        Wait(wait)
    end
end)

function StartRecolte()
    if not recoltepossible then
        recoltepossible = true
    while recoltepossible do
        Wait(5000)
        TriggerServerEvent('Gamemode:RecolteJardinier')
    end
    else
        recoltepossible = false
    end
end

function StopRecolte()
    if recoltepossible then
    	recoltepossible = false
    end
end

---- Marker ----


local inHarvest = false
CreateThread(function()
    local timer = 1000
    while true do
        timer = 0 
        for k,v in pairs(FreeJobConfig.JardinierRecolte) do 
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true)
            if distance < 1.5 and ESX.PlayerData.job.name == "jardinier" then
                DrawMarker(25, v.x, v.y, v.z - 0.95, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 255, 255, 255, 255, 0, 0, 0, 0, 0, 0, 0)
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour recolter des plantes.")
                if IsControlJustPressed(0, 51) then
                    inHarvest = true
                    ESX.ShowNotification("~g~Récolte en cours...")
                    while inHarvest do 
                        Wait(5000)
                        local newPos = GetEntityCoords(PlayerPedId())
                        local newDistance = #(newPos - vector3(v.x, v.y, v.z))
                        if newDistance < 1.5 then
                            TriggerServerEvent('Gamemode:RecolteJardinier')
                        else
                            ESX.ShowNotification("~r~Vous venez de quitté la zone de récolte.")
                            inHarvest = false
                        end
                    end
                end
            end
        end
        Wait(timer)
    end
end)


RegisterNetEvent('Jardinier:stop')
AddEventHandler('Jardinier:stop', function(source)    
    StopRecolte();
    SetPlayerControl(PlayerId(), true, 12);
    local playerPed = PlayerPedId(source);
    ClearPedTasksImmediately(playerPed);
    RageUI.CloseAll();
end)
