

local prenom = nil
local nom = nil
local date = nil
local raison = nil
local ServiceBCSO = false
local nomdelemploye = nil
local gradedelemploye = nil
local CasierJudiciaire = {}
local CheckPlaintes = {}
local ItemsBCSO = {}
local ArmesBCSO = {}
local ArgentSaleBCSO = {}
local infosvehicle = {}
local IsHandcuffed, DragStatus = false, {}
openF6no = false
local openClothes = false
local openedGarage = false
local openPlainte = false
local openBureau = false
local isArmurerieOpened = false

DragStatus.IsDragged = false

-- Décla + peds/blips

Citizen.CreateThread(function()
    for k,v in pairs(Config.Jobs.Bsco.Peds) do
        local model = GetHashKey(v.ped[1])
		RequestModel(model)
		while not HasModelLoaded(model) do Wait(1) end
		local ped = CreatePed(4, model, v.ped[2], v.ped[3], false, true)
		FreezeEntityPosition(ped, true)
		SetEntityInvincible(ped, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
		TaskStartScenarioInPlace(ped, "WORLD_HUMAN_COP_IDLES", 0, true)
    end
end)


function getPlayerInvBcso(player)
    ESX.TriggerServerCallback('bcso:getOtherPlayerDataBcso', function(data)
        for i=1, #data.accounts, 1 do
            if data.accounts[i].name == 'dirtycash' and data.accounts[i].money > 0 then
                table.insert(ArgentSaleBCSO, {
                    label    = ESX.Math.Round(data.accounts[i].money),
                    value    = 'dirtycash',
                    itemType = 'item_account',
                    amount   = data.accounts[i].money
                })
    
            end
        end
    
        for i=1, #data.inventory, 1 do
            if data.inventory[i].count > 0 then
                table.insert(ItemsBCSO, {
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
                table.insert(ArmesBCSO, {
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

function getInfosVehicleBcso(vehicleData)
    ESX.TriggerServerCallback('bcso:getVehicleInfos', function(retrivedInfo)
        if retrivedInfo == nil then
            table.insert(infosvehicle, {
                label = "inconnu",
                plaque = vehicleData.plate
            })
        else
            table.insert(infosvehicle, {
                label = retrivedInfo.owner,
                plaque = retrivedInfo.plate
            })
        end
    end, vehicleData.plate)
end


local objectsBCSO = {
    [0] = {
        model = "prop_roadcone02a",
        name = "Cônes"
    },
    [1] = {
        model = "prop_mp_barrier_02b",
        name = "Barrière"
    },
    [2] = {
        model = "p_ld_stinger_s",
        name = "Herses"
    },
}

-- Main
function openF6BCSO()
    ItemsBCSO = {}
    ArmesBCSO = {}
    ArgentSaleBCSO = {}
    local vehicleInfos = {}
    
    local mainMenu = RageUI.CreateMenu('', 'Faites vos actions')
    local actions = RageUI.CreateSubMenu(mainMenu, "", "Faites vos actions")
    local interaction = RageUI.CreateSubMenu(mainMenu, "", "Faites vos actions")
    local interactionveh = RageUI.CreateSubMenu(mainMenu, "", "Faites vos actions")
    local renfort = RageUI.CreateSubMenu(mainMenu, "", "Faites vos actions")
    local objets = RageUI.CreateSubMenu(mainMenu, "", "Faites vos actions")
    local casier = RageUI.CreateSubMenu(mainMenu, "", "Faites vos actions")
    local plaintes = RageUI.CreateSubMenu(mainMenu, "", "Faites vos actions")
    local fouiller = RageUI.CreateSubMenu(interaction, "", "Faites vos actions")
    local lesfinosmec = RageUI.CreateSubMenu(interactionveh, "", "Faites vos actions")
    local infoscasier = RageUI.CreateSubMenu(casier, "", "Faites vos actions")
    local showDatabase = RageUI.CreateSubMenu(casier, "", "Faites vos actions")
    local infosplaintes = RageUI.CreateSubMenu(plaintes, "", "Faites vos actions")
    local infoamende = RageUI.CreateSubMenu(mainMenu, "", "Faites vos actions")
    local props = RageUI.CreateSubMenu(mainMenu, "", "Intéractions : Objets")
    local propsList = RageUI.CreateSubMenu(props, "", "Intéractions : Gérer")
    local extraMenu = RageUI.CreateSubMenu(mainMenu, "", "Intéractions : Extras")
    lesfinosmec.Closed = function()
        vehicleInfos = {}
    end

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while openF6no do
        Wait(1)
        RageUI.IsVisible(mainMenu, function()
            RageUI.Line()
           if ServiceBCSO then
                RageUI.Button("Intéraction Citoyen", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                    end
                }, interaction)
                RageUI.Button("Intéraction Véhicule", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                    end
                }, interactionveh)
                if IsPedInAnyVehicle(PlayerPedId(), true) then
                    RageUI.Button("Extras", nil, {RightLabel = "→"}, true, {
                    }, extraMenu)
                end
                RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Stoppez les PNJ", "Activer/Désactiver les pnj dans la zone de 100 m", {RightLabel = "→"}, not stopPNJCooldownBcso, {
                    onSelected = function()
                        stopPNJCooldownBcso = true
                        Citizen.SetTimeout(15 * 60 * 10, function()
                            stopPNJCooldownBcso = false
                        end)
                        ExecuteCommand("arretpnj")
                        RageUI.CloseAll()
                    end
                })
                RageUI.Line()
                RageUI.Button("Objets", nil, { RightLabel = "→" }, true, {
                }, props)
                RageUI.Button("Demande de renforts", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                    end
                }, renfort)
                RageUI.Button("Casier judiciaire", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                    end
                }, casier)
                RageUI.Button("Ranger/Sortir son bouclier", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                        ExecuteCommand("shield")
                    end
                })
                -- RageUI.Button("Plaintes", nil, {RightLabel = "→"}, true , {
                --     onSelected = function()
                --     end 
                -- }, plaintes)
                if ESX.PlayerData.job.name == 'bcso' and ESX.PlayerData.job.grade >= 3 then
                    RageUI.Button("Drone", nil, {RightLabel = "→"}, true , {
                        onSelected = function()
                            RageUI.CloseAll()
                            ExecuteCommand("drone")
                        end
                    })
                end
            else
                RageUI.Separator(exports.Tree:serveurConfig().Serveur.color.."Vous devez etre en service")
            end
        end)

        RageUI.IsVisible(casier, function()
            RageUI.Line()
            RageUI.Button("Voir les casiers déjé existants", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    getData()
                end
            }, showDatabase)
            RageUI.Button("Ajouter un casier dans la base", nil, {RightLabel = "→"}, true , {
            }, infoscasier)
        end)

        -- RageUI.IsVisible(plaintes, function()
        --     RageUI.Line()
        --     RageUI.Button("Consulter les plaintes", nil, {RightLabel = "→"}, true , {
        --         onSelected = function()
        --             getPlaintes()
        --         end
        --     }, infosplaintes)
        -- end)

        -- RageUI.IsVisible(infosplaintes,function()
        --     RageUI.Line()
        --     for k,v in pairs(CheckPlaintes) do
        --         RageUI.Button("Plainte de: "..v.prenom.. " "..v.nom.. " Num: "..v.num, "Contre: "..v.prenom1.. " "..v.nom1.. " a contacter au: "..v.num1.. " pour la raison: "..v.raison, {RightLabel = "→"}, true , {
        --             onSelected = function()
        --                 verif = KeyboardInputBcso("delete", 'Voulez vous supprimer cette plainte ↓ (oui/non)', '', 4)
        --                 verified = (tostring(verif))

        --                 if verified == "oui" then
        --                     TriggerServerEvent('bcso:plaitetraiterbcso', v.prenom, v.nom, v.num)
        --                     RageUI.CloseAll()
        --                 else
        --                     ESX.ShowNotification("Suppression annulée")
        --                 end
        --             end
        --         })
        --     end
        -- end)

        RageUI.IsVisible(props, function()
            RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Gérer", nil, { RightLabel = "→" }, true, {
            }, propsList)
            RageUI.Line()
            for k,v in pairs(objectsBCSO) do 
                RageUI.Button(v.name, v.model, { RightLabel = "→" }, true, {
                    onSelected = function()
                        SpawnObj(v.model)
                        -- print(v.name)
                    end
                })
            end
        end)

        RageUI.IsVisible(propsList, function()
            RageUI.Line()
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

        RageUI.IsVisible(extraMenu, function()
            if extraTable == nil then extraTable = {} end
            for i= 1, 20 do
                if DoesExtraExist(GetVehiclePedIsIn(PlayerPedId(), false), i) then
                    if not IsVehicleExtraTurnedOn(GetVehiclePedIsIn(PlayerPedId(), false), i) then
                        RageUI.Button("Extra #"..i, nil, {RightLabel = "❌"}, true, {
                            onSelected = function()
                                if not IsVehicleExtraTurnedOn(GetVehiclePedIsIn(PlayerPedId(), false), i) then
                                    extraTable[i] = true
                                    SetVehicleExtra(GetVehiclePedIsIn(PlayerPedId(), false), i, 0)
                                else
                                    extraTable[i] = false
                                    SetVehicleExtra(GetVehiclePedIsIn(PlayerPedId(), false), i, 1)
                                end
                            end
                        })
                    else
                        RageUI.Button("Extra #"..i, nil, {RightLabel = "✅"}, true, {
                            onSelected = function()
                                if not IsVehicleExtraTurnedOn(GetVehiclePedIsIn(PlayerPedId(), false), i) then
                                    extraTable[i] = true
                                    SetVehicleExtra(GetVehiclePedIsIn(PlayerPedId(), false), i, 0)
                                else
                                    extraTable[i] = false
                                    SetVehicleExtra(GetVehiclePedIsIn(PlayerPedId(), false), i, 1)
                                end
                            end
                        })
                    end
                end
            end
        end)

        RageUI.IsVisible(infoamende,function()

            for k,v in pairs(PoliceConfigAAA.amende) do
            for _,i in pairs(v) do
            RageUI.Button(i.label, nil, {RightLabel = "~g~"..i.price.."$"}, true , {
                onSelected = function() 
                    local player, distance = ESX.Game.GetClosestPlayer()
                    local sID = GetPlayerServerId(player)

                    if player ~= -1 and distance <= 3.0 then
                        TriggerServerEvent("bcso:SendFacture", sID, i.price)
                        ESX.ShowNotification("~g~Facture envoyée avec succès !")
                        RageUI.CloseAll()
                        open = false
                    else
                        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Personne autour de vous")
                    end
                end
            })

        end
        end
        end)


        RageUI.IsVisible(interaction, function()
            RageUI.Button("Mettre une amende", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                end
            }, infoamende)
            RageUI.Button("Prendre la carte d'identité", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local player, distance = ESX.Game.GetClosestPlayer()
                    local getPlayerSearch = GetPlayerPed(player)
                    if IsEntityPlayingAnim(getPlayerSearch, 'random@mugging3', 'handsup_standing_base', 3) then
                        if distance ~= -1 and distance <= 3.0 then
                            RageUI.CloseAll()
                            ExecuteCommand("me Prend la carte d'identité..")                            
                            TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(player), GetPlayerServerId(PlayerId()))
                        else
                            ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Personne autour de vous')
                        end
                    else
                        ESX.ShowNotification("Cette personne ne lève pas les mains")
                    end
                end
            })
            RageUI.Button("Fouiller", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance ~= -1 and distance <= 3.0 then
                        ExecuteCommand("me Fouille l'individue..")
                        TriggerServerEvent('bcso:message', GetPlayerServerId(player))
                        -- getPlayerInvBcso(player)
                        
                        local getPlayerSearch = GetPlayerPed(player)
                        if not IsEntityPlayingAnim(getPlayerSearch, 'random@mugging3', 'handsup_standing_base', 3) then
                            ESX.ShowNotification("La personne en face lève pas les mains en l'air")
                        else
                            TriggerServerEvent("Gamemode:Inventory:OpenSecondInventory", "fplayerl", GetPlayerServerId(player))

                            CreateThread(function()
                                local bool = true
                                while bool do
                                    local getPlayerSearch = GetPlayerPed(player)
                                    
                                    local coords = GetEntityCoords(GetPlayerPed(-1))
                                    local dist = #(GetEntityCoords(getPlayerSearch) - coords)
                                    if (dist > 3) then
                                        bool = false
                                        exports[exports.Tree:serveurConfig().Serveur.hudScript]:CloseInventory()
                                    end


                                    if not IsEntityPlayingAnim(getPlayerSearch, 'random@mugging3', 'handsup_standing_base', 3) then
                                        ESX.ShowNotification("La personne en face lève pas les mains en l'air")
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
                        TriggerServerEvent('bcso:menotter', GetPlayerServerId(closestPlayer))
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
                        TriggerServerEvent('bcso:escorter', GetPlayerServerId(closestPlayer))
                    end
                end
            })
            RageUI.Button("Jeter dans le véhicule", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Personne autour de vous')
                    else
                        TriggerServerEvent('tF_bcsojob:putInVehicle', GetPlayerServerId(closestPlayer))
                    end
                end
            })

            RageUI.Button("Sortir du véhicule", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Personne autour de vous')
                    else
                        TriggerServerEvent('tF_bcsojob:OutVehicle', GetPlayerServerId(closestPlayer))
                    end
                end
            })
        end)

        RageUI.IsVisible(interactionveh, function()
            RageUI.Button("Informations du véhicule", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local coords  = GetEntityCoords(PlayerPedId())
                    local vehicle = ESX.Game.GetVehicleInDirection()
                    local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
                    if DoesEntityExist(vehicle) then
                        getInfosVehicleBcso(vehicleData)
                    else
                        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Aucun véhicule à proximité")
                    end
                end
            }, lesfinosmec)

            RageUI.Button("Crocheter le véhicule", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local coords  = GetEntityCoords(PlayerPedId())
                    local vehicle = ESX.Game.GetVehicleInDirection()
                    if DoesEntityExist(vehicle) then
                        local plyPed = PlayerPedId()
    
                        TaskStartScenarioInPlace(plyPed, 'WORLD_HUMAN_WELDING', 0, true)
                        Citizen.Wait(20000)
                        ClearPedTasksImmediately(plyPed)
    
                        SetVehicleDoorsLocked(vehicle, 1)
                        SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                        ESX.ShowNotification("~g~Véhicule dévérouillé")
                    else
                        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Aucun véhicule é proximité")
                    end
                end
            })

            RageUI.Button("Mettre le véhicule en fourriére", nil, {}, true, {
                onSelected = function()
                    local playerPed = PlayerPedId()
                    local coords    = GetEntityCoords(playerPed)
                    local vehicle = nil
                    if IsPedInAnyVehicle(playerPed, false) then
                        vehicle = GetVehiclePedIsIn(playerPed, false)
                    else
                        vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
                    end
                    if DoesEntityExist(vehicle) then
                        TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
                        Citizen.CreateThread(function()
                            Citizen.Wait(10000)
                            ESX.Game.DeleteVehicle(vehicle)
                            ClearPedTasksImmediately(playerPed)
                            ESX.ShowNotification("Véhicule mis en fourriére")
                        end)
                    end
                end
            })
        end)

        RageUI.IsVisible(lesfinosmec, function()
            local vehicle = ESX.Game.GetVehicleInDirection()
            if not DoesEntityExist(vehicle) then
                RageUI.GoBack()
                return
            end
            for k,v in pairs(infosvehicle) do
                RageUI.Button("Propriétaire: "..v.label, nil, {RightLabel = "→"}, true , {
                })
                RageUI.Button("Plaque: "..v.plaque, nil, {RightLabel = "→"}, true , {
                })
            end
        end)

        RageUI.IsVisible(renfort, function()
            RageUI.Button("Petite demande", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local playerPed = PlayerPedId()
                    local coords  = GetEntityCoords(playerPed)
                    TriggerServerEvent('bcso:demande', coords, 'petite')
                end
            })
            RageUI.Button("Moyenne demande", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local playerPed = PlayerPedId()
                    local coords  = GetEntityCoords(playerPed)
                    TriggerServerEvent('bcso:demande', coords, 'moyenne')
                end
            })
            RageUI.Button("Grande demande", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local playerPed = PlayerPedId()
                    local coords  = GetEntityCoords(playerPed)
                    TriggerServerEvent('bcso:demande', coords, 'Grande')
                end
            })
        end)

        RageUI.IsVisible(fouiller, function()
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            local getPlayerSearch = GetPlayerPed(closestPlayer)
            if not IsEntityPlayingAnim(getPlayerSearch, 'random@mugging3', 'handsup_standing_base', 3) then
                RageUI.GoBack()
                ESX.ShowNotification("La personne en face lève pas les mains en l'air")
                return
            end

            if closestPlayer == -1 or closestDistance > 3.0 then
                RageUI.CloseAll()
                return
            end
        
            RageUI.Separator("Vous Fouillez : " ..GetPlayerName(closestPlayer))
    
            RageUI.Separator("↓ "..exports.Tree:serveurConfig().Serveur.color.."Argent non déclaré ~s~↓")

            for k,v in pairs(ArgentSaleBCSO) do
                RageUI.Button("Argent non déclaré :", nil, {RightLabel = "~g~"..v.label.."$"}, true , {
                    onSelected = function()
                        local combien = KeyboardInputPolice("Combien ?", 'Indiquez un nombre', '', 10)
                        if tonumber(combien) > v.amount then
                            ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Montant invalide')
                        else
                            TriggerServerEvent('bcso:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                            RageUI.CloseAll()
                        end
                    end
                })
            end

            RageUI.Separator("↓ "..exports.Tree:serveurConfig().Serveur.color.."Items du joueur ~s~↓")

            for k,v in pairs(ItemsBCSO) do
                RageUI.Button("Nom: "..v.label, nil, {RightLabel = "~g~"..v.right.." exemplaires"}, true , {
                    onSelected = function()
                        local combien = KeyboardInputBcso("Combien ", 'Indiquez un nombre', '', 4)
                        if tonumber(combien) > v.amount then
                            ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Montant invalide')
                        else
                            TriggerServerEvent('bcso:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                            RageUI.CloseAll()
                        end
                    end
                })
            end
            
            RageUI.Separator("↓ "..exports.Tree:serveurConfig().Serveur.color.."Armes du joueur ~s~↓")
            for k,v in pairs(ArmesBCSO) do
                local isPermanent = ESX.IsWeaponPermanent(v.value);
                if (not isPermanent) then
                    RageUI.Button("Arme: "..v.label, nil, {RightLabel = "→"}, true , {
                        onSelected = function()
                            local combien = KeyboardInputBcso("Nombre de munitions", 'Indiquez un nombre', '', 4)
                            if tonumber(combien) > 1 then
                                ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Montant invalide')
                            else
                                TriggerServerEvent('bcso:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                                RageUI.CloseAll()
                            end
                        end
                    })
                end
            end
        end)


        RageUI.IsVisible(showDatabase, function()
            for k,v in pairs(CasierJudiciaire) do
                RageUI.Separator(exports.Tree:serveurConfig().Serveur.color.."Casier de: "..v.prenom.. " "..v.nom.."")
                RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Informations ci-dessous:", "Date de naissance: "..v.naissance.. " Motif du casier: "..v.raison, {RightLabel = "Auteur: "..v.auteur}, true , {
                    onSelected = function()
                        local grade = ESX.PlayerData.job.grade_name
                        if grade == 'boss' then
                            verif = KeyboardInputBcso("delete", 'Voulez vous supprimer ce casier ↓ (oui/non)', '', 4)
                            verified = (tostring(verif))
                            if verified == "oui" then
                                TriggerServerEvent('bcso:deletecasier', v.prenom, v.nom, v.naissance, v.raison, v.auteur)
                                RageUI.CloseAll()
                            else
                                ESX.ShowNotification("Suppression annulée.")
                                RageUI.CloseAll()
                            end
                        end
                    end
                })
            end
        end)

        RageUI.IsVisible(infoscasier, function()
            RageUI.Button("Prénom", "Indiquez le Prénom", {RightLabel = prenom}, true , {
                onSelected = function()
                    local prenomInput = KeyboardInputBcso("prenom", 'Indiquez le prenom du suspect ', '', 20)
                    if tostring(prenomInput) == nil then
                        return false
                    else
                        prenom = (tostring(prenomInput))
                    end
                end
            })
            RageUI.Button("Nom", "Indiquez le Nom de famille", {RightLabel = nom}, true , {
                onSelected = function()
                    local nomInput = KeyboardInputBcso("nom", 'Indiquez le nom du suspect ', '', 20)
                    if tostring(nomInput) == nil then
                        return false
                    else
                        nom = (tostring(nomInput))
                    end
                end
            })
            RageUI.Button("Date de naissance", "Indiquez la date de naissance", {RightLabel = date}, true , {
                onSelected = function()
                    local dateInput = KeyboardInputBcso("date", 'Indiquez la date de naissance du suspect ', '', 20)
                    if tostring(dateInput) == nil then
                        return false
                    else
                        date = (tostring(dateInput))
                    end
                end
            })
            RageUI.Button("Motif", "Indiquez le motif du casier", {RightLabel = raison}, true , {
                onSelected = function()
                    local raisonInput = KeyboardInputBcso("raison", 'Indiquez la raison du casier ', '', 100)
                    if tostring(raisonInput) == nil then
                        return false
                    else
                        raison = (tostring(raisonInput))
                    end
                end
            })
            RageUI.Button("Valider le casier", "Appuyez pour envoyer le casier dans la base", {RightLabel = "→"}, true , {
                onSelected = function()
                    local prenomInput = prenom
                    local nomInput = nom
                    local dateInput = date
                    local raisonInput = raison

                    if not prenomInput then
                        ESX.ShowNotification("Vous n'avez pas correctement renseigné la catégorie "..exports.Tree:serveurConfig().Serveur.color.."Prénom")
                    elseif not nomInput then
                        ESX.ShowNotification("Vous n'avez pas correctement renseigné la catégorie "..exports.Tree:serveurConfig().Serveur.color.."Nom")
                    elseif not dateInput then
                        ESX.ShowNotification("Vous n'avez pas correctement renseigné la catégorie "..exports.Tree:serveurConfig().Serveur.color.."Date de naissance") 
                    elseif not raisonInput then
                        ESX.ShowNotification("Vous n'avez pas correctement renseigné la catégorie "..exports.Tree:serveurConfig().Serveur.color.."Motif")
                    else
                        TriggerServerEvent('insertintocasier', nomInput, prenomInput, dateInput, raisonInput)
                        RageUI.CloseAll()
                    end
                end
            })
        end)


        -- if not RageUI.Visible(mainMenu) and not RageUI.Visible(extraMenu) and not RageUI.Visible(fouiller) and not RageUI.Visible(props) and not RageUI.Visible(propsList) and not RageUI.Visible(showDatabase) and not RageUI.Visible(plaintes) and not RageUI.Visible(infoamende) and not RageUI.Visible(shield) and not RageUI.Visible(infosplaintes) and not RageUI.Visible(actions) and not RageUI.Visible(infoscasier) and not RageUI.Visible(interaction) and not RageUI.Visible(casier) and not RageUI.Visible(interactionveh) and not RageUI.Visible(renfort) and not RageUI.Visible(objets) and not RageUI.Visible(lesfinosmec)then
        --     mainMenu = RMenu:DeleteType('mainMenu', true)
        --     openF6no = false
        -- end

        if not RageUI.Visible(lesfinosmec) then
            table.remove(infosvehicle, k)
        end

        -- if not RageUI.Visible(fouiller) then
        --     table.remove(ArgentSaleBCSO, k)
        --     table.remove(ItemsBCSO, k)
        --     table.remove(ArmesBCSO, k)
        -- end

        if not RageUI.Visible(showDatabase) then
            table.remove(CasierJudiciaire, k)
        end

        if not RageUI.Visible(infosplaintes) then
            table.remove(CheckPlaintes, k)
        end

    end
end

function openBureau()
    local mainMenu = RageUI.CreateMenu('', 'Faites vos actions')
    local rc = RageUI.CreateSubMenu(mainMenu, "", "Faites vos actions")
    local vr = RageUI.CreateSubMenu(mainMenu, "", "Faites vos actions")
    local pr = RageUI.CreateSubMenu(mainMenu, "", "Faites vos actions")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while openBureau do
        RageUI.IsVisible(mainMenu, function()
            RageUI.Button("Recruter des employés", nil, {RightLabel = "→"}, true , {
            })
            RageUI.Button("Virer des employés", nil, {RightLabel = "→"}, true , {
            })
            RageUI.Button("Promouvoir des employés", nil, {RightLabel = "→"}, true , {
            })
        end)

        Citizen.Wait(0)
        if not RageUI.Visible(mainMenu) and not RageUI.Visible(rc) and not RageUI.Visible(vr) and not RageUI.Visible(pr) then
            mainMenu = RMenu:DeleteType('mainMenu', true)
            openBureau = false
        end
    end


end

function openPlaintesBCSO()
    local mainMenu2 = RageUI.CreateMenu('', 'Faites vos actions')
    local depot = RageUI.CreateSubMenu(mainMenu2, "", "Faites vos actions")

    local nom
    local prenom
    local num
    local nom1
    local prenom1
    local num1
    local motif

    RageUI.Visible(mainMenu2, not RageUI.Visible(mainMenu2))

    while openPlainte do
        RageUI.IsVisible(mainMenu2, function()
            RageUI.Line()
            RageUI.Button("Déposer une plainte", nil, {RightLabel = "→"}, true , {
            }, depot)
        end)
        RageUI.IsVisible(depot, function()

            RageUI.Separator("↓ "..exports.Tree:serveurConfig().Serveur.color.."Vos informations ~s~↓")

            RageUI.Button("Nom de famille", nil, {RightLabel = nom}, true , {
                onSelected = function()
                    nomInput = KeyboardInputBcso("nom", 'Entrez votre nom', '', 15)
                    nom = (tostring(nomInput))
                end
            })
            RageUI.Button("Prénom", nil, {RightLabel = prenom}, true , {
                onSelected = function()
                    prenomInput = KeyboardInputBcso("prenom", 'Entrez votre prenom', '', 15)
                    prenom = (tostring(prenomInput))
                end
            })
            RageUI.Button("Numéro de téléphone", nil, {RightLabel = num}, true , {
                onSelected = function()
                    numInput = KeyboardInputBcso("num", 'Entrez votre numero de telephone', '', 15)
                    num = (tostring(numInput))
                end
            })

            RageUI.Separator("↓ "..exports.Tree:serveurConfig().Serveur.color.."Informations de l'accusé ~s~↓")

            RageUI.Button("Nom", nil, {RightLabel = nom1}, true , {
                onSelected = function()
                    nom1Input = KeyboardInputBcso("nom1", 'Entrez le nom de l\'accuse', '', 15)
                    nom1 = (tostring(nom1Input))
                end
            })
            RageUI.Button("Prénom", nil, {RightLabel = prenom1}, true , {
                onSelected = function()
                    prenom1Input = KeyboardInputBcso("prenom1", 'Entrez le prenom de l\'accuse', '', 15)
                    prenom1 = (tostring(prenom1Input))
                end
            })
            RageUI.Button("Numéro de téléphone", nil, {RightLabel = num1}, true , {
                onSelected = function()
                    num1Input = KeyboardInputBcso("num1", 'Entrez le numero de telephone de l\'accuse', '', 15)
                    num1 = (tostring(num1Input))
                end
            })
            RageUI.Button("Motif de votre plainte", motif, {RightLabel = "→"}, true , {
                onSelected = function()
                    motif = KeyboardInputBcso("motif", 'Entrez le motif de votre plainte', '', 80)
                end
            })

            RageUI.Separator("↓ "..exports.Tree:serveurConfig().Serveur.color.."Valider ~s~↓")

            RageUI.Button("Valider votre plainte", exports.Tree:serveurConfig().Serveur.color.."Aucun retour en arriére ne sera possible.", {RightLabel = "→"}, true , {
                onSelected = function()
                    if nom and prenom and num and nom1 and prenom1 and num1 and motif ~= nil then
                        TriggerServerEvent('bcso:validerplainte', nom, prenom, num, nom1, prenom1, num1, motif)
                        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Votre plainte a bien été transmise aux forces de l\'autorité")
                        RageUI.CloseAll()
                    else
                        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Merci de remplir toutes les informations")
                    end
                end
            })


        end)
        if not RageUI.Visible(mainMenu2) and not RageUI.Visible(depot) then
            mainMenu2 = RMenu:DeleteType('mainMenu', true)
            openPlainte = false
        end
        Citizen.Wait(0)
    end

end

function openArmurerieBCSO()
    local mainMenu = RageUI.CreateMenu('', 'Faites vos actions')
    local armes = RageUI.CreateSubMenu(mainMenu, "", "Faites vos actions")
    local paiement = RageUI.CreateSubMenu(mainMenu, "", "Faites vos actions")
    local achatArmes = {}

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))


    while isArmurerieOpened do
        RageUI.IsVisible(mainMenu, function()
            RageUI.Separator("↓ ~m~Armement ~s~↓")
            RageUI.Button("Armes de service", motif, {RightLabel = "→"}, true , {
            }, armes)
            RageUI.Separator("↓ ~m~Accessoires ~s~↓")
            RageUI.Button("Prendre un gilet par balle", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    TriggerServerEvent("addGilet:bcso")
                end
            })
            RageUI.Button("Prendre un chargeur", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    TriggerServerEvent("addChargeur:bcso")
                end
            })
        end)

        RageUI.IsVisible(armes, function()
            if ESX.PlayerData.job.grade_name == 'recruit' then
                RageUI.Button("Tazer", motif, {RightLabel = "→"}, true , {
                    onSelected = function()
                        table.insert(achatArmes, {
                            label = "Tazer",
                            hash = 'weapon_stungun',
                            prix = 0,
                        })
                    end
                }, paiement)
                RageUI.Button("Lampe torche", motif, {RightLabel = "→"}, true , {
                    onSelected = function()
                        table.insert(achatArmes, {
                            label = "Lampe torche",
                            hash = 'weapon_flashlight',
                            prix = 0,
                        })
                    end
                }, paiement)
                RageUI.Button("Matraque", motif, {RightLabel = "→"}, true , {
                    onSelected = function()
                        table.insert(achatArmes, {
                            label = "Matraque",
                            hash = 'weapon_nightstick',
                            prix = 0,
                        })
                    end
                }, paiement)
            elseif ESX.PlayerData.job.grade_name == 'deputyone' or ESX.PlayerData.job.grade_name == "deputytwo" then
                RageUI.Button("Tazer", motif, {RightLabel = "→"}, true , {
                    onSelected = function()
                        table.insert(achatArmes, {
                            label = "Tazer",
                            hash = 'weapon_stungun',
                            prix = 0,
                        })
                    end
                }, paiement)
                RageUI.Button("Lampe torche", motif, {RightLabel = "→"}, true , {
                    onSelected = function()
                        table.insert(achatArmes, {
                            label = "Lampe torche",
                            hash = 'weapon_flashlight',
                            prix = 0,
                        })
                    end
                }, paiement)
                RageUI.Button("Matraque", motif, {RightLabel = "→"}, true , {
                    onSelected = function()
                        table.insert(achatArmes, {
                            label = "Matraque",
                            hash = 'weapon_nightstick',
                            prix = 0,
                        })
                    end
                }, paiement)
                RageUI.Button("Pistolet de combat", motif, {RightLabel = "→"}, true , {
                    onSelected = function()
                        table.insert(achatArmes, {
                            label = "Pistolet de combat",
                            hash = 'weapon_combatpistol',
                            prix = 2500,
                        })
                    end
                }, paiement)
                -- RageUI.Button("Pompe bean-bag", motif, {RightLabel = "→"}, true , {
                --     onSelected = function()
                --         table.insert(achatArmes, {
                --             label = "Pompe bean-bag",
                --             hash = 'weapon_beanbag',
                --             prix = 2500,
                --         })
                --     end
                -- }, paiement)
            else
                RageUI.Button("Tazer", motif, {RightLabel = "→"}, true , {
                    onSelected = function()
                        table.insert(achatArmes, {
                            label = "Tazer",
                            hash = 'weapon_stungun',
                            prix = 0,
                        })
                    end
                }, paiement)
                RageUI.Button("Lampe torche", motif, {RightLabel = "→"}, true , {
                    onSelected = function()
                        table.insert(achatArmes, {
                            label = "Lampe torche",
                            hash = 'weapon_flashlight',
                            prix = 0,
                        })
                    end
                }, paiement)
                RageUI.Button("Matraque", motif, {RightLabel = "→"}, true , {
                    onSelected = function()
                        table.insert(achatArmes, {
                            label = "Matraque",
                            hash = 'weapon_nightstick',
                            prix = 0,
                        })
                    end
                }, paiement)
                RageUI.Button("Pistolet de combat", motif, {RightLabel = "→"}, true , {
                    onSelected = function()
                        table.insert(achatArmes, {
                            label = "Pistolet de combat",
                            hash = 'weapon_combatpistol',
                            prix = 2500,
                        })
                    end
                }, paiement)

                RageUI.Button("Pompe bean-bag", motif, {RightLabel = "→"}, true , {
                    onSelected = function()
                        table.insert(achatArmes, {
                            label = "Pompe bean-bag",
                            hash = 'weapon_beanbag',
                            prix = 2500,
                        })
                    end
                }, paiement)
                
            end

            if ESX.PlayerData.job.grade >= 9 then
                RageUI.Button("Pompe", motif, {RightLabel = "→"}, true , {
                    onSelected = function()
                        table.insert(achatArmes, {
                            label = "Pompe",
                            hash = 'weapon_pumpshotgun',
                            prix = 7500,
                        })
                    end
                }, paiement)
                RageUI.Button("Carabine d'assault", motif, {RightLabel = "→"}, true , {
                    onSelected = function()
                        table.insert(achatArmes, {
                            label = "Carabine d'assault",
                            hash = 'weapon_carbinerifle',
                            prix = 5000,
                        })
                    end
                }, paiement)
            end

        end)
        

        RageUI.IsVisible(paiement, function()
            for k,v in pairs(achatArmes) do
                RageUI.Button("Arme : 1 "..v.label, nil, {RightLabel = ""}, true , {
                })
                RageUI.Button("Récupérer votre armement", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                        TriggerServerEvent('bcso:buyWeapon', v.hash)
                        table.remove(achatArmes, k)
                        RageUI.CloseAll()
                    end
                })
            end
        end)

        if not RageUI.Visible(mainMenu) and not RageUI.Visible(armes) and not RageUI.Visible(paiement) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
            table.remove(achatArmes, k)
            isArmurerieOpened = false
        end


        Citizen.Wait(0)
    end
