

local AllRapportsDesAmbulanciers = {}
local ServiceAmbulance = false
local letypeasendendb
local thetype
local theWeaponWhoKilled
openambulanceF6 = false
local openGestion = false
local openPharma = false
local openClothes = false
openSpawnerAmbulance = false
local appelsdesmorts = {}
local countofappels = 0

local objectsEMS = {
    [0] = {
        model = "prop_roadcone02a",
        name = "Cônes"
    },
    [1] = {
        model = "prop_barrier_work06a",
        name = "Barrière"
    },
}

RegisterNetEvent('ambulance:updateCall')
AddEventHandler('ambulance:updateCall', function(Newappelsdesmorts)
    appelsdesmorts = Newappelsdesmorts
    -- print(json.encode(appelsdesmorts))
end)

AddEventHandler("esx:playerLoaded", function()
    ESX.TriggerServerCallback('GamemodeRP:GetDeath', function(theisDead)
        isDead = theisDead
    end)
end)

function GetDeath()
    return isDead
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        if isDead == 1 then
            Wait(3000)
            ESX.ShowNotification("Vous avez quitter le serveur en étant mort ! Vous avez été mis dans le coma de force !")
            SetEntityHealth(PlayerPedId(), 0)
            break
        end
    end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

CreateThread(function()
    while true do
        local interval = 1000
        local plyPed = PlayerPedId()

        local coords = GetEntityCoords(plyPed)

        if type(ESX.PlayerData) == "table" and type(ESX.PlayerData.job) == "table" and type(ESX.PlayerData.job.name) == "string" and ESX.PlayerData.job.name == 'ambulance' then
            for k,v in pairs(Config.Jobs.Ambulance.Pharma) do
                if #(coords - v.pharma) <= 10 then
                    DrawMarker(Config.Get.Marker.Type, v.pharma, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                    interval = 0
                    if #(coords - v.pharma) <= 3 then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu")
                        if IsControlJustPressed(0, 51) then
                            openPharma = true
                            OpenAmbulancePharmacie()
                        end
                    end  
                end
            end

            for k,v in pairs(Config.Jobs.Ambulance.Clothes) do
                if #(coords - v.clothes) <= 10 then
                    DrawMarker(Config.Get.Marker.Type, v.clothes, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                    interval = 0
                    if #(coords - v.clothes) <= 3 then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu")
                        if IsControlJustPressed(0, 51) then
                            CreateThread(function()
                                openClothes = true
                                OpenAmbulanceClothesMenu()
                            end)
                        end
                    end
                end
            end
            for k,v in pairs(Config.Jobs.Ambulance.Vehicle) do
                if #(coords - v.vehicle) <= 10 then
                    DrawMarker(Config.Get.Marker.Type, v.vehicle, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                    interval = 0
                    if #(coords - v.vehicle) <= 3 then
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu")
                        if IsControlJustPressed(0, 51) then
                            openSpawnerAmbulance = true
                            OpenAmbulanceVehicleSpawnerMenu()
                        end
                    end
                end
            end

            for k,v in pairs(Config.Jobs.Ambulance.DeleteVeh) do
                local veh = GetVehiclePedIsIn(PlayerPedId())
                if #(coords - v.deleteveh) <= 10 then
                    DrawMarker(Config.Get.Marker.Type, v.deleteveh, 0, 0, 0, Config.Get.Marker.Rotation, nil, nil, Config.Get.Marker.Size[1], Config.Get.Marker.Size[2], Config.Get.Marker.Size[3], Config.Get.Marker.Color[1], Config.Get.Marker.Color[2], Config.Get.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)
                    interval = 0
                    if #(coords - v.deleteveh) <= 3 then
                        if DoesEntityExist(veh) then
                            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ranger votre véhicule")
                            if IsControlJustPressed(0, 51) then
                                ESX.Game.DeleteVehicle(veh)
                            end
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

local doctorCoords = {x = -1832.7404, y = -383.1150, z = 48.3973, h = 47.5005}
local ped = 0

Citizen.CreateThread(function()
	local hash = GetHashKey("s_m_m_doctor_01")
	while not HasModelLoaded(hash) do
		RequestModel(hash)
		Wait(20)
	end
	ped = CreatePed("PED_TYPE_CIVFEMALE", "s_m_m_doctor_01", doctorCoords.x, doctorCoords.y, doctorCoords.z, doctorCoords.h, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	FreezeEntityPosition(ped, true)
end)


Citizen.CreateThread(function()
local wait = 2000
	local can = true
	while true do
		Citizen.Wait(wait)
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),GetEntityCoords(ped)) < 2 then
            wait = 0
			ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour parler au docteur.")
			if (IsControlJustPressed(1,51)) and (GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),GetEntityCoords(ped))) then 
				if can then
					TriggerEvent("ambulance:revive", GetPlayerServerId(PlayerId()))
                    TriggerServerEvent('ambulance:setDeathStatus', 0)
                    TriggerServerEvent('ambulance:payNPC')
					can = false
				else
					ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Vous devez attendre quelques minutes pour être à nouveau soigné !")
					Citizen.Wait(120000)
					can = true
				end
			end
        else
            wait = 2000
		end
	end
end)

local TableWeapon = {
    ["WEAPON_DAGGER"] = GetHashKey("WEAPON_DAGGER"),
    ["WEAPON_BAT"] = GetHashKey("WEAPON_BAT"),
    ["WEAPON_BOTTLE"] = GetHashKey("WEAPON_BOTTLE"),
    ["WEAPON_CROWBAR"] = GetHashKey("WEAPON_CROWBAR"),
    ["WEAPON_UNARMED"] = GetHashKey("WEAPON_UNARMED"),
    ["WEAPON_FLASHLIGHT"] = GetHashKey("WEAPON_FLASHLIGHT"),
    ["WEAPON_GOLFCLUB"] = GetHashKey("WEAPON_GOLFCLUB"),
    ["WEAPON_HAMMER"] = GetHashKey("WEAPON_HAMMER"),
    ["WEAPON_HATCHET"] = GetHashKey("WEAPON_HATCHET"),
    ["WEAPON_KNUCKLE"] = GetHashKey("WEAPON_KNUCKLE"),
    ["WEAPON_KNIFE"] = GetHashKey("WEAPON_KNIFE"),
    ["WEAPON_MACHETE"] = GetHashKey("WEAPON_MACHETE"),
    ["WEAPON_SWITCHBLADE"] = GetHashKey("WEAPON_SWITCHBLADE"),
    ["WEAPON_NIGHTSTICK"] = GetHashKey("WEAPON_NIGHTSTICK"),
    ["WEAPON_WRENCH"] = GetHashKey("WEAPON_WRENCH"),
    ["WEAPON_BATTLEAXE"] = GetHashKey("WEAPON_BATTLEAXE"),
    ["WEAPON_POOLCUE"] = GetHashKey("WEAPON_POOLCUE"),
    ["WEAPON_STONE_HATCHET"] = GetHashKey("WEAPON_STONE_HATCHET"),
    ["WEAPON_PISTOL"] = GetHashKey("WEAPON_PISTOL"),
    ["WEAPON_PISTOL_MK2"] = GetHashKey("WEAPON_PISTOL_MK2"),
    ["WEAPON_COMBATPISTOL"] = GetHashKey("WEAPON_COMBATPISTOL"),
    ["WEAPON_APPISTOL"] = GetHashKey("WEAPON_APPISTOL"),
    ["WEAPON_STUNGUN"] = GetHashKey("WEAPON_STUNGUN"),
    ["WEAPON_PISTOL50"] = GetHashKey("WEAPON_PISTOL50"),
    ["WEAPON_SNSPISTOL"] = GetHashKey("WEAPON_SNSPISTOL"),
    ["WEAPON_SNSPISTOL_MK2"] = GetHashKey("WEAPON_SNSPISTOL_MK2"),
    ["WEAPON_HEAVYPISTOL"] = GetHashKey("WEAPON_HEAVYPISTOL"),
    ["WEAPON_VINTAGEPISTOL"] = GetHashKey("WEAPON_VINTAGEPISTOL"),
    ["WEAPON_FLAREGUN"] = GetHashKey("WEAPON_FLAREGUN"),
    ["WEAPON_MARKSMANPISTOL"] = GetHashKey("WEAPON_MARKSMANPISTOL"),
    ["WEAPON_REVOLVER"] = GetHashKey("WEAPON_REVOLVER"),
    ["WEAPON_REVOLVER_MK2"] = GetHashKey("WEAPON_REVOLVER_MK2"),
    ["WEAPON_DOUBLEACTION"] = GetHashKey("WEAPON_DOUBLEACTION"),
    ["WEAPON_RAYPISTOL"] = GetHashKey("WEAPON_RAYPISTOL"),
    ["WEAPON_CERAMICPISTOL"] = GetHashKey("WEAPON_CERAMICPISTOL"),
    ["WEAPON_NAVYREVOLVER"] = GetHashKey("WEAPON_NAVYREVOLVER"),
    ["WEAPON_MICROSMG"] = GetHashKey("WEAPON_MICROSMG"),
    ["WEAPON_SMG"] = GetHashKey("WEAPON_SMG"),
    ["WEAPON_SMG_MK2"] = GetHashKey("WEAPON_SMG_MK2"),
    ["WEAPON_ASSAULTSMG"] = GetHashKey("WEAPON_ASSAULTSMG"),
    ["WEAPON_COMBATPDW"] = GetHashKey("WEAPON_COMBATPDW"),
    ["WEAPON_MACHINEPISTOL"] = GetHashKey("WEAPON_MACHINEPISTOL"),
    ["WEAPON_MINISMG"] = GetHashKey("WEAPON_MINISMG"),
    ["WEAPON_RAYCARBINE"] = GetHashKey("WEAPON_RAYCARBINE"),
    ["WEAPON_PUMPSHOTGUN"] = GetHashKey("WEAPON_PUMPSHOTGUN"),
    ["WEAPON_PUMPSHOTGUN_MK2"] = GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),
    ["WEAPON_SAWNOFFSHOTGUN"] = GetHashKey("WEAPON_SAWNOFFSHOTGUN"),
    ["WEAPON_ASSAULTSHOTGUN"] = GetHashKey("WEAPON_ASSAULTSHOTGUN"),
    ["WEAPON_BULLPUPSHOTGUN"] = GetHashKey("WEAPON_BULLPUPSHOTGUN"),
    ["WEAPON_MUSKET"] = GetHashKey("WEAPON_MUSKET"),
    ["WEAPON_HEAVYSHOTGUN"] = GetHashKey("WEAPON_HEAVYSHOTGUN"),
    ["WEAPON_DBSHOTGUN"] = GetHashKey("WEAPON_DBSHOTGUN"),
    ["WEAPON_AUTOSHOTGUN"] = GetHashKey("WEAPON_AUTOSHOTGUN"),
    ["WEAPON_ASSAULTRIFLE"] = GetHashKey("WEAPON_ASSAULTRIFLE"),
    ["WEAPON_ASSAULTRIFLE_MK2"] = GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),
    ["WEAPON_CARBINERIFLE"] = GetHashKey("WEAPON_CARBINERIFLE"),
    ["WEAPON_CARBINERIFLE_MK2"] = GetHashKey("WEAPON_CARBINERIFLE_MK2"),
    ["WEAPON_ADVANCEDRIFLE"] = GetHashKey("WEAPON_ADVANCEDRIFLE"),
    ["WEAPON_SPECIALCARBINE"] = GetHashKey("WEAPON_SPECIALCARBINE"),
    ["WEAPON_SPECIALCARBINE_MK2"] = GetHashKey("WEAPON_SPECIALCARBINE_MK2"),
    ["WEAPON_BULLPUPRIFLE"] = GetHashKey("WEAPON_BULLPUPRIFLE"),
    ["WEAPON_BULLPUPRIFLE_MK2"] = GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),
    ["WEAPON_COMPACTRIFLE"] = GetHashKey("WEAPON_COMPACTRIFLE"),
    ["WEAPON_MG"] = GetHashKey("WEAPON_MG"),
    ["WEAPON_COMBATMG"] = GetHashKey("WEAPON_COMBATMG"),
    ["WEAPON_COMBATMG_MK2"] = GetHashKey("WEAPON_COMBATMG_MK2"),
    ["WEAPON_GUSENBERG"] = GetHashKey("WEAPON_GUSENBERG"),
    ["WEAPON_SNIPERRIFLE"] = GetHashKey("WEAPON_SNIPERRIFLE"),
    ["WEAPON_HEAVYSNIPER"] = GetHashKey("WEAPON_HEAVYSNIPER"),
    ["WEAPON_HEAVYSNIPER_MK2"] = GetHashKey("WEAPON_HEAVYSNIPER_MK2"),
    ["WEAPON_MARKSMANRIFLE"] = GetHashKey("WEAPON_MARKSMANRIFLE"),
    ["WEAPON_MARKSMANRIFLE_MK2"] = GetHashKey("WEAPON_MARKSMANRIFLE_MK2"),
    ["WEAPON_RPG"] = GetHashKey("WEAPON_RPG"),
    ["WEAPON_GRENADELAUNCHER"] = GetHashKey("WEAPON_GRENADELAUNCHER"),
    ["WEAPON_GRENADELAUNCHER_SMOKE"] = GetHashKey("WEAPON_GRENADELAUNCHER_SMOKE"),
    ["WEAPON_MINIGUN"] = GetHashKey("WEAPON_MINIGUN"),
    ["WEAPON_FIREWORK"] = GetHashKey("WEAPON_FIREWORK"),
    ["WEAPON_RAILGUN"] = GetHashKey("WEAPON_RAILGUN"),
    ["WEAPON_HOMINGLAUNCHER"] = GetHashKey("WEAPON_HOMINGLAUNCHER"),
    ["WEAPON_COMPACTLAUNCHER"] = GetHashKey("WEAPON_COMPACTLAUNCHER"),
    ["WEAPON_RAYMINIGUN"] = GetHashKey("WEAPON_RAYMINIGUN"),
    ["WEAPON_GRENADE"] = GetHashKey("WEAPON_GRENADE"),
    ["WEAPON_BZGAS"] = GetHashKey("WEAPON_BZGAS"),
    ["WEAPON_MOLOTOV"] = GetHashKey("WEAPON_MOLOTOV"),
    ["WEAPON_STICKYBOMB"] = GetHashKey("WEAPON_STICKYBOMB"),
    ["WEAPON_PROXMINE"] = GetHashKey("WEAPON_PROXMINE"),
    ["WEAPON_SNOWBALL"] = GetHashKey("WEAPON_SNOWBALL"),
    ["WEAPON_PIPEBOMB"] = GetHashKey("WEAPON_PIPEBOMB"),
    ["WEAPON_BALL"] = GetHashKey("WEAPON_BALL"),
    ["WEAPON_SMOKEGRENADE"] = GetHashKey("WEAPON_SMOKEGRENADE"),
    ["WEAPON_FLARE"] = GetHashKey("WEAPON_FLARE"),
    ["WEAPON_PETROLCAN"] = GetHashKey("WEAPON_PETROLCAN"),
    ["GADGET_PARACHUTE"] = GetHashKey("GADGET_PARACHUTE"),
    ["WEAPON_FIREEXTINGUISHER"] = GetHashKey("WEAPON_FIREEXTINGUISHER"),
    ["WEAPON_HAZARDCAN"] = GetHashKey("WEAPON_HAZARDCAN"),
    ["WEAPON_ANTIDOTE"] = GetHashKey("WEAPON_ANTIDOTE"),
    ["WEAPON_MEGAPHONE"] = GetHashKey("WEAPON_MEGAPHONE"),
}

