RegisterNetEvent("tree:blanchiment:OpenMenuBlanch", function(pourcentage)
    local MainMenuMoneyWash = Tree.Menu.CreateMenu("", "Blanchiment")
    Tree.Menu.Visible(MainMenuMoneyWash, true)
    CreateThread(function()
        while MainMenuMoneyWash do
            MainMenuMoneyWash.Closed = function() 
                Tree.Menu.Visible(MainMenuMoneyWash, false)
                MainMenuMoneyWash = false
            end
            Tree.Menu.IsVisible(MainMenuMoneyWash, function()
                Tree.Menu.Separator("Taux de pourcentage de blanchiment : ~g~"..pourcentage.."%")
                Tree.Menu.Button("Blanchir de l'argent", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        local amount = Tree.Function.input("Combien voulez-vous blanchir ?", "", 30, false)
                        if Tree.Function.CheckQuantity(amount) then
                            TriggerServerEvent("tree:blanchiment:washMoney", tonumber(amount), pourcentage)
                        else
                            ESX.ShowNotification("~r~Veuillez entrer un montant valide.")
                        end
                    end,
                })

            end, MainMenuMoneyWash)
            Wait(1)
        end
    end)
end)