end

-- function openBcsoGarage()
--     local mainMenu = RageUI.CreateMenu('', 'Faites vos actions')

--     RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

--     while openedGarage do
--         local grade = ESX.PlayerData.job.grade_name

--         local AuthorizedVehiclesBcso = Config.AuthorizedVehiclesBcso[grade]

--         if (AuthorizedVehiclesBcso == nil) then openedGarage = false return end

--         RageUI.IsVisible(mainMenu, function()
--             if #AuthorizedVehiclesBcso > 0 then
--                 for k,vehicle in ipairs(AuthorizedVehiclesBcso) do
--                     RageUI.Button(GetDisplayNameFromVehicleModel(vehicle.model), nil, {RightLabel = "→"}, true , {
--                         onSelected = function()
--                             TriggerServerEvent('bcso:spawnVehicle', vehicle.model);
--                             ESX.Game.SpawnVehicle(vehicle.model, vector3(1863.636, 3687.703, 33.88995), 314.66, function (vehicle)
--                                 local newPlate = exports['Gamemode']:GeneratePlate()
--                                 SetVehicleNumberPlateText(vehicle, newPlate)
--                                 exports[exports.Tree:serveurConfig().Serveur.hudScript]:SetFuel(vehicle, 100)
--                                 TriggerServerEvent('babyboy:GiveDoubleKeys', 'no', newPlate)
--                                 TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
--                             end)
--                             RageUI.CloseAll()
--                         end
--                     })

--                 end
--             end
--         end)

