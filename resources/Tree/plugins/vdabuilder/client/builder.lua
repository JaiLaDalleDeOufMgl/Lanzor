dataVDA = {}
dataList = {}

RegisterNetEvent("tree:vda:getAllList", function(data)
    dataList = data
end)

local editModeList = {"Se téléporter", "Supprimer"}
local editModeIndex = 1

RegisterNetEvent("tree:vdabuilder:openMenu", function()
    local MainMenuVDABuilder = Tree.Menu.CreateMenu("", "Builder VDA")
    local MainMenuCreateVDA = Tree.Menu.CreateMenu("", "Builder VDA")
    local MainMenuRequestVDA = Tree.Menu.CreateMenu("", "Builder VDA")
    Tree.Menu.Visible(MainMenuVDABuilder, true)
    CreateThread(function()
        while MainMenuVDABuilder do
            MainMenuVDABuilder.Closed = function() 
                Tree.Menu.Visible(MainMenuVDABuilder, false)
                MainMenuVDABuilder = false
            end
            Tree.Menu.IsVisible(MainMenuVDABuilder, function()
                Tree.Menu.Button("Créer une VDA", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                    end
                }, MainMenuCreateVDA)
                Tree.Menu.Button("Liste des VDA", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        TriggerServerEvent("tree:vda:requestVDA")
                    end
                }, MainMenuRequestVDA)
            end)
            Tree.Menu.IsVisible(MainMenuCreateVDA, function()
                Tree.Menu.Button("Type du VDA", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        typeVDA = Tree.Function.input("Type du VDA ? (private ou public)", "", 30, false)
                        if not typeVDA or typeVDA == "" then
                            ESX.ShowNotification("~r~Veuillez entrer un type valide.")
                        end
                        ESX.ShowNotification("Type du VDA : ~g~"..typeVDA)
                    end
                })
                Tree.Menu.Button("Coordonnées du VDA", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        coordsVDA = GetEntityCoords(PlayerPedId())
                        ESX.ShowNotification("Coordonnées du VDA : ~r~"..coordsVDA.."")
                    end
                })
                if typeVDA == "private" then 
                    Tree.Menu.Button("Propriétaire de la VDA", nil, {RightLabel = "→→→"}, true, {
                        onSelected = function()
                            accessOwnerVDA = Tree.Function.input("ID Du joueur ?", "", 30, false)
                            if Tree.Function.CheckQuantity(accessOwnerVDA) then
                                ESX.ShowNotification("Accès Job : ~g~"..accessOwnerVDA)
                            else
                                ESX.ShowNotification("Veuillez entrer un ID valide.")
                            end
                        end
                    })
                end
                Tree.Menu.Button("Ajouter une arme dans la VDA", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        weaponVDAName = Tree.Function.input("Nom de l'arme ?", "", 30, false)
                        weaponVDALabel = Tree.Function.input("Label de l'arme ?", "", 30, false)
                        weaponVDAPrice = Tree.Function.input("Prix de l'arme ?", "", 30, false)
                        if not weaponVDAName or weaponVDAName == "" then
                            ESX.ShowNotification("~r~Veuillez entrer un nom d'arme valide.")
                        end
                        if not weaponVDALabel or weaponVDALabel == "" then
                            ESX.ShowNotification("~r~Veuillez entrer un label d'arme valide.")
                        end
                        if not weaponVDAPrice or weaponVDAPrice == "" then
                            ESX.ShowNotification("~r~Veuillez entrer un prix d'arme valide.")
                        end
                        table.insert(dataVDA, {name = weaponVDAName, label = weaponVDALabel, price = weaponVDAPrice, type = "weapon"})
                    end
                })
                Tree.Menu.Button("Ajouter un item dans la VDA", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        itemVDAName = Tree.Function.input("Nom de l'item ?", "", 30, false)
                        itemVDALabel = Tree.Function.input("Label de l'item ?", "", 30, false)
                        itemVDAPrice = Tree.Function.input("Prix de l'item ?", "", 30, false)
                        if not itemVDAName or itemVDAName == "" then
                            ESX.ShowNotification("~r~Veuillez entrer un nom d'item valide.")
                        end
                        if not itemVDALabel or itemVDALabel == "" then
                            ESX.ShowNotification("~r~Veuillez entrer un label d'item valide.")
                        end
                        if not itemVDAPrice or itemVDAPrice == "" then
                            ESX.ShowNotification("~r~Veuillez entrer un prix d'item valide.")
                        end
                        table.insert(dataVDA, {name = itemVDAName, label = itemVDALabel, price = itemVDAPrice, type = "item"})
                    end
                })
                Tree.Menu.Button("Créer la VDA", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        if not typeVDA or not coordsVDA then
                            ESX.ShowNotification("~r~Veuillez remplir tous les champs.")
                            return
                        end

                        if typeVDA == "private" and not accessOwnerVDA then
                            ESX.ShowNotification("~r~Veuillez remplir tous les champs")
                            return
                        end

                        TriggerServerEvent("tree:vdabuilder:createVDA", typeVDA, coordsVDA, accessOwnerVDA, dataVDA)
                        dataVDA = {}
                    end
                })
                Tree.Menu.Line()
                for k,v in pairs(dataVDA) do
                    Tree.Menu.Button(v.label, nil, {RightLabel = "~r~"..v.price.."$"}, true, {
                        onSelected = function()
                            table.remove(dataVDA, k)
                        end
                    })
                end
            end)
            Tree.Menu.IsVisible(MainMenuRequestVDA, function()
                for k,v in pairs(dataList) do 
                    Tree.Menu.List("VDA ID : "..v.id, editModeList, editModeIndex, nil, {RightLabel = ""}, true, {
                        onListChange = function(Index)
                            editModeIndex = Index
                        end,
                        onSelected = function(index)
                            if index == 1 then
                                SetEntityCoords(PlayerPedId(), v.coords.x, v.coords.y, v.coords.z)
                            elseif index == 2 then
                                TriggerServerEvent("tree:vdabuilder:deleteVDA", v.id)
                            end
                        end,
                        onActive = function()
                            Tree.Menu.Info("VDA ID : "..v.id, {"Propriétaire :", "Type de VDA :", "Position du VDA :"}, {v.owner, v.type, v.coords.x, v.coords.y, v.coords.z}, 450)
                        end
                    })
                end
            end)
            Wait(1)
        end
    end)
end)