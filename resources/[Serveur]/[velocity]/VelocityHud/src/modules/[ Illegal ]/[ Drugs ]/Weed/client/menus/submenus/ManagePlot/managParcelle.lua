local menu = {}

local WeedPlotList = require 'src.modules.[ Illegal ].[ Drugs ].Weed.client.menus.submenus.ManagePlot.parcelleList'

function menu:LoadMenu(parent)
    menu.Menu = RageUI.CreateSubMenu(parent, "", "Gestion des parcelles de weed")
    WeedPlotList:LoadMenu(menu.Menu)

    menu.Menu:IsVisible(function(Items)
        Items:Separator('↓ Creation Parcelle ↓')
        Items:Button("Ajouter une petite parcelle", nil, {}, true, {
            onSelected = function()
                MOD_Weed:StartPlotShop('small')
                parent:Toggle()
            end
        });
        Items:Button("Ajouter une grande parcelle", nil, {}, true, {
            onSelected = function()
                MOD_Weed:StartPlotShop('big')
                parent:Toggle()
            end
        });

        Items:Separator('↓ Gestion des Parcelles ↓')
        Items:Button("Liste des parcelles", nil, {}, true, {}, WeedPlotList.Menu);
    end, function()
    end)
end

return menu