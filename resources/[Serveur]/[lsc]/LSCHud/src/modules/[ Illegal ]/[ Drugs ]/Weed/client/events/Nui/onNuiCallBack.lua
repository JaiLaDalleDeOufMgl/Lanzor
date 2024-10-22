RegisterNUICallback('nui:Gamemode:Weed:CallbackSelectSeed', function(data)
    sendUIMessage({
        WeedSelectSeed = false,
        seedSelectId = 0
    })
    SetNuiFocus(false, false)

    TriggerEvent('Gamemode:Labo:Weed:ReadySelectWeed:'..data.selectSeedId, data.variety)
end)
RegisterNUICallback('nui:Gamemode:Drugs:Weed:CloseWeedSelectSeed', function(data)
    sendUIMessage({
        WeedSelectSeed = false,
        seedSelectId = 0
    })
    SetNuiFocus(false, false)

    TriggerEvent('Gamemode:Labo:Weed:ReadySelectWeed:'..data.selectSeedId, false)
end)


RegisterNUICallback('nui:Gamemode:Drugs:Weed:CloseWeedManagePlant', function()
    sendUIMessage({
        WeedInfosPlant = false
    })

    SetNuiFocus(false, false)

    MOD_Weed.LabData.OpenManagePlant = nil
end)

RegisterNUICallback('nui:Gamemode:Drugs:Weed:AddWater', function()
    local Info = MOD_Weed.LabData.OpenManagePlant
    TriggerServerEvent('Gamemode:Labo:Weed:AddWaterOnPot', Info.sizePlot, Info.indexPlot, Info.indexPot)
    
    ESX.TriggerServerCallback("Gamemode:Labos:Weed:GetWeedInfosPot", function(infos)
        sendUIMessage({
            event = 'UpdateWeedInfosPot',
            DataWeedInfosPlant   = {
                variety = infos.variety,
    
                state = infos.state,
    
                water = infos.water,
                health = infos.health,
                fertilizer = infos.fertilizer
            }
        })
    end, Info.sizePlot, Info.indexPlot, Info.indexPot)
end)

RegisterNUICallback('nui:Gamemode:Drugs:Weed:AddFertilizer', function()
    local Info = MOD_Weed.LabData.OpenManagePlant
    TriggerServerEvent('Gamemode:Labo:Weed:AddFertilizer', Info.sizePlot, Info.indexPlot, Info.indexPot)
    
    ESX.TriggerServerCallback("Gamemode:Labos:Weed:GetWeedInfosPot", function(infos)
        sendUIMessage({
            event = 'UpdateWeedInfosPot',
            DataWeedInfosPlant   = {
                variety = infos.variety,
    
                state = infos.state,
    
                water = infos.water,
                health = infos.health,
                fertilizer = infos.fertilizer
            }
        })
    end, Info.sizePlot, Info.indexPlot, Info.indexPot)
end)