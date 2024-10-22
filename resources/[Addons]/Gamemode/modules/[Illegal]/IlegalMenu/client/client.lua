local ArgentSale = {}
local Items = {}
local Armes = {}
local infosvehicle = {}
DragStatus = {}
DragStatus.IsDragged          = false
local IsCuffedHands = false

Citizen.CreateThread(function()
    while ESX.GetPlayerData().job2 == nil do
		Citizen.Wait(500)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()
    end
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job)
    ESX.PlayerData.job2 = job
end)

-- MENU F7
local CrewOptions = {
    InfosCrew = {},
    InfosTerritoires = {},
    InfosStatsPanel = {},
    ServerCrews = {},
    ShowTerritoires = false
}

openF7 = function()
    local mainMenu = RageUI.CreateMenu("", "Faites vos actions")
    local f7territoires = RageUI.CreateSubMenu(mainMenu, "", "Informations sur les territoires")
    local interaction = RageUI.CreateSubMenu(mainMenu, "", "Interactions avec le kidnappé")
    local fouiller = RageUI.CreateSubMenu(interaction, "", "Faites vos actions")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while mainMenu do

        RageUI.IsVisible(mainMenu, function()
            if GetResourceState("Territories") == "started" then
                RageUI.Button("Informations territoires", nil, {RightLabel = "→"}, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback("Piwel_Territoires:GetAllTerritoires", function(cb)
                            CrewOptions.InfosTerritoires = cb
                            RageUI.Visible(f7territoires, not RageUI.Visible(f7territoires))
                        end)
                    end
                }, nil)
                RageUI.Button(((CrewOptions.ShowTerritoires and "Enlever") or (not CrewOptions.ShowTerritoires and "Afficher")).." les territoires sur la carte", nil, {RightLabel = ""}, true, {
                    onSelected = function()
                        CrewOptions.ShowTerritoires = not CrewOptions.ShowTerritoires
                        TriggerEvent('Piwel_Territoires:ShowTerritoires', CrewOptions.ShowTerritoires)
                    end
                })
            end
            if not exports.Gamemode:IsInSafeZone() and not exports.Gamemode:IsInMenotte() and not exports.Gamemode:IsInPorter() and not exports.Gamemode:IsInOtage() then
                RageUI.Button("Interaction avec le kidnappé", nil, {RightLabel = "→"}, true, {
                }, interaction)
            else
                RageUI.Button("Interaction avec le kidnappé", "Action impossible en safe zone", {RightLabel = RageUI.BadgeStyle.Lock}, false, {
                }, interaction)
            end
        end)

        RageUI.IsVisible(f7territoires, function()
            for k,v in pairs(CrewOptions.InfosTerritoires) do
                RageUI.Button(k, nil, {RightLabel = (((string.upper(ESX.PlayerData.job2.name)) == (v.id_crew_owner ~= nil and string.upper(v.id_crew_owner)) and "✅") or "❌")}, true, {
                    onActive = function()
                        CrewOptions.InfosStatsPanel.show = true
                        CrewOptions.InfosStatsPanel.zone = k
                        if v.id_crew_owner then
                            CrewOptions.InfosStatsPanel.control = string.upper(v.id_crew_owner)
                        else
                            CrewOptions.InfosStatsPanel.control = "Aucun"
                        end

                        if CrewOptions.InfosTerritoires[k].crews_points[tostring(v.id_crew_owner)] then
                            CrewOptions.InfosStatsPanel.owner_points = CrewOptions.InfosTerritoires[k].crews_points[tostring(v.id_crew_owner)]
                        else
                            CrewOptions.InfosStatsPanel.owner_points = 0
                        end

                        if CrewOptions.InfosTerritoires[k].crews_points[tostring(ESX.PlayerData.job2.name)] then
                            CrewOptions.InfosStatsPanel.crew_points = CrewOptions.InfosTerritoires[k].crews_points[tostring(ESX.PlayerData.job2.name)]
                        else
                            CrewOptions.InfosStatsPanel.crew_points = 0
                        end
                        CrewOptions.InfosStatsPanel.missing_points = CrewOptions.InfosStatsPanel.owner_points - CrewOptions.InfosStatsPanel.crew_points
                        --CrewOptions.InfosStatsPanel.control2 = v.control1
                    end
                })
            end
        end, function()
            if CrewOptions.InfosStatsPanel.show and CrewOptions.InfosStatsPanel.control then
                RageUI.StatisticPanelString("Nom de la zone: "..CrewOptions.InfosStatsPanel.zone)
                RageUI.StatisticPanelString("Controlé par: "..CrewOptions.InfosStatsPanel.control)
                RageUI.StatisticPanelString("Nombre de points: "..CrewOptions.InfosStatsPanel.owner_points)
                RageUI.StatisticPanelString("-----")
                RageUI.StatisticPanelString("Votre nombre de points: "..CrewOptions.InfosStatsPanel.crew_points)
                RageUI.StatisticPanelString("Points manquants: "..CrewOptions.InfosStatsPanel.missing_points)
            end
        end)

        RageUI.IsVisible(interaction, function()
            -- RageUI.Button("Prendre la carte d'identité", nil, {RightLabel = "→"}, true , {
            --     onSelected = function()
            --         local player, distance = ESX.Game.GetClosestPlayer()
            --         local getPlayerSearch = GetPlayerPed(player)
            --         if IsEntityPlayingAnim(getPlayerSearch, 'random@mugging3', 'handsup_standing_base', 3) then
            --             if distance ~= -1 and distance <= 3.0 then
            --                 RageUI.CloseAll()
            --                 ExecuteCommand("me Prend la carte d'identité..")
            --                 TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(player), GetPlayerServerId(PlayerId()))
            --             else
            --                 ESX.ShowNotification(''..exports.Tree:serveurConfig().Serveur.color..'Personne autour de vous')
            --             end
            --         else
            --             ESX.ShowNotification("Cette personne ne lève pas les mains")
            --         end
            --     end
            -- })
            RageUI.Button("Fouiller", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local player, distance = ESX.Game.GetClosestPlayer()
                    local getPlayerSearch = GetPlayerPed(player)
                    if IsEntityPlayingAnim(getPlayerSearch, 'random@mugging3', 'handsup_standing_base', 3) then
                        if player ~= -1 and distance <= 3.0 then
                            ExecuteCommand("me Fouille l'individue..")
                            TriggerServerEvent('message', GetPlayerServerId(player))
                            -- getPlayerInv(player)

                            local getPlayerSearch = GetPlayerPed(player)
                            if not IsEntityPlayingAnim(getPlayerSearch, 'random@mugging3', 'handsup_standing_base', 3) then
                                ESX.ShowNotification("La personne en face lève pas les mains en l'air")
                            else
                                TriggerServerEvent("Gamemode:Inventory:OpenSecondInventory", "fplayeril", GetPlayerServerId(player))

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
                    else
                        ESX.ShowNotification("Cette personne ne lève pas les mains")
                    end
                end
            })
    
            RageUI.Button("Menotter/Démenotter", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    local getPlayerSearch = GetPlayerPed(closestPlayer)
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Personne autour de vous')
                    else
                        if IsEntityPlayingAnim(getPlayerSearch, 'mp_arresting', 'idle', 3) then
                            TriggerServerEvent('illegal:menotter', GetPlayerServerId(closestPlayer))
                        else
                            if not IsEntityPlayingAnim(getPlayerSearch, 'random@mugging3', 'handsup_standing_base', 3) then
                                ESX.ShowNotification("La personne en face lève pas les mains en l'air")
                            else
                                TriggerServerEvent('illegal:menotter', GetPlayerServerId(closestPlayer))
                            end
                        end
                    end
                end
            })

            RageUI.Button("Prendre en hotage", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    TriggerEvent('TakeHostake:CallFunction')
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
                        TriggerServerEvent('illegal:escorter', GetPlayerServerId(closestPlayer))
                    end
                end
            })
    
            RageUI.Button("Jeter dans le véhicule", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Personne autour de vous')
                    else
                        TriggerServerEvent('illegal:putInVehicle', GetPlayerServerId(closestPlayer))
                    end
                end
            })

            RageUI.Button("Sortir du véhicule", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestPlayer == -1 or closestDistance > 3.0 then
                        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Personne autour de vous')
                    else
                        TriggerServerEvent('illegal:OutVehicle', GetPlayerServerId(closestPlayer))
                    end
                end
            })
        end)

        if not RageUI.Visible(mainMenu) and not RageUI.Visible(f7territoires) and not RageUI.Visible(interaction) then
            mainMenu = RMenu:DeleteType(mainMenu, true)
        end

        if not RageUI.Visible(lesinfosduvehicle) then
            table.remove(infosvehicle, k)
        end

        if not RageUI.Visible(fouiller) then
            table.remove(ArgentSale, k)
            table.remove(Items, k)
            table.remove(Armes, k)
        end

        Citizen.Wait(0)
    end
