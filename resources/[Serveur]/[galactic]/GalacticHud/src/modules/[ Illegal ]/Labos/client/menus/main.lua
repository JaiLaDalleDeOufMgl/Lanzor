local MenuGestionAcces = require 'src.modules.[ Illegal ].Labos.client.menus.submenus.AccesGestion.gestionAcces'
local MenuGestionMember = require 'src.modules.[ Illegal ].Labos.client.menus.submenus.MembreGestion.gestionMembre'

function MOD_Labos:CreateMenuGestionLabo(Menu, MenuId)
    MenuGestionAcces:LoadMenu(MOD_Labos.MenuList[MenuId].main)
    MenuGestionMember:LoadMenu(MOD_Labos.MenuList[MenuId].main)

    Menu:IsVisible(function(Items)
        Items:Button("Gestion des accès", nil, {}, true, {
        }, MenuGestionAcces.Menu);

        Items:Button("Gestion des membres", nil, {}, true, {
        }, MenuGestionMember.Menu);
    end, function()
    end)

end