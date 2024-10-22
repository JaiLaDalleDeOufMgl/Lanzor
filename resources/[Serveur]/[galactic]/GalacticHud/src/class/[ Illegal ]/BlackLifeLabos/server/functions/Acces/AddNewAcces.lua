function _GamemodeLabos:AddNewAcces(accesName)
    self.AccesList[accesName] = {}

    local PlayersInBucket = self.bucket:GetPlayersInBucket()
    
    for _, src in pairs(PlayersInBucket) do
        TriggerClientEvent('Gamemode:Labos:AddNewAcces', src, accesName, self.AccesList[accesName])
    end
end