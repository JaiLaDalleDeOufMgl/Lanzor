local menu = {}

function menu:SetData(data)
    menu.DataMenu = data
end

function menu:LoadMenu(parent)
    menu.Menu = RageUI.CreateSubMenu(parent, "", "Gestion de l'acces")

    local DefaultAccesList = Gamemode.enums.Labos.AccessList['default']

    menu.Menu:IsVisible(function(Items)
        local DrugAccesList = Gamemode.enums.Labos.AccessList[MOD_Labos.LabData.DrugType]

        Items:Button("Nom de l'acces", nil, { RightLabel = menu.DataMenu.name }, true, {
        });
        Items:Button("Suprimer", nil, { RightLabel = "→→→" }, true, {
            onSelected = function()
                TriggerServerEvent('Gamemode:Labos:RemoveAcces', menu.DataMenu.name)
                RageUI.GoBack()
            end
        });

        Items:Separator('↓↓ Liste des accès du labo ↓↓')

        Items:Separator('↓ Acces labo ↓')

        for accesName, data in pairs(DefaultAccesList) do
            local Cheked = "❌"
            if (menu.DataMenu.acces[accesName]) then Cheked = "✅" end

            Items:Button(data.label, nil, { RightLabel = Cheked }, true, {
                onSelected = function()
                    if (menu.DataMenu.acces[accesName]) then
                        menu.DataMenu.acces[accesName] = nil
                    else
                        menu.DataMenu.acces[accesName] = true
                    end

                    TriggerServerEvent('Gamemode:Labos:ChangeStateAcces', menu.DataMenu.name, accesName, menu.DataMenu.acces[accesName])
                end
            });
        end

        Items:Separator('↓ Acces Drug ↓')
        for accesName, data in pairs(DrugAccesList) do
            local Cheked = "❌"
            if (menu.DataMenu.acces[accesName]) then Cheked = "✅" end

            Items:Button(data.label, nil, { RightLabel = Cheked }, true, {
                onSelected = function()
                    if (menu.DataMenu.acces[accesName]) then
                        menu.DataMenu.acces[accesName] = nil
                    else
                        menu.DataMenu.acces[accesName] = true
                    end

                    TriggerServerEvent('Gamemode:Labos:ChangeStateAcces', menu.DataMenu.name, accesName, menu.DataMenu.acces[accesName])
                end
            });
        end

    end, function()
    end)
end

return menu