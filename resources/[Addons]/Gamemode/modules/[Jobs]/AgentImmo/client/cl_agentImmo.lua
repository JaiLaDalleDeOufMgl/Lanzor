local open = false 
local mainMenu8 = RageUI.CreateMenu('', 'Interaction')
local subMenu8 = RageUI.CreateSubMenu(mainMenu8, "", "Interaction")
local subMenu10 = RageUI.CreateSubMenu(mainMenu8, "", "Interaction")
local ServiceAgentImmo = false
mainMenu8.Display.Header = true 
mainMenu8.Closed = function()
  open = false
end

function OpenF6Immo()
	if open then 
		open = false
		RageUI.Visible(mainMenu8, false)
		return
	else
		open = true 
		RageUI.Visible(mainMenu8, true)
		CreateThread(function()
		while open do 
		    RageUI.IsVisible(mainMenu8,function() 
            if ServiceAgentImmo then
                RageUI.Button("Crée une propriété", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                        open = false
                        ExecuteCommand("openProperties")
                    end
                })

                RageUI.Button("Annonces", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                    end
                }, subMenu8)
            else
                RageUI.Separator(exports.Tree:serveurConfig().Serveur.color.."Vous devez etre en service") 
            end 

			end)

			RageUI.IsVisible(subMenu8,function() 
                RageUI.Button("Annonce ~g~Ouvertures", nil, {RightLabel = "→"}, not codesCooldown1, {
                    onSelected = function()
                        codesCooldown1 = true 
                        TriggerServerEvent('Ouvre:realestateagent')
                    end
                })
                RageUI.Button("Annonce "..exports.Tree:serveurConfig().Serveur.color.."Fermetures", nil, {RightLabel = "→"}, not codesCooldown2, {
                    onSelected = function()
                        codesCooldown2 = true 
                        TriggerServerEvent('Ferme:realestateagent')
                    end
                })
                RageUI.Button("Annonce "..exports.Tree:serveurConfig().Serveur.color.."Recrutement", nil, {RightLabel = "→"}, not codesCooldown3, {
                    onSelected = function()
                        codesCooldown3 = true 
                        TriggerServerEvent('Recrutement:realestateagent')
                    end
                })
		   end)

		 Wait(0)
		end
	 end)
  end
end

local position = {
	{x = -700.42, y =  267.30, z =  83.10}
}

CreateThread(function()
    while true do

      local wait = 1000

        for k in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'realestateagent' then 
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

                if dist <= 15.0 then
                    wait = 0
                    --if ServiceAgentImmo then
                        DrawMarker(Config.Get.Marker.Type, -700.42, 267.30, 83.10, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                        if dist <= 1.0 then
                            Citizen.CreateThread(function()
                                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu.")
                                    if IsControlJustPressed(1,51) then
                                        OpenClotheForAgentImmo = true
                                        OpenClotheMenuAgentImmo()
                                end
                            end)
                        end
                   -- end
                end
            end
        end
        Wait(wait)
    end
end)


function OpenClotheMenuAgentImmo()
    local mainMenu = RageUI.CreateMenu("", "Faites vos actions")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while OpenClotheForAgentImmo do
        local PosMenuAgentJob = vector3(-700.42, 267.30, 83.10)
        local ped = GetEntityCoords(PlayerPedId())
        local dist = #(ped - PosMenuAgentJob)

        if dist >= 5 then
            OpenClotheForAgentImmo = false
            return
        end

        RageUI.IsVisible(mainMenu, function()
            if ServiceAgentImmo then
                RageUI.Button("Terminer son service", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                        ServiceAgentImmo = false
                        TriggerServerEvent('sendLogs:ServiceNo')
                    end
                })
            else
                RageUI.Button("Prendre votre service", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                        ServiceAgentImmo = true
                        TriggerServerEvent('sendLogs:ServiceYes')
                    end
                })
            end
        end)


        local onPos = false
        for _, v in pairs(Config.Jobs.AgentImmo.Clothes) do
            if #(GetEntityCoords(PlayerPedId()) - v.clothes) > 10 then
                onPos = true
            end
        end

        Citizen.Wait(0)
    end
end

Citizen.CreateThread(function()
 
	local blip = AddBlipForCoord(-700.42, 267.30, 83.10)  
  
	SetBlipSprite (blip, 375) -- Model du blip
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.6) -- Taille du blip
	SetBlipColour (blip, 0) -- Couleur du blip
	SetBlipAsShortRange(blip, true)
  
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Agence Immobilière') -- Nom du blip
	EndTextCommandSetBlipName(blip)
  end)



local open = false 
local AgentImmoGarage = RageUI.CreateMenu('', 'Garage Agent Immo')
AgentImmoGarage.Display.Header = true 
AgentImmoGarage.Closed = function()
  open = false
end

function OpenMenuAgentImmo()
     if open then 
         open = false
         RageUI.Visible(AgentImmoGarage, false)
         return
     else
         open = true 
         RageUI.Visible(AgentImmoGarage, true)
         CreateThread(function()
         while open do 
          local PosMenuAgentImmo = vector3(-715.85, 271.64, 84.69)
          local ped = GetEntityCoords(PlayerPedId())
          local dist = #(ped - PosMenuAgentImmo)

          if dist >= 5 then
            RageUI.Visible(AgentImmoGarage, false)
            open = false
            return
        end

            RageUI.IsVisible(AgentImmoGarage,function() 

              RageUI.Button("Ranger le véhicule", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                  local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                if dist4 < 5 then
                      DeleteEntity(veh)
                      ESX.ShowNotification("~g~Véhicule supprimer avec succès !")
                else
                        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Véhicule trop loins !")
                end
              end, })
              
               RageUI.Separator("↓ "..exports.Tree:serveurConfig().Serveur.color.."Gestion Véhicule ~s~ ↓")

                RageUI.Button("Véhicule de Fonction", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerServerEvent('realestateagent:spawnVehicleImmo')
                        ESX.Game.SpawnVehicle('windsor2', vector3(-710.18, 281.35, 84.17 ), 267.32, function (vehicle)
                          local newPlate = exports['Gamemode']:GeneratePlate()
                          SetVehicleNumberPlateText(vehicle, newPlate)
                          exports[exports.Tree:serveurConfig().Serveur.hudScript]:SetFuel(vehicle, 100)
                          TriggerServerEvent('babyboy:GiveDoubleKeys', 'no', newPlate)
                          TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                        -- print("oui")
                      end)
                    end
                })

           end)
          Wait(0)
         end
      end)
   end
end

----OUVRIR LE MENU------------

local position = {
	{x = -715.85, y =  271.64, z =  84.69}
}

CreateThread(function()
    while true do

      local wait = 1000

        for k in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'realestateagent' then 
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

                if dist <= 15.0 then
                    wait = 0
                    --if ServiceAgentImmo then
                        DrawMarker(Config.Get.Marker.Type, -715.85, 271.64, 84.69, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                        if dist <= 1.0 then
                            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage.")
                            if IsControlJustPressed(1,51) then
                                OpenMenuAgentImmo()
                            end
                        end
                   -- end
                end
            end
        end
        Wait(wait)
    end
end)