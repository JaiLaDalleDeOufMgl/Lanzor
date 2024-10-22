if Tree.Config.debugMode then
    SetTimeout(100, function()
        local fpsHistory = {}
        local minFps = math.huge
        local maxFps = 0
        local totalFps = 0
        local frameCount = 0
        
        local function DrawDebugLines(textLines)
            for i, line in ipairs(textLines) do
                SetTextFont(0)
                SetTextProportional(1)
                SetTextScale(0.0, 0.3)
                SetTextColour(255, 0, 0, 255)
                SetTextDropshadow(0, 0, 0, 0, 255)
                SetTextEdge(1, 0, 0, 0, 255)
                SetTextDropShadow()
                SetTextOutline()
                SetTextEntry("STRING")
                AddTextComponentString(line)
                DrawText(0.005, 0.005 + (i - 1) * 0.025)
            end
        end

        local function DrawEntityBox(entity)
            local min, max = GetModelDimensions(GetEntityModel(entity))
            local frontTopLeft = GetOffsetFromEntityInWorldCoords(entity, min.x, max.y, max.z)
            local frontTopRight = GetOffsetFromEntityInWorldCoords(entity, max.x, max.y, max.z)
            local frontBottomLeft = GetOffsetFromEntityInWorldCoords(entity, min.x, max.y, min.z)
            local frontBottomRight = GetOffsetFromEntityInWorldCoords(entity, max.x, max.y, min.z)
            local backTopLeft = GetOffsetFromEntityInWorldCoords(entity, min.x, min.y, max.z)
            local backTopRight = GetOffsetFromEntityInWorldCoords(entity, max.x, min.y, max.z)
            local backBottomLeft = GetOffsetFromEntityInWorldCoords(entity, min.x, min.y, min.z)
            local backBottomRight = GetOffsetFromEntityInWorldCoords(entity, max.x, min.y, min.z)
            DrawLine(frontTopLeft, frontTopRight, 255, 0, 0, 255)
            DrawLine(frontTopRight, frontBottomRight, 255, 0, 0, 255)
            DrawLine(frontBottomRight, frontBottomLeft, 255, 0, 0, 255)
            DrawLine(frontBottomLeft, frontTopLeft, 255, 0, 0, 255)
            DrawLine(backTopLeft, backTopRight, 255, 0, 0, 255)
            DrawLine(backTopRight, backBottomRight, 255, 0, 0, 255)
            DrawLine(backBottomRight, backBottomLeft, 255, 0, 0, 255)
            DrawLine(backBottomLeft, backTopLeft, 255, 0, 0, 255)
            DrawLine(frontTopLeft, backTopLeft, 255, 0, 0, 255)
            DrawLine(frontTopRight, backTopRight, 255, 0, 0, 255)
            DrawLine(frontBottomLeft, backBottomLeft, 255, 0, 0, 255)
            DrawLine(frontBottomRight, backBottomRight, 255, 0, 0, 255)
        end

        Tree.Function.Thread.addTask("Tree:DebugMode", function()
            Tree.Function.While.addTick(0, "Tree:DebugMode", function()
                local frameTime = GetFrameTime()
                local fps = math.floor(1.0 / frameTime)
                table.insert(fpsHistory, fps)
                if fps < minFps then
                    minFps = fps
                end
                if fps > maxFps then
                    maxFps = fps
                end
                totalFps = totalFps + fps
                frameCount = frameCount + 1
                local avgFps = totalFps / frameCount
                local coords = GetEntityCoords(PlayerPedId())
                local heading = GetEntityHeading(PlayerPedId())
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                local vehicleName = vehicle ~= 0 and GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)) or "N/A"
                local isInVehicle = IsPedInAnyVehicle(PlayerPedId(), false)
                local vehicleSpeed = isInVehicle and GetEntitySpeed(vehicle) * 3.6 or 0
                local chunkId = Tree.Chunk.getChunkId(coords.x, coords.y)
                local avgThreadTime = Tree.Function.Thread.getRecentAverageExecutionTime()
                local avgWhileTime = Tree.Function.While.getRecentAverageExecutionTime()
                local health = GetEntityHealth(PlayerPedId())
                local armor = GetPedArmour(PlayerPedId())
                local weapon = GetSelectedPedWeapon(PlayerPedId())
                local serverId = GetPlayerServerId(PlayerId())
                local gameTime = GetClockHours()..":"..GetClockMinutes()
                local entityCount = #GetGamePool('CObject')
                local pedCount = #GetGamePool('CPed')
                local vehicleCount = #GetGamePool('CVehicle')
                local memUsage = math.floor(collectgarbage("count"))
                local textLines = {
                    "DebugMode",
                    string.format("FPS: %d | Min: %d | Max: %d | Avg: %.2f", fps, minFps, maxFps, avgFps),
                    "Player Coordinates: "..string.format("X: %.2f, Y: %.2f, Z: %.2f", coords.x, coords.y, coords.z),
                    "Heading: "..string.format("%.2f", heading),
                    "Chunk ID: "..chunkId,
                    "Health: "..health.." | Armor: "..armor,
                    "Current Weapon: "..weapon,
                    "Server ID: "..serverId,
                    "In-Game Time: "..gameTime,
                    "Avg Execution Times - Thread: "..string.format("%.2f ms", avgThreadTime).." | While: "..string.format("%.2f ms", avgWhileTime),
                    "Entity Count: "..entityCount,
                    "Ped Count: "..pedCount,
                    "Vehicle Count: "..vehicleCount,
                    "Memory Usage: "..memUsage.." KB"
                }
                if isInVehicle then
                    table.insert(textLines, "Vehicle: "..vehicleName)
                    table.insert(textLines, string.format("Vehicle Speed: %.2f km/h", vehicleSpeed))
                end
                DrawDebugLines(textLines)
            end)
        end)

        Tree.Function.While.addTick(0, "Tree:EntityDebug", function()
            for _, entity in ipairs(GetGamePool('CObject')) do
                if entity ~= PlayerPedId() then
                    DrawEntityBox(entity)
                end
            end
            for _, ped in ipairs(GetGamePool('CPed')) do
                if ped ~= PlayerPedId() then
                    DrawEntityBox(ped)
                end
            end
            for _, vehicle in ipairs(GetGamePool('CVehicle')) do
                DrawEntityBox(vehicle)
            end
        end)
    end)
end
