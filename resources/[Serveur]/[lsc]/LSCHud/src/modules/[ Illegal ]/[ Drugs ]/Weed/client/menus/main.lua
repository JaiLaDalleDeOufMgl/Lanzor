MOD_Weed.LabData.MenuWeed = RageUI.CreateMenu("", "Gestion du labo de Weed")

local MenuGestionLabo = MOD_Labos:NewGestionLaboMenu(MOD_Weed.LabData.MenuWeed)
local WeedPlotManage = require 'src.modules.[ Illegal ].[ Drugs ].Weed.client.menus.submenus.ManagePlot.managParcelle'
WeedPlotManage:LoadMenu(MOD_Weed.LabData.MenuWeed)

MOD_Weed.LabData.MenuWeed:IsVisible(function(Items)
    Items:Button("Gestion du labo", nil, {}, true, {
    }, MenuGestionLabo);

    Items:Button("Gestion des parcelles de weed", nil, {}, true, {
    }, WeedPlotManage.Menu);
end, function()
end)



RegisterNetEvent('Gamemode:Labo:Weed:OpenWeedLaboManagement')
AddEventHandler('Gamemode:Labo:Weed:OpenWeedLaboManagement', function()
    MOD_Weed.LabData.MenuWeed:Toggle()
end)