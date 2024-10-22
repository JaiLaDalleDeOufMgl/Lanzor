local open = false 
local mainMenu8 = RageUI.CreateMenu('', 'Interaction')
local subMenu8 = RageUI.CreateSubMenu(mainMenu8, "", "Interaction")
local ObjectWeazel = RageUI.CreateSubMenu(mainMenu8, "", "Interaction")
local subMenu10 = RageUI.CreateSubMenu(mainMenu8, "", "Interaction")
local ServiceJournaliste = false
mainMenu8.Display.Header = true 
mainMenu8.Closed = function()
  open = false
end

function KeyboardInputJournaListTuCocoLesBye(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
  
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
      Citizen.Wait(0)
    end
  
    if UpdateOnscreenKeyboard() ~= 2 then
      local result = GetOnscreenKeyboardResult()
      return result
    else
      return nil
    end
end


function OpenWeazel()
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
            if ServiceJournaliste then
                RageUI.Button("Menu Objet", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                    end
                }, ObjectWeazel)

                RageUI.Button("Annonces", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                    end
                }, subMenu8)

                RageUI.Button("Faire une Facture", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                        local montant = KeyboardInputJournaListTuCocoLesBye("Montant:", 'Indiquez un montant', '', 7)
                        if tonumber(montant) == nil then
                            ESX.ShowNotification("Montant invalide")
                            return false
                        else
                            amount = (tonumber(montant))
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestDistance == -1 or closestDistance > 3.0 then
                                ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Personne autour de vous')
                            else
                                ESX.ShowNotification("~g~Facture envoyée avec succès !")
                                TriggerServerEvent('sendLogs:Facture', GetPlayerServerId(closestPlayer), amount)
                                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'journalist', 'Weazel News', amount)
                            end
                        end
                    end
                })    



            else
                RageUI.Separator(exports.Tree:serveurConfig().Serveur.color.."Vous devez etre en service") 
            end 
        end)
                RageUI.IsVisible(subMenu8,function() 
                    RageUI.Separator("↓ ~m~Statut ~s~↓")
                    RageUI.Button("Annonce ~g~Ouvertures", nil, {RightLabel = "→"}, not codesCooldown1, {
                        onSelected = function()
                            codesCooldown1 = true 
                            TriggerServerEvent('Ouvre:journalist')
                        end
                    })
                    RageUI.Button("Annonce "..exports.Tree:serveurConfig().Serveur.color.."Fermetures", nil, {RightLabel = "→"}, not codesCooldown2, {
                        onSelected = function()
                            codesCooldown2 = true 
                            TriggerServerEvent('Ferme:journalist')
                        end
                    })
                    RageUI.Separator("↓ ~m~Autre ~s~↓")
                    RageUI.Button("Annonce "..exports.Tree:serveurConfig().Serveur.color.."Recrutement", nil, {RightLabel = "→"}, not codesCooldown3, {
                        onSelected = function()
                            codesCooldown3 = true 
                            TriggerServerEvent('Recrutement:journalist')
                        end
                    })
                    RageUI.Button("Annonce "..exports.Tree:serveurConfig().Serveur.color.."Custom", nil, {RightLabel = "→"}, not codesCooldown4, {
                        onSelected = function()
                            codesCooldown4 = true 
                            local AnnonceCustom = KeyboardInputJournaListTuCocoLesBye("Annonce:", 'Indiquez votre message', '', 500)
                            if AnnonceCustom == nil or AnnonceCustom == "" then
                                ESX.ShowNotification("Erreur ! Message vide")
                            else
                                TriggerServerEvent('Custom:journalist', AnnonceCustom)
                            end
                        end
                    })
            end)

            RageUI.IsVisible(ObjectWeazel,function() 
                RageUI.Separator("↓ ~m~Caméra ~s~↓")
                RageUI.Button("Sortir une caméra (Petite)", nil, {RightLabel = "→"}, true, {
                    onSelected = function()
                        ExecuteCommand("e camera")
                    end
                })
                RageUI.Button("Sortir une caméra (Grande)", nil, {RightLabel = "→"}, true, {
                    onSelected = function()
                        ExecuteCommand("e newscam")
                    end
                })
                RageUI.Separator("↓ ~m~Micro~s~ ↓")
                RageUI.Button("Sortir un micro (Client)", nil, {RightLabel = "→"}, true, {
                    onSelected = function()
                        ExecuteCommand("e microcki")
                    end
                })
                RageUI.Button("Sortir un micro (Personelle)", nil, {RightLabel = "→"}, true, {
                    onSelected = function()
                        ExecuteCommand("e newsmic")
                    end
                })
                RageUI.Button("Sortir un micro perche", nil, {RightLabel = "→"}, true, {
                    onSelected = function()
                        ExecuteCommand("e newsbmic")
                    end
                })
                RageUI.Separator("↓ ~m~Autre~s~ ↓")
                RageUI.Button("Prendre des notes", nil, {RightLabel = "→"}, true, {
                    onSelected = function()
                        ExecuteCommand("e notepad")
                    end
                })
       end)

		 Wait(0)
		end
	 end)
  end
