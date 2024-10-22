local open = false 
local MenuShopBurgerShot = RageUI.CreateMenu('', 'Frigo') 
MenuShopBurgerShot.Display.Header = true 
MenuShopBurgerShot.Closed = function()
  	open = false
end

function ShopBurgerShot()
	if open then
		open = false
		RageUI.Visible(MenuShopBurgerShot, false)
		return
	else
		open = true 
		RageUI.Visible(MenuShopBurgerShot, true)
		CreateThread(function()
			while open do
				RageUI.IsVisible(MenuShopBurgerShot, function() 
					RageUI.Separator("↓ Cuisine ↓")

					RageUI.Button("Cornichons", nil, {RightLabel = "~g~7$"}, true , {
						onSelected = function()
							TriggerServerEvent('burgershot:BuyItem', 'cornichons', 7)
						end
					})

					RageUI.Button("Salades", nil, {RightLabel = "~g~7$"}, true , {
						onSelected = function()
							TriggerServerEvent('burgershot:BuyItem', 'salade', 7)
						end
					})

					RageUI.Button("Tomates", nil, {RightLabel = "~g~7$"}, true , {
						onSelected = function()
							TriggerServerEvent('burgershot:BuyItem', 'tomates', 7)
						end
					})

					RageUI.Button("Steak Haché", nil, {RightLabel = "~g~8$"}, true , {
						onSelected = function()
							TriggerServerEvent('burgershot:BuyItem', 'steak', 8)
						end
					})

					RageUI.Button("Pain", nil, {RightLabel = "~g~8$"}, true , {
						onSelected = function()
							TriggerServerEvent('burgershot:BuyItem', 'painburger', 8)
						end
					})

					RageUI.Separator("↓ Frites ↓")

					RageUI.Button("Frites", nil, {RightLabel = "~g~8$"}, true , {
						onSelected = function()
							TriggerServerEvent('burgershot:BuyItem', 'frites', 8)
						end
					})

					RageUI.Separator("↓ Boissons ↓")

					RageUI.Button("Coca", nil, {RightLabel = "~g~10$"}, true , {
						onSelected = function()
							TriggerServerEvent('burgershot:BuyItem', 'coca', 10)
						end
					})
		
					RageUI.Button("Orangina", nil, {RightLabel = "~g~10$"}, true , {
						onSelected = function()
							TriggerServerEvent('burgershot:BuyItem', 'orangina', 10)
						end
					})
				end)
				Citizen.Wait(wait)
			end
		end)
	end
end

local position = {
	{x = -1203.23, y = -896.05, z = 13.88}
}

Citizen.CreateThread(function()
	while true do
		local wait = 1000
		for k in pairs(position) do
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'burgershot' then
				local plyCoords = GetEntityCoords(PlayerPedId(), false)
				local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

				if dist <= 5.0 then
					wait = 0
					DrawMarker(20, -1203.23, -896.05, 13.88, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3,225, exports.Tree:serveurConfig().Serveur.colorMarkers.r, exports.Tree:serveurConfig().Serveur.colorMarkers.g, exports.Tree:serveurConfig().Serveur.colorMarkers.b, 0, 0, 0, 1, nil, nil, 0)

					if dist <= 1.0 then
						wait = 0
						ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le frigo")
						if IsControlJustPressed(1,51) then
							ShopBurgerShot()
						end
					end
				end
			end
			Wait(wait)
		end
	end
end)