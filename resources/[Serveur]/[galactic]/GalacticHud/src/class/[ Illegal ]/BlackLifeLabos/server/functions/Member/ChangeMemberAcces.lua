function _GamemodeLabos:ChangeMemberAcces(license, accesName)
    if (self.memberList[license]) then
        self.memberList[license].accesName = accesName

        local PlayersInBucket = self.bucket:GetPlayersInBucket()
        
        for _, src in pairs(PlayersInBucket) do
            TriggerClientEvent('Gamemode:Labos:ChangeAccesMember', src, license, accesName)
        end
    end
end