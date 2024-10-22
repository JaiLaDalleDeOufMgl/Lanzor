
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        ESX.PlayerData = ESX.GetPlayerData()
        Citizen.Wait(500)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(500)
    end
    if ESX.IsPlayerLoaded() then
        ESX.PlayerData = ESX.GetPlayerData()
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

OpenMenu = false
local mainMenuHunting = RageUI.CreateMenu("", "Chasse")
mainMenuHunting.Closed = function()
    OpenMenu = false
    hasChasse = nil
    FreezeEntityPosition(PlayerPedId(), false)
end

function MainMenuHunting(chasse)
    if OpenMenu then
        OpenMenu = false
        RageUI.Visible(mainMenuHunting, false)
        return
    else
        hasChasse = nil
        FreezeEntityPosition(PlayerPedId(), true)
        OpenMenu = true
        RageUI.Visible(mainMenuHunting, true)

        CreateThread(function()
            while OpenMenu and hasChasse == nil do
                Wait(250)
                ESX.TriggerServerCallback('Chasse:check', function(returnChasse)
                    hasChasse = returnChasse
                end, GetEntityCoords(PlayerPedId()))
            end
        end)


        CreateThread(function()
            while OpenMenu do
                Wait(1)

                RageUI.IsVisible(mainMenuHunting, function()

                    RageUI.Separator("~c~↓~s~ Actions disponible ~c~↓~s~")
                    RageUI.Separator("")

                    if hasChasse == nil then
                        RageUI.Separator("")
                        RageUI.Separator("~c~Chargement ...")
                        RageUI.Separator("")
                    else

                        if not hasChasse then
                            RageUI.Button("Commencer à chasser", nil, { RightLabel = "→→→" }, true, {
                                onSelected = function()
                                    TriggerServerEvent('BlackLifePass:taskCountAdd:standart', 2, 1)
                                    TriggerServerEvent("Chasse:start", GetEntityCoords(PlayerPedId()), chasse)
                                    RageUI.CloseAll()
                                    FreezeEntityPosition(PlayerPedId(), false)
                                end
                            })
                        else
                            RageUI.Button("Arrêter la chasse", nil, { RightLabel = "→→→" }, true, {
                                onSelected = function()
                                    local PATATE = false
                                    if not PATATE then
                                        TriggerServerEvent("Chasse:stop", true, GetEntityCoords(PlayerPedId()), chasse)
                                    else
                                        ESX.ShowNotification("~r~Merci d'enlever le mousquet de votre inventaire (slots d'arme).")
                                    end
                                    RageUI.CloseAll()
                                end
                            })
                        end

                    end


                end)


            end
        end)
    end
end

RegisterCommand("chasse", function()
    MainMenuHunting()
end, false)