MOD_GangBuilder.Menus.Manage = RageUI.CreateMenu("", "Gang builder")

local GangManageGrade = require 'src.addons.[ Builder ].sGangBuilder.menus.manage.submenus.ManageGrades.index'
GangManageGrade:LoadMenu(MOD_GangBuilder.Menus.Manage)

local GangManageMembres = require 'src.addons.[ Builder ].sGangBuilder.menus.manage.submenus.ManageMembres.index'
GangManageMembres:LoadMenu(MOD_GangBuilder.Menus.Manage)

MOD_GangBuilder.Menus.Manage:IsVisible(function(Items)
    Items:Separator(MOD_GangBuilder.data.infos.label);

    Items:Button("Gestion des grades", nil, { }, true, {
        onSelected = function()
            TriggerServerEvent('Gamemode:GangBuilder:RequestGrades', MOD_GangBuilder.data.infos.id)
        end
    }, GangManageGrade.Menu);
    Items:Button("Gestion des membres", nil, { }, true, {
        onSelected = function()
            TriggerServerEvent('Gamemode:GangBuilder:RequestGrades', MOD_GangBuilder.data.infos.id)
            TriggerServerEvent('Gamemode:GangBuilder:RequestMembres', MOD_GangBuilder.data.infos.id)
        end
    }, GangManageMembres.Menu);

end, nil, function()
    MOD_GangBuilder.data.infos = {}
end)


RegisterNetEvent('Gamemode:GangBuilder:OpenGangManage')
AddEventHandler('Gamemode:GangBuilder:OpenGangManage', function(gangInfos)
    MOD_GangBuilder.Menus.Manage:Toggle()

    MOD_GangBuilder.data.infos = gangInfos
end)