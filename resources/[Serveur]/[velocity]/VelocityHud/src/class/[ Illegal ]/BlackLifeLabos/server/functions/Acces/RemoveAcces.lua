function _GamemodeLabos:RemoveAcces(accesName)
    self.AccesList[accesName] = nil

    local PlayersInBucket = self.bucket:GetPlayersInBucket()
    
    for _, src in pairs(PlayersInBucket) do
        TriggerClientEvent('Gamemode:Labos:RemoveAcces', src, accesName)
    end
end