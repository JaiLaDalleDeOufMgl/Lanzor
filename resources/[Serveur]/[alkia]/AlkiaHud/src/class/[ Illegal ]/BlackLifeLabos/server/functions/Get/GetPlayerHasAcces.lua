function _GamemodeLabos:GetPlayerHasAccess(xPlayer)
    if (xPlayer.identifier == self.owner) then return true end

    for license in pairs(self.memberList) do
        if (license == xPlayer.identifier) then
            return true
        end
    end

    return false
end