function openF6Ambulance()
    local tableInfos = {}
    local mainMenu = RageUI.CreateMenu('', 'Faites vos actions')
    local interaction = RageUI.CreateSubMenu(mainMenu, '', 'Faites vos actions')
    local analyse = RageUI.CreateSubMenu(mainMenu, '', 'Faites vos actions')
    local rapport = RageUI.CreateSubMenu(mainMenu, '', 'Faites vos actions')
    local appels = RageUI.CreateSubMenu(mainMenu, '', 'Liste des rapports')
    local voirrapports = RageUI.CreateSubMenu(mainMenu, '', 'Faites vos actions')
    local fairerapport = RageUI.CreateSubMenu(rapport, '', 'Faites vos actions')
    local typedesoin = RageUI.CreateSubMenu(fairerapport, '', 'Faites vos actions')
    local props = RageUI.CreateSubMenu(mainMenu, "", "Intéractions : Objets")
    local propsList = RageUI.CreateSubMenu(props, "", "Intéractions : Gérer")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))
    while openambulanceF6 do
        RageUI.IsVisible(mainMenu, function()
            local grade = ESX.PlayerData.job.grade_name
            if ServiceAmbulance then
                    RageUI.Button("Intéractions citoyen", nil, {RightLabel = "→"}, true , {
                        onSelected = function()
                        end
                    }, interaction)
                    RageUI.Button("Mettre une facture", nil, {RightLabel = "→"}, true , {
                        onSelected = function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestPlayer == -1 or closestDistance > 3.0 then
                               ESX.ShowNotification('Personne autour de vous')
                            else
                                montantInput = KeyboardInputAmbulance("montant", 'Entrez le montant', '', 5)
                                if json.decode(montantInput) < 15000 then
                                    ESX.ShowNotification("~g~Facture envoyé !")
                                    TriggerServerEvent('sendLogs:Facture', GetPlayerServerId(closestPlayer), montantInput)
                                    TriggerServerEvent('ambulance:sendBill', GetPlayerServerId(closestPlayer), montantInput)
                                    ESX.ShowNotification("~g~Facture envoyée avec succès !")
                                else
                                    ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Montant trop élever ! (15000$ max)")
                                end
                            end
                        end
                    })

                    RageUI.Button("Consulter les appels", nil, {RightLabel = "→"}, true, {
                    }, appels)

                    RageUI.Button("Faire un rapport", nil, {RightLabel = "→"}, true , {
                        onSelected = function()
                        end
                    }, rapport)

                    RageUI.Button("Objets", nil, { RightLabel = "→" }, true, {
                    }, props)

                    if grade == 'boss' then
                        RageUI.Button("Voir les rapports de vos employés", nil, {RightLabel = "→"}, true , {
                            onSelected = function()
                                getAllRapports()
                            end
                        }, voirrapports)
                    end
                else
                    RageUI.Separator("Vous devez être en service")
                end
            end)

        RageUI.IsVisible(appels, function()
            
            -- RageUI.Button("Supprimer tout les appels", nil, {}, true, {
            --     onSelected = function()
            --         table.remove(appelsdesmorts, k)
            --         ESX.ShowNotification("Vous avez bien "..exports.Tree:serveurConfig().Serveur.color.."supprimer ~s~tout les appelle")
            --     end
            -- })

            RageUI.Separator(exports.Tree:serveurConfig().Serveur.color.."Liste des appels: ")

            for k,v in pairs(appelsdesmorts) do
                local dist = #(GetEntityCoords(PlayerPedId(), true) - vector3(v.x,v.y,v.z))
                local distance = math.ceil(dist)
                local numberOfCals = v.countofappels
                local playerDead = v.playerDead
                local NameAmbulance = v.NameOfJoueurs

                if not v.Checked then
                    RageUI.Button("["..exports.Tree:serveurConfig().Serveur.color.."EN ATTENTE~s~] Demande n°"..numberOfCals.."~s~ | Distance : "..distance.."m", nil, {}, true, {
                        onSelected = function()
                            TriggerServerEvent("babyboy:sendMessageToAccepte", playerDead, dist)
                            SetNewWaypoint(v.x, v.y)
                            ESX.ShowNotification("Vous avez bien ~g~accepter~s~ la demande d'aide !")
                            GetPlayerDeadIsOnline(playerDead)
                            Wait(500)
                            v.Checked = true
                            TriggerServerEvent('updateCall', appelsdesmorts, v.playerDead)
                            TriggerServerEvent('accepteCall:sendLogs')
                        end
                    })
                else
                    RageUI.Button("[~g~EN COURS~s~] Demande n°"..numberOfCals.."~s~ | Distance : "..distance.."m", "Appelle en cours par : "..NameAmbulance, {}, true, {
                        onSelected = function()
                            deleteCall = KeyboardInputAmbulance("valideDelete", 'Oui/Non', '', 3)
                            valideDelete = (tostring(deleteCall))
                            
                            if valideDelete == "Oui" or valideDelete == "oui" then
                                TriggerServerEvent('ambulance:deleteCall', k)
                            else
                                ESX.ShowNotification("Pour supprimer l'appel validé avec oui oui")
                            end
                        end
                    })
                end

                -- if dist < 5 then
                --     TriggerServerEvent('ambulance:deleteCall', k)
                --     ESX.ShowNotification("Appelle supprimer, patient a moins de 5 mètres")
                --     DeleteWaypoint()
                -- end
            end
        end)

        RageUI.IsVisible(interaction, function()
            RageUI.Separator(exports.Tree:serveurConfig().Serveur.color.."Actions de médecine")
            RageUI.Button("Réanimer", "Cette action nécessite 1 "..exports.Tree:serveurConfig().Serveur.color.."medikit", {RightLabel = "→"}, true , {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification('Personne autour de vous')
                    else
                        TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                        ESX.ShowNotification("Réanimation en cours")
                        Citizen.Wait(10000)
                        TriggerServerEvent('ambulance:réanimer', GetPlayerServerId(closestPlayer))
                        ClearPedTasks(PlayerPedId())


                        
                    end
                end
            })
            RageUI.Button("Prodiguer des soins", "Cette action nécessite 1 "..exports.Tree:serveurConfig().Serveur.color.."kit de soins", {RightLabel = "→"}, true , {
                onSelected = function()
                    local closestPlayer, closestDistance =ESX.Game.GetClosestPlayer()
                    local closestPlayerPed = GetPlayerPed(closestPlayer)
                    local health = GetEntityHealth(closestPlayerPed)
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification('Personne autour de vous')
                    else
                        if health > 0 then
                            local playerPed = PlayerPedId()
                            TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                            ESX.ShowNotification("Soins en cours")
                            Citizen.Wait(10000)
                            ClearPedTasks(playerPed)
                            TriggerServerEvent('ambulance:healsomeone', GetPlayerServerId(closestPlayer), 'small')




                        else
                            ESX.ShowNotification("Vous n'avez aucune raison de soigner cette personne")
                        end
                    end   
                end
            })

            -- RageUI.Button("Prodiguer des soins intensifs", "Cette action nécessite 1 "..exports.Tree:serveurConfig().Serveur.color.."bandage", {RightLabel = "→"}, true , {
            --     onSelected = function()
            --         local closestPlayer, closestDistance =ESX.Game.GetClosestPlayer()
            --         local closestPlayerPed = GetPlayerPed(closestPlayer)
            --         local health = GetEntityHealth(closestPlayerPed)
            --         if closestPlayer == -1 or closestDistance > 3.0 then
            --             ESX.ShowNotification('Personne autour de vous')
            --         else
            --             if health > 0 then
            --                 local playerPed = PlayerPedId()
            --                 TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
            --                 ESX.ShowNotification("Soins en cours")
            --                 Citizen.Wait(10000)
            --                 ClearPedTasks(playerPed)
            --                 TriggerServerEvent('ambulance:healsomeone', GetPlayerServerId(closestPlayer), 'big')
            --             else
            --                 ESX.ShowNotification("Vous n'avez aucune raison de soigner cette personne")
            --             end
            --         end
            --     end
            -- })

            RageUI.Button("Analyser un corps", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local closestPlayer = ESX.Game.GetClosestPlayer()
                    local closestPlayerPed = GetPlayerPed(closestPlayer)
                    local carkill = { 133987706, -1553120962 }
                    if IsPlayerDead(closestPlayer) then
                        local ReasonOfDead = GetPedCauseOfDeath(closestPlayerPed)
                        for key, value in pairs(TableWeapon) do
                            if value == ReasonOfDead then
                                ReasonOfDead = key
                                theWeaponWhoKilled = ESX.GetWeaponLabel(key)
                                key = "Meurtre par arme"
                                table.insert(tableInfos, {label = key, name = GetPlayerName(closestPlayer), weapon = theWeaponWhoKilled})
                            end
                        end
                        if verif(carkill, ReasonOfDead) then
                            table.insert(tableInfos, {name = GetPlayerName(closestPlayer), label = "Tué par un véhicule"})
                        end
                    end
                end
            }, analyse)
        end)

        RageUI.IsVisible(analyse, function()
            for k,v in pairs(tableInfos) do
                RageUI.Separator("Nom de la personne étudiée: "..v.name)
                RageUI.Button("Raison de la mort: "..v.label, nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                    end
                })
                if v.weapon ~= nil then
                    RageUI.Button("Arme utilisée: "..v.weapon, nil, {RightLabel = "→"}, true , {
                        onSelected = function()
                        end
                    })
                end
            end
        end)

        RageUI.IsVisible(props, function()
            RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Gérer", nil, { RightLabel = "→" }, true, {
            }, propsList)
            RageUI.Line()
            for k,v in pairs(objectsEMS) do 
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

        RageUI.IsVisible(rapport, function()
            RageUI.Button("Faire un rapport", nil, {RightLabel = "→"}, true, {
            }, fairerapport)
        end)

        RageUI.IsVisible(fairerapport, function()
            RageUI.Separator("Détaillez votre rapport →")
            RageUI.Button("Prénom du médecin", nil , {RightLabel = prenom}, true, {
                onSelected = function()
                    prenomInput = KeyboardInputAmbulance("prenom", 'Entrez votre prenom', '', 15)
                    prenom = (tostring(prenomInput))
                end
            })
            RageUI.Button("Nom du médecin", nil , {RightLabel = nom}, true, {
                onSelected = function()
                    nominput = KeyboardInputAmbulance("nom", 'Entrez votre nom', '', 15)
                    nom = (tostring(nominput))
                end
            })
            RageUI.Button("Type de soin donnés", nil , {RightLabel = thetype}, true, {
                onSelected = function()
                end
            }, typedesoin)
            RageUI.Button("Montant de la facture donnée", nil, {RightLabel = montant}, true, {
                onSelected = function()
                    montantInput = KeyboardInputAmbulance("montant", 'Entrez le montant', '', 15)
                    montant = tonumber(montantInput)
                end
            })

            RageUI.Button("Envoyez votre rapport", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    if not prenom or not nom or not letypeasendendb or not montant then
                        ESX.ShowNotification("Merci de remplir toutes les informations")  
                    else
                        TriggerServerEvent('ambulance:sendrapport', prenom, nom, letypeasendendb, montant)
                        RageUI.GoBack()
                    end
                end
            })
        end)

        RageUI.IsVisible(typedesoin, function()
            RageUI.Button("Petit soin ?", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    letypeasendendb = 'petit'
                    thetype = "Petit soin"
                    RageUI.GoBack()
                end
            })

            RageUI.Button("Grand soin ?", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    letypeasendendb = 'grand'
                    thetype = "Grand soin"
                    RageUI.GoBack()
                end
            })

            RageUI.Button("Réanimation ?", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    letypeasendendb = 'rea'
                    thetype = "Réanimation"
                    RageUI.GoBack()
                end
            })
        end)

        RageUI.IsVisible(voirrapports, function()
            for k,v in pairs(AllRapportsDesAmbulanciers) do
                RageUI.Separator("Rapport de: "..v.prenom.." "..v.nom.."")
                RageUI.Button("Voici les détails du rapport:", "Type de soin donnée: "..v.type.." montant de la facture donnée: "..v.montant.."$", {RightLabel = "→"}, true, {
                    onSelected = function()
                        confirmInput = KeyboardInputAmbulance("confirm", 'Entrez oui pour supprimer ce rapport et non pour annuler', '', 15)
                        confirm = (tostring(confirmInput))
                        if confirm == 'oui' then
                            TriggerServerEvent('ambulance:deleterapport', v.prenom, v.nom, v.type, v.montant)
                            ESX.ShowNotification("Rapport supprimé avec succès !")
                            RageUI.GoBack()
                        else
                            ESX.ShowNotification("Suppression annulée")
                            RageUI.GoBack()
                        end
                    end   
                })
            end
        end)

        if not RageUI.Visible(mainMenu) and not RageUI.Visible(appels) and not RageUI.Visible(interaction) and not RageUI.Visible(analyse) and not RageUI.Visible(rapport) and not RageUI.Visible(voirrapports) and not RageUI.Visible(fairerapport) and not RageUI.Visible(typedesoin) and not RageUI.Visible(props) and not RageUI.Visible(propsList) then
            mainMenu = RMenu:DeleteType('mainMenu', true)
            openambulanceF6 = false
        end
        if not RageUI.Visible(voirrapports) then
            table.remove(AllRapportsDesAmbulanciers, k)
        end
        if not RageUI.Visible(mainMenu) and not RageUI.Visible(interaction) and not RageUI.Visible(analyse) then
            table.remove(tableInfos, k)
        end
        Citizen.Wait(0)
    end