--         if not RageUI.Visible(mainMenu) then
--             mainMenu = RMenu:DeleteType(mainMenu, true)
--             openedGarage = false
--         end

--         Citizen.Wait(0)
--     end
-- end


local GradeVehicules = {}
CreateThread(function()
    local AuthorizedVehiclesBcso = Config.AuthorizedVehiclesBcso

    for key, value in pairs(AuthorizedVehiclesBcso) do
        GradeVehicules[key] = {}

        local GradeAdd = {}
        if (value['grades'] ~= nil) then
            for i=1, #value['grades'] do
                table.insert(GradeAdd, value['grades'][i])
            end
        end

        if (value['vehicules'] ~= nil) then
            GradeVehicules[key][key] = {}
            for i=1, #value['vehicules'] do
                table.insert(GradeVehicules[key][key], value['vehicules'][i])
            end
        end

        if (GradeAdd) then
            for i=1, #GradeAdd do
                local VehListGrade = Config.AuthorizedVehiclesBcso[GradeAdd[i]].vehicules

                GradeVehicules[key][GradeAdd[i]] = {}

                if (VehListGrade) then
                    for _i=1, #VehListGrade do
                        table.insert(GradeVehicules[key][GradeAdd[i]], VehListGrade[_i])
                    end
                end
            end
        end
    end
end)

