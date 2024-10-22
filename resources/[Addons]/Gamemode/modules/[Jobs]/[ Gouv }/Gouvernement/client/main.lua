local ArgentSaleGouv = {}
local ItemsGouv = {}
local ArmesGouv = {}

local objectsGouv = {
    [0] = {
        model = "prop_roadcone02a",
        name = "Cônes"
    },
    [1] = {
        model = "prop_barrier_work05",
        name = "Barrière"
    },
    [2] = {
        model = "p_ld_stinger_s",
        name = "Herses"
    },
}

Citizen.CreateThread(function()
    while ESX.GetPlayerData()['job'] == nil do
        Citizen.Wait(500)
    end
    while ESX.GetPlayerData()['job2'] == nil do
        Citizen.Wait(500)
    end
    while true do
        local interval = 750
        local plyCoords = GetEntityCoords(PlayerPedId())
        if ESX.PlayerData.job.name == 'gouv' then
            if #(plyCoords - Config.Gouv.BossActions) <= 10 then
                --if ESX.PlayerData.job.grade == 4 then
                    interval = 1
                    DrawMarker(Config.Marker.Type, Config.Gouv.BossActions, 0, 0, 0, Config.Marker.Rotation, nil, nil, Config.Marker.Size[1], Config.Marker.Size[2], Config.Marker.Size[3], 255,250,0, 170, 0, 1, 0, 0, nil, nil, 0)
                    if #(plyCoords - Config.Gouv.BossActions) <= 3 then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~  pour ouvrir le menu")
                        if IsControlJustPressed(0, 51) then
                            OpenGouvBoss()
                        end
                    end
                --end
            end
            if #(plyCoords - Config.Gouv.Armurerie) <= 10 then
                --if ESX.PlayerData.job.grade ~= 0 and ESX.PlayerData.job.grade ~= 1 then
                    interval = 1
                    DrawMarker(Config.Marker.Type, Config.Gouv.Armurerie, 0, 0, 0, Config.Marker.Rotation, nil, nil, Config.Marker.Size[1], Config.Marker.Size[2], Config.Marker.Size[3], 255,250,0, 170, 0, 1, 0, 0, nil, nil, 0)
                    if #(plyCoords - Config.Gouv.Armurerie) <= 3 then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~  pour ouvrir le menu")
                        if IsControlJustPressed(0, 51) then
                            OpenGouvArmurerie()
                        end
                    end
                --end
            end
            if #(plyCoords - Config.Gouv.SortirVehicule) <= 10 then
                interval = 1
                DrawMarker(Config.Marker.Type, Config.Gouv.SortirVehicule, 0, 0, 0, Config.Marker.Rotation, nil, nil, Config.Marker.Size[1], Config.Marker.Size[2], Config.Marker.Size[3], 255,250,0, 170, 0, 1, 0, 0, nil, nil, 0)
                if #(plyCoords - Config.Gouv.SortirVehicule) <= 3 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~  pour ouvrir le menu")
                    if IsControlJustPressed(0, 51) then
                        openSortirVehicle()
                    end
                end
            end
            if #(plyCoords - Config.Gouv.RangerVehicle) <= 10 then
                local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                if DoesEntityExist(veh) then
                    interval = 1
                    DrawMarker(Config.Marker.Type, Config.Gouv.RangerVehicle, 0, 0, 0, Config.Marker.Rotation, nil, nil, Config.Marker.Size[1], Config.Marker.Size[2], Config.Marker.Size[3], 255,250,0, 170, 0, 1, 0, 0, nil, nil, 0)
                    if #(plyCoords - Config.Gouv.RangerVehicle) <= 6 then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~  pour supprimer votre véhicule")
                        if IsControlJustPressed(0, 51) then
                            ESX.Game.DeleteVehicle(veh)
                        end
                    end
                end
            end
        end
        Citizen.Wait(interval)
    end
end)


function KeyboardInputGouv(entryTitle, textEntry, inputText, maxLength)
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