end

function openAmbulanceGestionMenu()
    local mainMenu = RageUI.CreateMenu("", "Faites vos actions")
    local rc = RageUI.CreateSubMenu(mainMenu, "", "Faites vos actions")
    local vr = RageUI.CreateSubMenu(mainMenu, "", "Faites vos actions")
    local pr = RageUI.CreateSubMenu(mainMenu, "", "Faites vos actions")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))
    while openGestion do
        RageUI.IsVisible(mainMenu, function()
            RageUI.Button("Recruter des employés", nil, {RightLabel = "→"}, true , {
            })
            RageUI.Button("Virer des employés", nil, {RightLabel = "→"}, true , {
            })
            RageUI.Button("Promouvoir des employés", nil, {RightLabel = "→"}, true , {
            })
        end)

        if not RageUI.Visible(mainMenu) and not RageUI.Visible(rc) and not RageUI.Visible(vr) and not RageUI.Visible(pr) then
            mainMenu = RMenu:DeleteType('mainMenu', true)
            openGestion = false
        end
        Citizen.Wait(0)
    end
end

function OpenAmbulancePharmacie()
    mainMenu = RageUI.CreateMenu("", "Faites vos actions")
    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))
    while openPharma do
        RageUI.IsVisible(mainMenu, function()
            RageUI.Button("Prendre des bandages", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    TriggerServerEvent('ambulance:takebandage')
                end
            })
            RageUI.Button("Prendre des kits de soin", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    TriggerServerEvent('ambulance:takemedikits')
                end
            })
            if ESX.PlayerData.job.grade == 1 then
                RageUI.Button("Prendre un Tazer de poche", nil, {RightLabel = "→"}, true, {
                    onSelected = function()
                        local tazer = "weapon_stungun"
                        TriggerServerEvent('ambulance:tazer', tazer)
                    end              
                })
            end
            RageUI.Button("Prendre une lampe torche", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    local lampeTorche = "weapon_flashlight"
                    TriggerServerEvent('ambulance:Lampe', lampeTorche)
                end              
            })
        end)

        if not RageUI.Visible(mainMenu) then
            mainMenu = RMenu:DeleteType('mainMenu', true)
            openPharma = false
        end
        Citizen.Wait(0)
    end
