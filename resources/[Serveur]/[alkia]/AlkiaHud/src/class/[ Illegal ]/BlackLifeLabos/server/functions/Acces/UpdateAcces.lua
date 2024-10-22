function _GamemodeLabos:UpdateAcces(name, accesName, state)
    self.AccesList[name][accesName] = state

    local PlayersInBucket = self.bucket:GetPlayersInBucket()
    
    for _, src in pairs(PlayersInBucket) do
        TriggerClientEvent('Gamemode:Labos:UpdateAcces', src, name, self.AccesList[name])
    end
end