OpenF6Gouv = function()
    local mainMenu = RageUI.CreateMenu("", "Menu d'intéractions")
    local civils = RageUI.CreateSubMenu(mainMenu, "", "Menu Interaction")
    local infoPdg = RageUI.CreateSubMenu(mainMenu, "", "Menu Interraction")
    local props = RageUI.CreateSubMenu(mainMenu, "", "Intéractions : Objets")
    local propsList = RageUI.CreateSubMenu(props, "", "Intéractions : Gérer")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while mainMenu do
        RageUI.IsVisible(mainMenu, function()
            RageUI.Button("Intéraction Citoyen", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                end
            }, civils)

            RageUI.Button("Objets", nil, { RightLabel = "→" }, true, {
            }, props)

            -- RageUI.Button("Information entreprise", nil, {RightLabel = "→"}, true , {
            --     onSelected = function()
            --     end
            -- }, infoPdg)
            
        end)

        RageUI.IsVisible(infoPdg, function()

            RageUI.Button("Société : ", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                end
            })
            RageUI.Button("Argent en société : ", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                end
            })

        end)

        RageUI.IsVisible(civils, function()
            RageUI.Button("Fouiller une personne", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance ~= -1 and distance <= 3.0 then

                        
                        local getPlayerSearch = GetPlayerPed(player)
                        if not IsEntityPlayingAnim(getPlayerSearch, 'random@mugging3', 'handsup_standing_base', 3) then
                            ESX.ShowNotification("La personne en face lève pas les mains en l'air")
                        else
                            TriggerServerEvent("Gamemode:Inventory:OpenSecondInventory", "fplayerl", GetPlayerServerId(player))
                            
                            CreateThread(function()
                                local bool = true

                                while (bool) do
                                    local coords = GetEntityCoords(GetPlayerPed(-1))
                                    local dist = #(GetEntityCoords(GetPlayerPed(player)) - coords)
                                    print(dist)
                                    if (dist > 3) then
                                        bool = false
                                        exports[exports.Tree:serveurConfig().Serveur.hudScript]:CloseInventory()
                                    end

                                    Wait(100)
                                end
                            end)
                        end
                    else
                        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Personne autour de vous')
                    end
                end
            })

            RageUI.Button("Menotter/Démenotter", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Personne autour de vous')
                    else
                        local dict, anim = 'mp_arrest_paired', 'cop_p2_back_left'
                        RequestAnimDict(dict)
                        while not HasAnimDictLoaded(dict) do
                            Citizen.Wait(100)
                        end
                        TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        Wait(5000)
                        TriggerServerEvent("menotterForGouv", GetPlayerServerId(closestPlayer))
                        ClearPedTasks(PlayerPedId())
                    end
                end
            })
    
            RageUI.Button("Escorter", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    playerheading = GetEntityHeading(PlayerPedId())
                    playerlocation = GetEntityForwardVector(PlayerPedId())
                    playerCoords = GetEntityCoords(PlayerPedId())
                    local target_id = GetPlayerServerId(target)
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Personne autour de vous')
                    else
                        TriggerServerEvent('escorterGouv', GetPlayerServerId(closestPlayer))
                    end
                end
            })
    
            RageUI.Button("Mettre dans le véhicule", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Personne autour de vous')
                    else
                        TriggerServerEvent('jeter', GetPlayerServerId(closestPlayer))
                    end
                end
            })

            RageUI.Button("Sortir du véhicule", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Personne autour de vous')
                    else
                        TriggerServerEvent('sortir', GetPlayerServerId(closestPlayer))
                    end
                end
            })
            RageUI.Button("Faire une Facture", nil, {RightLabel = ""}, true , {
                onSelected = function()
                    local montant = KeyboardInputGouv("Montant:", 'Indiquez un montant', '', 7)
                    if tonumber(montant) == nil then
                        ESX.ShowNotification("Montant invalide")
                        return false
                    else
                        amount = (tonumber(montant))
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance == -1 or closestDistance > 3.0 then
                            ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Personne autour de vous')
                        else
                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'gouv', 'Gouvernement', amount)
                        end
                    end
                end
            })    
        end)

        RageUI.IsVisible(props, function()
            RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Gérer", nil, { RightLabel = "→" }, true, {
            }, propsList)
            for k,v in pairs(objectsGouv) do 
                RageUI.Button(v.name, v.model, { RightLabel = "→" }, true, {
                    onSelected = function()
                        SpawnObj(v.model)
                        -- print(v.name)
                    end
                })
            end
        end)

        RageUI.IsVisible(propsList, function()
            for k,v in pairs(object) do
                if GoodName(GetEntityModel(NetworkGetEntityFromNetworkId(v))) == 0 then table.remove(object, k) end
                RageUI.Button("Objet : "..GoodName(GetEntityModel(NetworkGetEntityFromNetworkId(v))), v, { RightLabel = "→" }, true, {
                    onActive = function()
                        local entity = NetworkGetEntityFromNetworkId(v)
                        local ObjCoords = GetEntityCoords(entity)
                        DrawMarker(2, ObjCoords.x, ObjCoords.y, ObjCoords.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 170, 1, 0, 2, 1, nil, nil, 0)
                    end,
                    onSelected = function()
                        RemoveObj(v, k)
                        -- print("ID : "..v, k)
                    end
                })
            end
        end)

        if not RageUI.Visible(mainMenu) and not RageUI.Visible(civils) and not RageUI.Visible(infoPdg) and not RageUI.Visible(props) and not RageUI.Visible(propsList) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
        end
        
        Citizen.Wait(0)
    end
