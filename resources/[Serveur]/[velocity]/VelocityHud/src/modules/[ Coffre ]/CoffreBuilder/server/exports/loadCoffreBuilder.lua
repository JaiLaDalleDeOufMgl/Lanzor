exports("loadCoffreBuilder", function(jobCoffre, idCoffre, coordsCoffre, inventory, maxWeight)
    if (MOD_CoffreBuilder.list[idCoffre] == nil) then
        _GamemodeCoffreBuilder(jobCoffre, idCoffre, coordsCoffre, inventory, maxWeight)
    end

    while (MOD_CoffreBuilder.list[idCoffre] == nil) do
        Wait(250)
    end
end)