CreateThread(function()
	while ESX == nil do
		Wait(5000)
	end
    while ESX.GetPlayerData().job == nil do
        Wait(100)
    end
    ESX.PlayerData = ESX.GetPlayerData()
    if ESX.PlayerData.job.name == "ltd_sud" then 
        blips()
    end
end)

RegisterNetEvent('esx:setJob') --- Verification du job
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
    Wait(2000)
    if ESX.PlayerData.job.name == "ltd_sud" then
        blips()
    else
        RemoveBlip(blipstock) 
    end
end)

local open = false 
local MenuShopltd_sud = RageUI.CreateMenu('', 'Stock') 
MenuShopltd_sud.Display.Header = true 
MenuShopltd_sud.Closed = function()
  	open = false
end

function Shopltd_sud()
	if open then
		open = false
		RageUI.Visible(MenuShopltd_sud, false)
		return
	else
		open = true 
		RageUI.Visible(MenuShopltd_sud, true)
		CreateThread(function()
			while open do
				RageUI.IsVisible(MenuShopltd_sud, function() 

					RageUI.Separator("↓ Nourriture ↓")
					RageUI.Button("Chips", nil, {RightLabel = "~g~2$"}, true , {
						onSelected = function()
							TriggerServerEvent('ltd_sud:BuyItem', 'chips', 2)
						end
					})
					RageUI.Button("Sandwitch", nil, {RightLabel = "~g~4$"}, true , {
						onSelected = function()
							TriggerServerEvent('ltd_sud:BuyItem', 'casino_sandwitch', 4)
						end
					})
					RageUI.Button("Donuts", nil, {RightLabel = "~g~3$"}, true , {
						onSelected = function()
							TriggerServerEvent('ltd_sud:BuyItem', 'casino_donut', 3)
						end
					})
					RageUI.Button("Burger", nil, {RightLabel = "~g~20$"}, true , {
						onSelected = function()
							TriggerServerEvent('ltd_sud:BuyItem', 'casino_burger', 20)
						end
					})

					RageUI.Separator("↓ Boissons ↓")
					RageUI.Button("Coca", nil, {RightLabel = "~g~5$"}, true , {
						onSelected = function()
							TriggerServerEvent('ltd_sud:BuyItem', 'coca', 5)
						end
					})
					RageUI.Button("Café", nil, {RightLabel = "~g~5$"}, true , {
						onSelected = function()
							TriggerServerEvent('ltd_sud:BuyItem', 'cofee', 5)
						end
					})
					RageUI.Button("Orangina", nil, {RightLabel = "~g~5$"}, true , {
						onSelected = function()
							TriggerServerEvent('ltd_sud:BuyItem', 'orangina', 5)
						end
					})

					RageUI.Separator("↓ Autres ↓")
					RageUI.Button("Téléphone", nil, {RightLabel = "~g~400$"}, true , {
						onSelected = function()
							TriggerServerEvent('ltd_sud:BuyItem', 'phone', 400)
						end
					})
					RageUI.Button("Radio", nil, {RightLabel = "~g~1.000$"}, true , {
						onSelected = function()
							TriggerServerEvent('ltd_sud:BuyItem', 'radio', 1000)
						end
					})
					RageUI.Button("Capote", nil, {RightLabel = "~g~10$"}, true , {
						onSelected = function()
							TriggerServerEvent('ltd_sud:BuyItem', 'capote', 10)
						end
					})
					RageUI.Button("Cigarette", nil, {RightLabel = "~g~10$"}, true , {
						onSelected = function()
							TriggerServerEvent('ltd_sud:BuyItem', 'gitanes', 10)
						end
					})
					RageUI.Button("Jumelles", nil, {RightLabel = "~g~1500$"}, true , {
						onSelected = function()
							TriggerServerEvent('ltd_sud:BuyItem', 'jumelles', 1500)
						end
					})
					RageUI.Button("Canne à pêche", nil, {RightLabel = "~g~40$"}, true , {
						onSelected = function()
							TriggerServerEvent('ltd_sud:BuyItem', 'fishingrod', 40)
						end
					})
				end)
				Citizen.Wait(wait)
			end
		end)
	end
end

local position = {
	{x = 2747.72, y = 3473.08, z = 55.67}
}

Citizen.CreateThread(function()
	while true do
		local wait = 1000
		for k in pairs(position) do
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ltd_sud' then
				local plyCoords = GetEntityCoords(PlayerPedId(), false)
				local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

				if ServiceLtdSUD then
					if dist <= 5.0 then
						wait = 0
						DrawMarker(20, 2747.72, 3473.08, 55.67, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3,225, exports.Tree:serveurConfig().Serveur.colorMarkers.r, exports.Tree:serveurConfig().Serveur.colorMarkers.g, exports.Tree:serveurConfig().Serveur.colorMarkers.b, 0, 0, 0, 1, nil, nil, 0)

						if dist <= 1.0 then
							wait = 0
							ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le stock")
							if IsControlJustPressed(1,51) then
								open = true
								Shopltd_sud()
							end
						end
					end
				end
			end
			Wait(wait)
		end
	end
end)


function blips()
    blipstart = true
	blipstock = blapstock
	local blapstock = AddBlipForCoord(2747.72, 3473.08, 55.67)  
	SetBlipSprite (blapstock, 478) -- Model du blip
	SetBlipDisplay(blapstock, 4)
	SetBlipScale  (blapstock, 0.6) -- Taille du blip
	SetBlipColour (blapstock, 0) -- Couleur du blip
	SetBlipAsShortRange(blapstock, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Sotck LTD') -- Nom du blip
	EndTextCommandSetBlipName(blapstock)
end