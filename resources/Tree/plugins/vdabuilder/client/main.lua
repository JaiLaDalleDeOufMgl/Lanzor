
vdaTable = {}

CreateThread(function()
    TriggerServerEvent("tree:sendVDA:toClient")
end)

RegisterNetEvent("tree:vda:refreshAllVDA", function(tableVDA)
    if not tableVDA then
        return
    end
    vdaTable = tableVDA
end)


CreateThread(function()
    while true do
        timer = 750
        local playerCoords = GetEntityCoords(PlayerPedId())
        for k,v in pairs(vdaTable) do
            local distance = #(playerCoords - vector3(v.coords.x, v.coords.y, v.coords.z))
            if distance < 10 then
                timer = 0
                if distance < 3 then
                    DrawMarker(22, v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, exports.Tree:serveurConfig().Serveur.colorMarkers.r, exports.Tree:serveurConfig().Serveur.colorMarkers.g, exports.Tree:serveurConfig().Serveur.colorMarkers.b, 255, 55555, false, true, 2, false, false, false, false)
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder à la VDA")
                    if IsControlJustPressed(0, 51) then
                        TriggerServerEvent("tree:vda:enterVDA", v.id)
                    end
                end
            elseif distance > 5.0 and distance < 15.0 then
                timer = 750
            end
        end
        Wait(timer)
    end
end)

