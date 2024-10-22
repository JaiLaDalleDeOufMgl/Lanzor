local menu = {}

function menu:SetData(data)
    menu.DataMenu = data
end

function menu:LoadMenu(parent)
    menu.Menu = RageUI.CreateSubMenu(parent, "", "Gestion du Gang / Orga")
    
    menu.Menu:IsVisible(function(Items)

        Items:Separator("↓ Informations générales ↓")

        Items:Button("Nom du Gang / Orga:", nil, { RightLabel = menu.DataMenu.name }, true, { });
        Items:Button("Label du Gang / Orga:", nil, { RightLabel = menu.DataMenu.label }, true, { });
        
        Items:Separator("↓ Actions ↓")
        Items:Button("Se téléporter (Menu Boss)", nil, { }, true, {
            onSelected = function()
                TriggerServerEvent('Gamemode:GangBuilder:GotoMenuBoss', menu.DataMenu.id)

                RageUI.CloseAll()
            end
        });
        Items:Button("Suprimer", nil, { }, true, {
            onSelected = function()
                TriggerServerEvent('Gamemode:GangBuilder:DeleteGang', menu.DataMenu.id)
            
                RageUI.CloseAll()
            end
        });
        
        Items:Separator("↓ Reset ↓")
        Items:Button("Reset tout les grades", nil, { }, true, {
            onSelected = function()
            
            end
        });
        Items:Button("Reset tout les membres", nil, { }, true, {
            onSelected = function()
            
            end
        });
        Items:Button("Reset tout les vehicules", nil, { }, true, {
            onSelected = function()
            
            end
        });
        Items:Button("Reset tout le coffre", nil, { }, true, {
            onSelected = function()
            
            end
        });

    end)
end

return menu