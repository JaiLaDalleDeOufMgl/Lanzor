local MaxDistPoint = 100

function MOD_Zones:loadDivider()
    CreateThread(function()
        while (true) do
            local coords = GetEntityCoords(PlayerPedId())

            for id, zone in pairs(self.drawing) do
                local coordPly = vector3(coords.x, coords.y, coords.z)
                local zoneCoords = vector3(zone.coords.x, zone.coords.y, zone.coords.z)

                if (#(coordPly - zoneCoords) > MaxDistPoint) then
                    self.drawing[id] = nil
                end
            end

            for id, zone in pairs(self.list) do

                -- if (zone.requireJob) then
                --     print('HERE')
                --     print(type(zone.requireJob))
                --     -- if (zone.requireJob()) then
                --     --     goto continue
                --     -- end
                -- end

                
                if (zone.coords == nil) then
                    --print('HERE BUG GHOST', json.encode(zone), json.encode(zone.coords))
                    goto continue
                end


                if (self.drawing[id]) then
                    goto continue
                end

                local coordPly = vector3(coords.x, coords.y, coords.z)
                local zoneCoords = vector3(zone.coords.x, zone.coords.y, zone.coords.z)

                if (#(coordPly - zoneCoords) <= MaxDistPoint) then
                    self.drawing[id] = zone
                end

                :: continue ::
            end

            Wait(2500)
        end
    end)
end