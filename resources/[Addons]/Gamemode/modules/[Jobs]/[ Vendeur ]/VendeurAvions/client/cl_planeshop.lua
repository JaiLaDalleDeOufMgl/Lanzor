

local desCategoriesDeBateau = {}
local desAvions = {}
local isOpenedActions = false
local theCategoriesname
local theCategorieslabel
local thisIsForPreviewPlane = {}
local alwaysPreview = {}
local getSocietyAvions = {}
local LastPlanes = {}
local inCaseOfPlane = {}


Citizen.CreateThread(function()
    x,y,z = -964.3, -2965.4, 13.94
    local blip = AddBlipForCoord(x,y,z)

	SetBlipSprite (blip, 90)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.6)
	SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, 1)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Concession aéronautique")
	EndTextCommandSetBlipName(blip)
    
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    while true do
        local interval = 1000
        local coords = GetEntityCoords(PlayerPedId())
        for k,v in pairs(Config.Jobs.Plane.Actions) do
            if ESX.PlayerData.job.name == 'planeseller' then
                if #(coords - v.actions) <= 10 then
                    interval = 0
                    DrawMarker(Config.Get.Marker.Type, v.actions, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                    if #(coords - v.actions) <= 3 then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu")
                        if IsControlJustReleased(0, 38) then
                            openPlaneshopActions()
                        end
                    end
                end
            end
        end
        Citizen.Wait(interval)
    end
end)

-- RegisterNetEvent('planeseller:onSpawnVehicle', function(menuData, vehicleNetworkId, vehicleProps)
--     local data = menuData;
--     -- exports["JustGod"]:GetByNetworkId(vehicleNetworkId, function(vehicle)
--     --     table.insert(LastPlanes, vehicle);
--     --     table.insert(inCaseOfPlane, {
--     --         vehicle = data.props,
--     --         name = data.name,
--     --         price = data.price,
--     --         category = data.category,
--     --         vehicleProps = vehicleProps
--     --     });
--     -- end)
-- end);

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end

RegisterNetEvent('planeseller:onSpawnVehicle', function(vehicleProps)
    inCaseOfPlane = vehicleProps
end);

