function MOD_CoffreGang:loadCoffreGang(jobName, coords, inventory, maxWeight, maxSlots)
    if (self.list[jobName] == nil) then
        _GamemodeCoffreGang(jobName, coords, inventory, maxWeight, maxSlots)
    end
end