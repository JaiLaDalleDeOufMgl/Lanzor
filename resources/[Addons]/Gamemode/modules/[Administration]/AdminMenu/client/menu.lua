Menu = {
    GamerTags = {},
    PlayerSelected = nil,
    PlayerInventory = nil,
    PlayerAccounts = nil,
    PlayersWeapons = nil,
    ReportSelected = nil,
    List = {
        ClearZoneIndex = 1,
        ClearZoneItem = {Name = "10", Value = 10},
        TimeZoneIndex = 1,

        AppreciationIndex = 1,
        Item = {Name = "⭐️", Value = 1},

        GiveMoneyIndex = 1,
        GiveMoneyItem = {Name = "Liquide", Value = "money"},
    },
    ListStaff = {},
    ItemList = {},

    Type = {
        { Name = "Voiture", Value = "car"},
        { Name = "Avion", Value = "aircraft" },
        { Name = "Bateau", Value = "boat" }
    }
}
local TERRITOIRES = {}
local WeaponGive = {
    action = {
        'Pistolet',
        'Pistolet 50',
        'Pistolet Lourd',
        'Pistolet Vintage',
        'Pistolet Détresse',
        'Revolver',
        'Double Action',
        'Micro SMG',
        'SMG',
        'SMG d\'assault',
        'ADP de combat',
        'Machine Pistol',
        --'Mini SMG',
        'Pompe',
        'Carabine',
    },
    list = 1
}
local PedsChanges = {
    action = {
        'Mon personnage',
        'Dealer',
        'Singe',
        'Tonton',
        "DOA",
        "Caleb",
        "LSPD",
        "ARMY 1",
        "Army 2",
        "Benny's",
        "Pompier",
        "EMS",
    },
    list = 1
}
local AdminMenu = {
    VehiclesList = {
        "panto",
        "sanchez",
    },
    VehiclesListIndex = 1,
    StaffListIndex = 1,
}
local filterArray = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" }
local filter = 1
local alphaFilter = false
local zoneFilter = false
PlayerInSpec = false
local selectedColor = 1
local cVarLongC = { exports.Tree:serveurConfig().Serveur.color.."", ""}
local cVar1, cVar2 = exports.Tree:serveurConfig().Serveur.color.."", ""
local function cVarLong()
    return cVarLongC[selectedColor]
end

function SizeOfReport()
    local count = 0
    for k,v in pairs(sAdmin.ReportList) do 
        count = count + 1
    end
    return count
end

function ReportEnCours()
    local count = 0
    for k,v in pairs(sAdmin.ReportList) do 
        if v.Taken then 
            count = count + 1
        end
    end
    return count
end

local function MoyenneAppreciation(t)
    local a, b = 0, 0
    for k,v in pairs(t) do 
        a = a + 1
        b = b + v
    end
    return a > 0 and ESX.Math.Round(b/a, 2).."/5" or "0"
end

function KeyboardInputAdmin(TextEntry, ExampleText, MaxStringLength)

	AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end

local function CheckStateOfStaff(license)
    for k,v in pairs(sAdmin.AdminList) do 
        if v.license == license then 
            return "~g~En ligne"
        end
    end
    return exports.Tree:serveurConfig().Serveur.color.."Hors ligne"
end

function defineorNot(str) 
    if str == nil then
        return exports.Tree:serveurConfig().Serveur.color.."Non Défini"
    else
        return "~g~Défini"
    end
end

RegisterNetEvent("dclearw")
AddEventHandler("dclearw", function(id)
   ExecuteCommand("clearloadout "..id)
end)

local string1 = nil
local string2 = nil
local select_type = "car"
local INDEXFDP = 1


local objectsAdmin = {}
local dataStaffList = {}

-- RegisterNetEvent("sAdmin:StaffState")
-- AddEventHandler("sAdmin:StaffState", function(isStaff, data)
--     isStaffMode = isStaff
--     serverInteraction = false
--     DecorSetBool(PlayerPedId(), "isStaffMode", isStaffMode)
--     if isStaffMode then
--         Citizen.CreateThread(function()
--             while isStaffMode do
--                 RageUI.staffModeDesc("Administration Gamemode", {
--                     0, 0, 0
--                 }, {
--                     {""..SizeOfPlayersList().." Joueurs"},
--                     {""..MoyenneAppreciation(sAdmin.AdminList[GetPlayerServerId(PlayerId())].appreciation).." D\'appreciation"},
--                     {""..sAdmin.AdminList[GetPlayerServerId(PlayerId())].reportEffectued.." report(s) traité(s)~s~".." ("..SizeOfReport().." en attente)"},
--                 })
--                 Wait(1)
--             end
--         end)
--     end
-- end)

local function starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

local playerCount = 0
RegisterNetEvent('cl:adminMenu.getPlayerCount', function(count)
    playerCount = count
end)

local dataStaffList = {}


