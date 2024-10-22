local items = {
    ["viande_1"] = {price = 125, sell = true},
    ["viande_2"] = {price = 150, sell = true},
}

RegisterNetEvent("tree:boucherie:sellItems", function(v)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local haveItem = xPlayer.getInventoryItem(v.itemName)
    local verifItem = items[v.itemName]
    if verifItem == nil then return end
    if verifItem.sell ~= true then return end
    if not xPlayer then
        return 
    end
    if haveItem then
        if haveItem.count > 0 then
            xPlayer.removeInventoryItem(v.itemName, 1)
            xPlayer.addAccountMoney('cash', v.priceReseller)
            xPlayer.showNotification("~g~Vous avez vendu "..v.label.." pour "..v.priceReseller.."$")
        end
    else
        xPlayer.showNotification(Tree.Config.Serveur.color.."Vous n'avez pas de "..v.label.." à vendre !")
    end
end)