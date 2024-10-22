_GamemodeCoffreSociety = {}

local __instance = {
    __index = _GamemodeCoffreSociety
}

setmetatable(_GamemodeCoffreSociety, {
    __call = function(_, jobName, coords, inventory, maxWeight, maxSlots)
        local self = setmetatable({}, __instance)

        self.jobName = jobName

        self.coordsCoffre = coords

        local defaultSlots = maxSlots or 100
        self.inventoryClass = MOD_inventory:loadSocietyInventory(jobName, inventory, defaultSlots, maxWeight, self)

        --Functions
        exportMetatable(_GamemodeCoffreSociety, self)

        MOD_CoffreSociety.list[jobName] = self

        return (self)
    end
})