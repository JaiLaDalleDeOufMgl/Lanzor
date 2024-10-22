

local ShopsMain = function(items)
    Tree.Menu.CloseAll()
    local MainMenuShop = Tree.Menu.CreateMenu("", "Shops")
    Tree.Menu.Visible(MainMenuShop, true)
    CreateThread(function()
        while MainMenuShop do
            MainMenuShop.Closed = function() 
                Tree.Menu.Visible(MainMenuShop, false)
                MainMenuShop = false
            end
            Tree.Menu.IsVisible(MainMenuShop, function()
                for _,v in pairs(items) do
                    Tree.Menu.Button(v.label, nil, {RightLabel = "~g~"..v.price.."$"}, true, {
                        onSelected = function()
                            TriggerServerEvent("tree:shop:buyItem", v)
                        end,
                    })
                
                end



            end, MainMenuShop)
            Wait(1)
        end
    end)
end