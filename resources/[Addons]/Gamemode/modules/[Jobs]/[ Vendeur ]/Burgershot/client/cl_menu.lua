local open = false 
local mainMenu8 = RageUI.CreateMenu('', 'Interaction')
local subMenu8 = RageUI.CreateSubMenu(mainMenu8, "", "Interaction")
local subMenu10 = RageUI.CreateSubMenu(mainMenu8, "", "Interaction")
local ServiceBurgerShot = false
mainMenu8.Display.Header = true 
mainMenu8.Closed = function()
  open = false
end

function OpenF6BurgerShot()
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

			if ServiceBurgerShot then
				RageUI.Button("Annonces BurgerShot", nil, {RightLabel = "→"}, true , {
					onSelected = function()
					end
				}, subMenu8)

				RageUI.Button("Faire une Facture", nil, {RightLabel = "→"}, true , {
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
								TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'burgershot', 'BurgerShot', amount)
							end
						end
					end
            	})
			else
                RageUI.Separator(exports.Tree:serveurConfig().Serveur.color.."Vous devez être en service") 
			end

			end)

			RageUI.IsVisible(subMenu8,function() 

				RageUI.Button("Annonce ~g~Ouvertures", nil, {RightLabel = "→"}, not codesCooldown1, {
					onSelected = function()
						codesCooldown1 = true 
						TriggerServerEvent('Ouvre:BurgerShot')
					end
				})

				RageUI.Button("Annonce "..exports.Tree:serveurConfig().Serveur.color.."Fermetures", nil, {RightLabel = "→"}, not codesCooldown2, {
					onSelected = function()
						codesCooldown2 = true 
						TriggerServerEvent('Ferme:BurgerShot')
					end
				})

				RageUI.Button("Annonce "..exports.Tree:serveurConfig().Serveur.color.."Recrutement", nil, {RightLabel = "→"}, not codesCooldown3, {
					onSelected = function()
						codesCooldown3 = true 
						TriggerServerEvent('Recrutement:BurgerShot')
					end
				})

		   end)

		 Wait(0)
		end
	 end)
  end
end

function setUniformBurger(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			TriggerEvent('skinchanger:loadClothes', skin, Config.Jobs.Burgershot.Uniforms.male)
		else
			TriggerEvent('skinchanger:loadClothes', skin, Config.Jobs.Burgershot.Uniforms.female)
		end
	end)
end

function BurgerClotheMenu()
    local mainMenu = RageUI.CreateMenu("", "Faites vos actions")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while openClothesforBurgershot do

		local PosMenuBurgerJob = vector3(-1196.84, -901.89, 13.88)
		local ped = GetEntityCoords(PlayerPedId())
		local dist = #(ped - PosMenuBurgerJob)
	
		if dist >= 5 then
			openClothesforBurgershot = false
			return
		end

        RageUI.IsVisible(mainMenu, function()
			if ServiceBurgerShot then
				RageUI.Button("Reprendre votre tenue civile", nil, {RightLabel = "→"}, true , {
					onSelected = function()
						ServiceBurgerShot = false
						TriggerServerEvent('sendLogs:ServiceNo')
						--ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
						--	TriggerEvent('skinchanger:loadSkin', skin)
						--end)
					end
				})
			else
				RageUI.Button("Prendre votre tenue", nil, {RightLabel = "→"}, true , {
					onSelected = function()
						ServiceBurgerShot = true
						TriggerServerEvent('sendLogs:ServiceYes')
						-- setUniformBurger('burgershot', PlayerPedId())
					end
				})
			end
        end)

        local onPos = false
        for _, v in pairs(Config.Jobs.Burgershot.Clothes) do
            if #(GetEntityCoords(PlayerPedId()) - v.clothes) > 10 then
                onPos = true
            end
        end

        -- if not RageUI.Visible(mainMenu) or onPos == false then
        --     mainMenu = RMenu:DeleteType('mainMenu', true)
        --     openClothesforBurgershot = false
        -- end

        Citizen.Wait(0)
    end
end


-- function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

-- 	AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
--     DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
--     blockinput = true

--     while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
--         Citizen.Wait(0)
--     end
        
--     if UpdateOnscreenKeyboard() ~= 2 then
--         local result = GetOnscreenKeyboardResult() 
--         Citizen.Wait(500) 
--         blockinput = false
--         return result 
--     else
--         Citizen.Wait(500) 
--         blockinput = false 
--         return nil 
--     end
-- end

CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Wait(500)
    end
    while true do
        local interval = 1000
        local plyPed = PlayerPedId()
        local coords = GetEntityCoords(plyPed)
        if ESX.PlayerData.job.name == 'burgershot' then
            for k,v in pairs(Config.Jobs.Burgershot.Clothes) do
			if #(coords - v.clothes) <= 10 then
				DrawMarker(20, v.clothes, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
				interval = 0
				if #(coords - v.clothes) <= 3 then
					ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu")
					if IsControlJustPressed(0, 51) then
						CreateThread(function()
							openClothesforBurgershot = true
							BurgerClotheMenu()
						end)
					end
				end
			end
            end
        end
        Wait(interval)
    end
end)

CreateThread(function()
 
	local blip = AddBlipForCoord(-1191.99, -889.81, 302.66)  
  
	SetBlipSprite (blip, 106) -- Model du blip
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.6) -- Taille du blip
	SetBlipColour (blip, 46) -- Couleur du blip
	SetBlipAsShortRange(blip, true)
  
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('BurgerShot') -- Nom du blip
	EndTextCommandSetBlipName(blip)
  end)

