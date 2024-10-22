function MOD_GangBuilder:GetPlayerHasAccesAdmin(xPlayer)
    for grade in pairs(Gamemode.enums.GangBuilder.AdminList) do
        if (grade == xPlayer.getGroup()) then
            return true
        end
    end

    return false
end