end

function OpenAmbulanceClothesMenu()
    local playerPed = PlayerPedId()
    local mainMenu = RageUI.CreateMenu("", "Faites vos actions")
    local grade = ESX.PlayerData.job.grade_name
    local test = ESX.PlayerData.job.grade_label

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))
    while openClothes do
        RageUI.IsVisible(mainMenu, function()
            if (ServiceAmbulance) then
                RageUI.Button("Reprendre votre tenue civile", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                            TriggerEvent('skinchanger:loadSkin', skin)
                        end)
                        ServiceAmbulance = false
                        TriggerServerEvent('annonce:serviceAmbulance', 'fin')
                    end
                })
            else
                RageUI.Button("Prendre votre tenue ["..exports.Tree:serveurConfig().Serveur.color..""..test.."~s~]", nil, {RightLabel = "→"}, true , {
                    onSelected = function()
                        if grade == "stagiaire" then
                            setUniformAmbulance('stagiaire_wear', playerPed)
                            ServiceAmbulance = true
                        elseif grade == "ambulance" then
                            setUniformAmbulance('ambulance_wear', playerPed)
                            ServiceAmbulance = true
                        elseif grade == "infirmier" then
                            setUniformAmbulance('infirmier_wear', playerPed)
                            ServiceAmbulance = true
                        elseif grade == "chirurgien" then
                            setUniformAmbulance('chirurgien_wear', playerPed)
                            ServiceAmbulance = true
                        elseif grade == "chefs" then
                            setUniformAmbulance('chefs_wear', playerPed)
                            ServiceAmbulance = true
                        elseif grade == "coboss" then
                            setUniformAmbulance('chefs_wear', playerPed)
                            ServiceAmbulance = true
                        elseif grade == "boss" then
                            setUniformAmbulance('chefs_wear', playerPed)
                            ServiceAmbulance = true
                        end
                        TriggerServerEvent('sendLogs:ServiceYes')
                        TriggerServerEvent('annonce:serviceAmbulance', 'prise')
                    end
                })
            end
        end)
        local onPos = false
        for _, v in pairs(Config.Jobs.Ambulance.Clothes) do
            if #(GetEntityCoords(PlayerPedId()) - v.clothes) <= 10 then
                onPos = true
            end
        end

        if not RageUI.Visible(mainMenu) or onPos == false then
            mainMenu = RMenu:DeleteType('mainMenu', true)
            openClothes = false
        end
        Citizen.Wait(0)
    end
