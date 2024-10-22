
RegisterNetEvent("tree:radio:setMembers", function(data)
    SharedRadio.playersInRadios = data
end)


local RadioMain = function()
    local MainMenuRadio = Tree.Menu.CreateMenu("", "Radio")
    local MainMenuMembers = Tree.Menu.CreateMenu("", "Radio")
    Tree.Menu.Visible(MainMenuRadio, true)
    CreateThread(function()
        while MainMenuRadio do
            MainMenuRadio.Closed = function() 
                Tree.Menu.Visible(MainMenuRadio, false)
                MainMenuRadio = false
            end

            Tree.Menu.IsVisible(MainMenuRadio, function()

                Tree.Menu.Button("Fréquence actuelle :", nil, {RightLabel = SharedRadio.currentChannel}, true, {
                    onSelected = function()
                    end
                })

                Tree.Menu.Button("Se connecter à une fréquence", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        local newFrequence = Tree.Function.input("Entrez la fréquence ?", "", 5, true)
                        if newFrequence then
                            local frequencyNumber = tonumber(newFrequence)
                            local playerJob = ESX.GetPlayerData().job.name
                            local assignedJob = nil
                            for job, freq in pairs(SharedRadio.ListRadios) do
                                if freq == frequencyNumber then
                                    assignedJob = job
                                    break
                                end
                            end
                            if assignedJob then
                                if playerJob == assignedJob then
                                    exports['pma-voice']:setRadioChannel(frequencyNumber)
                                    exports['pma-voice']:setVoiceProperty('radioEnabled', true)
                                    SharedRadio.currentChannel = frequencyNumber
                                else
                                    ESX.ShowNotification(Tree.Config.Serveur.color.."Cette fréquence est réservée pour le métier: " .. assignedJob)
                                end
                            else
                                exports['pma-voice']:setRadioChannel(frequencyNumber)
                                exports['pma-voice']:setVoiceProperty('radioEnabled', true)
                                SharedRadio.currentChannel = frequencyNumber
                            end
                        else
                            ESX.ShowNotification(Tree.Config.Serveur.color.."Vous n'avez pas entré de fréquence.")
                        end
                    end
                })

                Tree.Menu.Button("Désactiver/activer les bruitages", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        if SharedRadio.currentChannel == 0 then
                            ESX.ShowNotification(Tree.Config.Serveur.color.."Vous n'êtes pas connecté à une fréquence")
                            return
                        end
                        bruitageActive = not bruitageActive
                        if bruitageActive then
                            exports['pma-voice']:setVoiceProperty('micClicks', false)
                        else
                            exports['pma-voice']:setVoiceProperty('micClicks', true)
                        end
                    end
                })

                Tree.Menu.Button("Voir les membres dans la fréquence", nil, {RightLabel = "→→→"}, SharedRadio.currentChannel ~= 0, {
                    onSelected = function()
                        if SharedRadio.currentChannel == 0 then
                            ESX.ShowNotification(Tree.Config.Serveur.color.."Vous n'êtes pas connecté à une fréquence")
                            return
                        end
                        TriggerServerEvent('tree:radio:getMembers', SharedRadio.currentChannel)
                    end
                }, MainMenuMembers)


                Tree.Menu.Button("Se déconnecter de la fréquence", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        if SharedRadio.currentChannel == 0 then
                            ESX.ShowNotification(Tree.Config.Serveur.color.."Vous n'êtes pas connecté à une fréquence !")
                            return
                        end
                        exports['pma-voice']:setRadioChannel(0)
                        exports['pma-voice']:setVoiceProperty('radioEnabled', false)
                        SharedRadio.currentChannel = 0
                        ESX.ShowNotification("Vous avez quitté la radio.")
                    end
                })

            end, MainMenuRadio)


            Tree.Menu.IsVisible(MainMenuMembers, function()
                for k,v in pairs(SharedRadio.playersInRadios) do
                    Tree.Menu.Button(v.name, nil, {RightLabel = "→→→"}, true, {
                        onSelected = function()
                        end
                    })
                end
            end, MainMenuRadio)

            Wait(1)
        end
    end)
end

Keys.Register("F9", "F9", "Ouvrir la radio", function()
    RadioMain()
end)