local function OpenMenu(data)
    if ESX.GetPlayerData()['group'] == "user" and ESX.GetPlayerData()['group'] == nil then
        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Vous n'avez pas accès à ce menu.")
        return
    end
    if sAdmin.Config.Debug then 
        sAdmin.Debug("Ouverture du menu")
    end
    local menu = RageUI.CreateMenu("", "Interaction disponible")
    local persoMenu = RageUI.CreateSubMenu(menu, "", "Interaction personnel")
    local PropsList = RageUI.CreateSubMenu(persoMenu, "", "Remove Props")
    local vehMenu = RageUI.CreateSubMenu(menu, "", "Interaction véhicule")
    local joueurMenu = RageUI.CreateSubMenu(menu, "", "Interaction joueurs")
    local joueurActionMenu = RageUI.CreateSubMenu(joueurMenu, "", "Actions sur le joueur")
    local cardinal = RageUI.CreateSubMenu(menu, "", "Interaction serveur")
    local cardinalListStaff = RageUI.CreateSubMenu(cardinal, "", "Liste des staffs")
    local resetTerritoires = RageUI.CreateSubMenu(cardinal, "", "Reset un territoire")
    local inventoryMenu = RageUI.CreateSubMenu(joueurActionMenu, "", "Inventaire du joueur")
    local reportMenu = RageUI.CreateSubMenu(menu, "", "Liste des reports")
    local reportInfoMenu = RageUI.CreateSubMenu(reportMenu, "", "Informations du report")
    local staffList = RageUI.CreateSubMenu(menu, "", "Liste des staffs")
    local staffAction = RageUI.CreateSubMenu(staffList, "", "Actions sur ce staff")
    local itemListe = RageUI.CreateSubMenu(joueurActionMenu, "", "Liste des items")
    local itemListeMe = RageUI.CreateSubMenu(joueurActionMenu, "", "Liste des items")
    
    RageUI.Visible(menu, not RageUI.Visible(menu))
    
    Citizen.CreateThread(function()
        while menu do
            Wait(800)
            if cVar1 == "" then
                cVar1 = exports.Tree:serveurConfig().Serveur.color..""
            else
                cVar1 = ""
            end
            if cVar2 == exports.Tree:serveurConfig().Serveur.color.."" then
                cVar2 = ""
            else
                cVar2 = ""
            end
        end
    end)

    Citizen.CreateThread(function()
        while menu do
            Wait(250)
            selectedColor = selectedColor + 1
            if selectedColor > #cVarLongC then
                selectedColor = 1
            end
        end
    end)

    while menu do
        Wait(0)
        RageUI.IsVisible(menu, function()
            if data.inService then 
                state = "~g~Actif"
            else 
                state = exports.Tree:serveurConfig().Serveur.color.."Inactif"
            end
            RageUI.Checkbox("Mode Staff", nil, data.inService, {}, {
                onChecked = function()
                    data.inService = true
                    sAdmin.inService = true
                    TriggerServerEvent("sAdmin:ChangeState", true, data)

                    exports[exports.Tree:serveurConfig().Serveur.hudScript]:onSetStaffBoardVisibility(true)
                end,
                onUnChecked = function()
                    data.inService = false
                    sAdmin.inService = false
                    TriggerServerEvent("sAdmin:ChangeState", false, data)

                    exports[exports.Tree:serveurConfig().Serveur.hudScript]:onSetStaffBoardVisibility(false)

                    if inNoclip then
                        inNoclip = false
                        CreateThread(function()
                            ToogleNoClip()
                        end)
                    end
                    if showName then 
                        showName = false
                        showNames(showName)
                    end
                    if showBlips then 
                        showBlips = false
                        showBlipsF(showBlips)
                    end
                    if inInvisible then 
                        inInvisible = false
                        SetEntityInvincible(PlayerPedId(), false)
                        SetEntityVisible(PlayerPedId(), true, false)
                    end
                end,
            })
            RageUI.Separator(" ~s~Joueurs : "..exports.Tree:serveurConfig().Serveur.color..playerCount.." ~s~| Report en cours : "..exports.Tree:serveurConfig().Serveur.color..SizeOfReport())
            
            RageUI.Separator(" ~s~Police : "..exports.Tree:serveurConfig().Serveur.color..sAdmin.ServiceCountList.LSPD.." ~s~| EMS : "..exports.Tree:serveurConfig().Serveur.color..sAdmin.ServiceCountList.EMS)

            RageUI.Separator("↓ Actions Disponible ↓")
            RageUI.Button("Liste des Reports ["..exports.Tree:serveurConfig().Serveur.color.. SizeOfReport() .. "~s~]", nil, {RightLabel = "→"}, data.inService and sAdmin.Config.Perms.AccesCat["report_menu"][data.grade], {}, reportMenu)
            RageUI.Button("Liste des Joueurs", nil, {RightLabel = "→"}, data.inService and sAdmin.Config.Perms.AccesCat["interaction_players"][data.grade], {}, joueurMenu)
            RageUI.Button("Gestion Véhicules", nil, {RightLabel = "→"}, data.inService and sAdmin.Config.Perms.AccesCat["interaction_vehicle"][data.grade], {}, vehMenu)
            RageUI.Button("Gestion personnel", nil, {RightLabel = "→"}, data.inService and sAdmin.Config.Perms.AccesCat["interaction_perso"][data.grade], {}, persoMenu)
            RageUI.Button("Gestion serveur", nil, {RightLabel = "→"}, data.inService and sAdmin.Config.Perms.AccesCat["interaction_cardinal"][data.grade], {}, cardinal)
            RageUI.Button('Gestion staff', nil, {RightLabel = "→"}, data.inService and sAdmin.Config.Perms.AccesCat["interaction_cardinal"][data.grade], {
                onSelected = function() 
                    ESX.TriggerServerCallback("sAdmin:getStaffList", function(staffList)
                        dataStaffList = staffList
                    end)
                end
            }, cardinalListStaff)

         
        end, function()
        end)

        RageUI.IsVisible(cardinalListStaff, function()
            for k,v in pairs(dataStaffList) do
                RageUI.List(v.name, {"Changer le groupe", "Demote"}, AdminMenu.StaffListIndex, nil, {}, true, {
                    onListChange = function(Index)
                        AdminMenu.StaffListIndex = Index
                    end;
                    onSelected = function(Index)
                        if Index == 1 then
                            local newGrade = sAdmin.KeyboardInput("Nouveau grade ?", 'Nouveau grade ?', '', 7)
                            if newGrade == "" then return end
                            if newGrade == "user" or newGrade == "helpeur" or newGrade == "animateur" or newGrade == "moderateur" or newGrade == "admin" or newGrade == "gerant" or newGrade == "fondateur" then
                                TriggerServerEvent("sAdmin:ChangeGradeStaff", v.license, newGrade)
                            else
                                ESX.ShowNotification("~r~Ce grade n'existe pas !")
                            end
                        elseif Index == 2 then
                            local IsValid = sAdmin.KeyboardInput('Veuillez ecrire (yes ou no)', 'Veuillez ecrire (yes ou no)', '', 7)
                            if IsValid == "yes" then
                                TriggerServerEvent("sAdmin:DemoteStaff", v.license)
                            elseif IsValid == "no" then
                                ESX.ShowNotification("~r~Vous avez annulé l'action !")
                            elseif IsValid == "" then
                                ESX.ShowNotification("~r~Vous avez annulé l'action !")
                            end
                        end
                    end
                })
            end
        end, function()
        end)

        RageUI.IsVisible(reportMenu, function()
            
            RageUI.Separator("Il y'a "..exports.Tree:serveurConfig().Serveur.color..SizeOfReport().." ~s~report(s) dont "..exports.Tree:serveurConfig().Serveur.color..ReportEnCours().." ~s~en cours")
            -- RageUI.Separator("Vous avez effectué "..exports.Tree:serveurConfig().Serveur.color..sAdmin.AdminList[GetPlayerServerId(PlayerId())].reportEffectued .." reports.")

            for k,v in pairs(sAdmin.ReportList) do
                if (v.TakenBy == nil) then v.TakenBy = "Personne" end
                if not v.Taken then
                    RageUI.Button("["..exports.Tree:serveurConfig().Serveur.color..k.."~s~] - "..v.Name, "~s~Raison : "..v.Raison.."\n~s~Heure : "..v.Date, {RightLabel = "["..exports.Tree:serveurConfig().Serveur.color.."EN ATTENTE~s~]"}, true, {
                        onSelected = function()
                            TriggerServerEvent("sAdmin:UpdateReport", k) 
                            Menu.ReportSelected = v
                        end
                    }, reportInfoMenu)
                else 
                    RageUI.Button("["..exports.Tree:serveurConfig().Serveur.color..k.."~s~] - "..v.Name, "~s~Raison : "..v.Raison.."\n~s~Heure : "..v.Date.."\n~s~Report pris par : "..v.TakenBy, {RightLabel = "[~g~EN COURS~s~]"}, true, {
                        onSelected = function()
                            Menu.ReportSelected = v
                        end
                    }, reportInfoMenu)
                end
            end
         
        end, function()
        end)

        RageUI.IsVisible(reportInfoMenu, function()
            
            while Menu.ReportSelected == nil do Wait(1) end
 
            RageUI.Button("Nom du joueur :", nil, {RightLabel = exports.Tree:serveurConfig().Serveur.color..""..Menu.ReportSelected.Name}, true, {})
            RageUI.Button("Raison du report :",nil , {RightLabel = exports.Tree:serveurConfig().Serveur.color..""..Menu.ReportSelected.Raison}, true, {})
            RageUI.Button("Heure du report :", nil, {RightLabel = exports.Tree:serveurConfig().Serveur.color..""..Menu.ReportSelected.Date}, true, {})
            RageUI.Button("Report pris par :", nil, {RightLabel = exports.Tree:serveurConfig().Serveur.color..""..Menu.ReportSelected.TakenBy}, true, {})
            RageUI.Button("Gestion du Joueur", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    Menu.PlayerSelected = {ped = GetPlayerPed(Menu.ReportSelected.Source), id = Menu.ReportSelected.Source}
                end
            }, joueurActionMenu)
            RageUI.Button("Cloturer ce report", nil, {RightLabel = "→"}, true, {
                onSelected = function()
                    local closeOrNo = sAdmin.KeyboardInput('~g~y ~s~/ ~g~n~s~ :', '~g~y ~s~/ ~g~n~s~', '', 100)
                    if closeOrNo == "y" then
                        TriggerServerEvent("sAdmin:ClotureReport", Menu.ReportSelected.Source)
                        RageUI.GoBack()
                    else
                        ESX.ShowNotification("~g~y ~s~/ ~g~n~s~")
                    end
                end
            })
         
        end, function()
        end)
            

        RageUI.IsVisible(persoMenu, function()
            if sAdmin.Config.Perms.Buttons["cat_persoMenu"]["noclip"][data.grade] then
                RageUI.Checkbox('Mode noclip', nil, inNoclip, {}, {
                    onChecked = function()
                        inNoclip = true
                        ESX.ShowNotification("~g~Administration\nMode noclip activé")

                        CreateThread(function()
                            ToogleNoClip()
                        end)
                    end,
                    onUnChecked = function()
                        inNoclip = false
                        ESX.ShowNotification("~g~Administration\nMode noclip désactivé")

                        CreateThread(function()
                            ToogleNoClip()
                        end)
                    end,
                })
            end
            if sAdmin.Config.Perms.Buttons["cat_persoMenu"]["invisibleMonde"][data.grade] then 
                RageUI.Checkbox('Mode invisible', nil, inInvisible, {}, {
                    onChecked = function()
                        inInvisible = true
                        SetEntityInvincible(PlayerPedId(), true)
                        SetEntityVisible(PlayerPedId(), false, false)
                        SetEntityNoCollisionEntity(PlayerPedId(), entity2, false)
                        ESX.ShowNotification("~g~Administration\nMode invisible activé")
                    end,
                    onUnChecked = function()
                        inInvisible = false
                        SetEntityInvincible(PlayerPedId(), false)
                        SetEntityVisible(PlayerPedId(), true, false)
                        ESX.ShowNotification("~g~Administration\nMode invisible désactivé")
                    end,
                })
            end
            if sAdmin.Config.Perms.Buttons["cat_persoMenu"]["show_gamertags"][data.grade] then
                RageUI.Checkbox('Affichez les noms', nil, showName, {}, {
                    onChecked = function()
                        showName = true
                        ESX.ShowNotification("~g~Administration\nVous avez affiché les noms")
                        showNames(showName)
                    end,
                    onUnChecked = function()
                        showName = false
                        ESX.ShowNotification("~g~Administration\nVous avez masqué les noms")
                        showNames(showName)
                    end,
                })
            end
            if sAdmin.Config.Perms.Buttons["cat_persoMenu"]["show_gamertags"][data.grade] then
                RageUI.Checkbox('Affichez les blips', nil, showBlips, {}, {
                    onChecked = function()
                        showBlips = true
                        ESX.ShowNotification("~g~Administration\nVous avez affiché les blips")
                        showBlipsF(showBlips)
                    end,
                    onUnChecked = function()
                        showBlips = false
                        ESX.ShowNotification("~g~Administration\nVous avez masqué les blips")
                        showBlipsF(showBlips)
                    end,
                })
            end
            RageUI.Button('Se téléporter sur marqueur', nil, {RightLabel = "→"}, sAdmin.Config.Perms.Buttons["cat_persoMenu"]["teleport_waypoint"][data.grade], {
                onSelected = function() 
                    local pPed = PlayerPedId()
                    local WaypointHandle = GetFirstBlipInfoId(8)
                    if DoesBlipExist(WaypointHandle) then
                        local coord = Citizen.InvokeNative(0xFA7C7F0AADF25D09, WaypointHandle, Citizen.ResultAsVector())
                        SetEntityCoordsNoOffset(pPed, coord.x, coord.y, -199.5, false, false, false, true)
                        ESX.ShowNotification("~g~Administration\nTéléporté au marqueur avec succés")
                    else
                        ESX.ShowNotification("~g~Administration\nIl n'y a pas de marqueur sur ta map")
                    end
                end
            })

            RageUI.Button('Revive le joueur à proximité', nil, {RightLabel = "→"}, sAdmin.Config.Perms.Buttons["cat_persoMenu"]["teleport_waypoint"][data.grade], {
                onSelected = function() 
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance ~= -1 and distance <= 3.0 then
                        ExecuteCommand("revive "..GetPlayerServerId(player))
                    else
                        ESX.ShowNotification("~r~Aucun joueur à revive à proximité !")
                    end
                end
            })


            
            RageUI.Separator("↓ Props ↓")
            RageUI.Button("Spawn un props", nil, {RightLabel = "→"}, sAdmin.Config.Perms.Buttons["cat_persoMenu"]["spawn_props"][data.grade], {
                onSelected = function()
                   RageUI.CloseAll()
                   TriggerEvent('spawnprops')
                end
            })
            RageUI.Button("Suprimer un props", nil, {RightLabel = "→"}, sAdmin.Config.Perms.Buttons["cat_persoMenu"]["spawn_props"][data.grade], {
                onSelected = function()
                    ESX.TriggerServerCallback('GetAllPropsAdmin', function(objects)
                        objectsAdmin = objects
                    end)
                end
            }, PropsList)

            
            RageUI.Separator("↓ Peds Mec ↓")

            if sAdmin.Config.Perms.Buttons["cat_cardinalActions"]["peds"][data.grade] then
                RageUI.Button("Reset peds", nil, {RightLabel = "→"}, sAdmin.Config.Perms.Buttons["cat_cardinalActions"]["peds"][data.grade], {
                    onSelected = function()
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                            local isMale = skin.sex == 0
                            TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                                TriggerEvent('skinchanger:loadSkin', skin, function()
                                    TriggerEvent('esx:restoreLoadout');
                                end);
                            end)
                        end)
                    end
                })

                RageUI.Button("Peds", nil, {RightLabel = "→"}, sAdmin.Config.Perms.Buttons["cat_cardinalActions"]["peds"][data.grade], {
                    onSelected = function()
                        local PedName = sAdmin.KeyboardInput('Name peds :', '', '', 100)

                        if (PedName == "" or PedName == nil) then
                            ESX.ShowNotification("~r~Nom invalide")
                            return
                        end

                        ESX.Streaming.RequestModel(PedName, function()
                            SetPlayerModel(PlayerId(), PedName)
                            SetModelAsNoLongerNeeded(PedName)
                            TriggerEvent('esx:restoreLoadout');
                        end)
                    end
                })
            end
        end, function()
        end)

        RageUI.IsVisible(PropsList, function()
            for k, netId in pairs(objectsAdmin) do

                local Entity = NetworkGetNetworkIdFromEntity(netId)
                local ObjectCoords = GetEntityCoords(Entity)
                local PlyCoords = GetEntityCoords(PlayerPedId())
                local Dist = #(PlyCoords - ObjectCoords)

                -- SetEntityDrawOutline(Entity, false)

                if (Dist < 10.0) then
                    RageUI.Button("Object N°"..netId, nil, {RightLabel = "→"}, sAdmin.Config.Perms.Buttons["cat_persoMenu"]["spawn_props"][data.grade], {
                        onActive = function()

                            -- SetEntityDrawOutline(Entity, true)
                            -- SetEntityDrawOutlineColor(255,0,0,255)

                            DrawMarker(2, ObjectCoords.x, ObjectCoords.y, ObjectCoords.z + 3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 170, 1, 0, 2, 1, nil, nil, 0)
                        end,
                        
                        onSelected = function()
                            TriggerEvent('RemoveProps', netId)
                        end
                    })
                end
            end
        end, function()
        end)

        RageUI.IsVisible(vehMenu, function()

            local pPed = PlayerPedId()
		    local plyCoords = GetEntityCoords(pPed)
            RageUI.Separator("↓ Apparition ↓")
            RageUI.List("Spawn un véhicule", AdminMenu.VehiclesList, AdminMenu.VehiclesListIndex, nil, {}, true, {
                onListChange = function(Index)
                    AdminMenu.VehiclesListIndex = Index
                end;
                onSelected = function(Index)
                    if Index == 1 then
                        TriggerServerEvent("sAdmin:spawnVehicle", 'panto', plyCoords)
                    elseif Index == 2 then
                        TriggerServerEvent("sAdmin:spawnVehicle", 'sanchez', plyCoords)
                        
                    end
                end
            })
            RageUI.Separator("↓ Gestion ↓")
            RageUI.Button("Réparer le véhicule", nil, { RightLabel = "→→" }, sAdmin.Config.Perms.Buttons["cat_vehMenu"]["repairVehicle"][data.grade], {
                onActive = function()
                    -- sAdmin.ClosetVehWithDisplay()
                end;
                onSelected = function()
                    local veh = GetClosestVehicleAdmin(GetEntityCoords(PlayerPedId()), nil)
                    NetworkRequestControlOfEntity(veh)
                    while not NetworkHasControlOfEntity(veh) do
                        Wait(1)
                    end
                    SetVehicleFixed(veh)
                    SetVehicleDeformationFixed(veh)
                    SetVehicleDirtLevel(veh, 0.0)
                    SetVehicleEngineHealth(veh, 1000.0)
                    ESX.ShowNotification("~g~Véhicule réparé")
                end
            })
            RageUI.Button("Supprimer le véhicule", nil, { RightLabel = "→→" }, sAdmin.Config.Perms.Buttons["cat_vehMenu"]["clearVehicle"][data.grade], {
                onActive = function()
                    -- sAdmin.ClosetVehWithDisplay()
                end;
                onSelected = function()
                    Citizen.CreateThread(function()
                        local veh = GetClosestVehicleAdmin(GetEntityCoords(PlayerPedId()), nil)
                        NetworkRequestControlOfEntity(veh)
                        while not NetworkHasControlOfEntity(veh) do
                            Wait(1)
                        end
                        DeleteEntity(veh)
                        ESX.ShowNotification("~g~Véhicule supprimé")
                    end)
                end
            })
            RageUI.Button("Faire le plein d'essence", nil, { RightLabel = "→→" }, true, {
                onSelected = function()
                    local player = PlayerPedId()
                    local veh = GetVehiclePedIsIn(player)

                    if veh ~= 0 then
                        exports[exports.Tree:serveurConfig().Serveur.hudScript]:SetFuel(veh, 100)
                    else
                        ESX.ShowNotification("Vous devez être dans un véhicule")
                    end   
                end
            })
            RageUI.Button("Upgrade le véhicule au max", nil, { RightLabel = "→→" }, sAdmin.Config.Perms.Buttons["cat_vehMenu"]["upgradeVehicules"][data.grade], {
                onActive = function()
                    -- sAdmin.ClosetVehWithDisplay()
                end;
                onSelected = function()
                    local veh = GetClosestVehicleAdmin(GetEntityCoords(PlayerPedId()), nil)
                    NetworkRequestControlOfEntity(veh)
                    while not NetworkHasControlOfEntity(veh) do
                        Wait(1)
                    end
                    ESX.Game.SetVehicleProperties(veh, {
                        modEngine = 5,
                        modBrakes = 4,
                        modTransmission = 4,
                        modSuspension = 3,
                        windowTint = 2,
                        modXenon = true,
                        modTurbo = true
                    })
                    ESX.ShowNotification("~g~Les performances du véhicule ont été upgrade avec succès.")
                end
            })
            
        end, function()
        end)

        RageUI.IsVisible(joueurMenu, function()

            RageUI.Checkbox("Filtre alphabétique", nil, alphaFilter, {}, {
                onChecked = function()
                    alphaFilter = true
                end;
                onUnChecked = function()
                    alphaFilter = false
                end
            })

            RageUI.Checkbox("Restreindre à ma zone", nil, zoneFilter, {}, {
                onChecked = function()
                    zoneFilter = true
                end;
                onUnChecked = function()
                    zoneFilter = false
                end
            })

            if alphaFilter then
                RageUI.List("Filtre:", filterArray, filter, nil, {}, true, {
                    onListChange = function(Index)
                        filter = Index
                    end
                })
            end

            RageUI.Separator("↓ Joueurs ↓")

            if not zoneFilter then 
                for k,v in pairs(sAdmin.PlayersList) do 
                    if v.name ~= nil then
                        if alphaFilter then
                            if starts(v.name:lower(), filterArray[filter]:lower()) then
                                local group = ""
                                if v.group ~= "user" then 
                                    group = " "..exports.Tree:serveurConfig().Serveur.color.."[STAFF]~s~ "
                                else
                                    group = " "
                                end
                                if group ~= nil then
                                    RageUI.Button("["..k.."]".. group .. v.name, "~s~Heure de connexion : "..v.hoursLogin, {RightLabel = "→"}, true, {
                                        onActive = function()
                                            sAdmin.PlayerMakrer(GetPlayerPed(k))
                                        end,
                                        onSelected = function()
                                            Menu.PlayerSelected = {ped = GetPlayerPed(k), id = k}
                                        end
                                    }, joueurActionMenu)
                                    
                                end
                            end
                        else
                            local group = ""
                            if v.group ~= "user" then 
                                group = " "..exports.Tree:serveurConfig().Serveur.color.."[STAFF]~s~ "
                            else
                                group = " "
                            end
                            RageUI.Button("["..k.."]".. group .. v.name, "~s~Heure de connexion : "..v.hoursLogin, {RightLabel = "→"}, true, {
                                onActive = function()
                                    sAdmin.PlayerMakrer(GetPlayerPed(k))
                                end,
                                onSelected = function()
                                    Menu.PlayerSelected = {ped = GetPlayerPed(k), id = k}
                                end
                            }, joueurActionMenu)
                        end
                    end
                end
            else
                for _,player in pairs(GetActivePlayers()) do 
                    local sID = GetPlayerServerId(player)
                    local name = GetPlayerName(player)
                    if name ~= nil then
                        if alphaFilter then
                            if starts(name:lower(), filterArray[filter]:lower()) then
                                RageUI.Button("["..sID.."] "..name, nil, {RightLabel = "→"}, true, {
                                    onActive = function()
                                        sAdmin.PlayerMakrer(GetPlayerPed(sID))
                                    end,
                                    onSelected = function()
                                        Menu.PlayerSelected = {ped = GetPlayerPed(sID), id = sID}
                                    end
                                }, joueurActionMenu)
                            end
                        else
                            RageUI.Button("["..sID.."] "..name, nil, {RightLabel = "→"}, true, {
                                onActive = function()
                                    sAdmin.PlayerMakrer(GetPlayerPed(sID))
                                end,
                                onSelected = function()
                                    Menu.PlayerSelected = {ped = GetPlayerPed(sID), id = sID}
                                end
                            }, joueurActionMenu)
                        end
                    end
                end
            end
        end, function()
        end)
        

        RageUI.IsVisible(joueurActionMenu, function()
            
            RageUI.Separator("↓ Téléportation ↓")
            RageUI.Button("Goto", nil, {RightLabel = "→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["goto"][data.grade], {
                onSelected = function()
                    TriggerServerEvent("sAdmin:Goto", Menu.PlayerSelected.id)
                end
            })
            RageUI.Button("Bring", nil, {RightLabel = "→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["bring"][data.grade], {
                onSelected = function()
                    TriggerServerEvent("sAdmin:Bring", Menu.PlayerSelected.id)
                end
            })            
            RageUI.Button("Bring Back", "Cela va permettre de remettre le joueur à sa position précédente", {RightLabel = "→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["bring"][data.grade], {
                onSelected = function()
                    TriggerServerEvent("sAdmin:BringBack", Menu.PlayerSelected.id)
                end
            })
            RageUI.Button("Bring au PC", nil, {RightLabel = "→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["tpparkingcentral"][data.grade], {
               onSelected = function()
                   TriggerServerEvent("sAdmin:TpParking", Menu.PlayerSelected.id)
               end
            })
            RageUI.Separator("↓ Sanction ↓")
            RageUI.Button("Freeze le joueur", nil, {RightLabel = "→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["freeze"][data.grade], {
                onSelected = function()
                    TriggerServerEvent("sAdmin:Freeze", Menu.PlayerSelected.id)
                end
            })
            RageUI.Button("Kick le joueur", nil, {RightLabel = "→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["kick"][data.grade], {
                onSelected = function()
                    local reason = sAdmin.KeyboardInput('Raison :', 'Raison :', '', 100)
                    if reason then
                        TriggerServerEvent("sAdmin:Kick", Menu.PlayerSelected.id, tostring(reason))
                        RageUI.CloseAll()
                    else 
                        ESX.ShowNotification("~g~Administration\nMessage invalide")
                    end
                end
                
            })
            RageUI.Button("Spectate le joueur", nil, {RightLabel = "→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["spec"][data.grade], {
                onSelected = function()
                    if Menu.PlayerSelected.id == PlayerPedId() then 
                        ESX.ShowNotification("Tu peux pas te spec toi même !")
                    else
                        Admin:StartSpectate({
                            id = Menu.PlayerSelected.id,
                            ped = GetPlayerPed(GetPlayerFromServerId(Menu.PlayerSelected.id))
                        })
                    end
                end
            })

            RageUI.Separator("↓ Autre ↓")
            RageUI.Button("Envoyer un message", nil, {RightLabel = "→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["sendMess"][data.grade], {
                onSelected = function()
                    local message = sAdmin.KeyboardInput('Message :', 'Message :', '', 100)
                    if message then
                        TriggerServerEvent("sAdmin:SendMessageGros", Menu.PlayerSelected.id, tostring(message))
                    else 
                        ESX.ShowNotification("~g~Administration\nMessage invalide")
                    end
                end
            })
            RageUI.Button("Réanimer le joueur", nil, {RightLabel = "→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["revive"][data.grade], {
                onSelected = function()
                    ExecuteCommand("revive "..Menu.PlayerSelected.id)
                end
            })
            RageUI.Button("Voir l'inventaire", nil, {RightLabel = "→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["showInventory"][data.grade], {
                onSelected = function()
                    TriggerServerEvent("Gamemode:Inventory:OpenSecondInventory", "fplayerStaff", Menu.PlayerSelected.id)
                end
            })

            RageUI.Separator("↓ Remboursement ↓")
            RageUI.Button("Clear Loadout (Armes)", exports.Tree:serveurConfig().Serveur.color.."ATTENTION~s~ cette option supprime toutes les armes du joueur ! (sauf armes perms)", {RightLabel = "→"}, sAdmin.Config.Perms.Buttons["cat_cardinalActions"]["clearloadout"][data.grade], {
                onSelected = function()
                    TriggerServerEvent("dclearloadout", Menu.PlayerSelected.id)
                   RageUI.CloseAll()
                end
            }, inventoryMenu)
            if sAdmin.Config.Perms.Buttons["cat_playersActions"]["giveMoney"][data.grade] then
                RageUI.List('Give de l\'argent', {
                    { Name = "Liquide", Value = "cash" },   
                    { Name = "Banque", Value = "bank" },
                    { Name = "Argent sale", Value = "dirtycash" }
                }, Menu.List.GiveMoneyIndex, nil, {}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["giveMoney"][data.grade], {
                    onListChange = function(Index, Item)
                        Menu.List.GiveMoneyIndex = Index;
                        Menu.List.GiveMoneyItem = Item
                    end,
                    onSelected = function()
                        local amount = sAdmin.KeyboardInput('Montant', 'Montant', '', 5)
                        if amount then
                            TriggerServerEvent("sAdmin:GiveMoney", Menu.PlayerSelected.id, Menu.List.GiveMoneyItem.Value, tonumber(amount))
                        else
                            ESX.ShowNotification("Le montant est incorrect")
                        end
                    end
                })
            end
            RageUI.Button("Give un item", nil, {RightLabel = "→"}, sAdmin.Config.Perms.Buttons["cat_playersActions"]["giveItem"][data.grade], {
                onSelected = function()
                    TriggerServerEvent("sAdmin:GetItemList")
                end
            }, itemListe)
        end, function()
        end)

        RageUI.IsVisible(resetTerritoires, function()
            if next(TERRITOIRES) ~= nil then
                for line, terr in pairs(TERRITOIRES) do
                    RageUI.Button(line .. " - Leader : "..((terr.id_crew_owner ~= nil and "~b~"..string.upper(terr.id_crew_owner)) or exports.Tree:serveurConfig().Serveur.color.."AUCUN"), "", {RightLabel = "→"}, sAdmin.Config.Perms.Buttons["cat_cardinalActions"]["clearloadout"][data.grade], {
                        onSelected = function()
                            local message = KeyboardInputAdmin("Etes-vous sûr ? (Ecrivez : oui OU non)", "", 30)
                            if string.lower(message) == "oui" then
                                ESX.TriggerServerCallback('Territories:WipeTerritoire', function(cb)
                                    if cb then
                                        ESX.ShowNotification("~g~Information\n~s~Reset effectué avec succès.")
                                        RageUI.GoBack()
                                    else
                                        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Information\n~s~Erreur. Contacte Piwel.")
                                    end
                                end, line)
                            else
                                RageUI.GoBack()
                            end
                           RageUI.CloseAll()
                        end
                    }, inventoryMenu)
                end
            else
                RageUI.GoBack()
            end
        end)

        RageUI.IsVisible(cardinal, function()

            RageUI.Separator("↓ Autre ↓")

            RageUI.Button("~s~Reset les report", nil, {RightLabel = "🧹"}, sAdmin.Config.Perms.Buttons["cat_cardinalActions"]["clearloadout"][data.grade], {
                onSelected = function()
                    local message = KeyboardInputAdmin("Mdp ?", "", 30)
                    if message == "babyboy" then
                        TriggerServerEvent("tF:resetReport")    
                        ESX.ShowNotification("~g~Information\n~s~Reset report effectuer avec succès !")
                    else
                        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Erreur !\n~s~Format invalide !")
                    end
                end
            })

            RageUI.Button("~s~Reset un territoire", nil, {RightLabel = "🧹"}, sAdmin.Config.Perms.Buttons["cat_cardinalActions"]["clearloadout"][data.grade], {
                onSelected = function()
                    local message = KeyboardInputAdmin("Mdp ?", "", 30)
                    if message == "lanzorpiwel" then
                        ESX.TriggerServerCallback('Piwel_Territoires:GetAllTerritoires', function(cb)
                            TERRITOIRES = cb
                            RageUI.Visible(resetTerritoires, not RageUI.Visible(resetTerritoires))
                        end)
                    else
                        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Erreur !\n~s~Format invalide !")
                    end
                end
            })
            
            RageUI.Button("Give un véhicule", nil, {RightLabel = "→"}, sAdmin.Config.Perms.Buttons["cat_cardinalActions"]["giveVehicle"][data.grade], {
                onSelected = function()
                    local id = sAdmin.KeyboardInput('ID du joueur', 'ID du joueur', '', 100)
                    if not tonumber(id) then
                        ESX.ShowNotification("ID incorrect")
                        return
                    end
                    local model = sAdmin.KeyboardInput("Nom du vehicule ?", 'Nom du vehicule ?', "", 20)
                    local vehicletype = sAdmin.KeyboardInput('Type du vehicule ? (boat,car,plane)', 'Type du vehicule ? (boat,car,plane)', '', 100)
                    if vehicletype ~= "car" and vehicletype ~= "plane" and vehicletype ~= "boat" then
                        ESX.ShowNotification("Type de véhicule incorrect")
                        return
                    end
                    local boutiquetype = sAdmin.KeyboardInput('0=non boutique 1=boutique', '0=non boutique 1=boutique', '', 100)
                    if not tonumber(boutiquetype) then
                        if boutiquetype > 1 then
                            ESX.ShowNotification("Indiquer un numéro entre 0-1")
                            return
                        end
                    end
                    local vehicleGive = {}
                    
                    TriggerServerEvent('sAdmin:giveVehicle', id, model, vehicletype, boutiquetype)
                end
            })
            RageUI.Separator("↓ Création ↓")

            RageUI.Button("Crée un gang", nil, {RightLabel = "→"}, sAdmin.Config.Perms.Buttons["cat_cardinalActions"]["clearloadout"][data.grade], {
                onSelected = function()
                   RageUI.CloseAll()
                   ExecuteCommand("sgangbuilder")
                   ESX.ShowNotification("Merci de prévenir master a la fin de la création !")
                end
            })

            RageUI.Button("Crée un job", nil, {RightLabel = "→"}, sAdmin.Config.Perms.Buttons["cat_cardinalActions"]["clearloadout"][data.grade], {
                onSelected = function()
                   RageUI.CloseAll()
                   ExecuteCommand("createjob")
                   ESX.ShowNotification("Merci de prévenir master a la fin de la création !")
                end
            })

            RageUI.Button("Crée un event", nil, {RightLabel = "→"}, sAdmin.Config.Perms.Buttons["cat_cardinalActions"]["clearloadout"][data.grade], {
                onSelected = function()
                   RageUI.CloseAll()
                   ExecuteCommand("event")
                end
            })
            RageUI.Button("Crée une drogue", nil, {RightLabel = "→"}, sAdmin.Config.Perms.Buttons["cat_cardinalActions"]["clearloadout"][data.grade], {
                onSelected = function()
                   RageUI.CloseAll()
                   ExecuteCommand("drugsbuilder")
                end
            })
            
            RageUI.Separator("↓ Peds Mec ↓")
            if sAdmin.Config.Perms.Buttons["cat_cardinalActions"]["peds"][data.grade] then

                

                RageUI.List('Peds', PedsChanges.action, PedsChanges.list, nil, {}, sAdmin.Config.Perms.Buttons["cat_cardinalActions"]["peds"][data.grade], {
                    onListChange = function(Index, Item)
                        PedsChanges.list = Index
                    end,
                    onSelected = function(Index)
                        if Index == 1 then
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                local isMale = skin.sex == 0
                                TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                                    TriggerEvent('skinchanger:loadSkin', skin, function()
                                        TriggerEvent('esx:restoreLoadout');
                                    end);
                                end)
                            end)
                        elseif Index == 2 then
                            ESX.Streaming.RequestModel("ig_claypain", function()
                                SetPlayerModel(PlayerId(), "ig_claypain")
                                SetModelAsNoLongerNeeded("ig_claypain")
                                TriggerEvent('esx:restoreLoadout');
                            end)
                        elseif Index == 3 then
                            ESX.Streaming.RequestModel("u_m_m_streetart_01", function()
                                SetPlayerModel(PlayerId(), "u_m_m_streetart_01")
                                SetModelAsNoLongerNeeded("u_m_m_streetart_01")
                                TriggerEvent('esx:restoreLoadout');
                            end);
                        elseif Index == 4 then
                            ESX.Streaming.RequestModel("a_m_y_downtown_01", function()
                                SetPlayerModel(PlayerId(), "a_m_y_downtown_01")
                                SetModelAsNoLongerNeeded("a_m_y_downtown_01")
                                TriggerEvent('esx:restoreLoadout');
                            end)
                            
                        elseif Index == 5 then
                            ESX.Streaming.RequestModel("s_m_m_ciasec_01", function()
                                SetPlayerModel(PlayerId(), "s_m_m_ciasec_01")
                                SetModelAsNoLongerNeeded("s_m_m_ciasec_01")
                                TriggerEvent('esx:restoreLoadout');
                            end)
                        elseif Index == 6 then
                            ESX.Streaming.RequestModel("csb_g", function()
                                SetPlayerModel(PlayerId(), "csb_g")
                                SetModelAsNoLongerNeeded("csb_g")
                                TriggerEvent('esx:restoreLoadout');
                            end)
                        elseif Index == 7 then
                            ESX.Streaming.RequestModel("s_m_y_cop_01", function()
                                SetPlayerModel(PlayerId(), "s_m_y_cop_01")
                                SetModelAsNoLongerNeeded("s_m_y_cop_01")
                                TriggerEvent('esx:restoreLoadout');
                            end)
                        elseif Index == 8 then
                
                            ESX.Streaming.RequestModel("s_m_y_marine_03", function()
                                SetPlayerModel(PlayerId(), "s_m_y_marine_03")
                                SetModelAsNoLongerNeeded("s_m_y_marine_03")
                                TriggerEvent('esx:restoreLoadout');
                            end)
                        elseif Index == 9 then
                            ESX.Streaming.RequestModel("s_m_y_marine_01", function()
                                SetPlayerModel(PlayerId(), "s_m_y_marine_01")
                                SetModelAsNoLongerNeeded("s_m_y_marine_01")
                                TriggerEvent('esx:restoreLoadout');
                            end)
                        elseif Index == 10 then
                            ESX.Streaming.RequestModel("ig_benny", function()
                                SetPlayerModel(PlayerId(), "ig_benny")
                                SetModelAsNoLongerNeeded("ig_benny")
                                TriggerEvent('esx:restoreLoadout');
                            end)
                        elseif Index == 11 then
                            ESX.Streaming.RequestModel("s_m_y_fireman_01", function()
                                SetPlayerModel(PlayerId(), "s_m_y_fireman_01")
                                SetModelAsNoLongerNeeded("s_m_y_fireman_01")
                                TriggerEvent('esx:restoreLoadout');
                            end)
                        elseif Index == 12 then
                            ESX.Streaming.RequestModel("s_m_y_autopsy_01", function()
                                SetPlayerModel(PlayerId(), "s_m_y_autopsy_01")
                                SetModelAsNoLongerNeeded("s_m_y_autopsy_01")
                                TriggerEvent('esx:restoreLoadout');
                            end)
                        end
                    end
                })
            end

        end, function()
        end)

        RageUI.IsVisible(inventoryMenu, function()
           
            if Menu.PlayerInventory == nil and Menu.PlayerAccounts == nil and Menu.PlayersWeapons == nil then 
                RageUI.Separator("")
                RageUI.Separator(exports.Tree:serveurConfig().Serveur.color.."En attente")
                RageUI.Separator("")
            else 
                RageUI.Line()
                for k,v in pairs(Menu.PlayerAccounts) do
                    RageUI.Button(v.label, nil, {RightLabel = v.money.."$"}, true, {})
                end
                RageUI.Line()
                for k,v in pairs(Menu.PlayerInventory) do 
                    if v.count > 0 then
                        RageUI.Button("x"..v.count.." "..v.label, nil, {}, true, {})
                    end
                end
                RageUI.Line()
                for k,v in pairs(Menu.PlayersWeapons) do 
                    RageUI.Button(v, nil, {}, true, {})
                end
            end

        end, function()
        end)

        RageUI.IsVisible(itemListe, function()
        
            for id, itemInfos in pairs(Menu.ItemList) do
                RageUI.Button(itemInfos.label.." - ~c~"..itemInfos.name, nil, {RightLabel = "→"}, true, {
                    onSelected = function()
                        local amount = sAdmin.KeyboardInput('Montant', 'Montant', '', 10)
                        if amount then
                            TriggerServerEvent("sAdmin:GiveItem", Menu.PlayerSelected.id, itemInfos.name, tonumber(amount))
                        else
                            ESX.ShowNotification("Le montant est incorrect")
                        end
                        RageUI.GoBack()
                    end
                })
            end
         
        end, function()
        end)

        RageUI.IsVisible(itemListeMe, function()
        
            for id, itemInfos in pairs(Menu.ItemList) do
                RageUI.Button(itemInfos.label.." - ~c~"..itemInfos.name, nil, {RightLabel = "→"}, true, {
                    onSelected = function()
                        local amount = sAdmin.KeyboardInput('Montant', 'Montant', '', 10)
                        if amount then
                            TriggerServerEvent("sAdmin:GiveItemMe", itemInfos.name, tonumber(amount))
                            RageUI.CloseAll()
                        else
                            ESX.ShowNotification("Le montant est incorrect")
                        end
                        RageUI.GoBack()
                    end
                })
            end
         
        end, function()
        end)

        if not RageUI.Visible(resetTerritoires) then
            TERRITOIRES = {}
        end

        if not RageUI.Visible(menu) and not RageUI.Visible(persoMenu) and not RageUI.Visible(PropsList) and not RageUI.Visible(vehMenu) and not RageUI.Visible(joueurMenu) 
        and not RageUI.Visible(joueurActionMenu) and not RageUI.Visible(cardinal) and not RageUI.Visible(cardinalListStaff) and not RageUI.Visible(resetTerritoires) and not RageUI.Visible(inventoryMenu) and not RageUI.Visible(reportMenu) 
        and not RageUI.Visible(reportInfoMenu) and not RageUI.Visible(staffList) and not RageUI.Visible(staffAction) and not RageUI.Visible(itemListe) and not RageUI.Visible(itemListeMe) then
            menu = RMenu:DeleteType('menu', true)
            persoMenu = RMenu:DeleteType('persoMenu', true)
            vehMenu = RMenu:DeleteType('vehMenu', true)
            joueurMenu = RMenu:DeleteType('joueurMenu', true)
            joueurActionMenu = RMenu:DeleteType('joueurActionMenu', true)
            cardinal = RMenu:DeleteType('cardinal', true)
            cardinalListStaff = RMenu:DeleteType('cardinalListStaff', true)
            resetTerritoires = RMenu:DeleteType('resetTerritoires', true)
            inventoryMenu = RMenu:DeleteType('inventoryMenu', true)
            reportMenu = RMenu:DeleteType('reportMenu', true)
            reportInfoMenu = RMenu:DeleteType('reportInfoMenu', true)
            staffList = RMenu:DeleteType('staffList', true)
            staffAction = RMenu:DeleteType('staffAction', true)
            itemListe = RMenu:DeleteType('itemListe', true)
            itemListeMe = RMenu:DeleteType('itemListeMe', true)
 
            Menu.PlayerSelected = nil 
            Menu.PlayerInventory = nil
            Menu.PlayerAccounts = nil
            Menu.PlayersWeapons = nil
        end
    end
