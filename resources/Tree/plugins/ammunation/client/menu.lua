
local havePPA = false

local AmmunationMain = function()
    Tree.TriggerServerCallback("tree:ammunation:getPPA", function(cb)            
        if cb then
            havePPA = true
        else 
            havePPA = false
        end
    end)
    local AmmunationMainMenu = Tree.Menu.CreateMenu("", "Armurerie")
    local whiteWeapon = Tree.Menu.CreateSubMenu(AmmunationMainMenu, "", "Catégorie : Armes Blanches")
    local letalWeapon = Tree.Menu.CreateSubMenu(AmmunationMainMenu, "", "Catégorie : Armes Létales")
    local accessories = Tree.Menu.CreateSubMenu(AmmunationMainMenu, "", "Catégorie : Accessoires")
    Tree.Menu.Visible(AmmunationMainMenu, true)
    CreateThread(function()
        while AmmunationMainMenu do
            AmmunationMainMenu.Closed = function() 
                Tree.Menu.Visible(AmmunationMainMenu, false)
                AmmunationMainMenu = false
            end
            Tree.Menu.IsVisible(AmmunationMainMenu, function()
                Tree.Menu.Separator("↓ Arme de mêlée ↓")
                Tree.Menu.Button("Armes Blanches", nil, {RightLabel = "→→→"}, true, {}, whiteWeapon)
                Tree.Menu.Separator("↓ Arme à feu ↓")
                if havePPA then 
                    Tree.Menu.Button("Armes Létales", nil, {RightLabel = "→→→"}, true, {}, letalWeapon)
                else
                    Tree.Menu.Button("Armes Létales", nil, {RightLabel = nil}, false, {})
                end
                Tree.Menu.Separator("↓ Autre ↓")
                Tree.Menu.Button("Accessoires", nil, {RightLabel = "→→→"}, true, {}, accessories)
                if not havePPA then
                    Tree.Menu.Button("Acheter le PPA", nil, {RightLabel = SharedAmmunation.pricePPA.." $"}, true, {
                        onSelected = function()
                            TriggerServerEvent("tree:ammunation:buyPPA")
                        end,
                    })
                else
                    Tree.Menu.Button("Acheter le PPA", nil, {RightLabel = SharedAmmunation.pricePPA.." $"}, false, {})
                end
            end, AmmunationMainMenu)
            Tree.Menu.IsVisible(whiteWeapon, function()
                for k,v in pairs(SharedAmmunation.Weapons.whiteWeapon) do 
                    Tree.Menu.Button(v.label, nil, {RightLabel = "~g~"..v.price.." $"}, true, {
                        onSelected = function()
                            TriggerServerEvent("tree:ammunation:buyWeapon", v)
                        end,
                    })
                end
            end)
            Tree.Menu.IsVisible(letalWeapon, function()
                for k,v in pairs(SharedAmmunation.Weapons.letalWeapon) do 
                    Tree.Menu.Button(v.label, nil, {RightLabel = "~g~"..v.price.." $"}, true, {
                        onSelected = function()
                            TriggerServerEvent("tree:ammunation:buyWeapon", v)
                        end,
                    })
                end
            end)
            Tree.Menu.IsVisible(accessories, function()
                for k,v in pairs(SharedAmmunation.Weapons.accessories) do 
                    Tree.Menu.Button(v.label, nil, {RightLabel = "~g~"..v.price.." $"}, true, {
                        onSelected = function()
                            TriggerServerEvent("tree:ammunation:buyWeapon", v)
                        end,
                    })
                end
            end)
            Wait(1)
        end
    end)
end