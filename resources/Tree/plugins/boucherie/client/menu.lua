local BoucherieMain = function()
    local MainMenuBoucherie = Tree.Menu.CreateMenu("", "Boucherie")
    Tree.Menu.Visible(MainMenuBoucherie, true)
    CreateThread(function()
        while MainMenuBoucherie do
            MainMenuBoucherie.Closed = function() 
                Tree.Menu.Visible(MainMenuBoucherie, false)
                MainMenuBoucherie = false
            end
            Tree.Menu.IsVisible(MainMenuBoucherie, function()
                for k,v in pairs(SharedBoucherie.items) do 
                    Tree.Menu.Button(v.label, nil, {RightLabel = "~g~"..v.priceReseller.." $"}, true, {
                        onSelected = function()
                            TriggerServerEvent("tree:boucherie:sellItems", v)
                        end,
                    })
                end
            end, MainMenuBoucherie)
            Wait(1)
        end
    end)
end


CreateThread(function()
    for k,v in pairs(SharedBoucherie.position) do 
        Tree.Function.Zone.create("Boucherie:"..k, v, 5.0, {
            onEnter = function()
                Tree.Function.While.addTick(0, 'drawmarker:'..k, function()
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder à la boucherie")
                    Tree.Function.Visual.drawMarker(v)
                end)
                Tree.Function.Zone.create('Boucherie:press:'..k, v, 2.5, {
                    onPress = function()
                        BoucherieMain()
                    end,
                    onExit = function()
                        Tree.Menu.CloseAll()
                    end
                })
            end,
            onExit = function()
                Tree.Function.While.removeTick('drawmarker:'..k)
                Tree.Function.Zone.delete('Boucherie:press:'..k)
            end
        })
        Tree.Function.Blips.create("Boucherie:"..k, v, 478, 34, "Boucherie")
    end
end)