end

RegisterNetEvent('OpenVehicleCrochetage')
AddEventHandler('OpenVehicleCrochetage', function()
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
        TriggerServerEvent("CheckCrochetage")
    else
        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Aucun véhicule à proximité")
    end
end)

Citizen.CreateThread(function()
    while true do
        local sleepThread = 1000
        if IsCuffedHands then
            sleepThread = 0
            if not IsEntityPlayingAnim(PlayerPedId(), 'mp_arresting', 'idle', 3) then
                TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
            end
            DisableControlAction(2, 37, true)
            SetEnableHandcuffs(PlayerPedId(), true)
            SetPedCanPlayGestureAnims(PlayerPedId(), false)
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 257, true) -- Attack 2
            DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 263, true) -- Melee Attack 1
            DisableControlAction(0, 37, true) -- Select Weapon
            DisableControlAction(0, 47, true)  -- Disable weapon
        end
        Wait(sleepThread)
    end
end)

RegisterNetEvent('illegal:menotterlejoueur')
AddEventHandler('illegal:menotterlejoueur', function()
    RequestAnimDict('mp_arresting')
    while not HasAnimDictLoaded('mp_arresting') do
        Citizen.Wait(100)
    end
    IsCuffedHands = not IsCuffedHands;
    if IsCuffedHands then
        TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
    else
        ClearPedSecondaryTask(PlayerPedId())
        SetEnableHandcuffs(PlayerPedId(), false)
        SetPedCanPlayGestureAnims(PlayerPedId(),  true)
    end
end)

