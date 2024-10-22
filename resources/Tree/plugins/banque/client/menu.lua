
local BanqueMain = function()
    local MainMenuBanque = Tree.Menu.CreateMenu("", "Boucherie")
    Tree.Menu.Visible(MainMenuBanque, true)
    CreateThread(function()
        while MainMenuBanque do
            MainMenuBanque.Closed = function() 
                Tree.Menu.Visible(MainMenuBanque, false)
                MainMenuBanque = false
            end

            local playerData = ESX.GetPlayerData()

            Tree.Menu.IsVisible(MainMenuBanque, function()

                for i = 1, #playerData.accounts do
                    local selectedAccount = playerData.accounts[i]
                    if (selectedAccount ~= nil) then
                        if (selectedAccount.name == "bank") then
                            accountMoney = selectedAccount.money
                        end
                    end
                end

                Tree.Menu.Separator("Solde de votre compte : "..ESX.Math.GroupDigits(accountMoney).."~g~$~s~")


                Tree.Menu.Button("Déposer de l'argent", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        local amount = Tree.Function.input("Montant à déposer ?", "", 10, true)
                        if Tree.Function.CheckQuantity(amount) then
                            TriggerServerEvent("tree:bank:deposit", tonumber(amount))
                        else
                            ESX.ShowNotification(Tree.Config.Serveur.color.."Montant invalide !")
                        end
                    end,
                })

                Tree.Menu.Button("Retirer de l'argent", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        local amount = Tree.Function.input("Montant à retirer ?", "", 10, true)
                        if Tree.Function.CheckQuantity(amount) then
                            TriggerServerEvent("tree:bank:withdraw", tonumber(amount))
                        else
                            ESX.ShowNotification(Tree.Config.Serveur.color.."Montant invalide !")
                        end
                    end,
                })

                Tree.Menu.Button("Faire un transfert d'argent", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        local target = Tree.Function.input("ID du joueur à transferer ?", "", 10, true)
                        local amount = Tree.Function.input("Montant à transferer ?", "", 10, true)
                        if Tree.Function.CheckQuantity(amount) then
                            TriggerServerEvent("tree:bank:transfert", target, tonumber(amount))
                        else
                            ESX.ShowNotification(Tree.Config.Serveur.color.."Montant invalide !")
                        end
                    end,
                })

            end, MainMenuBanque)
            Wait(1)
        end
    end)
end



CreateThread(function()
    for k,v in pairs(SharedBanking.position) do 
        Tree.Function.Zone.create("Banque:"..k, v, 5.0, {
            onEnter = function()
                Tree.Function.While.addTick(0, 'drawmarker:'..k, function()
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder à votre compte bancaire")
                    Tree.Function.Visual.drawMarker(v)
                end)
                Tree.Function.Zone.create('Banque:press:'..k, v, 2.5, {
                    onPress = function()
                        BanqueMain()
                    end,
                    onExit = function()
                        Tree.Menu.CloseAll()
                    end
                })
            end,
            onExit = function()
                Tree.Function.While.removeTick('drawmarker:'..k)
                Tree.Function.Zone.delete('Banque:press:'..k)
            end
        })
        Tree.Function.Blips.create("Banque:"..k, v, 108, 2, "Banque")
    end
    for k,v in pairs(SharedBanking.positionATM) do 
        if SharedBanking.enablesATM then
            Tree.Function.Zone.create("ATM:"..k, v, 3.0, {
                onEnter = function()
                    Tree.Function.While.addTick(0, 'drawmarker:'..k, function()
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder à l'ATM")
                        Tree.Function.Visual.drawMarker(v)
                    end)
                    Tree.Function.Zone.create('ATM:press:'..k, v, 2.5, {
                        onPress = function()
                            BanqueMain()
                        end,
                        onExit = function()
                            Tree.Menu.CloseAll()
                        end
                    })
                end,
                onExit = function()
                    Tree.Function.While.removeTick('drawmarker:'..k)
                    Tree.Function.Zone.delete('ATM:press:'..k)
                end
            })
        end
        if SharedBanking.enablesBlipsATM then
            Tree.Function.Blips.create("ATM:"..k, v, 277, 2, "ATM")
        end
    end
end)

