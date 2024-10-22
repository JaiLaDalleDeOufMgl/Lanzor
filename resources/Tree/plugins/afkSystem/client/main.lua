local pointsAFK = {}
local inAFK = false


local ratelimit = false

RegisterCommand("afk", function(source, args, rawCommand)
    if ratelimit then
        ESX.ShowNotification(Tree.Config.Serveur.color.."Vous ne pouvez pas entrer dans la zone AFK pour le moment.")
        return
    end
    if IsPedSittingInAnyVehicle(PlayerPedId()) then
        ESX.ShowNotification(Tree.Config.Serveur.color.."Vous ne pouvez pas entrer dans la zone AFK dans un véhicule.")
        return
    end
    if not exports.Gamemode:IsInSafeZone() then
        ESX.ShowNotification(Tree.Config.Serveur.color.."Vous ne pouvez pas entrer dans la zone AFK en dehors de la zone de sécurité.")
        return
    end
    TriggerServerEvent("tree:afkSystem:enterZone")
    ratelimit = true
    SetTimeout(60000, function()
        ratelimit = false
    end)
end)


local MainMenuAFK = function()
    local MainMenuAFKShop = Tree.Menu.CreateMenu("", "Zone AFK")
    Tree.Menu.Visible(MainMenuAFKShop, true)
    CreateThread(function()
        while MainMenuAFKShop do
            MainMenuAFKShop.Closed = function() 
                Tree.Menu.Visible(MainMenuAFKShop, false)
                MainMenuAFKShop = false
            end
            Tree.Menu.IsVisible(MainMenuAFKShop, function()
                Tree.Menu.Separator("Vous avez "..pointsAFK.." points AFK")
                for k,v in pairs(SharedAFKSystem.boutique) do
                    Tree.Menu.Button(v.label, nil,  {RightLabel = Tree.Config.Serveur.color..v.price, RightBadge = Tree.Menu.BadgeStyle.GoldMedal}, true, {
                        onActive = function()
                            Tree.Menu.Info("Récompense: "..Tree.Config.Serveur.color..v.label, v.reward, {}, 400)
                        end,
                        onSelected = function()
                            TriggerServerEvent("tree:afkSystem:buyItemAFK", v)
                        end,
                    })
                end
            end, MainMenuAFKShop)
            Wait(1)
        end
    end)
end

