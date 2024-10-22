AddEventHandler('Gamemode:Labos:Weed:OpenManagePlant', function(sizePlot, indexPlot, indexPot)
    local Loaded = false

    ESX.TriggerServerCallback("Gamemode:Labos:Weed:GetWeedInfosPot", function(infos)
        sendUIMessage({
            WeedInfosPlant = true,
            DataWeedInfosPlant   = {
                variety = infos.variety,
    
                state = infos.state,
    
                water = infos.water,
                health = infos.health,
                fertilizer = infos.fertilizer
            }
        })
    
        SetNuiFocus(true, true)

        MOD_Weed.LabData.OpenManagePlant = {
            sizePlot = sizePlot, 
            indexPlot = indexPlot, 
            indexPot = indexPot,

            data = infos
        }

        Loaded = true
    end, sizePlot, indexPlot, indexPot)

    while not Loaded do Wait(100) end

    CreateThread(function()
        while (type(MOD_Weed.LabData.OpenManagePlant) == "table") do
            ESX.TriggerServerCallback("Gamemode:Labos:Weed:GetWeedInfosPot", function(infos)
                if (not infos) then
                    sendUIMessage({
                        WeedInfosPlant = false
                    })
                
                    SetNuiFocus(false, false)
                
                    MOD_Weed.LabData.OpenManagePlant = nil

                    return
                end

                print(infos.state)

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
            end, sizePlot, indexPlot, indexPot)
        

            Wait(2000)
        end
    end)
end)