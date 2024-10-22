CreateThread(function()
    for _,type in pairs(SharedShops) do
        for k,v in pairs(type.position) do
            Tree.Function.Zone.create(k..':'..type.name, v, 5.0, {
                onEnter = function()
                    Tree.Function.While.addTick(0, k..':'..type.name..':drawmarker', function()
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder à la boutique")
                        Tree.Function.Visual.drawMarker(v)
                    end)
                    Tree.Function.Zone.create(k..':'..type.name..':press', v, 2.0, {
                        onPress = function()
                            ShopsMain(type.items)
                        end,
                        onExit = function()
                            Tree.Menu.CloseAll()
                        end
                    })
                end,
                onExit = function()
                    Tree.Function.While.removeTick(k..':'..type.name..':drawmarker')
                    Tree.Function.Zone.delete(k..':'..type.name..':press')
                end
            })
            Tree.Function.Blips.create((k..':'..type.name), v, type.blip.sprite, type.blip.color, type.blip.label)
        end
    end
end)
