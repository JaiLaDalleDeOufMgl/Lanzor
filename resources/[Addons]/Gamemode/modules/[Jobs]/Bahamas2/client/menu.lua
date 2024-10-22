ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)



OpenMenu = false
inServiceBahamas = false
local mainMenuBahamas = RageUI.CreateMenu("", "Bahamas")
mainMenuBahamas.Closed = function()
    OpenMenu = false
end

function OpenMainMenuBahamas()
    if OpenMenu then
        OpenMenu = false
        RageUI.Visible(mainMenuBahamas, false)
        return
    else
        OpenMenu = true
        RageUI.Visible(mainMenuBahamas, true)
        CreateThread(function()
            while OpenMenu do
                Wait(1)
                RageUI.IsVisible(mainMenuBahamas, function()
                    if inServiceBahamas then 
                        RageUI.Button("Annonce ~g~[Ouvertures]~s~", nil, {RightLabel = "→→→"}, true, {
                            onSelected = function()
                                TriggerServerEvent("Bahamas2:AnnonceOuverture")
                            end
                        })
                        RageUI.Button("Annonce ~r~[Fermetures]~s~", nil, {RightLabel = "→→→"}, true, {
                            onSelected = function()
                                TriggerServerEvent("Bahamas2:AnnonceFermeture")
                            end
                        })
                        RageUI.Button("Annonce ~r~[Recrutement]~s~", nil, {RightLabel = "→→→"}, true, {
                            onSelected = function()
                                TriggerServerEvent("Bahamas2:AnnonceRecrutement")
                            end
                        })
                        RageUI.Line()
                        RageUI.Button("Faire une facture", nil, {RightLabel = "→→→"}, true, {
                            onSelected = function()
                                local montant = KeyboardInputBahamas2("Montant de la facture ?", 'Montant de la facture ?', '', 7)
                                if tonumber(montant) == nil then
                                    ESX.ShowNotification("~r~Montant invalide")
                                    return false
                                else
                                    amount = (tonumber(montant))
                                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                    if closestPlayer == -1 or closestDistance > 3.0 then
                                        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Personne autour de vous')
                                    else
                                        ESX.ShowNotification("~g~Facture envoyée avec succès !")
                                        TriggerServerEvent('sendLogs:Facture', GetPlayerServerId(closestPlayer), amount)
                                        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'bahamas2', "Bahamas", amount)
                                    end
                                end
                            end
                        })
                    else
                        RageUI.Separator("~r~Vous devez être en service !")
                    end
                end)
            end
        end)
    end
end

Keys.Register('F6', 'Bahamas', 'Ouvrir le menu Bahamas', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bahamas2' then
    	OpenMainMenuBahamas()
	end
end)


function KeyboardInputBahamas2(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        return result
    else
        return nil
    end
end