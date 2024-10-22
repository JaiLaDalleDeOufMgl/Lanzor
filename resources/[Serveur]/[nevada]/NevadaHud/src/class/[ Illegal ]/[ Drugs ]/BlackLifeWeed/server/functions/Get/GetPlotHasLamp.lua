function _GamemodeDrugWeed:GetPlotHasLamp(plotSize, plotIndex)
    local HasLamp = false

    for i=1, #self.plotList[plotSize][plotIndex].LampList do
        if (self.plotList[plotSize][plotIndex].LampList[i] ~= "empty") then
            HasLamp = true
        end
    end

    return HasLamp
end