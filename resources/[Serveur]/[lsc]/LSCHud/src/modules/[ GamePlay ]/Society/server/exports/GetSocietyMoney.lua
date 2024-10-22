exports("GetSocietyMoney", function(societyName)
    local society = MOD_Society:getSocietyByName(societyName)

    if (society) then
        return society:GetMoney()
    end

    return 0
end)