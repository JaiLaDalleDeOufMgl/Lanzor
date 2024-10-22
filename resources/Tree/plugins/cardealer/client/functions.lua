function getAllCatalogues()
    Tree.TriggerServerCallback("tree:cardealer:getCategories", function(result)
        dataCarDealer.data = result
    end)
end

function getAllVehicles()
    Tree.TriggerServerCallback("tree:cardealer:getVehicles", function(result)
        dataCarDealer.dataVehicles = result
    end)
end

