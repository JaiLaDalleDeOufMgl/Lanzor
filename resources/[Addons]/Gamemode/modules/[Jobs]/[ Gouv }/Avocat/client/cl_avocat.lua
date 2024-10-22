local open = false 
local mainMenu8 = RageUI.CreateMenu('', 'Interaction')
local subMenu8 = RageUI.CreateSubMenu(mainMenu8, "", "Interaction")
local subMenu10 = RageUI.CreateSubMenu(mainMenu8, "", "Interaction")
local ServiceAvocat = false
mainMenu8.Display.Header = true 
mainMenu8.Closed = function()
  open = false
end

function OpenF6Avocat()
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
            if not ServiceAvocat then
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
                                ESX.ShowNotification("~g~Facture envoyé !")
								TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'avocat', 'Avocat', amount)
                                TriggerServerEvent('sendLogs:Facture', GetPlayerServerId(closestPlayer), amount)
                                ESX.ShowNotification("~g~Facture envoyée avec succès !")

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
                        TriggerServerEvent('Ouvre:avocat')
                    end
                })
                RageUI.Button("Annonce "..exports.Tree:serveurConfig().Serveur.color.."Fermetures", nil, {RightLabel = "→"}, not codesCooldown2, {
                    onSelected = function()
                        codesCooldown2 = true 
                        TriggerServerEvent('Ferme:avocat')
                    end
                })
                RageUI.Button("Annonce "..exports.Tree:serveurConfig().Serveur.color.."Recrutement", nil, {RightLabel = "→"}, not codesCooldown3, {
                    onSelected = function()
                        codesCooldown3 = true 
                        TriggerServerEvent('Recrutement:avocat')
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
        if ESX.PlayerData.job.name == 'avocat' then
            for k,v in pairs(Config.Jobs.AvocatJob.Clothes) do
                if #(coords - v.clothes) <= 10 then
                    DrawMarker(Config.Get.Marker.Type, v.clothes, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                    interval = 0
                    if #(coords - v.clothes) <= 3 then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu")
                        if IsControlJustPressed(0, 51) then
                            OpenClotheForAvocatJob = true
                            OpenClotheMenuAvocatJob()
                        end
                    end
                end
            end
        end
        Citizen.Wait(interval)
    end
end)

function OpenClotheMenuAvocatJob()
    local mainMenu = RageUI.CreateMenu("", "Faites vos actions")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while OpenClotheForAvocatJob do
        local PosMenuAvocatJob = vector3(-569.42, -334.00, 35.15)
        local ped = GetEntityCoords(PlayerPedId())
        local dist = #(ped - PosMenuAvocatJob)

        if dist >= 5 then
            OpenClotheForAvocatJob = false
            return
        end

        RageUI.IsVisible(mainMenu, function()
            if ServiceAvocat then
                RageUI.Button("Terminer son service", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                        ServiceAvocat = false
                        TriggerServerEvent('sendLogs:ServiceNo')
                        -- ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                        --     TriggerEvent('skinchanger:loadSkin', skin)
                        -- end)
                    end
                })
            else
                RageUI.Button("Prendre votre service", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                        ServiceAvocat = true
                        TriggerServerEvent('sendLogs:ServiceYes')
                        -- setClotheAvocatJob('avocat', PlayerPedId())
                    end
                })
            end
        end)

        local onPos = false
        for _, v in pairs(Config.Jobs.AvocatJob.Clothes) do
            if #(GetEntityCoords(PlayerPedId()) - v.clothes) > 10 then
                onPos = true
            end
        end

        -- if not RageUI.Visible(mainMenu) or onPos == false then
        --     mainMenu = RMenu:DeleteType('mainMenu', true)
        --     OpenClotheForAvocatJob = false
        -- end

        Citizen.Wait(0)
    end
end

function setClotheAvocatJob(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			TriggerEvent('skinchanger:loadClothes', skin, Config.Jobs.AvocatJob.Uniforms.male)
		else
			TriggerEvent('skinchanger:loadClothes', skin, Config.Jobs.AvocatJob.Uniforms.female)
		end
	end)
end

Citizen.CreateThread(function()

	local blip = AddBlipForCoord(-595.50, -344.98, 36.15)  
  
	SetBlipSprite (blip, 76) -- Model du blip
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.6) -- Taille du blip
	SetBlipColour (blip, 0) -- Couleur du blip
	SetBlipAsShortRange(blip, true)
  
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Cabinet Avocat') -- Nom du blip
	EndTextCommandSetBlipName(blip)
end)

local open = false 
local AvocatJobGarage = RageUI.CreateMenu('', 'Garage Avocat')
AvocatJobGarage.Display.Header = true 
AvocatJobGarage.Closed = function()
  open = false
end

function OpenMenuAvocatJob()
    if open then
        open = false
        RageUI.Visible(AvocatJobGarage, false)
        return
    else
        open = true
        RageUI.Visible(AvocatJobGarage, true)
        CreateThread(function()
            while open do 
                local PosMenuAvocatJob = vector3(-599.97, -338.46, 34.84)
                local ped = GetEntityCoords(PlayerPedId())
                local dist = #(ped - PosMenuAvocatJob)

                if dist >= 5 then
                    RageUI.Visible(AvocatJobGarage, false)
                    open = false
                    return
                end

                RageUI.IsVisible(AvocatJobGarage,function() 

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
                            TriggerServerEvent('avocat:spawnVehicleAvocat')
                            ESX.Game.SpawnVehicle('windsor2', vector3(-597.54, -334.02, 34.88 ), 303.23, function (vehicle)
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
	{x = -600.45, y =  -338.64, z =  34.84}
}

CreateThread(function()
    while true do
        local wait = 1000

        for k in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'avocat' then 
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

                if dist <= 15.0 then
                    wait = 0
                    if ServiceAvocat then
                        DrawMarker(Config.Get.Marker.Type, -600.45, -338.64, 34.84, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                        if dist <= 1.0 then
                            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage.")
                            if IsControlJustPressed(1,51) then
                                OpenMenuAvocatJob()
                            end
                        end
                    end
                end
            end
        end
        Wait(wait)
    end
end)