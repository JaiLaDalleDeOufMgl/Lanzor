function _GamemodeVehicule:IsPlayerHasKey(xPlayer)
    if (self:GetOwner() == xPlayer.getIdentifier()) then
        return true
    end

    if (xPlayer.job.name == self:GetOwner() or xPlayer.job2.name == self:GetOwner()) then
        return true
    end

    return false
end