RegisterNetEvent('putInVehicle')
AddEventHandler('putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if not IsCuffedHands then
		return
	end

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

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				dragStatus.isDragged = false
			end
		end
	end
end)

RegisterNetEvent('outofVehicle')
AddEventHandler('outofVehicle', function()
    local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)

RegisterNetEvent('actionescorter')
AddEventHandler('actionescorter', function(ganggg)
  IsDragged = not IsDragged
  GangPed = tonumber(ganggg)
end)

function getInfosVehicle(vehicleData)
    ESX.TriggerServerCallback('getVehicleInfos', function(retrivedInfo)
        if retrivedInfo.owner == nil then
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
    end)
end

function getPlayerInv(player)
    
    ESX.TriggerServerCallback('getOtherPlayerData', function(data)
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

Citizen.CreateThread(function()
    while true do
        local interval = 750
        if IsCuffedHands then
            interval = 0
            if IsDragged then
                local ped = GetPlayerPed(GetPlayerFromServerId(GangPed))
                local myped = PlayerPedId()
                AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            else
                DetachEntity(PlayerPedId(), true, false)
            end
        end
        Wait(interval)
    end
end)

function KeyboardInputOrga(entryTitle, textEntry, inputText, maxLength)
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

Keys.Register('F7','Interactgang', 'Actions gangs', function()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.name ~= "unemployed2" and ESX.PlayerData.job2.name ~= "unemployed" then
        PlaySoundFrontend(-1, 'ATM_WINDOW', 'HUD_FRONTEND_DEFAULT_SOUNDSET', 1)
        openF7()
    end
end)

-- Take Hostage
local takeHostage = {
	allowedWeapons = {
		`WEAPON_PISTOL`,
		`WEAPON_COMBATPISTOL`,
		--etc add guns you want
	},
	InProgress = false,
	type = "",
	targetSrc = -1,
	agressor = {
		animDict = "anim@gangops@hostage@",
		anim = "perp_idle",
		flag = 49,
	},
	hostage = {
		animDict = "anim@gangops@hostage@",
		anim = "victim_idle",
		attachX = -0.24,
		attachY = 0.11,
		attachZ = 0.0,
		flag = 49,
	}
}

local function drawNativeNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local function GetClosestPlayer(radius)
    local players = GetActivePlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    for _,playerId in ipairs(players) do
        local targetPed = GetPlayerPed(playerId)
        if targetPed ~= playerPed then
            local targetCoords = GetEntityCoords(targetPed)
            local distance = #(targetCoords-playerCoords)
            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = playerId
                closestDistance = distance
            end
        end
    end
	if closestDistance ~= -1 and closestDistance <= radius then
		return closestPlayer
	else
		return nil
	end
end

local function ensureAnimDict(animDict)
    if not HasAnimDictLoaded(animDict) then
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(0)
        end        
    end
    return animDict
end

local function drawNativeText(str)
	SetTextEntry_2("STRING")
	AddTextComponentString(str)
	EndTextCommandPrint(1000, 1)
end

-- RegisterCommand("takehostage",function()
-- 	callTakeHostage()
-- end)

-- RegisterCommand("th",function()
-- 	callTakeHostage()
-- end)

RegisterNetEvent('TakeHostake:CallFunction')
AddEventHandler('TakeHostake:CallFunction', function()
	callTakeHostage()
end)

function callTakeHostage()
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)

	local canTakeHostage = false
	for i=1, #takeHostage.allowedWeapons do
		if HasPedGotWeapon(PlayerPedId(), takeHostage.allowedWeapons[i], false) then
			if GetAmmoInPedWeapon(PlayerPedId(), takeHostage.allowedWeapons[i]) > 0 then
				canTakeHostage = true 
				foundWeapon = takeHostage.allowedWeapons[i]
				break
			end 					
		end
	end

	if not canTakeHostage then 
		drawNativeNotification("Vous avez besoin d'une arme et de balles dedans pour faire ceci.")
	end

	if not takeHostage.InProgress and canTakeHostage then			
		local closestPlayer = GetClosestPlayer(3)
		if closestPlayer then
			local targetSrc = GetPlayerServerId(closestPlayer)
			if targetSrc ~= -1 then
				SetCurrentPedWeapon(PlayerPedId(), foundWeapon, true)
				takeHostage.InProgress = true
				takeHostage.targetSrc = targetSrc
				--TriggerServerEvent("TakeHostage:sync",targetSrc) 
				TriggerServerEvent("TakeHostage:sync",targetSrc) 
				ensureAnimDict(takeHostage.agressor.animDict)
				takeHostage.type = "agressor"
			else
				drawNativeNotification(exports.Tree:serveurConfig().Serveur.color.."Il n'y a personne à prendre en otage autour de vous.")
			end
		else
			drawNativeNotification(exports.Tree:serveurConfig().Serveur.color.."Il n'y a personne à prendre en otage autour de vous.")
		end
	end
