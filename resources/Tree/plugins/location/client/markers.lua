CreateThread(function()
    for _,type in pairs(SharedLocation) do
        for k,v in pairs(type.position) do
            Tree.Function.Zone.create(k..':'..type.name, v, 5.0, {
                onEnter = function()
                    Tree.Function.While.addTick(0, k..':'..type.name..':drawmarker', function()
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder à la location")
                    end)
                    Tree.Function.Zone.create(k..':'..type.name..':press', v, 2.5, {
                        onPress = function()
                            LocationMainMenu(type.vehicles)
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


-- RegisterCommand("coordsP", function()
--     local coords = GetEntityCoords(PlayerPedId())
--     local heading = GetEntityHeading(PlayerPedId())
--     print(coords, heading)


-- end)