end

-- function OpenAmbulanceVehicleSpawnerMenu()
--     local mainMenu = RageUI.CreateMenu("", "Faites vos actions")

--     RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))
--     while openSpawner do
--         RageUI.IsVisible(mainMenu, function()
--             RageUI.Button("Sortir une Ambulance Van", nil, {RightLabel = "→"}, true , {
--                 onSelected = function()
--                     TriggerServerEvent('ambulance:spawnVehicle');

--                     ESX.Game.SpawnVehicle('ambulance2', vector3(-1839.20, -382.19, 40.72), 225.48, function (vehicle)
--                         local newPlate = exports['Gamemode']:GeneratePlate()
--                         SetVehicleNumberPlateText(vehicle, newPlate)
--                         exports[exports.Tree:serveurConfig().Serveur.hudScript]:SetFuel(vehicle, 100)
--                         TriggerServerEvent('babyboy:GiveDoubleKeys', 'no', newPlate)
--                         TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
--                     end)
--                     RageUI.CloseAll()
--                 end
--             })
--             RageUI.Button("Sortir un Dundreary Landstalker XL", nil, {RightLabel = "→"}, true , {
--                 onSelected = function()
--                     TriggerServerEvent('ambulance:spawnVehicle');
--                     ESX.Game.SpawnVehicle('emsstalker', vector3(-1839.20, -382.19, 40.72), 225.48, function (vehicle)
--                         local newPlate = exports['Gamemode']:GeneratePlate()
--                         SetVehicleNumberPlateText(vehicle, newPlate)
--                         exports[exports.Tree:serveurConfig().Serveur.hudScript]:SetFuel(vehicle, 100)
--                         TriggerServerEvent('babyboy:GiveDoubleKeys', 'no', newPlate)
--                         TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
--                     end)
--                     RageUI.CloseAll()
--                 end
--             })
--             if ESX.PlayerData.job.grade == "boss" then
--                 RageUI.Button("Sortir une Pfister Comet", nil, {RightLabel = "→"}, true , {
--                     onSelected = function()
--                         TriggerServerEvent('ambulance:spawnVehicle');

--                         ESX.Game.SpawnVehicle('emscomet', vector3(-1839.20, -382.19, 40.72), 225.48, function (vehicle)
--                             local newPlate = exports['Gamemode']:GeneratePlate()
--                             SetVehicleNumberPlateText(vehicle, newPlate)
--                             exports[exports.Tree:serveurConfig().Serveur.hudScript]:SetFuel(vehicle, 100)
--                             TriggerServerEvent('babyboy:GiveDoubleKeys', 'no', newPlate)
--                             TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
--                         end)

--                         RageUI.CloseAll()
--                     end
--                 })
--             end
--         end)

