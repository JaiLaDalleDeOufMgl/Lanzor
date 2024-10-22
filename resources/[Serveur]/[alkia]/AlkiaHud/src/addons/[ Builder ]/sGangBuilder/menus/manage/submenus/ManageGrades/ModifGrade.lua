local menu = {}

function menu:SetData(data)
    menu.DataMenu = data
end

function menu:LoadMenu(parent)
    menu.Menu = RageUI.CreateSubMenu(parent, "", "Gestion de l'acces")

    local AccesList = Gamemode.enums.GangBuilder.GradeAccesShow

    menu.Menu:IsVisible(function(Items)
        Items:Button("Nom de l'acces", nil, { RightLabel = menu.DataMenu.label }, true, {
        });
        Items:Button("Suprimer", nil, { RightLabel = "→→→" }, true, {
            onSelected = function()
                TriggerServerEvent('Gamemode:GangBuilder:RemoveGrade', menu.DataMenu.name, MOD_GangBuilder.data.infos.id)
                RageUI.GoBack()
            end
        });

        Items:Separator('↓↓ Liste des accès ↓↓')

        for key, acces in pairs(AccesList) do

            if (acces.separator) then
                Items:Separator('↓ '.. acces.label ..' ↓')
            else
                local Cheked = "❌"
                if (menu.DataMenu.grade[acces.name]) then Cheked = "✅" end

                Items:Button(acces.label, nil, { RightLabel = Cheked }, true, {
                    onSelected = function()
                        if (menu.DataMenu.grade[acces.name]) then
                            menu.DataMenu.grade[acces.name] = false
                        else
                            menu.DataMenu.grade[acces.name] = true
                        end

                        TriggerServerEvent('Gamemode:GangBuilder:ChangeStateGrade', menu.DataMenu.name, acces.name, menu.DataMenu.grade[acces.name], MOD_GangBuilder.data.infos.id)
                    end
                });
            end
        end

    end, function()
    end)
end

return menu