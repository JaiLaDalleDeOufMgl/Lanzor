dataCarDealer = {
    isFirstOpen = false,
    data = {},
    dataVehicles = {},
    categoriesSelected = nil,
    categoriesLabel = nil,
    loadingModel = nil,
    loadingPreview = nil,
    isLoadingVehicle = false
}

local CatalogueMain = function()
    local MainMenuCatalogue = Tree.Menu.CreateMenu("", "Catalogue voitures")
    local MainMenuVehicles = Tree.Menu.CreateMenu("", "Véhicules")
    Tree.Menu.Visible(MainMenuCatalogue, true)
    getAllCatalogues()

    CreateThread(function()
        while MainMenuCatalogue do
            MainMenuCatalogue.Closed = function()
                Tree.Menu.Visible(MainMenuCatalogue, false)
                MainMenuCatalogue = false
            end
            MainMenuVehicles.Closed = function()
                if dataCarDealer.loadingPreview then
                    DeleteEntity(dataCarDealer.loadingPreview)
                    dataCarDealer.loadingPreview = nil
                end
                dataCarDealer.loadingModel = nil
            end

            Tree.Menu.IsVisible(MainMenuCatalogue, function()
                for k, v in pairs(dataCarDealer.data) do
                    if v.name ~= 'avionfdp' and v.name ~= 'superboat' then
                    Tree.Menu.Button(v.label, nil, {RightLabel = "→→→"}, true, {
                onSelected = function()
                dataCarDealer.categoriesSelected = v.name
                dataCarDealer.categoriesLabel = v.label
                getAllVehicles()
                end
                }, MainMenuVehicles)
                    end
                end
            end, MainMenuCatalogue)

            Tree.Menu.IsVisible(MainMenuVehicles, function()
                for k, v in pairs(dataCarDealer.dataVehicles) do
                    local moneyPrice = v.price * 2
                    if v.category == dataCarDealer.categoriesSelected then
                        Tree.Menu.Button(v.name, "Prix : " .. moneyPrice .. " $", {RightLabel = "→→→"}, true, {
                            onActive = function()
                                if dataCarDealer.loadingModel ~= v.model then
                                    if dataCarDealer.loadingPreview then
                                        DeleteEntity(dataCarDealer.loadingPreview)
                                        dataCarDealer.loadingPreview = nil

                                        while DoesEntityExist(dataCarDealer.loadingPreview) do
                                            Wait(0)
                                        end
                                    end

                                    dataCarDealer.loadingModel = v.model
                                    dataCarDealer.isLoadingVehicle = true -- Verrou activé
                                    ESX.Game.SpawnLocalVehicle(v.model, SharedCarDealer.positionSpawnVehicle, 183.51811218262, function(vehicle)
                                        if vehicle then
                                            for _,vehicles in pairs(ESX.Game.GetVehiclesInArea(SharedCarDealer.positionSpawnVehicle, 1)) do
                                                if vehicles ~= vehicle then
                                                    DeleteEntity(vehicles)
                                                end
                                            end
                                            dataCarDealer.loadingPreview = vehicle
                                            SetEntityAsMissionEntity(vehicle, true, true)
                                            FreezeEntityPosition(vehicle, true)
                                            SetEntityInvincible(vehicle, true)
                                            SetVehicleDoorsLocked(vehicle, 2)
                                            SetEntityCollision(vehicle, false, false)
                                        end
                                        dataCarDealer.isLoadingVehicle = false
                                    end)
                                end
                            end,
                            onSelected = function()
                            end
                        })
                    end
                end
            end)
            Wait(1)
        end
    end)
end

CreateThread(function()
    for k,v in pairs(SharedCarDealer.position) do 
        Tree.Function.Zone.create("CatalogueCardealer:"..k, v, 5.0, {
            onEnter = function()
                Tree.Function.While.addTick(0, 'drawmarker:'..k, function()
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au catalogue de voitures")
                    Tree.Function.Visual.drawMarker(v)
                end)
                Tree.Function.Zone.create('CatalogueCardealer:press:'..k, v, 2.5, {
                    onPress = function()
                        CatalogueMain()
                    end,
                    onExit = function()
                        Tree.Menu.CloseAll()
                    end
                })
            end,
            onExit = function()
                Tree.Function.While.removeTick('drawmarker:'..k)
                Tree.Function.Zone.delete('CatalogueCardealer:press:'..k)
            end
        })
    end
end)