local menu = {}

local SocietyAccountsMoney = require 'src.addons.[ Gameplay ].Society.menus.submenus.accounts.money'
local SocietyAccountsDirty_Money = require 'src.addons.[ Gameplay ].Society.menus.submenus.accounts.dirty_money'

function menu:LoadMenu(parent)
    menu.Menu = RageUI.CreateSubMenu(parent, "", "Garage")

    SocietyAccountsMoney:LoadMenu(menu.Menu)
    SocietyAccountsDirty_Money:LoadMenu(menu.Menu)

    menu.Menu:IsVisible(function(Items)

        Items:Button("Compte en banque", nil, {}, true, {}, SocietyAccountsMoney.Menu);
        Items:Button("Compte offshore", nil, {}, MOD_Society.data?.canUseOffShore, {}, SocietyAccountsDirty_Money.Menu);

    end)
end

return menu