end

local CanOpenMenu = false
local announcestring = false

RegisterNetEvent('announceForMessage')
AddEventHandler('announceForMessage', function(msg, name)
	announcestring = msg
    thename = name
	PlaySoundFrontend("DELETE","HUD_DEATHMATCH_SOUNDSET", 1)
	Citizen.Wait(5000)
	announcestring = false
end)

function Initialize(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
	PushScaleformMovieFunctionParameterString(exports.Tree:serveurConfig().Serveur.color.."Message Staff ~w~("..thename..")")
    PushScaleformMovieFunctionParameterString(announcestring)
    PopScaleformMovieFunctionVoid()
    return scaleform
end


Citizen.CreateThread(function()
while true do
	Wait(0)
        if announcestring then
            scaleform = Initialize("mp_big_message_freemode")
            DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
        end
    end
end)



RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    ESX.PlayerLoaded = true
end)

AddEventHandler('skinchanger:modelLoaded', function()
	while not ESX.PlayerLoaded do
		Citizen.Wait(1)
	end

	CanOpenMenu = true
end);

RegisterCommand("+adminMenu", function()
    -- if (CanOpenMenu) then
        local pPed = PlayerId()
        local pId = GetPlayerServerId(pPed)
        for k,v in pairs(sAdmin.AdminList) do 
            if k == pId then 
                OpenMenu(v)
                return
            end
        end 
    -- else
    --    ESX.ShowNotification("Veuillez attendre que votre personnage charge correctement...")
    -- end
end, false)

