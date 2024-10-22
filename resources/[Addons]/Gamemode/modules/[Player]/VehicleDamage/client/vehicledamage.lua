ESX = nil
local colorb = "~g~"
local colore = "~g~"
local coloreg = "~g~"
local fuelc = "~g~"
local rad = 0
local rag = 0
local rard = 0 
local rarg = 0

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Wait(100)
    end
    while ESX.GetPlayerData().job == nil do
        Wait(100)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)

CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed, false) then
            local veh = GetVehiclePedIsIn(playerPed, false)

            SetVehicleDamageModifier(veh, 2.0)
            local engin = GetVehicleEngineHealth(veh)
            local body = GetVehicleBodyHealth(veh)
            local clasee = GetVehicleClass(veh)
            local egene = engin + body
            local Statut = math.round(egene / 2 / 10)
            SetDisableVehicleEngineFires(true)

            if engin > 1 and engin < 500 then
                ESX.ShowNotification("Le moteur du véhicule est "..exports.Tree:serveurConfig().Serveur.color.."hors-service")
                local soundId3 = GetSoundId()
                PlaySoundFrontend(soundId3, "Engine_fail", "DLC_PILOT_ENGINE_FAILURE_SOUNDS", true)
                SetVehicleEngineHealth(veh, -4000.0)
                Wait(5000)
                SetVehicleEngineHealth(veh, 0.0)
            end

            if clasee == 15 or clasee == 16 then
                if IsVehicleTyreBurst(veh, 4) then
                    SetEntityMaxSpeed(veh, 6.94444)
                end
            elseif clasee == 8 then
                if IsVehicleTyreBurst(veh, 0) and IsVehicleTyreBurst(veh, 4) then
                    SetEntityMaxSpeed(veh, 0)
                elseif IsVehicleTyreBurst(veh, 0) or IsVehicleTyreBurst(veh, 4) then
                    SetEntityMaxSpeed(veh, 6.94444)
                end
            else
                if IsVehicleTyreBurst(veh, 0) then
                    rag = 25
                else
                    rag = 0
                end
                if IsVehicleTyreBurst(veh, 1) then
                    rad = 25
                else
                    rad = 0
                end
                if IsVehicleTyreBurst(veh, 4) then
                    rarg = 25
                else
                    rarg = 0
                end
                if IsVehicleTyreBurst(veh, 5) then
                    rard = 25
                else
                    rard = 0
                end

                if rag + rad + rard + rarg >= 50 then
                    SetVehicleEngineOn(veh, false, false, false)
                end
            end
        end
        Wait(300)
    end
end)

RegisterCommand("carinfo", function()
    dcartable()
end)

---- Tableau de bord ----

local dmcartable = RageUI.CreateMenu("", "Tableau de bord", 0, 0, 'commonmenu', 'interaction_bgd')
dmcartable.Closed = function()
    open = false
end

function dcartable()
    if open then
        open = false
        RageUI.Visible(dmcartable, false)
        return
    else
        open = true
        RageUI.Visible(dmcartable, true)
        CreateThread(function()
            while open do 
                local ped = PlayerPedId()
                local veh = GetVehiclePedIsIn(ped, false)
                local clasee = GetVehicleClass(veh)
                local engin = GetVehicleEngineHealth(veh)
                local body = GetVehicleBodyHealth(veh)
                local egene = engin + body
                local showengin = math.floor(engin / 10)
                local showbody = math.floor(body / 10)
                local Statut = math.round(egene / 2 / 10)
                local fuel = math.round(GetVehicleFuelLevel(veh))
                local km = math.ceil(GetEntitySpeed(veh) * 3.6)

                if veh ~= 0 then
                    if engin <= 700 and engin > 500 then
                        colore = exports.Tree:serveurConfig().Serveur.color..""
                    elseif engin <= 500 then
                        colore = exports.Tree:serveurConfig().Serveur.color..""
                    else
                        colore = "~g~"
                    end

                    if body <= 700 and body > 500 then
                        colorb = exports.Tree:serveurConfig().Serveur.color..""
                    elseif body <= 500 then
                        colorb = exports.Tree:serveurConfig().Serveur.color..""
                    else
                        colorb = "~g~"
                    end

                    if Statut < 70 and egene > 55 then
                        coloreg = exports.Tree:serveurConfig().Serveur.color..""
                    elseif Statut <= 55 then
                        coloreg = exports.Tree:serveurConfig().Serveur.color..""
                    end

                    if fuel <= 30 then
                        fuelc = exports.Tree:serveurConfig().Serveur.color..""
                    elseif fuel <= 15 then
                        fuelc = exports.Tree:serveurConfig().Serveur.color..""
                    end

                    RageUI.IsVisible(dmcartable, function() 
                        RageUI.Separator("Vitesse actuelle du véhicule : " .. km .. "KM/H")
                        RageUI.Separator("État du réservoir d'essence : " .. fuelc .. fuel .. "L")
                        RageUI.Separator("État du moteur : " .. colore .. showengin .. "%")
                        RageUI.Separator("État de la carrosserie : " .. colorb .. showbody .. "%")
                        RageUI.Separator("État général du véhicule : " .. colorb .. Statut .. "%")

                        if clasee == 15 or clasee == 16 then
                            if IsVehicleTyreBurst(veh, 4) then
                                RageUI.Separator("Roue principale : " .. exports.Tree:serveurConfig().Serveur.color .. " Non Fonctionnelle")
                            else
                                RageUI.Separator("Roue principale : ~g~ Fonctionnelle")
                            end
                        elseif clasee == 8 then
                            if IsVehicleTyreBurst(veh, 0) then
                                RageUI.Separator("Roue avant : " .. exports.Tree:serveurConfig().Serveur.color .. " Non Fonctionnelle")
                            else
                                RageUI.Separator("Roue avant : ~g~ Fonctionnelle")
                            end
                            if IsVehicleTyreBurst(veh, 4) then
                                RageUI.Separator("Roue arrière : " .. exports.Tree:serveurConfig().Serveur.color .. " Non Fonctionnelle")
                            else
                                RageUI.Separator("Roue arrière : ~g~ Fonctionnelle")
                            end
                        else
                            if IsVehicleTyreBurst(veh, 0) then
                                RageUI.Separator("Roue avant gauche : " .. exports.Tree:serveurConfig().Serveur.color .. " Non Fonctionnelle")
                            else
                                RageUI.Separator("Roue avant gauche : ~g~ Fonctionnelle")
                            end
                            if IsVehicleTyreBurst(veh, 1) then
                                RageUI.Separator("Roue avant droite : " .. exports.Tree:serveurConfig().Serveur.color .. " Non Fonctionnelle")
                            else
                                RageUI.Separator("Roue avant droite : ~g~ Fonctionnelle")
                            end
                            if IsVehicleTyreBurst(veh, 4) then
                                RageUI.Separator("Roue arrière gauche : " .. exports.Tree:serveurConfig().Serveur.color .. " Non Fonctionnelle")
                            else
                                RageUI.Separator("Roue arrière gauche : ~g~ Fonctionnelle")
                            end
                            if IsVehicleTyreBurst(veh, 5) then
                                RageUI.Separator("Roue arrière droite : " .. exports.Tree:serveurConfig().Serveur.color .. " Non Fonctionnelle")
                            else
                                RageUI.Separator("Roue arrière droite : ~g~ Fonctionnelle")
                            end
                        end
                    end)
                else
                    ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color .. " Vous n'êtes dans aucun véhicule")
                    return
                end
                Citizen.Wait(1)
            end
        end)
    end
end
