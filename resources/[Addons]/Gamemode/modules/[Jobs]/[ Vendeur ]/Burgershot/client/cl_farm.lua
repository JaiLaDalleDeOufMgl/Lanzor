CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Wait(100)
    end
    ESX.PlayerData = ESX.GetPlayerData()
    if ESX.PlayerData.job.name == "burgershot" then 
        blips()
    end
end)

local blipette = nil 
local blipstart = false

RegisterNetEvent('esx:setJob') --- Verification du job
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
    Wait(2000)
    if ESX.PlayerData.job.name == "burgershot" then
        blips()
    else
        RemoveBlip(blipette) 
    end
end)

function blips()
    blipstart = true
    for k, v in pairs(ConfigBurgerShotFarm.Blips) do
        local blap = AddBlipForCoord(v.BlipsCoords.x, v.BlipsCoords.y, v.BlipsCoords.z)
        blipette = blap
        SetBlipSprite(blap, v.Blips)
        SetBlipDisplay(blap, v.BlipsDisplay)
        SetBlipScale(blap, v.BlipsScale)
        SetBlipColour(blap, v.BlipsColor)
        SetBlipAsShortRange(blap, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(v.BlipsName)
        EndTextCommandSetBlipName(blap)
    end
end

-- CreateThread(function()
--     if ESX.PlayerData.job and  ESX.PlayerData.job.name == "burgershot" then
--         Wait(10000)
--         blips()
--     end
-- end)

local bfarm = RageUI.CreateMenu("", "BurgerShot Recolte", 0, 0, 'commonmenu', 'interaction_bgd')
local btfarm = RageUI.CreateMenu("", "BurgerShot Traitement", 0, 0, 'commonmenu', 'interaction_bgd')
local bvente = RageUI.CreateMenu("", "BurgerShot Vente", 0, 0, 'commonmenu', 'interaction_bgd')
local bmveh = RageUI.CreateMenu("", "BurgerShot Sortie véhicule", 0, 0, 'commonmenu', 'interaction_bgd')

bfarm.Closed = function()
    open = false
end

RegisterNetEvent("burger:spawnveh")
AddEventHandler("burger:spawnveh", function(model, coord, head)
    local hash = GetHashKey(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(10)
    end
    local ped = PlayerPedId()
    ESX.Game.SpawnVehicle(model, coord, head, function(vehicle)
        local newPlate = exports['Gamemode']:GeneratePlate()
        SetVehicleNumberPlateText(vehicle, newPlate)
        SetVehicleFuelLevel(vehicle, 100.0)
        TriggerServerEvent('babyboy:GiveDoubleKeys', 'no', newPlate)
        ESX.Game.SetVehicleProperties(vehicle, {
            color1 = 30,
            plateIndex = 2,
            modEngine = 5,
            modBrakes = 4,
            modTransmission = 4,
            modSuspension = 3,
            windowTint = 2,
            modXenon = true,
            modTurbo = true
        })
        SetVehicleEngineOn(vehicle, true, true, false)
        SetVehicleLivery(vehicle, 2)
        TaskWarpPedIntoVehicle(ped, vehicle, -1)
        vb(vehicle)
        RageUI.CloseAll()
    end)
end)


function vb(entity)
    local blip = AddBlipForEntity(entity)
    SetBlipSprite(blip, ConfigBurgerShotFarm.CTBlips)
    SetBlipScale(blip, ConfigBurgerShotFarm.CTScale)
    SetBlipColour(blip, ConfigBurgerShotFarm.CTColor)
    SetBlipCategory(blip, 2)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(ConfigBurgerShotFarm.CTName)
    EndTextCommandSetBlipName(blip)
end

RegisterNetEvent("ShowNotif")
AddEventHandler("ShowNotif", function(text, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time, 1)
end)

RegisterNetEvent("rcverif")
AddEventHandler("rcverif", function()
    farmed = false
    RageUI.CloseAll()
end)
RegisterNetEvent("transverif")
AddEventHandler("transverif", function()
    trt = false
    RageUI.CloseAll()
end)
RegisterNetEvent("sverif")
AddEventHandler("sverif", function()
    vente = false
    RageUI.CloseAll()
end)

trt = false
farmed = false
vente = false
veh = false

function bmfarm()
    if open then
        open = false
        RageUI.Visible(bfarm, false)
        return
    else
        open = true
        RageUI.Visible(bfarm, true)
        CreateThread(function()
            while open do
                local ped = PlayerPedId()
                local vh = GetVehiclePedIsIn(ped, false)
                if not IsPedInVehicle(ped, vh) then
                    RageUI.IsVisible(bfarm, function() --- Premier Menu
                        RageUI.Button("Commence à récolte", "Appuyez sur ce bouton pour commence à récolte !",
                        { RightLabel = "→" }, farmed == false, {
                            onSelected = function()
                                TriggerServerEvent("brecolte")
                                farmed = true
                                RageUI.CloseAll()
                            end
                        })
                    end)
                end


                Wait(1)
            end
            --  end
        end)
    end
end

function bmtfarm()
    if open then
        open = false
        RageUI.Visible(btfarm, false)
        return
    else
        open = true
        RageUI.Visible(btfarm, true)
        CreateThread(function()
            while open do
                -- if ESX.PlayerData.job and ESX.PlayerData.job.name == 'burgershot' then
                local ped = PlayerPedId()
                local vh = GetVehiclePedIsIn(ped, false)
                if not IsPedInVehicle(ped, vh) then
                    RageUI.IsVisible(btfarm, function()
                        RageUI.Button("Commence à traite", "Appuyez sur ce bouton pour commence à traite !",
                        { RightLabel = "→" }, trt == false, {
                            onSelected = function()
                                TriggerServerEvent("btransform")
                                trt = true
                            end
                        })
                    end)
                end
                Wait(1)
            end
        end)
    end
end

function bsell()
    if open then
        open = false
        RageUI.Visible(bvente, false)
        return
    else
        open = true
        RageUI.Visible(bvente, true)
        CreateThread(function()
            while open do
                local ped = PlayerPedId()
                local vh = GetVehiclePedIsIn(ped, false)
                if not IsPedInVehicle(ped, vh) then
                    RageUI.IsVisible(bvente, function()
                        RageUI.Button("Commence à vendre", "Appuyez sur ce bouton pour commence à vendre !",
                        { RightLabel = "→" }, vente == false, {
                            onSelected = function()
                                TriggerServerEvent("bsell")
                                vente = true
                            end
                        })
                    end)
                end
                Wait(1)
            end
        end)
    end
end

function bveh()
    if open then
        open = false
        RageUI.Visible(bmveh, false)
        return
    else
        open = true
        RageUI.Visible(bmveh, true)
        CreateThread(function()
            while open do
                RageUI.IsVisible(bmveh, function()
                    for k, v in pairs(ConfigBurgerShotFarm.Veh) do
                        local via = ESX.Game.IsSpawnPointClear(v.pos, 5)
                        RageUI.Button(v.label, v.description, { RightLabel = "→" }, vente == false, {
                            onSelected = function()
                                if via == false then
                                    ESX.ShowNotification("La place de parking est "..exports.Tree:serveurConfig().Serveur.color.."encombrer")
                                else
                                    -- spawnveh(v.name,v.pos)
                                    TriggerServerEvent("burgers:spawnveh", v.name, v.pos, ConfigBurgerShotFarm.SpawnHead)
                                    vente = true
                                end
                            end
                        })
                    end
                    RageUI.Button("Ranger votre véhicule", "Appuie sur le bouton pour ranger votre véhicule",
                    { RightLabel = "→" }, true, {
                        onSelected = function()
                            local veh = ESX.Game.GetClosestVehicle()
                            if veh then
                                DeleteEntity(veh)
                                ESX.ShowNotification("~g~Véhicule ranger avec succès")
                            else
                                ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Aucun véhicule à proximité")
                            end
                        end
                    })
                end)
                Wait(1)
            end
        end)
    end
end

------------------------------------------------------------------------- Marker Therad -------------------------------------------------------------------------






CreateThread(function()
    while true do
        ---- Recolte
        local interval = 750
        local interval1 = 750
        local interval2 = 750
        local interval3 = 750
        
        local type = ConfigBurgerShotFarm.Recolte.markertype
        local mc = ConfigBurgerShotFarm.Recolte.recolte
        local pPed = PlayerPedId()
        local pc = GetEntityCoords(pPed)
        local dif = GetDistanceBetweenCoords(mc, pc, true)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == "burgershot" then
           
            if dif > 30 then
                interval = 750
            else
                interval = 1
                DrawMarker(type, mc.x, mc.y, mc.z, 0.0, 0.0, 0.0, 90.0, 180.0, 360.0, 1.0, 1.0, 1.0,
                ConfigBurgerShotFarm.Recolte.markercolor[1], ConfigBurgerShotFarm.Recolte.markercolor[2],
                ConfigBurgerShotFarm.Recolte.markercolor[3], 155)
                if dif <= 3 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder a la "..exports.Tree:serveurConfig().Serveur.color.."récolte.")
                    if IsControlJustPressed(0, 51) then
                        bmfarm()
                    end
                end
            end
        end
        -- Traitement
        
        local type = ConfigBurgerShotFarm.Traitement.markertype
        local mc = ConfigBurgerShotFarm.Traitement.traitement
        local pPed = PlayerPedId()
        local pc = GetEntityCoords(pPed)
        local dif = GetDistanceBetweenCoords(mc, pc, true)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == "burgershot" then
            if dif > 20 then
                interval1 = 750
            else
                interval1 = 1
                DrawMarker(type, mc.x, mc.y, mc.z, 0.0, 0.0, 0.0, 90.0, 180.0, 360.0, 1.0, 1.0, 1.0,
                ConfigBurgerShotFarm.Traitement.markercolor[1], ConfigBurgerShotFarm.Traitement.markercolor[2],
                ConfigBurgerShotFarm.Traitement.markercolor[3], 155)
                if dif <= 3 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au "..exports.Tree:serveurConfig().Serveur.color.." traitement.")
                    if IsControlJustPressed(0, 51) then
                        bmtfarm()
                    end
                end
            end
        end

        
        -- vente

        local type = ConfigBurgerShotFarm.Vente.markertype
        local mc = ConfigBurgerShotFarm.Vente.vente
        local pPed = PlayerPedId()
        local pc = GetEntityCoords(pPed)
        local dif = GetDistanceBetweenCoords(mc, pc, true)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == "burgershot" then
            if dif > 20 then
                interval2 = 750
            else
                interval2 = 1
                DrawMarker(type, mc.x, mc.y, mc.z, 0.0, 0.0, 0.0, 90.0, 180.0, 360.0, 1.0, 1.0, 1.0,
                ConfigBurgerShotFarm.Traitement.markercolor[1], ConfigBurgerShotFarm.Traitement.markercolor[2],
                ConfigBurgerShotFarm.Traitement.markercolor[3], 155)
                if dif <= 3 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder a la "..exports.Tree:serveurConfig().Serveur.color.."vente.")
                    if IsControlJustPressed(0, 51) then
                        bsell()
                    end
                end
            end
        end
        --- marker veh
        local type = ConfigBurgerShotFarm.Mveh.markertype
        local mc = ConfigBurgerShotFarm.Mveh.mvc
        local pPed = PlayerPedId()
        local pc = GetEntityCoords(pPed)
        local dif = GetDistanceBetweenCoords(mc, pc, true)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == "burgershot" then
            if dif > 20 then
                interval3 = 750
            else
                interval3 = 1
                DrawMarker(type, mc.x, mc.y, mc.z, 0.0, 0.0, 0.0, 90.0, 180.0, 360.0, 1.0, 1.0, 1.0,
                ConfigBurgerShotFarm.Traitement.markercolor[1], ConfigBurgerShotFarm.Traitement.markercolor[2],
                ConfigBurgerShotFarm.Traitement.markercolor[3], 155)
                if dif <= 5 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder a la "..exports.Tree:serveurConfig().Serveur.color.."sortie véhicule.")
                    if IsControlJustPressed(0, 51) then
                        bveh()
                    end
                end
            end
        end
       if interval == 1 then
            Wait(1)
        elseif interval1 == 1 then
            Wait(1)
        elseif interval2 == 1 then
            Wait(1)
        elseif interval3 == 1 then
            Wait(1)
        else
            Wait(750)
        end
    end
end)
