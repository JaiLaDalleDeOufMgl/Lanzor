local Menu = function()
    Tree.Menu.CloseAll()
    MainMenu = Tree.Menu.CreateMenu("Menu", "Categorie disponibles")
    Tree.Menu.Visible(MainMenu, true)
    CreateThread(function()
        while MainMenu do
            MainMenu.Closed = function() Tree.Menu.Visible(MainMenu, false) MainMenu = false end
            Tree.Menu.IsVisible(MainMenu, function()
                Tree.Menu.Button("Armes Blanches", nil, {RightLabel = "→"}, true, {})
                Tree.Menu.Button("Munitions", nil, {RightLabel = "→"}, true, {})
            end)
            Wait(1)
        end
    end)
end

local main = Tree.ContextUI:CreateMenu(1, "Example title")
local submenu = Tree.ContextUI:CreateSubMenu(main)

Tree.ContextUI:IsVisible(main, function(Entity)
    for i=1, 10 do
        Tree.ContextUI:Button("Button #"..i, nil, function(onSelected)
            if (onSelected) then
                print("onSelected #"..i)
                submenu.Title = "Button #"..i
            end
        end, submenu)
    end
end)

Tree.ContextUI:IsVisible(submenu, function(Entity)
    for k, v in pairs(Entity) do
        Tree.ContextUI:Button(k, v, function(onSelected)
            if onSelected then
                print(v)
            end
        end)
    end
end)

-- Keys.Register("LMENU", "LMENU", "Enable / disable focus mode.", function()
--     Tree.ContextUI.Focus = not Tree.ContextUI.Focus;
-- end)

-- RegisterCommand('menu', Menu, false)

