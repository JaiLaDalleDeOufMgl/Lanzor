local menu = {}

function menu:SetData(data)
    menu.DataMenu = data
end

local GangModifGrade = require 'src.addons.[ Builder ].sGangBuilder.menus.manage.submenus.ManageGrades.ModifGrade'

function menu:LoadMenu(parent)
    menu.Menu = RageUI.CreateSubMenu(parent, "", "Gestion des grades")
    GangModifGrade:LoadMenu(menu.Menu)
    
    menu.Menu:IsVisible(function(Items)
        if (not MOD_GangBuilder.data.grades) then
            Items:Separator("Chargement des grades...")
        else
            Items:Button("Ajouter un grade", nil, {}, true, {
                onSelected = function()
                    local gradeName = KeyboardInput("Choisir le nom du grade", "", 99);

                    if (gradeName) then
                        TriggerServerEvent('Gamemode:GangBuilder:AddNewGrade', gradeName, MOD_GangBuilder.data.infos.id)
                    end
                end
            });

            Items:Separator('↓ Liste des grades ↓')

            for name, grade in pairs(MOD_GangBuilder.data.grades) do
                Items:Button(grade.label, nil, {}, true, {
                    onSelected = function()
                        GangModifGrade:SetData({
                            name = name,
                            label = grade.label,
                            grade = grade
                        })
                    end
                }, GangModifGrade.Menu);
            end
        end

    end, function()
    end)
end

return menu