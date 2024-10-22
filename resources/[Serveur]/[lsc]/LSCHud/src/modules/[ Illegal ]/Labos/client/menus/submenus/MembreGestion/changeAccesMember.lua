local menu = {}

function menu:SetData(data)
    menu.DataMenu = data
end

function menu:LoadMenu(parent)
    menu.Menu = RageUI.CreateSubMenu(parent, "", "Modification du membre")

    menu.Menu:IsVisible(function(Items)
        Items:Separator('↓ Actions membre ↓')
        Items:Button("Nom du membre", nil, { RightLabel = menu.DataMenu.name }, true, {
        });
        Items:Button("Suprimer", nil, { RightLabel = "→→→" }, true, {
            onSelected = function()
                TriggerServerEvent('Gamemode:Labos:RemoveMembre', menu.DataMenu.license)
                RageUI.GoBack()
            end
        });

        Items:Separator("↓ Changer l'accès ↓")
        for name, acces in pairs(MOD_Labos.LabData.AccesList) do
            Items:Button(name, 'Appuyez sur entrer pour sélectionner cet accès', { RightLabel = "→→→" }, true, {
                onSelected = function()
                    TriggerServerEvent('Gamemode:Labos:ChangeMemberAcces', menu.DataMenu.license, name)
                    RageUI.GoBack()
                end
            });
        end
        
    end, function()
    end)
end

return menu