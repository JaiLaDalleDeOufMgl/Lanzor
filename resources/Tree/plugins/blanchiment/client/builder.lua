
dataTable = {}

RegisterNetEvent("tree:blanchiment:getList", function(data)
    dataTable = data
end)

local editModeList = {"Se téléporter", "Supprimer"}
local editModeIndex = 1

RegisterNetEvent("tree:openMenu:blanchiment", function()
    local MainMenuBlanchBuilder = Tree.Menu.CreateMenu("", "Builder Blanchiment")
    local MainMenuCreateBuilder = Tree.Menu.CreateMenu("", "Builder Blanchiment")
    local MainMenuBlanchList = Tree.Menu.CreateMenu("", "Liste des Blanchiments")
    Tree.Menu.Visible(MainMenuBlanchBuilder, true)
    CreateThread(function()
        while MainMenuBlanchBuilder do
            MainMenuBlanchBuilder.Closed = function() 
                Tree.Menu.Visible(MainMenuBlanchBuilder, false)
                MainMenuBlanchBuilder = false
            end
            Tree.Menu.IsVisible(MainMenuBlanchBuilder, function()
                Tree.Menu.Button("Créer un blanchiment", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                    end
                }, MainMenuCreateBuilder)

                Tree.Menu.Button("Liste des blanchiments", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        TriggerServerEvent("tree:blanchiment:requestBlanch")
                    end
                }, MainMenuBlanchList)
            end)
            Tree.Menu.IsVisible(MainMenuCreateBuilder, function()
            Tree.Menu.Button("Type de blanchiment", nil, {RightLabel = "→→→"}, true, {
                onSelected = function()
                    typeBlanch = Tree.Function.input("Type de blanchiment ? (private ou public)", "", 30, false)
                    if typeBlanch == "private" or typeBlanch == "public" then
                        ESX.ShowNotification("Type de blanchiment : ~g~"..typeBlanch)
                    else
                        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Erreur : ~w~Veuillez entrer un type valide.")
                    end
                end
            })
            Tree.Menu.Button("Coordonnées du blanchiment", nil, {RightLabel = "→→→"}, true, {
                onSelected = function()
                    coordsBlanch = GetEntityCoords(PlayerPedId())
                    ESX.ShowNotification("Coordonnées du blanchiment : ~g~"..coordsBlanch.."")
                end
            })
            Tree.Menu.Button("Pourcentage du blanchiment", nil, {RightLabel = "→→→"}, true, {
                onSelected = function()
                    pourcentageBlanch = Tree.Function.input("Pourcentage du blanchiment ?", "", 30, false)
                    if Tree.Function.CheckQuantity(pourcentageBlanch) then
                        ESX.ShowNotification("Pourcentage du blanchiment : ~g~"..pourcentageBlanch.."~s~ %")
                    else
                        ESX.ShowNotification("~r~Veuillez entrer un pourcentage valide.")
                    end
                end
            })
            if typeBlanch == "private" then
                Tree.Menu.Button("Propriétaire du blanchiment", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        accessOwner = Tree.Function.input("ID Du joueur ?", "", 30, false)
                        if Tree.Function.CheckQuantity(accessOwner) then
                            ESX.ShowNotification("Accès Job : ~g~"..accessOwner)
                        else
                            ESX.ShowNotification("Veuillez entrer un ID valide.")
                        end
                    end
                })
            end
            Tree.Menu.Button("Créer le blanchiment", nil, {RightLabel = "→→→"}, true, {
                onSelected = function()
                    if not typeBlanch or not coordsBlanch then
                        ESX.ShowNotification("~r~Veuillez remplir tous les champs")
                        return
                    end

                    if typeBlanch == "private" and not accessOwner then
                        ESX.ShowNotification("~r~Veuillez remplir tous les champs")
                        return
                    end

                    TriggerServerEvent("tree:blanchiment:createBlanch", typeBlanch, coordsBlanch, accessOwner, pourcentageBlanch)
                end
            })
            end)
            Tree.Menu.IsVisible(MainMenuBlanchList, function()
                for k,v in pairs(dataTable) do
                    Tree.Menu.List("Blanchiment ID : "..v.id, editModeList, editModeIndex, nil, {RightLabel = ""}, true, {
                        onListChange = function(Index)
                            editModeIndex = Index
                        end,
                        onSelected = function(index)
                            if index == 1 then
                                SetEntityCoords(PlayerPedId(), v.coords.x, v.coords.y, v.coords.z)
                            elseif index == 2 then
                                TriggerServerEvent("tree:blanchiment:deleteBlanchiment", v.id)
                            end

                        end,
                        onActive = function()
                            Tree.Menu.Info("Blanchiment ID : "..v.id, {"Propriétaire :", "Type de blanchiment :", "Pourcentage du blanchiment", "Position du blanchiment :"}, {v.owner, v.type, v.pourcentage, v.coords.x, v.coords.y, v.coords.z}, 450)
                        end
                    })
                end
            end)
            Wait(1)
        end
    end)
end)