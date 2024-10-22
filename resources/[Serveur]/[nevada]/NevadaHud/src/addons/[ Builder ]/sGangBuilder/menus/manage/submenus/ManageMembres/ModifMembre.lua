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
        Items:Button("Virer le membre", nil, { RightLabel = "→→→" }, true, {
            onSelected = function()
                TriggerServerEvent('Gamemode:GangBuilder:RemoveMembre', MOD_GangBuilder.data.infos.id, menu.DataMenu.license)
                RageUI.GoBack()
            end
        });

        Items:Separator("↓ Changer l'accès ↓")
        for name, grade in pairs(MOD_GangBuilder.data.grades) do
            Items:Button(grade.label, 'Appuyez sur entrer pour sélectionner cet accès', { RightLabel = "→→→" }, true, {
                onSelected = function()
                    TriggerServerEvent('Gamemode:GangBuilder:ChangeMemberAcces', menu.DataMenu.license, name, MOD_GangBuilder.data.infos.id)
                    RageUI.GoBack()
                end
            });
        end
        
    end, function()
    end)
end

return menu