function openPlaneshopActions()
    local mainMenu = RageUI.CreateMenu("", "Faites vos actions")
    local sortirAvions = RageUI.CreateSubMenu(mainMenu, "", "Sortir un avion")
    local listeAvions = RageUI.CreateSubMenu(mainMenu, "", "Liste des catégories")
    local lesAvionsDeLaCategories = RageUI.CreateSubMenu(mainMenu, "", "Faites vos actions")
    local preview = RageUI.CreateSubMenu(mainMenu, '', 'Faites vos actions')

    local x,y,z 

    preview.Closed = function()
        SetEntityCoords(PlayerPedId(), x, y, z)
        FreezeEntityPosition(PlayerPedId(), false)
        NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
        SetEntityLocallyInvisible(PlayerPedId(), false)
        for k,v in pairs(thisIsForPreviewPlane) do
            SetModelAsNoLongerNeeded(v.vehicle)
            ESX.Game.DeleteVehicle(v.vehicle)
        end
        RageUI.CloseAll()
    end

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while mainMenu do
        RageUI.IsVisible(mainMenu, function()
            RageUI.Separator("↓ ~m~Achat Avion~s~ ↓")
            RageUI.Button("Acheter un avion", nil , {RightLabel = "→"}, true, {
                onSelected = function()
                    getPlaneCategories()
                    getPlanes()
                end
            }, listeAvions)
            RageUI.Separator("↓ ~m~Vente Avion~s~ ↓")
            RageUI.Button("Vendre l'avion sortie", "Facture et Vente automatique !", {RightLabel = "→"}, true, {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                       ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Personne autour de vous')
                    else
                        for k,v in pairs(inCaseOfPlane) do
                            --TriggerServerEvent('selltheplane', GetPlayerServerId(closestPlayer), v.vehicleProps, v.price, v.vehicle)
                            TriggerServerEvent('selltheplane', GetPlayerServerId(closestPlayer), inCaseOfPlane, v.price)
                        end
                        inCaseOfPlane = {}
                    end
                end
            })
            -- RageUI.Button("Mettre une facture", nil, {RightLabel = "→"}, true , {
            --     onSelected = function()
            --         local montant = KeyboardInputPlaneShop("Montant:", 'Rentrez un montant', '', 8)
            --         if tonumber(montant) == nil then
            --             ESX.ShowNotification("Montant invalide")
            --             return false
            --         else
            --             amount = (tonumber(montant))
            --             local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			-- 			if closestPlayer == -1 or closestDistance > 3.0 then
			-- 				ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Personne autour de vous')
			-- 			else
			-- 				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'planeseller', 'Concessionnaire Avion', amount)
			-- 			end
            --         end
            --     end
            -- })
            RageUI.Separator("↓ ~m~Gestion Avion ~s~↓")
            RageUI.Button("Sortir un avion", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    getPossedPlanes()
                end
            }, sortirAvions)
            RageUI.Button("Ranger l'avion", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    DeleteShopInsidePlane()
                end
            })
        end)

        RageUI.IsVisible(sortirAvions, function()
            for k,v in pairs(getSocietyAvions) do
                RageUI.Button(v.name, nil , {RightLabel = v.price.."$"}, true, {
                    onSelected = function()
                        local plate     = GeneratePlate();
                        TriggerServerEvent('PlaneShop:removesocietyplane',  v.id, v.props, plate, v);
                        --[[ESX.Game.SpawnVehicle(v.props, {x = -961.7, y = -3001.5, z = 13.9}, 349.06, function (vehicle)
                            local plaque     = GeneratePlate()
                            SetVehicleNumberPlateText(vehicle, plaque)
                            table.insert(LastPlanes, vehicle)
                            local vehicleProps = ESX.Game.GetVehicleProperties(LastPlanes[#LastPlanes])
                            vehicleProps.plate = plaque
                            table.insert(inCaseOfPlane, {
                                vehicle = v.props,
                                name = v.name,
                                price = v.price,
                                category = v.category,
                                vehicleProps = vehicleProps
                            })
                            
                        end)
                        ]]
                        RageUI.CloseAll()
                    end
                })
            end
        end)

        RageUI.IsVisible(listeAvions, function()
            for k,v in pairs(desCategoriesDeBateau) do
                if v.name == 'avionfdp' then
                    RageUI.Button(v.label, nil , {RightLabel = "→"}, true, {
                        onSelected = function()
                            theCategories = v.name
                            theCategorieslabel = v.label
                        end
                    }, lesAvionsDeLaCategories)
                end
            end
        end)

        RageUI.IsVisible(lesAvionsDeLaCategories, function()
            RageUI.Separator("Avions de la catégorie: "..theCategorieslabel)
            for k,v in pairs(desAvions) do
                if v.category == theCategories then
                    RageUI.Button(v.name, nil , {RightLabel = "→"}, true, {
                        onSelected = function()
                            x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
                            local plyPed = PlayerPedId()
                            SetEntityCoords(plyPed, -75.0, -818.0, 326.0)
                            local vehicle = v.model
                            ESX.Game.SpawnLocalVehicle(vehicle, {x = -961.7, y = -3001.5, z = 13.9}, 60.7, function (vehicle)
                                TaskWarpPedIntoVehicle(plyPed, vehicle, -1)
                                FreezeEntityPosition(vehicle, true)
                                --SetModelAsNoLongerNeeded(vehicle)
                                table.insert(thisIsForPreviewPlane, {
                                    vehicle = vehicle,
                                    price = v.price,
                                    name = v.name,
                                    model = v.model
                                })
                            end)
                        end
                    }, preview)
                end
            end
        end)


        RageUI.IsVisible(preview, function()
            for k,v in pairs(thisIsForPreviewPlane) do
                local plyPed = PlayerPedId()
                NetworkSetEntityInvisibleToNetwork(PlayerPedId(), true)
                SetEntityLocallyInvisible(PlayerPedId(), true)
                if GetVehiclePedIsIn(plyPed) == 0 then
                    TaskWarpPedIntoVehicle(plyPed, v.vehicle, -1)
                end
                RageUI.Separator(exports.Tree:serveurConfig().Serveur.color.."Confirmez l'achat de "..v.name.."")
                RageUI.Button("Acheter un avion", nil, {RightLabel = v.price.."$"}, true, { 
                    onSelected = function()
                        ESX.TriggerServerCallback('PlaneShop:getSocietyMoney', function(data)
                            local d = data;
                            if (d >= v.price) then
                                TriggerServerEvent('PlaneShop:buyVehicle', v.model, v.name, v.price);
                                SetModelAsNoLongerNeeded(v.vehicle)
                                ESX.Game.DeleteVehicle(v.vehicle)
                                RageUI.CloseAll()
                                SetEntityCoords(PlayerPedId(), x, y, z)
                                NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
                                SetEntityLocallyInvisible(PlayerPedId(), false)
                                TriggerServerEvent('PlaneShop:changeBucket', "leave")
                                inCaseOfPlane = {}
                            else
                                ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Il n'y a pas suffisamment d'argent dans la société.")
                            end
                        end)
                    end
                })
                RageUI.Button("Non", nil, {RightLabel = ""}, true, {
                    onSelected = function()
                        SetModelAsNoLongerNeeded(v.vehicle)
                        ESX.Game.DeleteVehicle(v.vehicle)
                        RageUI.CloseAll()
                        SetEntityCoords(PlayerPedId(), x, y, z)
                        NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
                        SetEntityLocallyInvisible(PlayerPedId(), false)
                    end
                })
            end
        end)

        if not RageUI.Visible(mainMenu) and not RageUI.Visible(listeAvions) and not RageUI.Visible(lesAvionsDeLaCategories) and not RageUI.Visible(preview) and not RageUI.Visible(sortirAvions) then
            mainMenu = RMenu:DeleteType('mainMenu', true)
        end
        if not RageUI.Visible(listeAvions) and not RageUI.Visible(lesAvionsDeLaCategories) and not RageUI.Visible(preview) then
            desCategoriesDeBateau = {}
            desAvions = {}
            thisIsForPreviewPlane = {}
        end
        if not RageUI.Visible(sortirAvions) then
            getSocietyAvions = {}
            alwaysPreview = {}
        end

        Citizen.Wait(0)
    end
end

function getPlaneCategories()
    ESX.TriggerServerCallback('PlaneShop:getPlaneCategories', function(cb)
        for i=1, #cb do
            local d = cb[i]
            table.insert(desCategoriesDeBateau, {
                name = d.name,
                label = d.label,
                society = d.society
            })

        end
    end)
end

function getPlanes()
    ESX.TriggerServerCallback('PlaneShop:getAllVehicles', function(result)
        for i=1, #result do
            local d = result[i]
            table.insert(desAvions, {
                model = d.model,
                name = d.name,
                price = d.price,
                category = d.category
            })
        end
    end)
end

function getPossedPlanes()
    ESX.TriggerServerCallback('PlaneShop:getSocietyVehicles', function(ladata)
        for i=1, #ladata do
            local d = ladata[i]
            table.insert(getSocietyAvions, {
                id = d.id,
                props = d.vehicle,
                name = d.name,
                price = d.price,
                society = d.society
            })
        end
    end)
end

function DeleteShopInsidePlane()

    TriggerServerEvent("planeseller:deleteAllVehicles");

	--while #LastPlanes > 0 do
	--	local vehicle = LastPlanes[1]
    --
	--	ESX.Game.DeleteVehicle(vehicle)
    --   for k,v in pairs(inCaseOfPlane) do
    --        TriggerServerEvent('PlaneShop:recupvehicle', v.vehicle, v.name, v.price, v.society)
    --    end
	--	table.remove(LastPlanes, 1)
    --    inCaseOfPlane = {}
	--end
end

function KeyboardInputPlaneShop(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
  
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
      Citizen.Wait(0)
    end
  
    if UpdateOnscreenKeyboard() ~= 2 then
      local result = GetOnscreenKeyboardResult()
      return result
    else
      return nil
    end
end

local open = false 
local planeMain2 = RageUI.CreateMenu('', 'Concessionnaire Avion')
local subMenu8 = RageUI.CreateSubMenu(planeMain2, "", "Interaction")
planeMain2.Display.Header = true 
planeMain2.Closed = function()
  open = false
end

function OpenMenuPlaneShop()
	if open then 
		open = false
		RageUI.Visible(planeMain2, false)
		return
	else
		open = true 
		RageUI.Visible(planeMain2, true)
		CreateThread(function()
		while open do 
		   RageUI.IsVisible(planeMain2,function() 

            RageUI.Button("Annonces", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                end
            }, subMenu8)

            RageUI.Button("Faire une Facture", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local montant = KeyboardInputPolice("Montant:", 'Indiquez un montant', '', 7)
                    if tonumber(montant) == nil then
                        ESX.ShowNotification("Montant invalide")
                        return false
                    else
                        amount = (tonumber(montant))
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestPlayer == -1 or closestDistance > 3.0 then
                            ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Personne autour de vous')
                        else
                            ESX.ShowNotification("~g~Facture envoyée avec succès !")
                            TriggerServerEvent('sendLogs:Facture', GetPlayerServerId(closestPlayer), amount)
                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'planeseller', 'Concess Avion', amount)
                        end
                    end
                end
            })
			end)

            RageUI.IsVisible(subMenu8,function() 

                RageUI.Button("Annonce ~g~[Ouvertures]~s~", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                        TriggerServerEvent('Ouvre:PlaneShop')
                    end
                })
    
                RageUI.Button("Annonce "..exports.Tree:serveurConfig().Serveur.color.."[Fermetures]"..exports.Tree:serveurConfig().Serveur.color.."", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                        TriggerServerEvent('Ferme:PlaneShop')
                    end
                })
    
                RageUI.Button("Annonce "..exports.Tree:serveurConfig().Serveur.color.."[Recrutement]", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                        TriggerServerEvent('Recrutement:PlaneShop')
                    end
                })

            end)

		 Wait(0)
		end
	 end)
  end
