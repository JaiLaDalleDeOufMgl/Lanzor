local Items = {}
local Armes = {}
local ArgentSale = {}
local customindex = 1
local customindex2 = 2

RegisterNetEvent("DEN:AddedInVehicle")
AddEventHandler("DEN:AddedInVehicle", function(id)
    local vehicle = NetworkGetEntityFromNetworkId(id)
    if IsVehicleSeatFree(vehicle, 1) then
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, 1)
    elseif IsVehicleSeatFree(vehicle, 2) then
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, 2)
    elseif IsVehicleSeatFree(vehicle, 3) then
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, 3)
    elseif IsVehicleSeatFree(vehicle, 4) then
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, 4)
    elseif IsVehicleSeatFree(vehicle, 5) then
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, 5)
    end
end)


function getPlayerInv(player)
    ESX.TriggerServerCallback('getOtherPlayerDataFBI', function(data)
        for i=1, #data.accounts, 1 do
            if data.accounts[i].name == 'dirtycash' and data.accounts[i].money > 0 then
                table.insert(ArgentSale, {
                    label    = ESX.Math.Round(data.accounts[i].money),
                    value    = 'dirtycash',
                    itemType = 'item_account',
                    amount   = data.accounts[i].money
                })
    
            end
        end
    
        for i=1, #data.inventory, 1 do
            if data.inventory[i].count > 0 then
                table.insert(Items, {
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
                table.insert(Armes, {
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


local objectsFIB = {
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


RegisterCommand('menufbif6', function()
    if ( ESX.PlayerData.job.name ~= 'fib') then
        return
    end

    local main = RageUI.CreateMenu("", "Menu Interaction")
    local civils = RageUI.CreateSubMenu(main, "", "Menu Interaction")
    local vehicules = RageUI.CreateSubMenu(main, "", "Menu Interaction")
    local fbi = RageUI.CreateSubMenu(main, "", "Menu Interaction")
    local fouiller = RageUI.CreateSubMenu(civils, "", "Menu Interaction")
    local props = RageUI.CreateSubMenu(main, "", "Intéractions : Objets")
    local propsList = RageUI.CreateSubMenu(props, "", "Intéractions : Gérer")
    RageUI.Visible(main, not RageUI.Visible(main))

    while main do
        Wait(0)
        RageUI.IsVisible(main, function()
            RageUI.Button("Intéraction Citoyens", nil, {RightLabel = "→"}, true, {}, civils)
            RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Stoppez les PNJ", "Activer/Désactiver les pnj dans la zone de 100 m", {RightLabel = "→"}, not stopPNJCooldownFIB, {
                onSelected = function()
                    stopPNJCooldownFIB = true
                    Citizen.SetTimeout(15 * 60 * 10, function()
                        stopPNJCooldownFIB = false
                    end)
                    ExecuteCommand("arretpnj")
                    RageUI.CloseAll()
                end
            })
            RageUI.Button("Intéraction Véhicules", nil, {RightLabel = "→"}, true, {}, vehicules)
            RageUI.Button("Demande de renfort", nil, {RightLabel = "→"}, true, {}, fbi)
            RageUI.Button("Objets", nil, { RightLabel = "→" }, true, {
            }, props)


            RageUI.Button("Ranger/Sortir son bouclier", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    ExecuteCommand("shield")
                end
            })
        end)

        RageUI.IsVisible(civils, function()
            local playerCoords = GetEntityCoords(PlayerPedId())
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
            if closestPlayer ~= -1 and closestDistance <= 3.0 then
                RageUI.Button("Fouiller", nil, {}, true, {
                    onActive = function()
                        plyMarker(closestPlayer)
                    end;
                    onSelected = function()
                        Items = {}
                        Armes = {}
                        ArgentSale = {}
                        
                        local getPlayerSearch = GetPlayerPed(closestPlayer)
                        if not IsEntityPlayingAnim(getPlayerSearch, 'random@mugging3', 'handsup_standing_base', 3) then
                            ESX.ShowNotification("La personne en face lève pas les mains en l'air")
                        else
                            TriggerServerEvent("Gamemode:Inventory:OpenSecondInventory", "fplayerl", GetPlayerServerId(closestPlayer))

                            CreateThread(function()
                                local bool = true
                                while bool do
                                    local getPlayerSearch = GetPlayerPed(closestPlayer)
                                    
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
                    end
                })
                RageUI.Button("Prendre la carte d\'identité", nil, {}, true, {
                    onActive = function()
                        plyMarker(closestPlayer)
                    end;
                    onSelected = function()
                        RageUI.CloseAll()
                        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(closestPlayer), GetPlayerServerId(PlayerId()))
                    end
                })
                RageUI.Button("Menotter/Démenoter l\'individu", nil, {}, true, {
                    onActive = function()
                        plyMarker(closestPlayer)
                    end;
                    onSelected = function()
                        local dict, anim = 'mp_arrest_paired', 'cop_p2_back_left'
                        RequestAnimDict(dict)
                        while not HasAnimDictLoaded(dict) do
                            Citizen.Wait(100)
                        end
                        TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        Wait(5000)
                        TriggerServerEvent('Space:Menotter', GetPlayerServerId(closestPlayer))
                        ClearPedTasks(PlayerPedId())
                    end
                })
                RageUI.Button("Escorter l\'individu", nil, {}, true, {
                    onActive = function()
                        plyMarker(closestPlayer)
                    end;
                    onSelected = function()
                        TriggerServerEvent('Space:Escorter', GetPlayerServerId(closestPlayer))
                    end
                })
                RageUI.Button("Mettre dans le véhicule", nil, {}, true, {
                    onActive = function()
                        plyMarker(closestPlayer)
                    end;
                    onSelected = function()
                        if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'mp_arresting', 'idle', 3) then
                            TriggerServerEvent('DEN:AddeIntoVehicle', GetPlayerServerId(closestPlayer),NetworkGetNetworkIdFromEntity(veh))
                        else
                            ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."La personne en face n'est pas menotté")
                        end
                        --TriggerServerEvent('DEN:AddeIntoVehicle', GetPlayerServerId(closestPlayer),NetworkGetNetworkIdFromEntity(veh))
                    end
                })
                RageUI.Button("Sortir du véhicule", nil, {}, true, {
                    onActive = function()
                        plyMarker(closestPlayer)
                    end;
                    onSelected = function()
                        TriggerServerEvent('DEN:OutVehicle', GetPlayerServerId(closestPlayer))
                    end
                })
            else
                RageUI.Separator()
                RageUI.Separator(exports.Tree:serveurConfig().Serveur.color.."Aucun individu(s) à proximitée")
                RageUI.Separator()
            end
        end)

        RageUI.IsVisible(props, function()
            RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Gérer", nil, { RightLabel = "→" }, true, {
            }, propsList)
            RageUI.Line()
            for k,v in pairs(objectsFIB) do 
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

        RageUI.IsVisible(vehicules, function()
            RageUI.Button("Information véhicule", nil, {}, true, {
                onSelected = function()
                    local numplaque = CustomString('', '', 100)
                    local length = string.len(numplaque)
                    if not numplaque or length < 2 or length > 8 then
                        ESX.ShowNotification("Ce n'est "..exports.Tree:serveurConfig().Serveur.color.."pas~s~ un numéro enregistrement dans les fichier de "..exports.Tree:serveurConfig().Serveur.color.."fbi")
                    else
                        Rechercherplaquevoiture(numplaque)
                        RageUI.CloseAll()
                    end
                end
            })
            RageUI.Button("Crocheter le véhicule", nil, {}, true , {
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
                        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Aucun véhicule à proximité")
                    end
                end
            })
        end)

        RageUI.IsVisible(fbi, function()
            RageUI.Button("Petite demande", nil, {}, true , {
                onSelected = function()
                    local playerPed = PlayerPedId()
                    local coords  = GetEntityCoords(playerPed)
                    TriggerServerEvent('demande:Fbi', coords, 'petite')
                end
            })
            RageUI.Button("Moyenne demande", nil, {}, true , {
                onSelected = function()
                    local playerPed = PlayerPedId()
                    local coords  = GetEntityCoords(playerPed)
                    TriggerServerEvent('demande:Fbi', coords, 'moyenne')
                end
            })
            RageUI.Button("Grande demande", nil, {}, true , {
                onSelected = function()
                    local playerPed = PlayerPedId()
                    local coords  = GetEntityCoords(playerPed)
                    TriggerServerEvent('demande:Fbi', coords, 'Grande')
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
                RageUI.GoBack()
                return
            end
    
            RageUI.Separator("Vous Fouillez : " .. GetPlayerName(closestPlayer))

            RageUI.Separator("↓ "..exports.Tree:serveurConfig().Serveur.color.."Argent non déclaré ~s~↓")

            for k,v in pairs(ArgentSale) do
                RageUI.Button("Argent non déclaré :", nil, {RightLabel = "~g~"..v.label.."$"}, true , {
                    onSelected = function()
                        local combien = CustomString("Combien ?", 'Indiquez un nombre', 10)
                        if tonumber(combien) > v.amount then
                            ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Montant invalide')
                        else
                            TriggerServerEvent('confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                            RageUI.GoBack()
                        end
                    end
                })
            end

            RageUI.Separator("↓ "..exports.Tree:serveurConfig().Serveur.color.."Items du joueur ~s~↓")

            for k,v in pairs(Items) do
                RageUI.Button("Nom: "..v.label, nil, {RightLabel = "~g~"..v.right.." exemplaires"}, true , {
                    onSelected = function()
                        local combien = CustomString("Combien ", 'Indiquez un nombre', 4)
                        if tonumber(combien) > v.amount then
                            ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Montant invalide')
                        else
                            TriggerServerEvent('FBI:ConfiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                            RageUI.GoBack()
                        end
                    end
                })
            end
            
            RageUI.Separator("↓ "..exports.Tree:serveurConfig().Serveur.color.."Armes du joueur ~s~↓")

            for k,v in pairs(Armes) do
                local isPermanent = ESX.IsWeaponPermanent(v.value);
                if (not isPermanent) then
                    RageUI.Button("Arme: "..v.label, nil, {}, true , {
                        onSelected = function()
                            local combien = CustomString("Nombre de munitions", 'Indiquez un nombre', 4)
                            if tonumber(combien) > 1 then
                                ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Montant invalide')
                            else
                                TriggerServerEvent('confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                                RageUI.GoBack()
                            end
                        end
                    })
                end
            end
        end)

        
    end
    fouiller.Closed = function()
        Items = {}
        Armes = {}
        ArgentSale = {}
    end
    if not RageUI.Visible(main) and
        not RageUI.Visible(civils) and
        not RageUI.Visible(vehicules) and
        not RageUI.Visible(fbi) and
        not RageUI.Visible(fouiller)
        and not RageUI.Visible(props) and not RageUI.Visible(propsList)
    then
        main = RMenu:DeleteType('main', true)
        civils = RMenu:DeleteType('civils', true)
        vehicules = RMenu:DeleteType('civils', true)
        fbi = RMenu:DeleteType('civils', true)
        fouiller = RMenu:DeleteType('fouiller', true)
        props = RMenu:DeleteType('props', true)
        propsList = RMenu:DeleteType('propsList', true)
    end
end)

function Rechercherplaquevoiture(plaquerechercher)
    local PlaqueMenu = RageUI.CreateMenu("", "Informations")
    ESX.TriggerServerCallback('FBI:getVehicleInfos', function(retrivedInfo)
        RageUI.Visible(PlaqueMenu, not RageUI.Visible(PlaqueMenu))
            while PlaqueMenu do
                Citizen.Wait(0)
                RageUI.IsVisible(PlaqueMenu,function()
                    RageUI.Button("Numéro de plaque : ", nil, {RightLabel = retrivedInfo.plate}, true, {})
                    if not retrivedInfo.owner then
                        RageUI.Button("Propriétaire : ", nil, {RightLabel = "Inconnu"}, true, {})
                    else
                        RageUI.Button("Propriétaire : ", nil, {RightLabel = retrivedInfo.owner}, true, {})

                        local hashvoiture = retrivedInfo.vehicle.model
                        local nomvoituremodele = GetDisplayNameFromVehicleModel(hashvoiture)
                        local nomvoituretexte  = GetLabelText(nomvoituremodele)

                        RageUI.Button("Modèle du véhicule : ", nil, {RightLabel = nomvoituretexte}, true, {})
                    end
                end, function()
                end)
                if not RageUI.Visible(PlaqueMenu) then
                PlaqueMenu = RMenu:DeleteType("plaque d'immatriculation", true)
            end
        end
    end, plaquerechercher)
end

RegisterKeyMapping('menufbif6', 'Menu F6 FBI', 'keyboard', 'F6')

RegisterNetEvent('FIB:renfortsetBlip')
AddEventHandler('FIB:renfortsetBlip', function(coords, raison)
	if raison == 'petite' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		ESX.ShowAdvancedNotification('Notification', exports.Tree:serveurConfig().Serveur.color..'Demande de renfort', 'Demande de renfort demandé.\nRéponse: ~g~CODE-2\nImportance: ~g~Légère.', "CHAR_CALL911", 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
		color = 2
	elseif raison == 'moyenne' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		ESX.ShowAdvancedNotification('Notification', exports.Tree:serveurConfig().Serveur.color..'Demande de renfort', 'Demande de renfort demandé.\nRéponse: ~g~CODE-3\nImportance: '..exports.Tree:serveurConfig().Serveur.color..'Importante.', "CHAR_CALL911", 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
		color = 47
	elseif raison == 'Grande' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
		PlaySoundFrontend(-1, "FocusIn", "HintCamSounds", 1)
		ESX.ShowAdvancedNotification('Notification', exports.Tree:serveurConfig().Serveur.color..'Demande de renfort', 'Demande de renfort demandé.\nRéponse: ~g~CODE-99\nImportance: '..exports.Tree:serveurConfig().Serveur.color..'URGENTE !\nDANGER IMPORTANT', "CHAR_CALL911", 8)
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
    SetTimeout(80 * 1000, function()
        RemoveBlip(blipId)
    end)
	
	
end)


function MenuVeheculesFBI()
    local main = RageUI.CreateMenu("", "Menu Interaction")
    RageUI.Visible(main, not RageUI.Visible(main))
    while main do
        Wait(0)
        local plyped = PlayerPedId()
        local playcoords = GetEntityCoords(plyped)
        local menucoords = ZonesListe["MenuVeheculesFBI"].Position
        local dif = #(playcoords - menucoords )
        if dif > 7 then 
            RageUI.CloseAll()
        end
        RageUI.IsVisible(main, function()
            for k, v in pairs(FBI.Vehicules) do
                RageUI.Button(v.label, nil, {}, ESX.PlayerData.job.grade >= v.minimum_grade, {
                    onSelected = function()
                        ESX.Game.SpawnVehicle(v.name, vector3(2549.459, -372.1366, 92.9934), 350.28515625, function (vehicle)
                            local newPlate = exports['Gamemode']:GeneratePlate()
                            SetVehicleNumberPlateText(vehicle, newPlate)
                            exports[exports.Tree:serveurConfig().Serveur.hudScript]:SetFuel(vehicle, 100)
                            TriggerServerEvent('babyboy:GiveDoubleKeys', 'no', newPlate)
                            TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                        end)
                        TriggerServerEvent('Space:spawnVehicle');
                        RageUI.CloseAll()
                    end
                })
            end
        end)
        if not RageUI.Visible(main) then
            main = RMenu:DeleteType('main', true)
        end
    end
end


function Menucustom()
    local main = RageUI.CreateMenu("", "Menu Interaction")
    RageUI.Visible(main, not RageUI.Visible(main))
    while main do
        Wait(0)
        local plyped = PlayerPedId()
        local playcoords = GetEntityCoords(plyped)
        local menucoords = ZonesListe["Menucustom"].Position
        local dif = #(playcoords - menucoords )
        local vh = GetVehiclePedIsIn(plyped, false)
        local modelName = GetEntityModel(vh)
        if vh ~= 0 then
            if FBI.wlcustom[modelName] then
                if dif > 9 then 
                    RageUI.CloseAll()
                end
                
                RageUI.IsVisible(main, function()
                    RageUI.List("Couleur", {"Noir","Rouge","Blanc","Bleu"}, customindex, nil, {}, true,{
                        onListChange = function(index)
                            customindex = index
                            if customindex == 1 then
                                vehcustom(vh,1)
                            elseif customindex == 2 then
                                vehcustom(vh,27)
                            elseif customindex == 3 then
                                vehcustom(vh,111)
                            elseif customindex == 4 then
                                vehcustom(vh,62)
                            end
                        end
                    })
                    RageUI.List("Vitre teintée", {"Niveau 1","Niveau 2","Niveau 3","Niveau 4","Niveau 5","Niveau 6"}, customindex2, nil, {}, true,{
                        onListChange = function(index)
                            customindex2 = index
                            if customindex2 == 1 then
                                vehcustom(vh,nil,4)
                            elseif customindex2 == 2 then
                                vehcustom(vh,nil,0)
                            elseif customindex2 == 3 then
                                vehcustom(vh,nil,5)
                            elseif customindex2 == 4 then
                                vehcustom(vh,nil,3)
                            elseif customindex2 == 5 then
                                vehcustom(vh,nil,2)
                            elseif customindex2 == 6 then
                                vehcustom(vh,nil,1)
                            end
                        end
                    })
                end)
                
            else
                ESX.ShowNotification("Votre véhicule n'est pas autorise a etre modifier au FIB")
                RageUI.CloseAll()
            end
            if not RageUI.Visible(main) then
                main = RMenu:DeleteType('main', true)
            end
        else
            ESX.ShowNotification("vous n'êtes dans aucun véhicule")
            RageUI.CloseAll()
            return
        end
    end
end

function vehcustom(vehicle,colors,windowcolor)
    ESX.Game.SetVehicleProperties(vehicle, {
        color1 = colors,
        color2 = colors,
        windowTint = windowcolor
    })
end

function MenuWeaponsFBI()
    local mainMenu = RageUI.CreateMenu('', 'Faites vos actions')
    local paiement = RageUI.CreateSubMenu(mainMenu, "", "Faites vos actions")
    local ListeWeapon = RageUI.CreateSubMenu(mainMenu, "", "Faites vos actions")
    local ListeEquipement = RageUI.CreateSubMenu(mainMenu, "", "Faites vos actions")
    local achatArmes = {}

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))
    
    while mainMenu do
        Wait(0)
        local plyped = PlayerPedId()
        local playcoords = GetEntityCoords(plyped)
        local menucoords = ZonesListe["MenuWeaponsFBI"].Position
        local dif = #(playcoords - menucoords )
        if dif > 7 then 
            RageUI.CloseAll()
        end

        RageUI.IsVisible(mainMenu, function()
            RageUI.Button("Acheter une armes", nil, {RightLabel = "→"}, true , {
            }, ListeWeapon)

            RageUI.Button("Acheter de l'équipement", nil, {RightLabel = "→"}, true , {
            }, ListeEquipement)

        end)

        RageUI.IsVisible(paiement, function()
            for k,v in pairs(achatArmes) do
                RageUI.Button("Arme: 1 "..v.label, nil, {}, true , {})
                RageUI.Button("Récupérer votre armement", nil, {}, true , {
                    onSelected = function()
                        TriggerServerEvent('buyWeaponForFIB', v.hash)
                        table.remove(achatArmes, k)
                        RageUI.CloseAll()
                    end
                })
            end
        end)

        RageUI.IsVisible(ListeWeapon, function()
            RageUI.Button("Tazer", nil, {}, true , {
                onSelected = function()
                    table.insert(achatArmes, {
                        label = "Tazer",
                        hash = 'weapon_stungun',
                        prix = 0,
                    })
                end
            }, paiement)
            RageUI.Button("Lampe torche", nil, {}, true , {
                onSelected = function()
                    table.insert(achatArmes, {
                        label = "Lampe torche",
                        hash = 'weapon_flashlight',
                        prix = 0,
                    })
                end
            }, paiement)
            RageUI.Button("Matraque", nil, {}, true , {
                onSelected = function()
                    table.insert(achatArmes, {
                        label = "Matraque",
                        hash = 'weapon_nightstick',
                        prix = 0,
                    })
                end
            }, paiement)
            RageUI.Button("Pistolet de combat", nil, {}, true , {
                onSelected = function()
                    table.insert(achatArmes, {
                        label = "Pistolet de combat",
                        hash = 'weapon_combatpistol',
                        prix = 0,
                    })
                end
            }, paiement)

            if ESX.PlayerData.job.grade >= 6 then
                RageUI.Button("Carabine d'assault", nil, {}, true , {
                    onSelected = function()
                        table.insert(achatArmes, {
                            label = "Carabine d'assault",
                            hash = 'weapon_carbinerifle',
                            prix = 0,
                        })
                    end
                }, paiement)

                RageUI.Button("Pompe FIB", nil, {}, true , {
                    onSelected = function()
                        table.insert(achatArmes, {
                            label = "Pompe FIB",
                            hash = 'weapon_pumpshotgun',
                            prix = 0,
                        })
                    end
                }, paiement)
            end

            -- if ESX.PlayerData.job.grade >= 6 then
            --     RageUI.Button("Grenade Flash", nil, {RightLabel = "~g~500 $"}, true , {
            --         onSelected = function()
            --             table.insert(achatArmes, {
            --                 label = "Grenade Flash",
            --                 hash = 'weapon_flashbang',
            --                 prix = 500,
            --             })
            --         end
            --     }, paiement)
            -- end

        end)

        RageUI.IsVisible(ListeEquipement, function()

            RageUI.Button("Prendre un gilet par balle", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    TriggerServerEvent("addGilet:fib")
                end
            })

            RageUI.Button("Prendre un pack de chargeur", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    TriggerServerEvent("addChargeur:fib")
                end
            })

            RageUI.Button("Prendre une paire de Jummelles", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    TriggerServerEvent("addJumelles:fib")
                end
            })

        end)

        if not RageUI.Visible(mainMenu) and not RageUI.Visible(paiement) and not RageUI.Visible(ListeWeapon) and not RageUI.Visible(ListeEquipement) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
            table.remove(achatArmes, k)
        end
    end
end

local lockKeys = false
function SpawnObj(obj)
    local playerPed = PlayerPedId()
	local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * 1.0)
    local Ent = nil

    SpawnObject(obj, objectCoords, function(obj)
        SetEntityCoords(obj, objectCoords, 0.0, 0.0, 0.0, 0)
        SetEntityHeading(obj, GetEntityHeading(playerPed))
		PlaceObjectOnGroundProperly(obj)
        Ent = obj
        Wait(1)
    end) 
    Wait(1)
    while Ent == nil do Wait(1) end
    SetEntityHeading(Ent, GetEntityHeading(playerPed))
    PlaceObjectOnGroundProperly(Ent)
    local placed = false
    lockKeys = true
    CreateThread(function()
        while lockKeys do
            Wait(1)
            DisableControlAction(0, 22, true) 
            DisableControlAction(0, 21, true)
        end
    end)
    while not placed do
        Citizen.Wait(1)
        local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
        local objectCoords = (coords + forward * 3.0)
        SetEntityCoords(Ent, objectCoords, 0.0, 0.0, 0.0, 0)
        SetEntityHeading(Ent, GetEntityHeading(playerPed))
        PlaceObjectOnGroundProperly(Ent)
        SetEntityAlpha(Ent, 170, 170)
        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour placer l'objet")
        if IsControlJustReleased(1, 38) then
			placed = true
        end
    end
    lockKeys = false
    FreezeEntityPosition(Ent, true)
    SetEntityInvincible(Ent, true)
    ResetEntityAlpha(Ent)
    local NetId = NetworkGetNetworkIdFromEntity(Ent)
    table.insert(object, NetId)
end

object = {}


function RemoveObj(id, k)
    Citizen.CreateThread(function()
        SetNetworkIdCanMigrate(id, true)
        local entity = NetworkGetEntityFromNetworkId(id)
        NetworkRequestControlOfEntity(entity)
        local test = 0
        while test > 100 and not NetworkHasControlOfEntity(entity) do
            NetworkRequestControlOfEntity(entity)
            Wait(1)
            test = test + 1
        end
        SetEntityAsNoLongerNeeded(entity)

        local test = 0
        while test < 100 and DoesEntityExist(entity) do 
            SetEntityAsNoLongerNeeded(entity)
            DeleteEntity(entity)
            DeleteObject(entity)
            if not DoesEntityExist(entity) then 
                table.remove(object, k)
            end
            SetEntityCoords(entity, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0)
            Wait(1)
            test = test + 1
        end
    end)
end

function GoodName(hash)
    if hash == GetHashKey("prop_roadcone02a") then
        return "Cone"
    elseif hash == GetHashKey("prop_barrier_work05") then
        return "Barrière"
    else
        return hash
    end

end

Utils = {}

Utils.RequestAndWaitModel = function(modelName)
	if modelName and IsModelInCdimage(modelName) and not HasModelLoaded(modelName) then
		RequestModel(modelName)
		while not HasModelLoaded(modelName) do Wait(100) end
	end
end



RegisterNetEvent('Space:Menotter')
AddEventHandler('Space:Menotter', function()
    IsHandcuffed = not IsHandcuffed;
    local playerPed = PlayerPedId()
  
    CreateThread(function()
        if (IsHandcuffed) then
            RequestAnimDict('mp_arresting')
            while not HasAnimDictLoaded('mp_arresting') do
                Wait(100)
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

RegisterNetEvent('Space:Escorter')
AddEventHandler('Space:Escorter', function(cop)
    IsDragged = not IsDragged
    CopPed = tonumber(cop)

    CreateThread(function()
        while true do
            if (IsHandcuffed) then
                if IsDragged then
                    local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
                    local myped = PlayerPedId()
                    AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                else
                    DetachEntity(PlayerPedId(), true, false)
                end
            end
            Wait(0)
        end
    end)
end)

function SpawnObject(model, coords, cb)
	local model = GetHashKey(model)

	Citizen.CreateThread(function()
		Utils.RequestAndWaitModel(model)
        Wait(1)
		local obj = CreateObject(model, coords.x, coords.y, coords.z, true, false, true)

		if cb then
			cb(obj)
		end
	end)
end

function plyMarker(player)
    local ped = GetPlayerPed(player)
    local pos = GetEntityCoords(ped)
	if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), pos, true) < 2.5 then
		DrawMarker(22, pos.x, pos.y, pos.z+1.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 203, 54, 148, 255, 0, 2, 1, nil, nil, 0)
	end
end


function DrawText3D(coords, text, size, font)
	local camCoords = GetGameplayCamCoords()
	local distance = #(coords - camCoords)

	if not size then size = 1 end
	if not font then font = 0 end

	local scale = (size / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	scale = scale * fov

	SetTextScale(0.0 * scale, 0.55 * scale)
	SetTextFont(font)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	SetDrawOrigin(coords, 0)
	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.0, 0.0)
	ClearDrawOrigin()
end

function CustomString()
    local txt = nil
    AddTextEntry("CREATOR_TXT", "Entrez votre texte.")
    DisplayOnscreenKeyboard(1, "CREATOR_TXT", '', "", '', '', '', 15)

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        txt = GetOnscreenKeyboardResult()
        Citizen.Wait(1)
    else
        Citizen.Wait(1)
    end
    return txt
end