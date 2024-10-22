CreateThread(function()
    for k,v in pairs(SharedAFKSystem.leaveZone) do 
        Tree.Function.Zone.create("AFKSystemLeave:"..k, v, 3.0, {
            onEnter = function()
                Tree.Function.While.addTick(0, 'drawmarker:'..k, function()
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour quitter la zone AFK")
                end)
                Tree.Function.Zone.create('AFKSystem:press:'..k, v, 2.5, {
                    onPress = function()
                        TriggerServerEvent("tree:afkSystem:exitZone")
                    end,
                })
            end,
            onExit = function()
                Tree.Function.While.removeTick('drawmarker:'..k)
                Tree.Function.Zone.delete('AFKSystem:press:'..k)
            end
        })
        local model = "a_m_y_business_03"
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(1)
        end
        local ped = CreatePed(4, model, v.x, v.y, v.z, 287.10925292969, false, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
        local name = CreateMpGamerTag(ped, "AFK", false, false, "", false)
    end
    for k,v in pairs(SharedAFKSystem.shopZone) do 
        Tree.Function.Zone.create("AFKSystemShop:"..k, v, 5.0, {
            onEnter = function()
                Tree.Function.While.addTick(0, 'drawmarker:'..k, function()
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour parler à Lanzor")
                end)
                Tree.Function.Zone.create('AFKSystem:press:'..k, v, 2.5, {
                    onPress = function()
                        Tree.TriggerServerCallback("tree:afkSystem:getCoins", function(data)
                            pointsAFK = data
                            MainMenuAFK()
                        end)
                    end,
                    onExit = function()
                    end
                })
            end,
            onExit = function()
                Tree.Function.While.removeTick('drawmarker:'..k)
                Tree.Function.Zone.delete('AFKSystem:press:'..k)
            end
        })
        local model = "a_m_y_business_03"
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(1)
        end
        local ped = CreatePed(4, model, v.x, v.y, v.z, 286.03768920898, false, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
        local name = CreateMpGamerTag(ped, "Lanzor", false, false, "", false)
    end
end)