end

RegisterNetEvent('openMenuCatalogue:plane', function(menuData, vehicleNetworkId, vehicleProps)
    local CataloguemainMenu = RageUI.CreateMenu("", "Faites vos actions")
    local CataloguelisteAvions = RageUI.CreateSubMenu(CataloguemainMenu, "", "Liste des catégories")
    local CataloguelesAvionsDeLaCategories = RageUI.CreateSubMenu(CataloguemainMenu, "", "Faites vos actions")
    local Cataloguepreview = RageUI.CreateSubMenu(CataloguemainMenu, '', 'Faites vos actions')

    local x,y,z 

    Cataloguepreview.Closed = function()
        SetEntityCoords(PlayerPedId(), x, y, z)
        FreezeEntityPosition(PlayerPedId(), false)
        NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
        SetEntityLocallyInvisible(PlayerPedId(), false)
        for k,v in pairs(thisIsForPreviewPlane) do
            SetModelAsNoLongerNeeded(v.vehicle)
            ESX.Game.DeleteVehicle(v.vehicle)
        end
        RageUI.CloseAll()
    end

    RageUI.Visible(CataloguemainMenu, not RageUI.Visible(CataloguemainMenu))

    while CataloguemainMenu do
        RageUI.IsVisible(CataloguemainMenu, function()
            RageUI.Button("Acheter un avion", nil , {RightLabel = "→"}, true, {
                onSelected = function()
                    getPlaneCategories()
                    getPlanes()
                end
            }, CataloguelisteAvions)
        end)

        RageUI.IsVisible(CataloguelisteAvions, function()
            for k,v in pairs(desCategoriesDeBateau) do
                if v.name == 'avionfdp' then
                    RageUI.Button(v.label, nil , {RightLabel = "→"}, true, {
                        onSelected = function()
                            theCategories = v.name
                            theCategorieslabel = v.label
                        end
                    }, CataloguelesAvionsDeLaCategories)
                end
            end
        end)

        RageUI.IsVisible(CataloguelesAvionsDeLaCategories, function()
            RageUI.Separator("Avions de la catégorie: "..theCategorieslabel)
            for k,v in pairs(desAvions) do
                if v.category == theCategories then
                    RageUI.Button(v.name, nil , {RightLabel = "~g~"..v.price.."$~s~ →"}, true, {
                        onSelected = function()
                            x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
                            local plyPed = PlayerPedId()
                            SetEntityCoords(plyPed, -75.0, -818.0, 326.0)
                            local vehicle = v.model
                            ESX.Game.SpawnLocalVehicle(vehicle, {x = -961.7, y = -3001.5, z = 13.9}, 60.7, function (vehicle)
                                TaskWarpPedIntoVehicle(plyPed, vehicle, -1)
                                FreezeEntityPosition(vehicle, true)
                                --SetModelAsNoLongerNeeded(vehicle)
                                table.insert(thisIsForPreviewPlane, {
                                    vehicle = vehicle,
                                    price = v.price,
                                    name = v.name,
                                    model = v.model
                                })
                            end)
                        end
                    }, Cataloguepreview)
                end
            end
        end)


        RageUI.IsVisible(Cataloguepreview, function()
            for k,v in pairs(thisIsForPreviewPlane) do
                local plyPed = PlayerPedId()
                NetworkSetEntityInvisibleToNetwork(PlayerPedId(), true)
                SetEntityLocallyInvisible(PlayerPedId(), true)
                if GetVehiclePedIsIn(plyPed) == 0 then
                    TaskWarpPedIntoVehicle(plyPed, v.vehicle, -1)
                end
                RageUI.Separator(exports.Tree:serveurConfig().Serveur.color..""..v.name)
                RageUI.Button("Retour en arrière", nil, {RightLabel = ""}, true, {
                    onSelected = function()
                        SetModelAsNoLongerNeeded(v.vehicle)
                        ESX.Game.DeleteVehicle(v.vehicle)
                        RageUI.CloseAll()
                        SetEntityCoords(PlayerPedId(), x, y, z)
                        NetworkSetEntityInvisibleToNetwork(PlayerPedId(), false)
                        SetEntityLocallyInvisible(PlayerPedId(), false)
                    end
                })
            end
        end)

        if not RageUI.Visible(CataloguemainMenu) and not RageUI.Visible(CataloguelisteAvions) and not RageUI.Visible(CataloguelesAvionsDeLaCategories) and not RageUI.Visible(Cataloguepreview) and not RageUI.Visible(sCatalogueortirAvions) then
            CataloguemainMenu = RMenu:DeleteType('CataloguemainMenu', true)
        end
        if not RageUI.Visible(CataloguelisteAvions) and not RageUI.Visible(CataloguelesAvionsDeLaCategories) and not RageUI.Visible(Cataloguepreview) then
            desCategoriesDeBateau = {}
            desAvions = {}
            thisIsForPreviewPlane = {}
        end

        Citizen.Wait(0)
    end
end)