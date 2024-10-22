Tree.Chunk = {}
local chunkSize = 200
local chunkMarkers = {}

--- @param x number La coordonnée X.
--- @param y number La coordonnée Y.
--- @return string L'identifiant du chunk sous forme de chaîne.
function Tree.Chunk.getChunkId(x, y)
    local chunkX = math.floor(x / chunkSize)
    local chunkY = math.floor(y / chunkSize)
    return chunkX .. ":" .. chunkY
end

local function drawChunkMarkers()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local playerX, playerY, playerZ = playerCoords.x, playerCoords.y, playerCoords.z
    local minX, minY, maxX, maxY = -4000, -4000, 4000, 4000
    for x = minX, maxX, chunkSize do
        for y = minY, maxY, chunkSize do
            local chunkId = Tree.Chunk.getChunkId(x, y)
            local markerX = x + chunkSize * 2.5
            local markerY = y + chunkSize * 2.5
            if not chunkMarkers[chunkId] then
                chunkMarkers[chunkId] = AddBlipForCoord(markerX, markerY, playerZ)
                SetBlipSprite(chunkMarkers[chunkId], 1)
                SetBlipColour(chunkMarkers[chunkId], 1)
                SetBlipScale(chunkMarkers[chunkId], 1.0)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("Chunk " .. chunkId)
                EndTextCommandSetBlipName(chunkMarkers[chunkId])
            end
            local distance = GetDistanceBetweenCoords(playerX, playerY, playerZ, markerX, markerY, playerZ, true)
            if distance <= 500 then
                SetBlipDisplay(chunkMarkers[chunkId], 4)
            else
                SetBlipDisplay(chunkMarkers[chunkId], 0)
            end
        end
    end
end

--- @param x1 number La coordonnée X du coin inférieur gauche avant de la boîte.
--- @param y1 number La coordonnée Y du coin inférieur gauche avant de la boîte.
--- @param z1 number La coordonnée Z du coin inférieur gauche avant de la boîte.
--- @param x2 number La coordonnée X du coin supérieur droit arrière de la boîte.
--- @param y2 number La coordonnée Y du coin supérieur droit arrière de la boîte.
--- @param z2 number La coordonnée Z du coin supérieur droit arrière de la boîte.
--- @param r number La composante rouge de la couleur de la boîte.
--- @param g number La composante verte de la couleur de la boîte.
--- @param b number La composante bleue de la couleur de la boîte.
--- @param a number La composante alpha de la couleur de la boîte.
local function DrawBox(x1, y1, z1, x2, y2, z2, r, g, b, a)
    DrawLine(x1, y1, z1, x2, y1, z1, r, g, b, a)
    DrawLine(x2, y1, z1, x2, y2, z1, r, g, b, a)
    DrawLine(x2, y2, z1, x1, y2, z1, r, g, b, a)
    DrawLine(x1, y2, z1, x1, y1, z1, r, g, b, a)
    DrawLine(x1, y1, z2, x2, y1, z2, r, g, b, a)
    DrawLine(x2, y1, z2, x2, y2, z2, r, g, b, a)
    DrawLine(x2, y2, z2, x1, y2, z2, r, g, b, a)
    DrawLine(x1, y2, z2, x1, y1, z2, r, g, b, a)
    DrawLine(x1, y1, z1, x1, y1, z2, r, g, b, a)
    DrawLine(x2, y1, z1, x2, y1, z2, r, g, b, a)
    DrawLine(x2, y2, z1, x2, y2, z2, r, g, b, a)
    DrawLine(x1, y2, z1, x1, y2, z2, r, g, b, a)
end

if Tree.Config.debugMode then

    Tree.Function.Thread.addTask("Tree:Chunk:DrawDebug", function()
        while true do
            drawChunkMarkers()
            Wait(1000)
        end
    end)

    Tree.Function.Thread.addTask("Tree:Chunk:DrawLineDebug", function()
        while true do
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local x1, y1, z1 = playerCoords.x - 200, playerCoords.y - 200, playerCoords.z
            local x2, y2, z2 = playerCoords.x + 200, playerCoords.y + 200, playerCoords.z + 20
            DrawBox(x1, y1, 0, x2, y2, z2, 255, 0, 0, 255) -- Dessiner une boîte rouge
            Wait(0)
        end
    end)
end

Tree.RegisterClientCallback('Tree:chunk:getChunkId', function(cb)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local chunkId = Tree.Chunk.getChunkId(playerCoords.x, playerCoords.y)
    cb(chunkId)
end)
