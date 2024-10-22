MOD_GangBuilder.Menus.MainBuilder = RageUI.CreateMenu("", "Gang builder")

local GangBuilderCreate = require 'src.addons.[ Builder ].sGangBuilder.menus.builder.submenus.CreateGang.index'
GangBuilderCreate:LoadMenu(MOD_GangBuilder.Menus.MainBuilder)

local GangBuilderList = require 'src.addons.[ Builder ].sGangBuilder.menus.builder.submenus.ListGang.index'
GangBuilderList:LoadMenu(MOD_GangBuilder.Menus.MainBuilder)

MOD_GangBuilder.Menus.MainBuilder:IsVisible(function(Items)
    Items:Button("Crée un gang", nil, { }, true, {
    }, GangBuilderCreate.Menu);

    Items:Button("Liste des gang", nil, { }, true, {
    }, GangBuilderList.Menu);
end)


RegisterNetEvent('Gamemode:GangBuilder:OpenGangBuilder')
AddEventHandler('Gamemode:GangBuilder:OpenGangBuilder', function(dataGang)
    MOD_GangBuilder.Menus.MainBuilder:Toggle()

    MOD_GangBuilder.GangList = dataGang
end)