end

Citizen.CreateThread(function()
 
	local blip = AddBlipForCoord(-536.83, -887.38, 25.16)  
  
	SetBlipSprite (blip, 564) -- Model du blip
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.6) -- Taille du blip
	SetBlipColour (blip, 0) -- Couleur du blip
	SetBlipAsShortRange(blip, true)
  
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Weazel News') -- Nom du blip
	EndTextCommandSetBlipName(blip)
  end)

Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(500)
    end
    while true do
        local interval = 500
        local plyPed = PlayerPedId()
        local coords = GetEntityCoords(plyPed)
        if ESX.PlayerData.job.name == 'journalist' then
            for k,v in pairs(Config.Jobs.Journalist.Clothes) do
                if #(coords - v.clothes) <= 10 then
                    DrawMarker(Config.Get.Marker.Type, v.clothes, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                    interval = 1
                    if #(coords - v.clothes) <= 3 then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu")
                        if IsControlJustPressed(0, 51) then
                            CreateThread(function()
                                OpenClotheForJournaliste = true
                                OpenClotheMenuJournalist()
                            end)
                        end
                    end
                end
            end
        end
        Citizen.Wait(interval)
    end
end)

function OpenClotheMenuJournalist()
    local mainMenu = RageUI.CreateMenu("", "Faites vos actions")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while OpenClotheForJournaliste do
        RageUI.IsVisible(mainMenu, function()
            if ServiceJournaliste then
                RageUI.Button("Reprendre votre tenue civile", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                        ServiceJournaliste = false
                        TriggerServerEvent('sendLogs:ServiceNo')
                        -- ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                        --     TriggerEvent('skinchanger:loadSkin', skin)
                        -- end)
                    end
                })
            else
                RageUI.Button("Prendre votre service", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                        ServiceJournaliste = true
                        TriggerServerEvent('sendLogs:ServiceYes')
                        -- setClotheJournaliste('journaliste', PlayerPedId())
                    end
                })
            end
        end)

        local onPos = false
        for _, v in pairs(Config.Jobs.Journalist.Clothes) do
            if #(GetEntityCoords(PlayerPedId()) - v.clothes) > 10 then
                onPos = true
            end
        end

        -- if not RageUI.Visible(mainMenu) or onPos == false then
        --     mainMenu = RMenu:DeleteType('mainMenu', true)
        --     OpenClotheForJournaliste = false
        -- end

        Citizen.Wait(0)
    end
end

function setClotheJournaliste(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			TriggerEvent('skinchanger:loadClothes', skin, Config.Jobs.Journalist.Uniforms.male)
		else
			TriggerEvent('skinchanger:loadClothes', skin, Config.Jobs.Journalist.Uniforms.female)
		end
	end)
end



local open = false 
local journalistDeTesMort = RageUI.CreateMenu('', 'Garage Journalist')
journalistDeTesMort.Display.Header = true 
journalistDeTesMort.Closed = function()
  open = false
end

function OpenTesMortjournalist()
     if open then 
         open = false
         RageUI.Visible(journalistDeTesMort, false)
         return
     else
         open = true 
         RageUI.Visible(journalistDeTesMort, true)
         CreateThread(function()
         while open do 
          local PosMenujournalist = vector3(-536.83, -887.38, 25.16)
          local ped = GetEntityCoords(PlayerPedId())
          local dist = #(ped - PosMenujournalist)
          if dist >= 5 then
            RageUI.Visible(journalistDeTesMort, false)
            open = false
        else
          end
            RageUI.IsVisible(journalistDeTesMort,function() 

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

-- test
               RageUI.Separator("↓ "..exports.Tree:serveurConfig().Serveur.color.."Gestion Véhicule ~s~ ↓")

                RageUI.Button("Véhicule de Fonction", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        ESX.Game.SpawnVehicle('newsvan', vector3(-542.61, -900.10, 23.90 ), 161.32, function (vehicle)
                          local newPlate = exports['Gamemode']:GeneratePlate()
                          SetVehicleNumberPlateText(vehicle, newPlate)
                          exports[exports.Tree:serveurConfig().Serveur.hudScript]:SetFuel(vehicle, 100)
                          TriggerServerEvent('babyboy:GiveDoubleKeys', 'no', newPlate)
                          TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                          TriggerServerEvent('journaliste:spawnVehicleJournalist')
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
	{x = -536.83, y =  -887.38, z =  25.16}
}

Citizen.CreateThread(function()
    while true do

        local wait = 1000

        for k in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'journalist' then 
                local plyCoords = GetEntityCoords(PlayerPedId(), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

                if dist <= 15.0 then
                    wait = 0
                    if ServiceJournaliste then
                        DrawMarker(Config.Get.Marker.Type, -536.83, -887.38, 25.16, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                        if dist <= 1.0 then
                            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage.")
                            if IsControlJustPressed(1,51) then
                            OpenTesMortjournalist()
                            end
                        end
                    end
                end
            end
        end

        Wait(wait)
    end
end)