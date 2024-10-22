
OpenMenu = false
local mainMenuVestiaireMalibu = RageUI.CreateMenu("", "Vestiaire Malibu")
mainMenuVestiaireMalibu.Closed = function()
    OpenMenu = false
end

function OpenMainMenuVestiaireMalibu()
    if OpenMenu then
        OpenMenu = false
        RageUI.Visible(mainMenuVestiaireMalibu, false)
        return
    else
        OpenMenu = true
        RageUI.Visible(mainMenuVestiaireMalibu, true)
        CreateThread(function()
            while OpenMenu do
                Wait(1)
                RageUI.IsVisible(mainMenuVestiaireMalibu, function()
                    if inServiceMalibu then
                        RageUI.Button("Terminer son service", nil, {RightLabel = "→→→"}, true , {
                            onSelected = function()
                                inServiceMalibu = false
                            end
                        })
                    else
                        RageUI.Button("Prendre votre service", nil, {RightLabel = "→→→"}, true , {
                            onSelected = function()
                                inServiceMalibu = true
                            end
                        })
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
        local distance = #(playerCoords - Config.Jobs.Malibu.Service.position)
        if distance < 10 and ESX.PlayerData.job.name == "bahamas" then
            timer = 0
            if distance < 3 then
                DrawMarker(22, Config.Jobs.Malibu.Service.position, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, exports.Tree:serveurConfig().Serveur.colorMarkers.r, exports.Tree:serveurConfig().Serveur.colorMarkers.g, exports.Tree:serveurConfig().Serveur.colorMarkers.b, 255, 55555, false, true, 2, false, false, false, false)
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir les vestiaires")
                if IsControlJustPressed(0, 51) then
                    OpenMainMenuVestiaireMalibu()
                end
            end
        elseif distance > 5.0 and distance < 15.0 then
            timer = 750
        end
        Wait(timer)
    end
end)