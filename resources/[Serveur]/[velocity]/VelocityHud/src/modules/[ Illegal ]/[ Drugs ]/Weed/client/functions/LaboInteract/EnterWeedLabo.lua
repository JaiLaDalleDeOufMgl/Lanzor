function MOD_Weed:EnterWeedLabo(plotData)
    self:SetWeedLaboPlotData(plotData)
    self.LabData.playerInLab = true

    self:StartPlotTask()
end