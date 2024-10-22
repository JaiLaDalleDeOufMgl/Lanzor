function _GamemodeDrugWeed:GetWeedInfosPot(sizePlot, indexPlot, indexPot)
    local InfoPot = self.plotList[sizePlot][indexPlot].PotList[indexPot].metadata

    if (not InfoPot or InfoPot.finished) then return false end

    local Infos = {
        variety = InfoPot.variety,
        state = InfoPot.state,

        water = InfoPot.water,
        fertilizer = InfoPot.fertilizer,
        health = InfoPot.health
    }

    return (Infos)
end