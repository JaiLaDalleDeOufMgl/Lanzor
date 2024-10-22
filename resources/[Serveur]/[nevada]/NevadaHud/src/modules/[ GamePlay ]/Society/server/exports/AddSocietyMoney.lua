exports("AddSocietyMoney", function(societyName, amount)
    local society = MOD_Society:getSocietyByName(societyName)

    if (society) then
        society:AddMoney(amount)
        return true
    end

    return false
end)