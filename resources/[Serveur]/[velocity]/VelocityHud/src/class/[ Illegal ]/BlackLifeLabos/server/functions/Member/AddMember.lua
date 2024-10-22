function _GamemodeLabos:AddMember(targetId)
    local targetPlayer = ESX.GetPlayerFromId(targetId)
    local PlayersInBucket = self.bucket:GetPlayersInBucket()

    if (targetPlayer) then
        if (self.memberList[targetPlayer.identifier]) then
            print('USER ALREADY EXIST')
        else
            self.memberList[targetPlayer.identifier] = {
                name = targetPlayer.name,
                accesName = false
            }

            for _, src in pairs(PlayersInBucket) do
                TriggerClientEvent('Gamemode:Labos:AddMember', src, targetPlayer.identifier, self.memberList[targetPlayer.identifier])
            end
        end
    end
end