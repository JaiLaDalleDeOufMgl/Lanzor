local menu = {}

function menu:SetData(data)
    menu.DataMenu = data
end

local GangModifMembre = require 'src.addons.[ Builder ].sGangBuilder.menus.manage.submenus.ManageMembres.ModifMembre'

function menu:LoadMenu(parent)
    menu.Menu = RageUI.CreateSubMenu(parent, "", "Gestion des membres")
    GangModifMembre:LoadMenu(menu.Menu)
    
    menu.Menu:IsVisible(function(Items)

        if (not MOD_GangBuilder.data.membres) then
            Items:Separator("Chargement des membres...")
        else
            Items:Button("Ajouter un membre", nil, {}, true, {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Aucun joueur proche.');
                    else
                        TriggerServerEvent('Gamemode:GangBuilder:RecruitPlayer', GetPlayerServerId(closestPlayer), MOD_GangBuilder.data.infos.id)
                    end
                end
            });

            Items:Separator('↓↓ Liste des membres ↓↓')

            Items:Separator('↓ Owner du gang ↓')
            for license, membre in pairs(MOD_GangBuilder.data.membres) do
                if (membre.isOwner) then
                    Items:Button(membre.firstname.." "..membre.lastname, nil, { RightLabel = "Owner" }, false, {
                    });
                end
            end

            Items:Separator('↓ Membres du gang ↓')
            for license, membre in pairs(MOD_GangBuilder.data.membres) do
                if (not membre.isOwner) then
                    Items:Button(membre.firstname.." "..membre.lastname, nil, { RightLabel = membre.grade }, true, {
                        onSelected = function()
                            GangModifMembre:SetData({
                                license = license,
                                name = membre.firstname.." "..membre.lastname
                            })
                        end
                    }, GangModifMembre.Menu);
                end
            end
        end

    end, function()
    end)
end

return menu