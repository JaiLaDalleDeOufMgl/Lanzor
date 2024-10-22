local desVehicles = {}
local desCategories= {}
local theCategories
local theCategorieslabel
local isInPreview = false




getCatalogue = function()
    ESX.TriggerServerCallback('catalogue:getCatalogue', function(cb)
        for i=1, #cb do
            local d = cb[i]
            table.insert(desCategories, {
                name = d.name,
                label = d.label,
            })
        end
    end)
end

getVehiclesCatalogue = function()
    ESX.TriggerServerCallback('catalogue:getAllVehicles', function(result)
        for i=1, #result do
            local d = result[i]
            table.insert(desVehicles, {
                model = d.model,
                name = d.name,
                price = d.price,
                category = d.category
            })
        end
    end)
end