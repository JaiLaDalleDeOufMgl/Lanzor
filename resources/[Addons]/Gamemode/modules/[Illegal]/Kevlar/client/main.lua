Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do 
        Citizen.Wait(100)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)

local dead = false
local Kevlared = false

AddEventHandler("entityDamaged", function(player,culprit,weapom,baseDamage)
    if player == PlayerPedId() then
        if GetPedArmour(PlayerPedId()) ~= 0 then
            Kevlared = true
            --return
       elseif GetPedArmour(PlayerPedId()) <= 0 and Kevlared  then
           dead = true
           ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Votre Kevlar c'est briser")
           --ClearTimecycleModifier()
            --SetEntityInvincible(PlayerPedId(), true)
            --SetTimecycleModifier("hud_def_blur")
           -- DEN:DrawMissionText("~g~ Invincible~s~ - "..exports.Tree:serveurConfig().Serveur.color.."Vous etes K.O", 3000)
            --DEN:Ragdoll(3000) 
            --SetPedComponentVariation(PlayerPedId(),9,0,0,0)
            --Wait(3000)
            ClearTimecycleModifier()
            TriggerEvent("Kevlar:Remove")
            SetEntityInvincible(PlayerPedId(), false)
            Kevlared = false
            dead = false
        end
    end
end)

RegisterNetEvent("Kevlar:Verif")
AddEventHandler("Kevlar:Verif", function()
    -- print("It's Working")
    if GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
        if GetPedArmour(PlayerPedId()) >= 20  or Kevlared then
            Kevlared = true
            ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Vous avez deja un kevlar sur vous")
            return
        else
            TriggerServerEvent("Kevlar:Pass")
            Kevlared = false
        end
    else
        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Vous ne pouvez pas utliser de kevlar en véhicule")
    end
end)

RegisterNetEvent("Kevlar:Add")
RegisterNetEvent("Kevlar:Add", function()
    local ped = PlayerPedId()
    DEN:AddProgressBar("Mise du kevlar en cours",13,21,266,255,5000)
    ExecuteCommand("me  est entrain de ce mettre un kevlar")
    DEN:TaskScenarioInplace("CODE_HUMAN_MEDIC_KNEEL",5000)
    SetPedArmour(ped, 100)
    -- SetEntityMaxSpeed(ped, 4.9)
    SetPedComponentVariation(ped,0,0,0,0)
    -- ESX.ShowNotification("Votre vitesse a etait reduite de : "..exports.Tree:serveurConfig().Serveur.color.." 30%")
    Kevlared = true
end)

RegisterNetEvent("Kevlar:Remove")
AddEventHandler("Kevlar:Remove", function()
    SetEntityMaxSpeed(PlayerPedId(), 7.0)
    Kevlared = false
end)