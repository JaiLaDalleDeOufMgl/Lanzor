local position = {
    {x = -1188.5384521484, y = -901.35675048828, z = 13.834519386292}
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
                    DrawMarker(20,  -1188.5384521484, -901.35675048828, 13.834519386292, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3,115, 24, 49, 255, 0, 0, 0, 1, nil, nil, 0)

                    if dist <= 1.0 then
                        wait = 0
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage")
                        if IsControlJustPressed(1,51) then
                            bveh()
                        end
                    end
                end
        end
        Wait(wait)
    end
    end
end)