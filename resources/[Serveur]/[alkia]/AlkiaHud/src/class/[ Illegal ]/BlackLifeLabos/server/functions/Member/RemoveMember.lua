function _GamemodeLabos:RemoveMembre(license)
    if (self.memberList[license]) then
        self.memberList[license] = nil

        local PlayersInBucket = self.bucket:GetPlayersInBucket()

        for _, src in pairs(PlayersInBucket) do
            TriggerClientEvent('Gamemode:Labos:RemoveMember', src, license)
        end
    end
end