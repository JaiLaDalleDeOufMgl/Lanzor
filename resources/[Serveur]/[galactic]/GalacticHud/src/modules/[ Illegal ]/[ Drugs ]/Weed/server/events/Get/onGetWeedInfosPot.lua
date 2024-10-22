ESX.RegisterServerCallback("Gamemode:Labos:Weed:GetWeedInfosPot", function(source, cb, sizePlot, indexPlot, indexPot)
    local xPlayer = ESX.GetPlayerFromId(source)

    local Lab = MOD_Labos:GetPlayerOnLabo(xPlayer)

    if (Lab) then
        cb(Lab.Drug:GetWeedInfosPot(sizePlot, indexPlot, indexPot))
    end
end)