end

OpenGouvBoss = function()
    local mainMenu = RageUI.CreateMenu("", "Menu du gouvernement")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    FreezeEntityPosition(PlayerPedId(), true)

    while mainMenu do
        RageUI.IsVisible(mainMenu, function()
            -- Trigger open boss menu
        end)
        if not RageUI.Visible(mainMenu) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
            FreezeEntityPosition(PlayerPedId(), false)
        end
        Citizen.Wait(0)
    end
end

OpenGouvArmurerie = function()
    local mainMenu = RageUI.CreateMenu("", "Achetez vos équipements")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    FreezeEntityPosition(PlayerPedId(), true)

    while mainMenu do
        RageUI.IsVisible(mainMenu, function()
            RageUI.Separator("↓ ~m~Armement ~s~↓")

            for k,v in pairs(Config.Gouv.Items) do
                RageUI.Button(v.label, nil, {RightLabel = ""}, true, {
                    onSelected = function()
                        if (v.weapon) then
                            TriggerServerEvent('gouv:payWeapon', v.weapon)
                        elseif (v.item) then
                            TriggerServerEvent('gouv:payItem', v.item)
                        end
                    end
                })
            end

            RageUI.Separator("↓ ~m~Accessoires ~s~↓")

            RageUI.Button("Prendre un gilet par balle", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    TriggerServerEvent("addGilet:gouv")
                end
            })
            RageUI.Button("Prendre un chargeur", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    TriggerServerEvent("addChargeur:gouv")
                end
            })
        end)
        if not RageUI.Visible(mainMenu) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
            FreezeEntityPosition(PlayerPedId(), false)
        end
        Wait(0)
    end
end

openSortirVehicle = function()
    local mainMenu = RageUI.CreateMenu("", "Sortir un véhicule")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    FreezeEntityPosition(PlayerPedId(), true)

    while mainMenu do
        RageUI.IsVisible(mainMenu, function()
            for k,v in pairs(Config.Gouv.ListeVehicle) do
                if ESX.PlayerData.job.grade >= v.grade then
                    RageUI.Button(v.label, nil, {RightLabel = ""}, true, {
                        onSelected = function()
                            ESX.Game.SpawnVehicle(v.model, Config.Gouv.PosSortirVehicule, Config.Gouv.HeadingSortirVehicule, function(vehicle)
                                local newPlate = exports['Gamemode']:GeneratePlate()
                                SetVehicleNumberPlateText(vehicle, newPlate)
                                exports[exports.Tree:serveurConfig().Serveur.hudScript]:SetFuel(vehicle, 100)
                                TriggerServerEvent('babyboy:GiveDoubleKeys', 'no', newPlate)
                                TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                RageUI.CloseAll()
                            end)
                        end
                    })
                end
            end
        end)
        if not RageUI.Visible(mainMenu) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
            FreezeEntityPosition(PlayerPedId(), false)
        end
        Citizen.Wait(0)
    end
end


function getPlayerInvGouv(player)
    
    ESX.TriggerServerCallback('getOtherPlayerData', function(data)
        for i=1, #data.accounts, 1 do
            if data.accounts[i].name == 'dirtycash' and data.accounts[i].money > 0 then
                table.insert(ArgentSaleGouv, {
                    label    = ESX.Math.Round(data.accounts[i].money),
                    value    = 'dirtycash',
                    itemType = 'item_account',
                    amount   = data.accounts[i].money
                })
    
            end
        end
    
        for i=1, #data.inventory, 1 do
            if data.inventory[i].count > 0 then
                table.insert(ItemsGouv, {
                    label    = data.inventory[i].label,
                    right    = data.inventory[i].count,
                    value    = data.inventory[i].name,
                    itemType = 'item_standard',
                    amount   = data.inventory[i].count
                })
            end
        end

        for i=1, #data.weapons, 1 do
           -- if data.weapons[i].count > 0 then
                table.insert(ArmesGouv, {
                    label    = ESX.GetWeaponLabel(data.weapons[i].name),
                    right    = data.weapons[i].ammo,
                    value    = data.weapons[i].name,
                    itemType = 'item_weapon',
                    amount   = data.weapons[i].ammo
                })   
           -- end
        end

    end, GetPlayerServerId(player))
end

Keys.Register('F6','Interactgouv', 'Actions Gouvernement', function()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == "gouv" then
        OpenF6Gouv()
    end
end)