function openBcsoGarage()
    local mainMenu = RageUI.CreateMenu('', 'Que voulez-vous faire ?')

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while openedGarage do
        local grade = ESX.PlayerData.job.grade_name
        local AuthorizedVehiclesBcso = GradeVehicules[grade]

        if (AuthorizedVehiclesBcso == nil) then openedGarage = false return end

        RageUI.IsVisible(mainMenu, function()

            for i=1, #Config.BcsoOrderGrades do
                for gradeName, vehicle in pairs(AuthorizedVehiclesBcso) do

                    if (Config.BcsoOrderGrades[i].grade == gradeName) then

                        RageUI.Separator("↓ "..Config.BcsoOrderGrades[i].name.." ↓")

                        for i=1, #vehicle do
                            RageUI.Button(Config.VehiclesModelNameBcso[vehicle[i].model], nil, {RightLabel = "→"}, true , {
                                onSelected = function()
                                    TriggerServerEvent('bcso:spawnVehicle', vehicle[i].model);
                                    
                                    ESX.Game.SpawnVehicle(vehicle[i].model, vector3(1863.636, 3687.703, 33.88995), 314.66, function (vehicle)
                                        local newPlate = exports['Gamemode']:GeneratePlate()
                                        SetVehicleNumberPlateText(vehicle, newPlate)
                                        exports[exports.Tree:serveurConfig().Serveur.hudScript]:SetFuel(vehicle, 100)
                                        TriggerServerEvent('babyboy:GiveDoubleKeys', 'no', newPlate)
                                        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                    end)
                
                                    RageUI.CloseAll()
                                end
                            })
                        end

                    end
                end
            end
        end)

        if not RageUI.Visible(mainMenu) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
            openedGarage = false
        end

        Citizen.Wait(0)
    end
