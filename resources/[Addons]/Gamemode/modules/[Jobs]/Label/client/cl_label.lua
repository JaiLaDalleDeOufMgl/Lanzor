open = false 
local mainMenu8 = RageUI.CreateMenu('', 'Interaction')
local subMenu8 = RageUI.CreateSubMenu(mainMenu8, "", "Interaction")
local subMenu10 = RageUI.CreateSubMenu(mainMenu8, "", "Interaction")
local ServiceLabelMusique = false
mainMenu8.Display.Header = true 
mainMenu8.Closed = function()
  open = false
end

function OpenF6Label()
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
            if ServiceLabelMusique then
                RageUI.Button("Crée une facture", nil, {RightLabel = "→"}, true, {
                    onSelected = function()
                        local montant = KeyboardInputPolice("Montant:", 'Indiquez un montant', '', 7)
						if tonumber(montant) == nil then
							ESX.ShowNotification("Montant invalide")
							return false
						else
							amount = (tonumber(montant))
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer == -1 or closestDistance > 3.0 then
								ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Personne autour de vous')
							else
                                ESX.ShowNotification("~g~Facture envoyée avec succès !")
                                TriggerServerEvent('sendLogs:Facture', GetPlayerServerId(closestPlayer), amount)
								TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'label', 'label', amount)
							end
						end
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
                        TriggerServerEvent('Ouvre:label')
                    end
                })
                RageUI.Button("Annonce "..exports.Tree:serveurConfig().Serveur.color.."Fermetures", nil, {RightLabel = "→"}, not codesCooldown2, {
                    onSelected = function()
                        codesCooldown2 = true 
                        TriggerServerEvent('Ferme:label')
                    end
                })
                RageUI.Button("Annonce "..exports.Tree:serveurConfig().Serveur.color.."Recrutement", nil, {RightLabel = "→"}, not codesCooldown3, {
                    onSelected = function()
                        codesCooldown3 = true 
                        TriggerServerEvent('Recrutement:label')
                    end
                })
		   end)
		 Wait(0)
		end
	 end)
  end
end

Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(500)
    end
    while true do
        local interval = 1000
        local plyPed = PlayerPedId()
        local coords = GetEntityCoords(plyPed)
        if ESX.PlayerData.job.name == 'label' then
            for k,v in pairs(Config.Jobs.LabelJob.Clothes) do
                if #(coords - v.clothes) <= 10 then
                    DrawMarker(Config.Get.Marker.Type, v.clothes, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                    interval = 0
                    if #(coords - v.clothes) <= 3 then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu")
                        if IsControlJustPressed(0, 51) then
                            OpenClotheForLabelJob = true
                            OpenClotheMenuLabelJob()
                        end
                    end
                end
            end
        end
        Citizen.Wait(interval)
    end
end)

function OpenClotheMenuLabelJob()
    local mainMenu = RageUI.CreateMenu("", "Faites vos actions")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while OpenClotheForLabelJob do
        RageUI.IsVisible(mainMenu, function()
            if ServiceLabelMusique then
                RageUI.Button("Terminer son service", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                        ServiceLabelMusique = false
                        TriggerServerEvent('sendLogs:ServiceNo')
                        -- ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                        --     TriggerEvent('skinchanger:loadSkin', skin)
                        -- end)
                    end
                })
            else
                RageUI.Button("Prendre votre service", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                        ServiceLabelMusique = true
                        TriggerServerEvent('sendLogs:ServiceYes')
                        -- setClotheLabelJob('label', PlayerPedId())
                    end
                })
            end
        end)

        local onPos = false
        for _, v in pairs(Config.Jobs.LabelJob.Clothes) do
            if #(GetEntityCoords(PlayerPedId()) - v.clothes) > 10 then
                onPos = true
            end
        end

        Citizen.Wait(0)
    end
end

function setClotheLabelJob(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			TriggerEvent('skinchanger:loadClothes', skin, Config.Jobs.LabelJob.Uniforms.male)
		else
			TriggerEvent('skinchanger:loadClothes', skin, Config.Jobs.LabelJob.Uniforms.female)
		end
	end)
end

local open = false 
local LabelJobGarage = RageUI.CreateMenu('', 'Garage label')
LabelJobGarage.Display.Header = true 
LabelJobGarage.Closed = function()
  open = false
end

function OpenMenuLabelJob()
     if open then 
         open = false
         RageUI.Visible(LabelJobGarage, false)
         return
     else
         open = true 
         RageUI.Visible(LabelJobGarage, true)
         CreateThread(function()
         while open do 
          local PosMenuLabelJob = vector3(495.08, -105.77, 61.28)
          local ped = GetEntityCoords(PlayerPedId())
          local dist = #(ped - PosMenuLabelJob)
          if dist >= 5 then
            RageUI.Visible(LabelJobGarage, false)
            return
          else
          end
            RageUI.IsVisible(LabelJobGarage,function() 

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
                        TriggerServerEvent('label:spawnVehicleLabel')
                        ESX.Game.SpawnVehicle('windsor2', vector3(502.50, -102.99, 62.34), 236.40, function (vehicle)
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
	{x = 495.08, y = -105.77, z =  61.28}
}

CreateThread(function()
    while true do

      local wait = 1000

        for k in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'label' then 
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

                if dist <= 15.0 then
                    wait = 0
                    if ServiceLabelMusique then
                        DrawMarker(Config.Get.Marker.Type, 495.08, -105.77, 61.28, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                        if dist <= 1.0 then
                            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage.")
                                if IsControlJustPressed(1,51) then
                                OpenMenuLabelJob()
                            end
                        end
                    end
                end
            end
        end
        Wait(wait)
    end
end)