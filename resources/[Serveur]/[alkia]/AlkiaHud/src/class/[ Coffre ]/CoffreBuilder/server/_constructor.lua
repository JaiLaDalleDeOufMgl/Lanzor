_GamemodeCoffreBuilder = {}

local __instance = {
    __index = _GamemodeCoffreBuilder
}

setmetatable(_GamemodeCoffreBuilder, {
    __call = function(_, jobCoffre, idCoffre, coordsCoffre, inventory, maxWeight)
        local self = setmetatable({}, __instance)

        self.idCoffre = idCoffre
        self.jobCoffre = jobCoffre

        self.coordsCoffre = idCoffre

        local defaultSlots = 100
        self.inventoryClass = MOD_inventory:loadCoffreBuilderInventory(idCoffre, inventory, defaultSlots, maxWeight, self)

        --Functions
        exportMetatable(_GamemodeCoffreBuilder, self)

        MOD_CoffreBuilder.list[idCoffre] = self

        return (self)
    end
})