end 

local agressorIs = nil
RegisterNetEvent("TakeHostage:syncTarget")
AddEventHandler("TakeHostage:syncTarget", function(target)
	agressorIs = nil
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	takeHostage.InProgress = true
	ensureAnimDict(takeHostage.hostage.animDict)
	agressorIs = targetPed
	--AttachEntityToEntity(PlayerPedId(), targetPed, 0, takeHostage.hostage.attachX, takeHostage.hostage.attachY, takeHostage.hostage.attachZ, 0.5, 0.5, 0.0, false, false, false, false, 2, false)
	takeHostage.type = "hostage" 
end)

RegisterNetEvent("TakeHostage:releaseHostage")
AddEventHandler("TakeHostage:releaseHostage", function()
	agressorIs = nil
	takeHostage.InProgress = false 
	takeHostage.type = ""
	DetachEntity(PlayerPedId(), true, false)
	ensureAnimDict("reaction@shove")
	TaskPlayAnim(PlayerPedId(), "reaction@shove", "shoved_back", 8.0, -8.0, -1, 0, 0, false, false, false)
	Wait(250)
	ClearPedSecondaryTask(PlayerPedId())
end)

RegisterNetEvent("TakeHostage:killHostage")
AddEventHandler("TakeHostage:killHostage", function()
	agressorIs = nil
	takeHostage.InProgress = false 
	takeHostage.type = ""
	SetEntityHealth(PlayerPedId(),0)
	DetachEntity(PlayerPedId(), true, false)
	ensureAnimDict("anim@gangops@hostage@")
	TaskPlayAnim(PlayerPedId(), "anim@gangops@hostage@", "victim_fail", 8.0, -8.0, -1, 168, 0, false, false, false)
end)

RegisterNetEvent("TakeHostage:cl_stop")
AddEventHandler("TakeHostage:cl_stop", function()
	agressorIs = nil
	takeHostage.InProgress = false
	takeHostage.type = "" 
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
end)

