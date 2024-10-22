
local editModeIndex = 1
local filterIndex = 1
local filterList = {"Aucun", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"}
local editModeList = {"Modifier le label", "Modifier le prix", "Modifier la catégorie", "Supprimer le véhicule"}
local filteredList = {}


function updateFilteredList()
    filteredList = {}
    if filterIndex == 1 then
        filteredList = dataCarDealer.dataVehicles
    else
        for k,v in pairs(dataCarDealer.dataVehicles) do
            if string.sub(v.name, 1, #filterList[filterIndex]) == filterList[filterIndex] then
                table.insert(filteredList, v)
            end
        end
    end
end

RegisterNetEvent("tree:openMenuBuilderCardealer", function()
    local MainMenuBuilderCardealer = Tree.Menu.CreateMenu("", "Builder Catalogue")
    local SubMenuBuilderCardealer = Tree.Menu.CreateMenu("", "Builder Catalogue")
    local SubMenuEditCardealer = Tree.Menu.CreateMenu("", "Builder Catalogue")
    Tree.Menu.Visible(MainMenuBuilderCardealer, true)
    CreateThread(function()
        while MainMenuBuilderCardealer do
            MainMenuBuilderCardealer.Closed = function() 
                Tree.Menu.Visible(MainMenuBuilderCardealer, false)
                MainMenuBuilderCardealer = false
            end
            Tree.Menu.IsVisible(MainMenuBuilderCardealer, function()
                Tree.Menu.Button("Ajouter un véhicule", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                    end
                }, SubMenuBuilderCardealer)
                Tree.Menu.Button("Voir les véhicules", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        getAllVehicles()
                    end
                }, SubMenuEditCardealer)
            end, MainMenuBuilderCardealer)
            Tree.Menu.IsVisible(SubMenuBuilderCardealer, function()
                Tree.Menu.Button("Label du véhicule", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        labelVehicle = Tree.Function.input("Label du véhicule ?", "", 30, false)
                        if labelVehicle then
                            ESX.ShowNotification("Label du véhicule : ~g~"..labelVehicle)
                        else
                            ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Erreur : ~w~Veuillez entrer un label valide.")
                        end
                    end
                })
                Tree.Menu.Button("Model du véhicule", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        modelVehicle = Tree.Function.input("Model du véhicule ?", "", 30, false)
                        if modelVehicle then
                            ESX.ShowNotification("Model du véhicule : ~g~"..modelVehicle)
                        else
                            ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Erreur : ~w~Veuillez entrer un model valide.")
                        end
                    end
                })
                Tree.Menu.Button("Prix du véhicule", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        priceVehicle = Tree.Function.input("Prix du véhicule ?", "", 30, true)
                        if priceVehicle then
                            ESX.ShowNotification("Prix du véhicule : ~g~"..priceVehicle)
                        else
                            ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Erreur : ~w~Veuillez entrer un prix valide.")
                        end
                    end
                })
                Tree.Menu.Button("Catégorie du véhicule", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        categoryVehicle = Tree.Function.input("Catégorie du véhicule ?", "", 30, false)
                        if categoryVehicle then
                            ESX.ShowNotification("Catégorie du véhicule : ~g~"..categoryVehicle)
                        else
                            ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Erreur : ~w~Veuillez entrer une catégorie valide.")
                        end
                    end
                })
                Tree.Menu.Button("Ajouter le véhicule au catalogue", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        if not labelVehicle or not modelVehicle or not priceVehicle or not categoryVehicle then
                            ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Il manque des informations veuillez les remplir avant d'ajouter le véhicule !")
                            return
                        end
                        TriggerServerEvent("tree:cardealer:addVehicle", labelVehicle, modelVehicle, priceVehicle, categoryVehicle)
                    end
                })
            end)
            Tree.Menu.IsVisible(SubMenuEditCardealer, function()
                Tree.Menu.List("Filtre :", filterList, filterIndex, nil, {RightLabel = ""}, true, {
                    onListChange = function(Index)
                        filterIndex = Index
                        updateFilteredList()
                    end,
                })
                Tree.Menu.Line()
                for k,v in pairs(filteredList) do
                    Tree.Menu.List(v.name, editModeList, editModeIndex, nil, {RightLabel = ""}, true, {
                        onListChange = function(Index)
                            editModeIndex = Index
                        end,
                        onSelected = function(index)
                            if index == 1 then
                                local editLabelVehicle = Tree.Function.input("Nouveau label du véhicule ?", "", 30, false)
                                if editLabelVehicle then
                                    TriggerServerEvent("tree:cardealer:editlabelVehicle", v.name, editLabelVehicle)
                                else
                                    ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Merci de rentrer un label valide.")
                                end
                            elseif index == 2 then
                                local editPriceVehicle = Tree.Function.input("Nouveau prix du véhicule ?", "", 30, true)
                                if editPriceVehicle then
                                    TriggerServerEvent("tree:cardealer:editPriceVehicle", v.name, editPriceVehicle)
                                else
                                    ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Merci de rentrer un prix valide.")
                                end
                            elseif index == 3 then 
                                local editCategoryVehicle = Tree.Function.input("Nouvelle catégorie du véhicule ?", "", 30, false)
                                if editCategoryVehicle then
                                    TriggerServerEvent("tree:cardealer:editCategoryVehicle", v.name, editCategoryVehicle)
                                else
                                    ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Merci de rentrer une catégorie valide.")
                                end
                            elseif index == 4 then
                                TriggerServerEvent("tree:cardealer:deleteVehicle", v.name)
                            end
                        end
                    })
                end
            end)
            Wait(1)
        end
    end)
end)
