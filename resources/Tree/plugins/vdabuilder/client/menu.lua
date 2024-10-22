RegisterNetEvent("tree:vda:OpenMenuVDA", function(data)
    local MainMenuVDA = Tree.Menu.CreateMenu("", "VDA")
    Tree.Menu.Visible(MainMenuVDA, true)
    CreateThread(function()
        while MainMenuVDA do
            MainMenuVDA.Closed = function() 
                Tree.Menu.Visible(MainMenuVDA, false)
                MainMenuVDA = false
            end
            Tree.Menu.IsVisible(MainMenuVDA, function()
                for k,v in pairs(data) do 
                    if v.type == "item" then
                        Tree.Menu.Button(v.label, nil, {RightLabel = "~r~"..v.price.."$"}, true, {
                            onSelected = function()
                                TriggerServerEvent("tree:vdaBuilder:Paid", v)
                            end
                        })
                    elseif v.type == "weapon" then 
                        Tree.Menu.Button(v.label, nil, {RightLabel = "~r~"..v.price.."$"}, true, {
                            onSelected = function()
                                TriggerServerEvent("tree:vdaBuilder:Paid", v)
                            end
                        })
                    end
                end
            end, MainMenuVDA)
            Wait(1)
        end
    end)
end)