--         if not RageUI.Visible(mainMenu) then
--             openSpawner = false
--             mainMenu = RMenu:DeleteType('mainMenu', true)
--         end
--         Citizen.Wait(0)
--     end
-- end


function setUniformAmbulance(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
        if (skin.sex ~= nil) then
            if skin.sex == 0 then
                TriggerEvent('skinchanger:loadClothes', skin, Config.Jobs.Ambulance.Uniforms[job].male)
                if job == 'bullet_wear' then
                    SetPedArmour(playerPed, 100)
                end
            else
                TriggerEvent('skinchanger:loadClothes', skin, Config.Jobs.Ambulance.Uniforms[job].female)
            end
        end
	end)
end

RegisterNetEvent('ambulance:InfoService')
AddEventHandler('ambulance:InfoService', function(service, nom)
	if service == 'prise' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('Notification', exports.Tree:serveurConfig().Serveur.color..'Prise de service', exports.Tree:serveurConfig().Serveur.color..'Ambulancier : '..exports.Tree:serveurConfig().Serveur.color..''..nom..'\n'..exports.Tree:serveurConfig().Serveur.color..'Information : '..exports.Tree:serveurConfig().Serveur.color..'Prise de service.', nil, 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
	elseif service == 'fin' then
		PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
		ESX.ShowAdvancedNotification('Notification', exports.Tree:serveurConfig().Serveur.color..'Fin de service', exports.Tree:serveurConfig().Serveur.color..'Ambulancier : '..exports.Tree:serveurConfig().Serveur.color..''..nom..'\n'..exports.Tree:serveurConfig().Serveur.color..'Information : '..exports.Tree:serveurConfig().Serveur.color..'Fin de service.', nil, 8)
		Wait(1000)
		PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
    end
end)

RegisterNetEvent('ambulance:signal')
AddEventHandler('ambulance:signal', function(playerDead, x,y,z)

    countofappels = countofappels + 1
    table.insert(appelsdesmorts, {
        playerDead = playerDead,
        x = x,
        y = y,
        z = z,
        countofappels = countofappels,
        Checked = false,
        NameOfJoueurs = "",
    })
    if ServiceAmbulance then
        ESX.ShowNotification("Une nouvelle demande d'aide est arriver !")
    end
end)


RegisterNetEvent("ambulance:sendMarker", function(playerDead, x, y, z)
    local timer = 1000
    while true do 
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local dist = #(playerCoords - vector3(x, y, z))
        if dist < 5 then
            timer = 0
            DrawMarker(1, x, y, z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 100, 0, 0, 0, 0)
            if dist < 2 then
                ESX.ShowHelpNotification("Appuyez sur ~b~E~s~ pour réanimer la personne")
                if IsControlJustPressed(1, 38) then
                    TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                    ESX.ShowNotification("Réanimation en cours")
                    Citizen.Wait(10000)

                    print(playerDead)

                    TriggerServerEvent('ambulance:réanimer', tonumber(playerDead))

                    ClearPedTasks(PlayerPedId())
                    print("reanimate")
                    Wait(5000)
                    print("break boucle")
                    break
                end
            end
        end
        Wait(timer)
    end
end)
RegisterNetEvent('ServiceAmbulanceCheck')
AddEventHandler('ServiceAmbulanceCheck', function(args)
    if ServiceAmbulance and args == "+" then
        TriggerServerEvent('ambulance:sendAnnonce', "+")
    elseif ServiceAmbulance and args == "-" then
        TriggerServerEvent('ambulance:sendAnnonce', "-")
    end
end)

RegisterNetEvent('ambulance:deleteAppel')
AddEventHandler('ambulance:deleteAppel', function(k)
    table.remove(appelsdesmorts, k)
end)

RegisterNetEvent('ambulance:revive')
AddEventHandler('ambulance:revive', function()
	-- exports[exports.Tree:serveurConfig().Serveur.hudScript]:SaveCurrentWeaponAmmoInv()

    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed);
    TriggerServerEvent('ambulance:setDeathStatus', 0);
    RageUI.CloseAll()
    SetEntityHealth(PlayerPedId(), 100);
    Citizen.CreateThread(function()
        DoScreenFadeOut(800);
        while not IsScreenFadedOut() do
            Citizen.Wait(0);
        end
        ESX.SetPlayerData('lastPosition', {
            x = coords.x,
            y = coords.y,
            z = coords.z
        })
        TriggerServerEvent('esx:updateLastPosition', {
            x = coords.x,
            y = coords.y,
            z = coords.z
        })
        RespawnPed(playerPed, {
            x = coords.x,
            y = coords.y,
            z = coords.z
        });
        StopScreenEffect('DeathFailOut');
        DoScreenFadeIn(800);
    end)
end)


