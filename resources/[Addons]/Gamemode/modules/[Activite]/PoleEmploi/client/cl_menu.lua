

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)      
		Citizen.Wait(0)
	end
end)

local open = false 
local Fortnite = RageUI.CreateMenu("","Interaction")
local Libre = RageUI.CreateSubMenu(Fortnite,"","Interaction")
Fortnite.Display.Header = true
Fortnite.Closed = function ()
    open = false
end

function Pole()
    if open then
        open = false
        RageUI.Visible(Fortnite,false)
        return
    else
        open = true
        RageUI.Visible(Fortnite,true)
        CreateThread(function ()
        while open do
            RageUI.IsVisible(Fortnite, function ()

            RageUI.Button("Métiers Libres", nil, {RightLabel = exports.Tree:serveurConfig().Serveur.color.."→→→"}, true, {}, Libre)

            RageUI.Button("Chômage", nil, {RightLabel = exports.Tree:serveurConfig().Serveur.color.."→→→"}, true, {
                onSelected = function ()
                    TriggerServerEvent('Gamemode:Chomeur')
                    ClearGpsMultiRoute()
                    ESX.ShowNotification("Votre métier a été réinitialisé vous êtes maintenant chômeur.")
                    RageUI.CloseAll()
                end
             }) 
    end)

        RageUI.IsVisible(Libre, function ()

            for k,v in pairs(FreeJobConfig.Libre) do
            RageUI.Button(v.label, v.objectif, {RightLabel = exports.Tree:serveurConfig().Serveur.color.."→→→"}, true, {
                onSelected = function ()
                    TriggerServerEvent('Gamemode:Setjob', v.label, v.name)
                    ClearGpsMultiRoute();
                    SetNewWaypoint(v.x, v.y);
                    ESX.ShowNotification(""..v.message);
                    RageUI.CloseAll();
                end
            })
        end
    end)
        
              Wait(0)
            end
        end)
    end
end

--- Ped ----

Citizen.CreateThread(function ()
    for k, v in pairs(FreeJobConfig.Ped) do
    while not HasModelLoaded(v.pedModel) do
        RequestModel(v.pedModel)
        Wait(0)
    end
    Ped = CreatePed(2, GetHashKey(v.pedModel), v.position, 0, 0)
    FreezeEntityPosition(Ped, 1)
    TaskStartScenarioInPlace(Ped, v.pedModel, 0, false)
    SetEntityInvincible(Ped, true) 
    SetBlockingOfNonTemporaryEvents(Ped, 1)
end
end)

---- Blips ----

Citizen.CreateThread(function ()
    Citizen.Wait(100)
  if FreeJobConfig.BlipsPoleEmploi then
        for k, v in pairs(FreeJobConfig.BlipsPoleEmploiPosition) do
            local Blips = AddBlipForCoord(v.x, v.y, v.z)
  
            SetBlipSprite (Blips, FreeJobConfig.BlipsPoleEmploiId)
            SetBlipScale  (Blips, FreeJobConfig.BlipsPoleEmploiTaille)
            SetBlipColour (Blips, FreeJobConfig.BlipsPoleEmploiCouleur)
            SetBlipAsShortRange(Blips, true)
  
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(FreeJobConfig.BlipsPoleEmploiName)
            EndTextCommandSetBlipName(Blips)
        end
    end
  end)

---- Marker ----

Citizen.CreateThread(function()
    while true do
    local wait = 1000
      for k, v in pairs(FreeJobConfig.PoleEmploi) do
        local playerCoords = GetEntityCoords(PlayerPedId())
                local distance = GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true)

                if distance <= 2.0 then
                    wait = 0
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accèder au pôle emploi.")
                    if IsControlJustPressed(1,51) then
                        Pole()
                    end
                end
        end
    Citizen.Wait(wait)
    end
end)