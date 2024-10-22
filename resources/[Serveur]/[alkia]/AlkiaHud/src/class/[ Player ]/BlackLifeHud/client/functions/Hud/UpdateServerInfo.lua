---@return void
function _GamemodeHud:UpdateServerInfosData(bool)

    sendUIMessage({
        event = 'SetServerInfosData',
        ServerInfos = {
            playerConnected = self.ServerInfos.playerConnected
        }
    })

end