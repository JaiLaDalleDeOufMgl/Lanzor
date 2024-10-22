Citizen.CreateThread(function()
    while ESX.GetPlayerData() == nil do  
        Citizen.Wait(100)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)


DEN = {}
function DEN:new()
    local DEN = {}
    setmetatable(DEN, self)
    self.__index = self
    return DEN
end

DEN = DEN:new()


RegisterNetEvent('esx:addInventoryItem')
AddEventHandler('esx:addInventoryItem', function(item)
	ESX.UI.ShowInventoryItemNotification(true, item.label, item.count)
	table.insert(ESX.PlayerData.inventory, item)
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(item, identifier)
	for i = 1, #ESX.PlayerData.inventory, 1 do
		if ESX.PlayerData.inventory[i].name == item.name and (not identifier or (item.unique and ESX.PlayerData.inventory[i].extra.identifier and ESX.PlayerData.inventory[i].extra.identifier == identifier)) then
			ESX.UI.ShowInventoryItemNotification(false, item.label, item.count)
			table.remove(ESX.PlayerData.inventory, i)
			break
		end
	end
end)