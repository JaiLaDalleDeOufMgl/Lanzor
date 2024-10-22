_GamemodeHud = {}

local __instance = {
    __index = _GamemodeHud
}

setmetatable(_GamemodeHud, {
    __call = function()
        local self = setmetatable({}, __instance)

        self.StateHud = true
        self.StateSpeedoMeter = false
    
        self.PlayerData =  {
            id = GetPlayerServerId(PlayerId()),
            health = 0,
            shield = 0,
            states = nil
        }
        self.ServerInfos = {
            playerConnected = 0
        }

        
        self:UpdatePlayerData()
        self:LoadTaskSpeedoMeter()
        self:LoadTaskUpdateHealShieldAndStatus()

        --Functions
        exportMetatable(_GamemodeHud, self)

        return (self)
    end
})