
RegisterNetEvent("tree:carwash:cleanVehicle", function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    SetVehicleDirtLevel(vehicle, 0.0)
end)


local CarwashMain = function()
    local MainMenuCarWash = Tree.Menu.CreateMenu("", "CarWash")
    Tree.Menu.Visible(MainMenuCarWash, true)
    CreateThread(function()
        while MainMenuCarWash do
            MainMenuCarWash.Closed = function() 
                Tree.Menu.Visible(MainMenuCarWash, false)
                MainMenuCarWash = false
            end
            Tree.Menu.IsVisible(MainMenuCarWash, function()
                Tree.Menu.Button("Laver son véhicule", nil, {RightLabel = SharedCarWash.price.." $"}, true, {
                    onSelected = function()
                        TriggerServerEvent("tree:carwash:washVehicle", SharedCarWash.price)
                    end,
                })
            end, MainMenuCarWash)
            Wait(1)
        end
    end)
end


CreateThread(function()
    for k,v in pairs(SharedCarWash.position) do 
        Tree.Function.Zone.create("CarWash:"..k, v, 5.0, {
            onEnter = function()
                Tree.Function.While.addTick(0, 'drawmarker:'..k, function()
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu")
                    Tree.Function.Visual.drawMarker(v)
                end)
                Tree.Function.Zone.create('Carwash:press:'..k, v, 2.5, {
                    onPress = function()
                        if IsPedSittingInAnyVehicle(PlayerPedId()) then
                            CarwashMain()
                        else
                            ESX.ShowNotification("Vous devez être dans un véhicule pour accéder au menu")
                        end
                    end,
                    onExit = function()
                        Tree.Menu.CloseAll()
                    end
                })
            end,
            onExit = function()
                Tree.Function.While.removeTick('drawmarker:'..k)
                Tree.Function.Zone.delete('Carwash:press:'..k)
            end
        })
        Tree.Function.Blips.create("CarWash:"..k, v, 100, 3, "Station de lavage")
    end
end)