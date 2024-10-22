RegisterCommand('giveclothe', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    
	xPlayer.addInventoryItem("clothes_pants", 1, { pants_1 = 3, pants_2 = 0 }, true)
	xPlayer.addInventoryItem("clothes_shoes", 1, { shoes_1 = 3, shoes_2 = 0 }, true)
	xPlayer.addInventoryItem("clothes_bag", 1, { bags_1 = 5, bags_2 = 0 }, true)
end)