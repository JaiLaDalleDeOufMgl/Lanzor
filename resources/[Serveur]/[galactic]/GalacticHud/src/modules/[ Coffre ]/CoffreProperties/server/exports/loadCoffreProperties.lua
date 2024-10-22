exports("loadCoffreProperties", function(nameProperties, inventory, maxWeight)
    if (MOD_CoffreProperties.list[nameProperties] == nil) then
        _GamemodeCoffreProperties(inventory, nameProperties, maxWeight)
    end
end)