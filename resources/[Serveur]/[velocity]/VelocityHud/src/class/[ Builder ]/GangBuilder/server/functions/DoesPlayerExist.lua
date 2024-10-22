function _GamemodeGangBuilder:DoesPlayerExist(xPlayer)
    if (xPlayer) then
        if (xPlayer.job2.name == self.name) then
            return true
        end
    end

    return false
end