end





function openBcsoCloathroom()
    local mainMenu = RageUI.CreateMenu('', 'Faites vos actions')

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while openClothes do
        
        local playerPed = PlayerPedId()
        local grade = ESX.PlayerData.job.grade_name
        RageUI.IsVisible(mainMenu, function()
            RageUI.Button("Reprendre ses vétements", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                    end)
                    ServiceBCSO = false
                    TriggerServerEvent('sendLogs:ServiceNo')
                    TriggerServerEvent('annonce:serviceBcso', 'fin')
                end
            })
            -- RageUI.Button("Mettre un gilet pare-balles", nil, {RightLabel = "→"}, true , {
            --     onSelected = function()
            --         setUniformBcso('bullet_wear', playerPed)
            --     end
            -- })
            RageUI.Button("Enfiler sa tenue", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    if grade == 'recruit' then
                        setUniformBcso('recruit_wear', playerPed)
                        ServiceBCSO = true
                    elseif grade == 'deputyone' then
                        setUniformBcso('officer_wear', playerPed)
                        ServiceBCSO = true
                    elseif grade == 'deputytwo' then
                        setUniformBcso('sergeant_wear', playerPed)
                        ServiceBCSO = true
                    elseif grade == 'deputytre' then
                        setUniformBcso('sergeantchief_wear', playerPed)
                        ServiceBCSO = true
                    elseif grade == 'seniordeputy' then
                        setUniformBcso('intendent_wear', playerPed)
                        ServiceBCSO = true
                    elseif grade == 'masterdeputy' then
                        setUniformBcso('lieutenant_wear', playerPed)
                        ServiceBCSO = true
                    elseif grade == 'caporal' then
                        setUniformBcso('chef_wear', playerPed)
                        ServiceBCSO = true
                    elseif grade == 'sergeant' then
                        setUniformBcso('boss_wear', playerPed)
                        ServiceBCSO = true
                    elseif grade == 'mastersergeant' then
                        setUniformBcso('boss_wear', playerPed)
                        ServiceBCSO = true
                    elseif grade == 'lieutenant' then
                        setUniformBcso('boss_wear', playerPed)
                        ServiceBCSO = true
                    elseif grade == 'captain' then
                        setUniformBcso('boss_wear', playerPed)
                        ServiceBCSO = true
                    elseif grade == 'major' then
                        setUniformBcso('boss_wear', playerPed)
                        ServiceBCSO = true
                    elseif grade == 'chefdeputy' then
                        setUniformBcso('boss_wear', playerPed)
                        ServiceBCSO = true
                    elseif grade == 'assistsheriff' then
                        setUniformBcso('boss_wear', playerPed)
                        ServiceBCSO = true
                    elseif grade == 'undersheriff' then
                        setUniformBcso('boss_wear', playerPed)
                        ServiceBCSO = true
                    elseif grade == 'boss' then
                        setUniformBcso('boss_wear', playerPed)
                        ServiceBCSO = true
                    end
                    TriggerServerEvent('sendLogs:ServiceYes')
                    TriggerServerEvent('annonce:serviceBcso', 'prise')
                end
            })
        end)
        if not RageUI.Visible(mainMenu) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
            openClothes = false
        end
        Citizen.Wait(0)
    end
