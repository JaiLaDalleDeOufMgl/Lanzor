local menu = {}

function menu:SetData(data)
    menu.DataMenu = data
end

local MenuAccesManager = require 'src.modules.[ Illegal ].Labos.client.menus.submenus.AccesGestion.accesManager'

function menu:LoadMenu(parent)
    menu.Menu = RageUI.CreateSubMenu(parent, "", "Gestion des accès")
    MenuAccesManager:LoadMenu(menu.Menu)
    
    menu.Menu:IsVisible(function(Items)
        Items:Button("Ajouter un accès", nil, {}, true, {
            onSelected = function()
                local AccesName = KeyboardInput("Choisir le nom de l'accès", "", 99);

                if (AccesName) then
                    TriggerServerEvent('Gamemode:Labos:AddNewAcces', AccesName)
                end
            end
        });

        Items:Separator('↓ Liste des accès ↓')

        for name, acces in pairs(MOD_Labos.LabData.AccesList) do
            Items:Button(name, nil, {}, true, {
                onSelected = function()
                    MenuAccesManager:SetData({
                        name = name,
                        acces = acces
                    })
                end
            }, MenuAccesManager.Menu);
        end

    end, function()
    end)
end

return menu