_GamemodeItems = {}

local __instance = {
    __index = _GamemodeItems
}

setmetatable(_GamemodeItems, {
    __call = function(_, type, data)
        local self = setmetatable({}, __instance)
    
        self.type = type
        self.name = data.name
        self.label = data.label
        self.weight = data.weight
        self.unique = false

        if (data.unique == 1) then
            self.unique = true
        end
        

        --Functions
        exportMetatable(_GamemodeItems, self)

        return (self)
    end
})