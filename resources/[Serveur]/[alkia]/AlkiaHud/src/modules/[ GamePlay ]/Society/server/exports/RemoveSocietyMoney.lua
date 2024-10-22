exports("RemoveSocietyMoney", function(societyName, amount)
    local society = MOD_Society:getSocietyByName(societyName)

    if (society) then
        society:RemoveMoney(amount)
        return true
    end

    return false
end)