local open = false 
local tacosMain5 = RageUI.CreateMenu('', 'Interaction')
tacosMain5.Display.Header = true 
tacosMain5.Closed = function()
    open = false
end

function OpenPrepa()
    if open then
        open = false
        RageUI.Visible(tacosMain5, false)
        return
    else
        open = true
        RageUI.Visible(tacosMain5, true)
        CreateThread(function()
            while open do
              RageUI.IsVisible(tacosMain5,function()
                  RageUI.Separator("↓ BurgerShot ↓")
                  RageUI.Button("Préparer la garnitures", "Requis : Salade + Cornichons + Tomates", {RightLabel = "→→"}, true , {
                      onSelected = function()
                        if not codesCooldown then
                            Citizen.SetTimeout(6500, function() codesCooldown = false end)
                            codesCooldown = true
                            local playerPed = PlayerPedId()
                            TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BBQ', 0, true)
                            Citizen.Wait(6500)
                            TriggerServerEvent('burgershot:garnitures')
                            ClearPedTasksImmediately(playerPed)
                        else
                            ESX.ShowNotification("Merci de patienter !")
                        end
                    end
                  })
              end)
              Citizen.Wait(0)
            end
        end)
    end
end

local position = {
    {x = -1197.032, y = -897.78, z = 13.88616}
}

CreateThread(function()
    while true do
        local wait = 1000
        for k in pairs(position) do
          if ESX.PlayerData.job and ESX.PlayerData.job.name == 'burgershot' then
              local plyCoords = GetEntityCoords(PlayerPedId(), false)
              local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
            if dist <= 5.0 then
                wait = 0
                DrawMarker(20, -1197.032, -897.78, 13.88616, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, exports.Tree:serveurConfig().Serveur.colorMarkers.r, exports.Tree:serveurConfig().Serveur.colorMarkers.g, exports.Tree:serveurConfig().Serveur.colorMarkers.b, exports.Tree:serveurConfig().Serveur.colorMarkers.a, 0, 0, 0, 1, nil, nil, 0)

                if dist <= 1.0 then
                    wait = 0
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour préparer la garnitures")
                    if IsControlJustPressed(1,51) then
                        OpenPrepa()
                    end
                end
            end
        end
        Wait(wait)
    end
end
end)