end

function setUniformBcso(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			TriggerEvent('skinchanger:loadClothes', skin, Config.Jobs.Bsco.Uniforms[job].male)

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
		else
			TriggerEvent('skinchanger:loadClothes', skin, Config.Jobs.Bsco.Uniforms[job].female)

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
		end
	end)
end

function getData()
    ESX.TriggerServerCallback('bcso:getData', function(cb)
        if not cb then return end
    
        for i = 1, #cb, 1 do
            local d = cb[i]
    
            table.insert(CasierJudiciaire, {
                prenom = d.Prenom,
                nom = d.Nom,
                naissance = d.naissance,
                raison = d.raison,
                auteur = d.auteur
                -- bla bla ...
            })
        end
    end)
end

function getPlaintes()
    ESX.TriggerServerCallback('bcso:getPlaintes', function(cb)
        if not cb then return end

        for i = 1, #cb, 1 do
            local d = cb[i]

            table.insert(CheckPlaintes, {
                prenom = d.Prenom,
                nom = d.Nom,
                num = d.Num,
                prenom1 = d.Prenom1,
                nom1 = d.Nom1,
                num1 = d.Num1,
                raison = d.raison,
                auteur = d.auteur
            })
        end
    end)
end

RegisterNetEvent('bcso:addTransactions')
AddEventHandler('bcso:addTransactions', function(source)
    for k,v in pairs(tableachat) do
        table.remove(achatArmes, k)
    end
end)

RegisterNetEvent('bcso:updateinfos')
AddEventHandler('bcso:updateinfos', function(xPlayers)
    getData()
end)

