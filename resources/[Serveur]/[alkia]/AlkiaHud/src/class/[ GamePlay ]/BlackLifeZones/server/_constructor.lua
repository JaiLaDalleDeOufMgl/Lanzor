_GamemodeZones = {}

local __instance = {
    __index = _GamemodeZones
}

setmetatable(_GamemodeZones, {
    __call = function(_, zoneId, coords, handler, requireJob, interactDistance, helpText, notSendCl)
        local self = setmetatable({}, __instance)

        self.id = zoneId
        self.coords = coords

        self.handler = handler
        self.requireJob = requireJob

        self.notSendCl = notSendCl

        self.helpText = helpText

        self.drawDistance = 10.0 --- TODO: CONFIG DRAWDISTANCE
        self.interactDistance = interactDistance

        --Functions
        exportMetatable(_GamemodeZones, self)

        return (self)
    end
})