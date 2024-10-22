_GamemodeStatus = {}
_GamemodeStatus.className = "_GamemodeStatus"

local __instance = {
    __index = _GamemodeStatus,
}

setmetatable(_GamemodeStatus, {
    __call = function(_, name, value, tickcallback)
        local self = setmetatable({}, __instance)

        self.name = name
        self.val = value
        self.tickcallback = tickcallback

        --Functions
        exportMetatable(_GamemodeStatus, self)

        return (self)
    end
})