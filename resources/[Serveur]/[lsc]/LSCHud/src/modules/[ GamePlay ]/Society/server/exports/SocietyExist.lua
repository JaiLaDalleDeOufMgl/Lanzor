exports("SocietyExist", function(societyName)
    return MOD_Society:getSocietyByName(societyName) ~= nil
end)