RegisterCommand("tpm", function()
    if ESX.GetPlayerData()['group'] ~= "user"then
        local pPed = PlayerPedId()
        local WaypointHandle = GetFirstBlipInfoId(8)
        if DoesBlipExist(WaypointHandle) then
            local coord = Citizen.InvokeNative(0xFA7C7F0AADF25D09, WaypointHandle, Citizen.ResultAsVector())
            SetEntityCoordsNoOffset(pPed, coord.x, coord.y, -199.5, false, false, false, true)
            ESX.ShowNotification("~g~Administration\nTéléporté au marqueur avec succés")
        else
            ESX.ShowNotification("~g~Administration\nIl n'y a pas de marqueur sur ta map")
        end
    end
end)

RegisterKeyMapping("+adminMenu", "Menu Admin", 'keyboard', sAdmin.Config.KeyOpenMenu)

-- local function OpenAvisMenu(data)
--     if sAdmin.Config.Debug then 
--         sAdmin.Debug("Ouverture du menu")
--     end
--     local menu = RageUI.CreateMenu("", "Interaction disponible")
--     menu.Closable = false;
  
--     RageUI.Visible(menu, not RageUI.Visible(menu))
    
--     while menu do
--         Wait(0)
--         RageUI.IsVisible(menu, function()
            
--             RageUI.Line()
--             RageUI.Separator("Vous allez évaluer le service d'un staff")
--             RageUI.Separator("Vous allez évaluer : "..data.name)
--             RageUI.Separator("Ce staff vous a aidé pour : "..data.reasonReport)
--             RageUI.Line()
--             RageUI.List('Appréciation', {
--                 { Name = "⭐️", Value = 1 }, 
--                 { Name = "⭐️⭐️", Value = 2 },
--                 { Name = "⭐️⭐️⭐️", Value = 3 }, 
--                 { Name = "⭐️⭐️⭐️⭐️", Value = 4 }, 
--                 { Name = "⭐️⭐️⭐️⭐️⭐️", Value = 5 }
--             }, Menu.List.AppreciationIndex, nil, {}, true, {
--                 onListChange = function(Index, Item)
--                     Menu.List.AppreciationIndex = Index;
--                     Menu.List.AppreciationItem = Item
--                 end
--             })
--             RageUI.Button("Envoyer l'appréciation", nil, {RightLabel = "→"}, true, {
--                 onSelected = function()
--                     if data.id ~= nil and Menu.List.AppreciationItem.Value ~= nil then
--                         TriggerServerEvent("sAdmin:AddEvaluation", data.id, Menu.List.AppreciationItem.Value)
--                     end
--                     RageUI.CloseAll()
--                 end 
--             })
--         end, function()
--         end)

--         if not RageUI.Visible(menu) then
--             menu = RMenu:DeleteType('menu', true)
--         end
--     end
-- end

-- RegisterNetEvent("sAdmin:OpenAvisMenu")
-- AddEventHandler("sAdmin:OpenAvisMenu", function(data)
--     OpenAvisMenu(data)
-- end)

RegisterNetEvent("sAdmin:GetStaffsList")
AddEventHandler("sAdmin:GetStaffsList", function(staffList)
    Menu.ListStaff = staffList
end)

RegisterNetEvent("sAdmin:ReceiveItemList")
AddEventHandler("sAdmin:ReceiveItemList", function(itemList)
    Menu.ItemList = itemList
end)

Citizen.CreateThread(function()
    while true do 
        if PlayerInSpec then 
            -- RageUI.Text({message = "Appuyez sur "..exports.Tree:serveurConfig().Serveur.color.."[E]~s~ pour quitter le mode spectate"})
            ESX.ShowNotification("Appuyez sur "..exports.Tree:serveurConfig().Serveur.color.."[E]~s~ pour quitter le mode spectate")

            if IsControlJustPressed(1, 51) then
                Admin:ExitSpectate()
            end
            Wait(1)
        else 
            Wait(1000)
        end
    end
end)
