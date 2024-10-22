local menu = {}

local WeedInfosPlot = require 'src.modules.[ Illegal ].[ Drugs ].Weed.client.menus.submenus.ManagePlot.infosParcelle'

function menu:LoadMenu(parent)
    menu.Menu = RageUI.CreateSubMenu(parent, "", "Liste des parcelles")
    WeedInfosPlot:LoadMenu(menu.Menu)

    menu.Menu:IsVisible(function(Items)
        Items:Separator('↓ Liste des petites parcelles ↓')

        local NumberSmall = false
        for i = 1, #MOD_Weed.LabData.Data.plotList['small'] do
            if (MOD_Weed.LabData.Data.plotList['small'][i] ~= "empty") then
                NumberSmall = true
                Items:Button(MOD_Weed.LabData.Data.plotList['small'][i].name, nil, {}, true, {
                    onSelected = function()
                        local WeedPlotInfos = MOD_Weed.LabData.Data.plotList['small'][i]
                        WeedPlotInfos.size = 'Petite'

                        WeedInfosPlot:SetData(WeedPlotInfos)
                    end
                }, WeedInfosPlot.Menu);
            end
        end
        if (not NumberSmall) then
            Items:Separator("Vous n'avez pas de petite parcelle")
        end


        Items:Separator('↓ Liste des grandes parcelles ↓')


        local NumberBig = false
        for i = 1, #MOD_Weed.LabData.Data.plotList['big'] do
            if (MOD_Weed.LabData.Data.plotList['big'][i] ~= "empty") then
                NumberBig = true
                Items:Button("Parcelle N°" .. i, nil, {}, true, {
                });
            end
        end
        if (not NumberBig) then
            Items:Separator("Vous n'avez pas de grande parcelle")
        end
    end, function()
    end)
end

return menu
