OpenMenu = false
local mainMenuBarBahamas = RageUI.CreateMenu("", "Bar Bahamas")
mainMenuBarBahamas.Closed = function()
    OpenMenu = false
end

function OpenMainMenuBarBahamas()
    if OpenMenu then
        OpenMenu = false
        RageUI.Visible(mainMenuBarBahamas, false)
        return
    else
        OpenMenu = true
        RageUI.Visible(mainMenuBarBahamas, true)
        CreateThread(function()
            while OpenMenu do
                Wait(1)
                RageUI.IsVisible(mainMenuBarBahamas, function()
                    if inServiceBahamas then
                        for k,v in pairs(Config.Jobs.Bahamas2.Bar.items) do 
                            RageUI.Button(v.label, nil, {RightLabel = v.price.."$"}, true, {
                                onSelected = function()
                                    local amount = KeyboardInputBahamas2("Combien ?", "Combien ?", "", 10)
                                    if not tonumber(amount) then 
                                        ESX.ShowNotification("~r~Veuillez entrer un montant valide.")
                                        return 
                                    end
                                    TriggerServerEvent('Bahamas:BuyItem', tonumber(amount), v)
                                end
                            })
                        end
                    else
                        RageUI.Separator("~r~Vous devez être en service !")
                    end
                end)
            end
        end)
    end
end

CreateThread(function()
    while true do
        timer = 750
        local playerCoords = GetEntityCoords(PlayerPedId())
        local distance = #(playerCoords - Config.Jobs.Bahamas2.Bar.position)
        if distance < 10 and ESX.PlayerData.job.name == "bahamas2" then
            timer = 0
            if distance < 3 then
                DrawMarker(22, Config.Jobs.Bahamas2.Bar.position, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, exports.Tree:serveurConfig().Serveur.colorMarkers.r, exports.Tree:serveurConfig().Serveur.colorMarkers.g, exports.Tree:serveurConfig().Serveur.colorMarkers.b, 255, 55555, false, true, 2, false, false, false, false)
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le bar")
                if IsControlJustPressed(0, 51) then
                    OpenMainMenuBarBahamas()
                end
            end
        elseif distance > 5.0 and distance < 15.0 then
            timer = 750
        end
        Wait(timer)
    end
end)

