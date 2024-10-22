local menu = {}

function menu:LoadMenu(parent)
    menu.Menu = RageUI.CreateSubMenu(parent, "", "Garage")

    menu.Menu:IsVisible(function(Items)
        Items:Separator(string.format("Argent disponible: %s~g~$~s~", MOD_Society.data?.money));

        Items:Button("Déposer de l'argent", nil, {
            RightBadge = RageUI.BadgeStyle.Tick,
        }, true, {
            onSelected = function()
                local amount = API_Player:showKeyboard("Combien voulez vous déposer", "", 10);

                if (API_Player:InputIsValid(amount, "number") and tonumber(amount) > 0) then
                    local newAmount = tonumber(amount);

                    if (newAmount > 0) then
                        TriggerServerEvent('Gamemode:Society:AddMoney', MOD_Society.data.name, newAmount, "cash")
                    else
                        ESX.ShowNotification("Entré invalide.")
                    end
                else
                    ESX.ShowNotification("Entré invalide.")
                end
            end
        });

        Items:Button("Retirer de l'argent", nil, {
            RightBadge = RageUI.BadgeStyle.Alert,
        }, true, {
            onSelected = function()
                local amount = API_Player:showKeyboard("Combien voulez vous retirer", "", 10);

                if (API_Player:InputIsValid(amount, "number") and tonumber(amount) > 0) then
                    local newAmount = tonumber(amount);

                    if (newAmount > 0) then
                        TriggerServerEvent('Gamemode:Society:RemoveMoney', MOD_Society.data.name, newAmount, "cash")
                    else
                        ESX.ShowNotification("Entré invalide.")
                    end
                else
                    ESX.ShowNotification("Entré invalide.")
                end
            end
        });
    end)
end

return menu