RegisterNetEvent('ambulance:reviveAfterDie')
AddEventHandler('ambulance:reviveAfterDie', function()
    local playerPed = PlayerPedId()
    local coords    = Config.RespawningPlace
    TriggerServerEvent('ambulance:setDeathStatus', 0)
    Citizen.CreateThread(function()
        DoScreenFadeOut(800)
        while not IsScreenFadedOut() do
            Citizen.Wait(0)
        end
        ESX.SetPlayerData('lastPosition', {x = coords.x, y = coords.y, z = coords.z})
        TriggerServerEvent('esx:updateLastPosition', {x = coords.x, y = coords.y, z = coords.z})
        RespawnPed(playerPed, {x = coords.x, y = coords.y, z = coords.z})
        StopScreenEffect('DeathFailOut')
        DoScreenFadeIn(800)
        TriggerServerEvent("clear:armeAfterDeath")
    end)
end)

RegisterNetEvent('ambulance:slay')
AddEventHandler('ambulance:slay', function()
    local playerPed = PlayerPedId()
    TriggerServerEvent('ambulance:setDeathStatus', 1)
    SetEntityHealth(playerPed, 0)
end)

RegisterNetEvent('ambulance:heal')
AddEventHandler('ambulance:heal', function(type)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)
	if type == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth , math.floor(health + maxHealth/8))
		SetEntityHealth(playerPed, newHealth)
	elseif type == 'big' then
		SetEntityHealth(playerPed, maxHealth)
	end
	ESX.ShowNotification("Vous avez été soigné !")