Citizen.CreateThread(function()
	while true do
		local sleepThread = 1000
		if takeHostage.InProgress then
			sleepThread = 0
			if agressorIs then
				if not IsEntityAttachedToEntity(PlayerPedId(), agressorIs) then
					AttachEntityToEntity(PlayerPedId(), agressorIs, 0, takeHostage.hostage.attachX, takeHostage.hostage.attachY, takeHostage.hostage.attachZ, 0.5, 0.5, 0.0, false, false, false, false, 2, false)
				end
			end
			if takeHostage.type == "agressor" then
				if not IsEntityPlayingAnim(PlayerPedId(), takeHostage.agressor.animDict, takeHostage.agressor.anim, 3) then
					TaskPlayAnim(PlayerPedId(), takeHostage.agressor.animDict, takeHostage.agressor.anim, 8.0, -8.0, 100000, takeHostage.agressor.flag, 0, false, false, false)
				end
			elseif takeHostage.type == "hostage" then
				if not IsEntityPlayingAnim(PlayerPedId(), takeHostage.hostage.animDict, takeHostage.hostage.anim, 3) then
					TaskPlayAnim(PlayerPedId(), takeHostage.hostage.animDict, takeHostage.hostage.anim, 8.0, -8.0, 100000, takeHostage.hostage.flag, 0, false, false, false)
				end
			end
		end
		Wait(sleepThread)
	end
end)

Citizen.CreateThread(function()
	while true do 
		local sleepThread = 1000
		if takeHostage.InProgress then
			sleepThread = 0
			if takeHostage.type == "agressor" then
				DisableControlAction(0,24,true) -- disable attack
				DisableControlAction(0,25,true) -- disable aim
				DisableControlAction(0,47,true) -- disable weapon
				DisableControlAction(0,58,true) -- disable weapon
				DisableControlAction(0,21,true) -- disable sprint
				DisablePlayerFiring(PlayerPedId(),true)
				drawNativeText("Appuie sur [G] pour libérer, [H] pour tuer")

				if IsEntityDead(PlayerPedId()) then
					takeHostage.type = ""
					takeHostage.InProgress = false
					ensureAnimDict("reaction@shove")
					TaskPlayAnim(PlayerPedId(), "reaction@shove", "shove_var_a", 8.0, -8.0, -1, 168, 0, false, false, false)
					TriggerServerEvent("TakeHostage:releaseHostage", takeHostage.targetSrc)
				end 

				if IsDisabledControlJustPressed(0,47) then --release	
					takeHostage.type = ""
					takeHostage.InProgress = false 
					ensureAnimDict("reaction@shove")
					TaskPlayAnim(PlayerPedId(), "reaction@shove", "shove_var_a", 8.0, -8.0, -1, 168, 0, false, false, false)
					TriggerServerEvent("TakeHostage:releaseHostage", takeHostage.targetSrc)
				elseif IsDisabledControlJustPressed(0,74) then --kill 			
					takeHostage.type = ""
					takeHostage.InProgress = false 		
					ensureAnimDict("anim@gangops@hostage@")
					TaskPlayAnim(PlayerPedId(), "anim@gangops@hostage@", "perp_fail", 8.0, -8.0, -1, 168, 0, false, false, false)
					TriggerServerEvent("TakeHostage:killHostage", takeHostage.targetSrc)
					TriggerServerEvent("TakeHostage:stop",takeHostage.targetSrc)
					Wait(100)
					SetPedShootsAtCoord(PlayerPedId(), 0.0, 0.0, 0.0, 0)
				end
			elseif takeHostage.type == "hostage" then 
				DisableControlAction(0,21,true) -- disable sprint
				DisableControlAction(0,24,true) -- disable attack
				DisableControlAction(0,25,true) -- disable aim
				DisableControlAction(0,47,true) -- disable weapon
				DisableControlAction(0,58,true) -- disable weapon
				DisableControlAction(0,263,true) -- disable melee
				DisableControlAction(0,264,true) -- disable melee
				DisableControlAction(0,257,true) -- disable melee
				DisableControlAction(0,140,true) -- disable melee
				DisableControlAction(0,141,true) -- disable melee
				DisableControlAction(0,142,true) -- disable melee
				DisableControlAction(0,143,true) -- disable melee
				DisableControlAction(0,75,true) -- disable exit vehicle
				DisableControlAction(27,75,true) -- disable exit vehicle  
				DisableControlAction(0,22,true) -- disable jump
				DisableControlAction(0,32,true) -- disable move up
				DisableControlAction(0,268,true)
				DisableControlAction(0,33,true) -- disable move down
				DisableControlAction(0,269,true)
				DisableControlAction(0,34,true) -- disable move left
				DisableControlAction(0,270,true)
				DisableControlAction(0,35,true) -- disable move right
				DisableControlAction(0,271,true)
			end
		end
		Wait(sleepThread)
	end
end)