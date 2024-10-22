local AlreadyRun = false

function MOD_Zones:loadDrawer()
    if (AlreadyRun) then return end

    AlreadyRun = true

    CreateThread(function()
        while (AlreadyRun) do
            local PlayerPos = GetEntityCoords(PlayerPedId())
            local Interval = 2500

            if (next(self.drawing) == nil) then
                goto Skip
            end

            Interval = 1000

            for id, zone in pairs(self.drawing) do
                local distance = #(PlayerPos - zone.coords)

                if (distance <= zone.drawDistance) then
                    Interval = 0
                    DrawMarker(25, zone.coords.x, zone.coords.y, (zone.coords.z - 0.97), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, zone.interactDistance, zone.interactDistance, zone.interactDistance, exports.Tree:serveurConfig().Serveur.colorMarkers.r, exports.Tree:serveurConfig().Serveur.colorMarkers.g, exports.Tree:serveurConfig().Serveur.colorMarkers.b, exports.Tree:serveurConfig().Serveur.colorMarkers.a, false, true, 2, false, false, false, false)

                    if (distance <= zone.interactDistance) then
                        ESX.ShowHelpNotification(zone.helpText)
                    end
                end
            end

            :: Skip ::

            Wait(Interval)
        end
    end)
end