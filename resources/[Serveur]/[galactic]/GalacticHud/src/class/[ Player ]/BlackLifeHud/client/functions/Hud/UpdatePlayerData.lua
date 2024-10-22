---@return void
function _GamemodeHud:UpdatePlayerData()

    sendUIMessage({
        event = 'SetPlayerData',
        PlayerData = {
            id = self.PlayerData.id,
            health = self.PlayerData.health,
            shield = self.PlayerData.shield,
            states = self.PlayerData.states
        }
    })

end