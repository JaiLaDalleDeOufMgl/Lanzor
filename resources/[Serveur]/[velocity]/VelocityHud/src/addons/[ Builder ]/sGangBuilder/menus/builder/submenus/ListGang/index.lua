local menu = {}

local GangBuilderSelectGang = require 'src.addons.[ Builder ].sGangBuilder.menus.builder.submenus.ListGang.SelectGang'

function menu:LoadMenu(parent)
    menu.Menu = RageUI.CreateSubMenu(parent, "", "Liste des gang")
    GangBuilderSelectGang:LoadMenu(menu.Menu)
    
    menu.Menu:IsVisible(function(Items)

        for i=1, #MOD_GangBuilder.GangList do
            Items:Button(MOD_GangBuilder.GangList[i].label, nil, { }, true, {
                onSelected = function()
                    GangBuilderSelectGang:SetData(MOD_GangBuilder.GangList[i])
                end
            }, GangBuilderSelectGang.Menu);
        end

    end)
end

return menu