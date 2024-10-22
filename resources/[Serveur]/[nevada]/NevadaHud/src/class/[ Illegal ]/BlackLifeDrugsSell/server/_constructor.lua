_GamemodeDrugsSell = {}

local __instance = {
    __index = _GamemodeDrugsSell
}

setmetatable(_GamemodeDrugsSell, {
    __call = function(_, DrugsSellId, coords, radius)
        local self = setmetatable({}, __instance)

        self.id = DrugsSellId

        self.coords = coords
        self.radius = radius

        --Functions
        exportMetatable(_GamemodeDrugsSell, self)

        return (self)
    end
})