RegisterNetEvent('bcso:checkplaintes')
AddEventHandler('bcso:checkplaintes', function(xPlayers)
    getPlaintes()
end)

Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    while true do
        local interval = 500
        for k,v in pairs(Config.Jobs.Bsco.RangerVehicule) do
            local coords = GetEntityCoords(PlayerPedId())
            if #(coords - v.pos) <= 10 then
                if ServiceBCSO then
                    interval = 1
                    DrawMarker(Config.Get.Marker.Type, v.pos, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                    if #(coords - v.pos) <= 3 then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ranger votre véhicule")
                        if IsControlJustPressed(0, 51) then
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                            TriggerServerEvent('babyboy:DeleteDoubleKeys', 'no', GetVehicleNumberPlateText(vehicle))
                            ESX.Game.DeleteVehicle(vehicle)
                        end
                    end
                end
            end

        end
        for k,v in pairs(Config.Jobs.Bsco.Plainte) do
            local coords = GetEntityCoords(PlayerPedId(), false)
            --local dist = Vdist(coords.x, coords.y, coords.z, v.Plainte)
            if #(coords - v.Plainte) <= 5 then
                DrawMarker(Config.Get.Marker.Type, v.Plainte, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                if #(coords - v.Plainte) <= 3 then
                   -- interval = 0
                    if IsControlJustPressed(0, 51) then
                        openPlainte = true
                        openPlaintesBCSO()
                    end
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour déposer plainte")
                   -- DrawMarker(Config.Get.Marker.Type, v.Plainte, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                end
                interval = 1
            end
        end
        for k,v in pairs(Config.Jobs.Bsco.Zones2) do
            local coords = GetEntityCoords(PlayerPedId(), false)
            if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'bcso' then
                if #(coords - v.Armurerie2) <= 3 then
                    -- if ServiceBCSO then
                        interval = 1
                        DrawMarker(Config.Get.Marker.Type, v.Armurerie2, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                        if #(coords - v.Armurerie2) <= 3 then
                            if IsControlJustPressed(0, 51) then
                                isArmurerieOpened = true
                                openArmurerieBCSO()
                            end
                            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder à l'armurerie")
                        end
                    -- end
                elseif #(coords - v.Vestiaire2) <= 3 then
                    interval = 1
                    DrawMarker(Config.Get.Marker.Type, v.Vestiaire2, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                    if #(coords - v.Vestiaire2) <= 3 then
                        if IsControlJustPressed(0, 51) then
                            openClothes = true
                            openBcsoCloathroom()
                        end
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder aux vestiaires")
                    end
                elseif #(coords - v.PosGarage2) <= 3 then
                    if ServiceBCSO then
                        interval = 1
                        DrawMarker(Config.Get.Marker.Type, v.PosGarage2, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                        if #(coords - v.PosGarage2) <= 3 then
                            if IsControlJustPressed(0, 51) then
                                openedGarage = true
                                openBcsoGarage()
                            end
                            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au garage")
                        end
                    end
                end
            end
        end
        Citizen.Wait(interval)
    end
end)

function KeyboardInputBcso(entryTitle, textEntry, inputText, maxLength)
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

function spawnObject(name)
	local plyPed = PlayerPedId()
	local coords = GetEntityCoords(plyPed, false) + (GetEntityForwardVector(plyPed) * 1.0)

    ESX.Game.SpawnObject(name, coords, function(obj)
        SetEntityHeading(obj, GetEntityPhysicsHeading(plyPed))
        PlaceObjectOnGroundProperly(obj)
    end)
end


RegisterNetEvent('bcso:renfort:setBlip')
AddEventHandler('bcso:renfort:setBlip', function(coords, raison)
	if raison == 'petite' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		ESX.ShowAdvancedNotification('Notification', exports.Tree:serveurConfig().Serveur.color..'Demande de renfort', 'Demande de renfort demandé.\nRéponse: ~g~CODE-2\nImportance: ~g~Légére.', nil, 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
		color = 2
	elseif raison == 'moyenne' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		ESX.ShowAdvancedNotification('Notification', exports.Tree:serveurConfig().Serveur.color..'Demande de renfort', 'Demande de renfort demandé.\nRéponse: ~g~CODE-3\nImportance: '..exports.Tree:serveurConfig().Serveur.color..'Importante.', nil, 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
		color = 47
	elseif raison == 'Grande' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		PlaySoundFrontend(-1, "FocusIn", "HintCamSounds", 1)
		ESX.ShowAdvancedNotification('Notification', exports.Tree:serveurConfig().Serveur.color..'Demande de renfort', 'Demande de renfort demandé.\nRéponse: ~g~CODE-99\nImportance: '..exports.Tree:serveurConfig().Serveur.color..'URGENTE !\nDANGER IMPORTANT', nil, 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "FocusOut", "HintCamSounds", 1)
		color = 1
	end
	local blipId = AddBlipForCoord(coords)
	SetBlipSprite(blipId, 161)
	SetBlipScale(blipId, 1.2)
	SetBlipColour(blipId, color)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Demande renfort')
	EndTextCommandSetBlipName(blipId)
	Wait(80 * 1000)
	RemoveBlip(blipId)
end)

RegisterNetEvent('bcso:InfoService')
AddEventHandler('bcso:InfoService', function(service, nom)
	if service == 'prise' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('Notification', exports.Tree:serveurConfig().Serveur.color..'Prise de service', 'Agent : '..exports.Tree:serveurConfig().Serveur.color..nom..'\n'..exports.Tree:serveurConfig().Serveur.color..'Code : '..exports.Tree:serveurConfig().Serveur.color..'10-8\n'..exports.Tree:serveurConfig().Serveur.color..'Information : '..exports.Tree:serveurConfig().Serveur.color..'Prise de service.', nil, 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'fin' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('Notification', exports.Tree:serveurConfig().Serveur.color..'Fin de service', 'Agent : '..exports.Tree:serveurConfig().Serveur.color..nom..'\n'..exports.Tree:serveurConfig().Serveur.color..'Code : '..exports.Tree:serveurConfig().Serveur.color..'10-10\n'..exports.Tree:serveurConfig().Serveur.color..'Information : '..exports.Tree:serveurConfig().Serveur.color..'Fin de service.', nil, 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'pause' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('Notification', exports.Tree:serveurConfig().Serveur.color..'Pause de service', 'Agent : ~g~'..nom..'\nCode : ~g~10-6\nInformation : ~g~Pause de service.', nil, 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'standby' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('Notification', exports.Tree:serveurConfig().Serveur.color..'Mise en standby', 'Agent : ~g~'..nom..'\nCode : ~g~10-12\nInformation : ~g~Standby, en attente de dispatch.', nil, 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'control' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('Notification', exports.Tree:serveurConfig().Serveur.color..'Control routier', 'Agent : ~g~'..nom..'\nCode : ~g~10-48\nInformation : ~g~Control routier en cours.', nil, 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'refus' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('Notification', exports.Tree:serveurConfig().Serveur.color..'Refus d\'obtemperer', 'Agent : ~g~'..nom..'\nCode : ~g~10-30\nInformation : ~g~Refus d\'obtemperer / Delit de fuite en cours.', nil, 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'crime' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('Notification', exports.Tree:serveurConfig().Serveur.color..'Crime en cours', 'Agent : ~g~'..nom..'\nCode : ~g~10-31\nInformation : ~g~Crime en cours / poursuite en cours.', nil, 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	end
end)

IsInMenotte = function()
	if IsHandcuffed == true then
		return true
	else
		return false
	end
end

RegisterNetEvent('bcso:actionescorter')
AddEventHandler('bcso:actionescorter', function(cop)
  IsDragged = not IsDragged
  CopPed = tonumber(cop)
end)

CreateThread(function()
    while true do
        local Interval = 1000

        if IsHandcuffed then
            Interval = 0
            if IsDragged then
                local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
                local myped = PlayerPedId()
                AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            else
                DetachEntity(PlayerPedId(), true, false)
            end
        end

        Wait(Interval)
    end
end)

-- local function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
--     AddTextEntry('FMMC_KEY_TIP1', TextEntry)
--     blockinput = true
--     DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
--     while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
--         Wait(0)
--     end 
        
--     if UpdateOnscreenKeyboard() ~= 2 then
--         local result = GetOnscreenKeyboardResult()
--         Wait(500)
--         blockinput = false
--         return result
--     else
--         Wait(500)
--         blockinput = false
--         return nil
--     end
-- end

function CoffreBcso()
    local bcsoSasie = RageUIPolice.CreateMenu("", "Blaine County Sheriff Office")
        RageUIPolice.Visible(bcsoSasie, not RageUIPolice.Visible(bcsoSasie))
            while bcsoSasie do
            Citizen.Wait(0)
            RageUIPolice.IsVisible(bcsoSasie, true, true, true, function()


                RageUIPolice.Separator("↓ "..exports.Tree:serveurConfig().Serveur.color.."Argent(s)~s~ ↓")
                if ESX.PlayerData.job.grade >= 0 then
                    RageUIPolice.ButtonWithStyle("Détruire de l'argent(s)",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local combien = KeyboardInputPolice("Combien ?", 'Indiquez un nombre', '', 10)
                            if tonumber(combien) > v.amount then
                                ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Montant invalide')
                            else
                                TriggerServerEvent('babyboy:deleteMoneyBCSO', tonumber(combien))
                                RageUI.GoBack()
                            end
                        end
                    end)
                end
                    
                RageUIPolice.Separator("↓ "..exports.Tree:serveurConfig().Serveur.color.."Objet(s)~s~ ↓")
                if ESX.PlayerData.job.grade >= 0 then
                    RageUIPolice.ButtonWithStyle("Détruire un objet(s)",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            ADeposerobjetBCSO()
                            RageUIPolice.CloseAll()
                        end
                    end)
                end

                RageUIPolice.Separator("↓ "..exports.Tree:serveurConfig().Serveur.color.."Arme(s)~s~ ↓")
                if ESX.PlayerData.job.grade >= 0 then
                    RageUIPolice.ButtonWithStyle("Détruire une arme(s)",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            PCoffreRetirerWeaponBCSO()
                            RageUIPolice.CloseAll()
                        end
                    end)
                end

                end, function()
                end)

            if not RageUIPolice.Visible(bcsoSasie) then
            bcsoSasie = RMenu:DeleteType("Coffre", true)
        end
    end
end

Citizen.CreateThread(function()
	while true do
		local Timer = 1000
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bcso' and ESX.PlayerData.job.grade >= 0 then
		local plycrdjob = GetEntityCoords(PlayerPedId(), false)
		local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, 1828.93, 3658.361, 30.31487) 
        if ServiceBCSO then
            if jobdist <= 10 then
                Timer = 0
                --DrawMarker(6, 449.91, -996.77, 30.68-0.99, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0,250,0,255 , 255)
                DrawMarker(Config.Get.Marker.Type, 1828.93, 3658.361, 30.31487, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
            end
                if jobdist <= 1.0 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre")
                        if IsControlJustPressed(1,51) then
                        CoffreBcso()
                    end   
                end
            end
        end 
        Wait(Timer)
    end
end)
---------------------------------------------------------------------------------------------------------------------------------------

itemstock = {}
function FRetirerobjetBCSO()
    local Stockpolice = RageUIPolice.CreateMenu("", "Blaine County Sheriff Office")
    ESX.TriggerServerCallback('bcso:getStockItems', function(items) 
    itemstock = items
   
    RageUIPolice.Visible(Stockpolice, not RageUIPolice.Visible(Stockpolice))
        while Stockpolice do
            Citizen.Wait(0)
                RageUIPolice.IsVisible(Stockpolice, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count > 0 then
                            RageUIPolice.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ↓", "", 2)
                                    TriggerServerEvent('bcso:getStockItem', v.name, tonumber(count))
                                    FRetirerobjetBCSO()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUIPolice.Visible(Stockpolice) then
            Stockpolice = RMenu:DeleteType("Coffre", true)
        end
    end
     end)
end

local PlayersItem = {}
function ADeposerobjetBCSO()
    local StockPlayer = RageUIPolice.CreateMenu("", "Blaine County Sheriff Office")

    ESX.TriggerServerCallback('bcso:getPlayerInventory', function(inventory)
        RageUIPolice.Visible(StockPlayer, not RageUIPolice.Visible(StockPlayer))
    while StockPlayer do
        Citizen.Wait(0)
            RageUIPolice.IsVisible(StockPlayer, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUIPolice.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ↓", '' , 8)
                                            TriggerServerEvent('bcso:putStockItems', item.name, tonumber(count))
                                            ADeposerobjetBCSO()
                                        end
                                    end)
                                end
                            else
                                RageUIPolice.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUIPolice.Visible(StockPlayer) then
                StockPlayer = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end

-- Weaponstock = {}
-- function Removeweaponbcso()
--     local StockCoffreWeapon = RageUIPolice.CreateMenu("", 'Blaine County Sheriff Office')
--     ESX.TriggerServerCallback('bcso:getArmoryWeapons', function(weapons)
--     Weaponstock = weapons
--     RageUIPolice.Visible(StockCoffreWeapon, not RageUIPolice.Visible(StockCoffreWeapon))
--         while StockCoffreWeapon do
--             Citizen.Wait(0)
--                 RageUIPolice.IsVisible(StockCoffreWeapon, true, true, true, function()
--                         for k,v in pairs(Weaponstock) do 
--                             if v.count > 0 then
--                             RageUIPolice.ButtonWithStyle(""..ESX.GetWeaponLabel(v.name), nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
--                                 if Selected then
--                                     ESX.TriggerServerCallback('bcso:removeArmoryWeapon', function()
--                                         Removeweaponbcso()
--                                     end, v.name)
--                                 end
--                             end)
--                         end
--                     end
--                 end, function()
--                 end)
--             if not RageUIPolice.Visible(StockCoffreWeapon) then
--             StockCoffreWeapon = RMenu:DeleteType("Coffre", true)
--         end
--     end
--     end)
-- end

function PCoffreRetirerWeaponBCSO()
    local StockPlayerWeapon = RageUIPolice.CreateMenu("", "Blaine County Sheriff Office")
    RageUIPolice.Visible(StockPlayerWeapon, not RageUIPolice.Visible(StockPlayerWeapon))
    while StockPlayerWeapon do
        Citizen.Wait(0)
            RageUIPolice.IsVisible(StockPlayerWeapon, true, true, true, function()
                
                local weaponList = ESX.GetWeaponList()

                for i=1, #weaponList, 1 do
                    local weaponHash = GetHashKey(weaponList[i].name);
                    local isPermanent = ESX.IsWeaponPermanent(weaponList[i].name);
                    if not isPermanent and HasPedGotWeapon(PlayerPedId(), weaponHash, false) and weaponList[i].name ~= 'WEAPON_SPECIALCARBINE' then
                        RageUIPolice.ButtonWithStyle(""..weaponList[i].label, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                            if Selected then
                                ESX.TriggerServerCallback('bcso:addArmoryWeapon', function()
                                    PCoffreRetirerWeaponBCSO()
                                end, weaponList[i].name, true)
                            end
                        end)
                    end
                end
            end, function()
            end)
            if not RageUIPolice.Visible(StockPlayerWeapon) then
            StockPlayerWeapon = RMenu:DeleteType("Coffre", true)
        end
    end
end

RegisterNetEvent('menotterlejoueurBcso')
AddEventHandler('menotterlejoueurBcso', function()
    IsHandcuffed    = not IsHandcuffed;
    local playerPed = PlayerPedId()
  
    Citizen.CreateThread(function()
        if IsHandcuffed then
            RequestAnimDict('mp_arresting')
            while not HasAnimDictLoaded('mp_arresting') do
                Citizen.Wait(100)
            end
  
            TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
            DisableControlAction(2, 37, true)
            SetEnableHandcuffs(playerPed, true)
            SetPedCanPlayGestureAnims(playerPed, false)
            FreezeEntityPosition(playerPed,  true)
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 257, true) -- Attack 2
            DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 263, true) -- Melee Attack 1
            DisableControlAction(0, 37, true) -- Select Weapon
            DisableControlAction(0, 47, true)  -- Disable weapon
        else
            ClearPedSecondaryTask(playerPed)
            SetEnableHandcuffs(playerPed, false)
            SetPedCanPlayGestureAnims(playerPed,  true)
            FreezeEntityPosition(playerPed, false)
        end
    end)
end)


RegisterNetEvent('tF_bcsojob:putInVehicle')
AddEventHandler('tF_bcsojob:putInVehicle', function()
	-- if isHandcuffed then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if IsAnyVehicleNearPoint(coords, 5.0) then
			local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

			if DoesEntityExist(vehicle) then
				local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

				for i=maxSeats - 1, 0, -1 do
					if IsVehicleSeatFree(vehicle, i) then
						freeSeat = i
						break
					end
				end

				--if freeSeat then
					TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				--	dragStatus.isDragged = false
				--end
			end
		end
	-- else
    --     ESX.ShowNotification("Le joueur n'est pas menotter")
    -- end
end)

RegisterNetEvent('tF_bcsojob:OutVehicle')
AddEventHandler('tF_bcsojob:OutVehicle', function()
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		TaskLeaveVehicle(playerPed, vehicle, 64)
	end
end)