end)

function getAllRapports()
    ESX.TriggerServerCallback('getAllRapports', function(cb)
        if not cb then return end
        for i = 1, #cb, 1 do
            local d = cb[i]
            table.insert(AllRapportsDesAmbulanciers, {
                prenom = d.Prenom,
                nom = d.Nom,
                type = d.Type,
                montant = d.Montant
            })
        end
    end)
end

function RespawnPed(ped, coords)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, coords.heading, true, false);
    SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true);
	SetPlayerInvincible(ped, false);
	TriggerEvent('playerSpawned', { x = coords.x, y = coords.y, z = coords.z, heading = coords.heading }, false);
	ClearPedBloodDamage(ped)
end

function verif(a, val)
    for name, value in ipairs(a) do
        if value == val then
            return true
        end
    end
    return false
end

function KeyboardInputAmbulance(entryTitle, textEntry, inputText, maxLength)
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


function GetPlayerDeadIsOnline(playerDead)

    local playerIdx = GetPlayerFromServerId(playerDead)
    local ped = GetPlayerPed(playerIdx)

    Citizen.CreateThread(function()
        while true do 
            Wait(1000)

            if not DoesEntityExist(ped) then
                TriggerServerEvent('ambulance:deleteCall', k)
                ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Votre patient a quitter la ville, suppression du marker !")
                DeleteWaypoint()
                break
            end

            if ped == not isDead then
                TriggerServerEvent('ambulance:deleteCall', k)
                ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Votre patient est en vie, suppression du marker !")
                DeleteWaypoint()
                break
            end

        end
    end)
end
