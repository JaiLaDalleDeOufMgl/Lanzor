CreateThread(function()
    TriggerServerEvent("tree:sendBlanchiment:toClient")
end)

BlanchimentDataGlobal = {}

RegisterNetEvent("tree:blanchiment:syncBlanch", function(tableBlanchiment)
    if not tableBlanchiment then
        return
    end
    BlanchimentDataGlobal = tableBlanchiment
end)

CreateThread(function()
    while true do
        timer = 750
        local playerCoords = GetEntityCoords(PlayerPedId())
        for k,v in pairs(BlanchimentDataGlobal) do
            local distance = #(playerCoords - vector3(v.coords.x, v.coords.y, v.coords.z))
            if distance < 10 then
                timer = 0
                if distance < 3 then
                    DrawMarker(22, v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, exports.Tree:serveurConfig().Serveur.colorMarkers.r, exports.Tree:serveurConfig().Serveur.colorMarkers.g, exports.Tree:serveurConfig().Serveur.colorMarkers.b, 255, 55555, false, true, 2, false, false, false, false)
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au blanchiment")
                    if IsControlJustPressed(0, 51) then
                        TriggerServerEvent("tree:blanchiment:enterBlanch", v.id)
                    end
                end
            elseif distance > 5.0 and distance < 15.0 then
                timer = 750
            end
        end
        Wait(timer)
    end
end)

