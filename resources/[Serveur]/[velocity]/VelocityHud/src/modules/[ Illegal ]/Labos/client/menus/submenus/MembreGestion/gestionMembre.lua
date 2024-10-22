local menu = {}

local MenuChangeAccesMember = require 'src.modules.[ Illegal ].Labos.client.menus.submenus.MembreGestion.changeAccesMember'

function menu:LoadMenu(parent)
    menu.Menu = RageUI.CreateSubMenu(parent, "", "Gestion des membres")
    MenuChangeAccesMember:LoadMenu(menu.Menu)

    menu.Menu:IsVisible(function(Items)
        Items:Button("Ajouter un membre", nil, {}, true, {
            onSelected = function()
                local IdTarget = KeyboardInput("Indiquer l'id", "", 99);

                if (IdTarget) then
                    TriggerServerEvent('Gamemode:Labos:AddMember', IdTarget)
                end
            end
        });

        Items:Separator('↓ Liste des membres ↓')
        
        for license, data in pairs(MOD_Labos.LabData.memberList) do
            if (not data.accesName) then data.accesName = "Pas d'accès" end

            Items:Button(data.name, 'Appuyez sur entrer pour modifier les paramètre du membre', { RightLabel = data.accesName.." →→→" }, true, {
                onSelected = function()
                    MenuChangeAccesMember:SetData({
                        license = license,
                        name = data.name
                    })
                end
            }, MenuChangeAccesMember.Menu);
        end
    end, function()
    end)
end

return menu