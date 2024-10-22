local open = false 
local mainMenu8 = RageUI.CreateMenu('', 'Interaction')
local subMenu8 = RageUI.CreateSubMenu(mainMenu8, "", "Interaction")
local subMenu10 = RageUI.CreateSubMenu(mainMenu8, "", "Interaction")
local ServiceLtdSUD = false
mainMenu8.Display.Header = true 
mainMenu8.Closed = function()
  open = false
end

function OpenF6ltd_sud()
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
            if ServiceLtdSUD then
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
								TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'ltd_sud', 'ltd_sud', amount)
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
                        TriggerServerEvent('Ouvre:ltd_sud')
                    end
                })
                RageUI.Button("Annonce "..exports.Tree:serveurConfig().Serveur.color.."Fermetures", nil, {RightLabel = "→"}, not codesCooldown2, {
                    onSelected = function()
                        codesCooldown2 = true 
                        TriggerServerEvent('Ferme:ltd_sud')
                    end
                })
                RageUI.Button("Annonce "..exports.Tree:serveurConfig().Serveur.color.."Recrutement", nil, {RightLabel = "→"}, not codesCooldown3, {
                    onSelected = function()
                        codesCooldown3 = true 
                        TriggerServerEvent('Recrutement:ltd_sud')
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
        if ESX.PlayerData.job.name == 'ltd_sud' then
            for k,v in pairs(Config.Jobs.LTDSudJob.Clothes) do
                if #(coords - v.clothes) <= 10 then
                    DrawMarker(Config.Get.Marker.Type, v.clothes, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                    interval = 0
                    if #(coords - v.clothes) <= 3 then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu")
                        if IsControlJustPressed(0, 51) then
                            OpenClotheForLTDSudJob = true
                            OpenClotheMenuLTDSudJob()
                        end
                    end
                end
            end
        end
        Citizen.Wait(interval)
    end
end)

function OpenClotheMenuLTDSudJob()
    local mainMenu = RageUI.CreateMenu("", "Faites vos actions")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while OpenClotheForLTDSudJob do
        RageUI.IsVisible(mainMenu, function()
            if ServiceLtdSUD then
                RageUI.Button("Terminer son service", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                        ServiceLtdSUD = false
                        TriggerServerEvent('sendLogs:ServiceNo')
                        -- ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                        --     TriggerEvent('skinchanger:loadSkin', skin)
                        -- end)
                    end
                })
            else
                RageUI.Button("Prendre votre service", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                        ServiceLtdSUD = true
                        TriggerServerEvent('sendLogs:ServiceYes')
                        -- setClotheLTDSudJob('ltd_sud', PlayerPedId())
                    end
                })
            end
        end)

        local onPos = false
        for _, v in pairs(Config.Jobs.LTDSudJob.Clothes) do
            if #(GetEntityCoords(PlayerPedId()) - v.clothes) > 10 then
                onPos = true
                OpenClotheForLTDSudJob = false
            end
        end
        
        Citizen.Wait(0)
    end
end

function setClotheLTDSudJob(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			TriggerEvent('skinchanger:loadClothes', skin, Config.Jobs.LTDSudJob.Uniforms.male)
		else
			TriggerEvent('skinchanger:loadClothes', skin, Config.Jobs.LTDSudJob.Uniforms.female)
		end
	end)
end

Citizen.CreateThread(function()

	local blip = AddBlipForCoord(-707.40, -914.74, 19.21)  
  
	SetBlipSprite (blip, 59) -- Model du blip
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.6) -- Taille du blip
	SetBlipColour (blip, 0) -- Couleur du blip
	SetBlipAsShortRange(blip, true)
  
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('LTD SUD') -- Nom du blip
	EndTextCommandSetBlipName(blip)
end)

local open = false 
local LTDSudJobGarage = RageUI.CreateMenu('', 'Garage ltd_sud')
LTDSudJobGarage.Display.Header = true 
LTDSudJobGarage.Closed = function()
  open = false
end

function OpenMenuLTDSudJob()
     if open then 
         open = false
         RageUI.Visible(LTDSudJobGarage, false)
         return
     else
         open = true 
         RageUI.Visible(LTDSudJobGarage, true)
         CreateThread(function()
         while open do 
          local PosMenuLTDSudJob = vector3(-702.83, -916.85, 19.21)
          local ped = GetEntityCoords(PlayerPedId())
          local dist = #(ped - PosMenuLTDSudJob)
          if dist >= 5 then
            RageUI.Visible(LTDSudJobGarage, false)
            return
          else
          end
            RageUI.IsVisible(LTDSudJobGarage,function() 

              RageUI.Button("Ranger le véhicule", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                  local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                if dist4 < 10 then
                      DeleteEntity(veh)
                      ESX.ShowNotification("~g~Véhicule supprimer avec succès !")
                else
                    ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Véhicule trop loins !")
                end
              end, })
              
               RageUI.Separator("↓ "..exports.Tree:serveurConfig().Serveur.color.."Gestion Véhicule ~s~ ↓")

                RageUI.Button("Véhicule de livraison", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        TriggerServerEvent('ltd_sud:spawnVehicleltd_sud')
                        ESX.Game.SpawnVehicle('mule7', vector3(-727.91, -917.87, 19.01), 173.66, function (vehicle)
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
	{x = -702.83, y =  -916.85, z =  19.21}
}

CreateThread(function()
    while true do

      local wait = 1000

        for k in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ltd_sud' then 
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

                if dist <= 15.0 then
                    wait = 0
                    if ServiceLtdSUD then
                        DrawMarker(Config.Get.Marker.Type, -702.83, -916.85, 19.21, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                        if dist <= 1.0 then
                            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage.")
                                if IsControlJustPressed(1,51) then
                                OpenMenuLTDSudJob()
                            end
                        end
                    end
                end
            end
        end
        Wait(wait)
    end
end)