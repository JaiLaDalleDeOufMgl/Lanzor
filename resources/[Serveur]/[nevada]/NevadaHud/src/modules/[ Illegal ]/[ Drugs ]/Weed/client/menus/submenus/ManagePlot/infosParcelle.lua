local menu = {}

function menu:SetData(data)
    menu.DataMenu = data
end
function menu:LoadMenu(parent)
    menu.Menu = RageUI.CreateSubMenu(parent, "", "Infos de la parcelle")

    menu.Menu:IsVisible(function(Items)
        Items:Separator('↓ Infos générale ↓')
    
        Items:Button("Nom de la parcelle:", nil, { RightLabel = menu.DataMenu.name }, true, {
        });
        Items:Button("Taille de la parcelle:", nil, { RightLabel = menu.DataMenu.size }, true, {
        });
    
        Items:Separator('↓ Infos sur la parcelle ↓')
    end, function()
    end)
end

return menu