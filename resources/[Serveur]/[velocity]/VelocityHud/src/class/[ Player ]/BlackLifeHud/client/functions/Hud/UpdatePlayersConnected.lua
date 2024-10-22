---@return void
function _GamemodeHud:UpdatePlayersConnected(int)

    self.ServerInfos.playerConnected = int

    self:UpdateServerInfosData()

end