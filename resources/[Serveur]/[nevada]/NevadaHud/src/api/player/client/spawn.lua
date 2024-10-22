local defaultModel  = "mp_m_freemode_01"

---spawn
---@param coords table
---@param callback function
---@public
function API_Player:spawn(coords, callback)
    local position , heading  = coords.position, coords.heading
    CreateThread(function()

        self:freeze(PlayerId(), true)

        self:setModel(defaultModel)

        SetPedDefaultComponentVariation(PlayerPedId())

        RequestCollisionAtCoord(position.x, position.y, position.z)

        local ped  = PlayerPedId()

        SetEntityCoordsNoOffset(ped, position.x, position.y, position.z, false, false, false, true)
        SetEntityHeading(ped, heading)

        NetworkResurrectLocalPlayer(position.x, position.y, position.z, heading, true, true, false)

        ClearPedBloodDamage(ped)
        ClearPedTasksImmediately(ped)
        RemoveAllPedWeapons(ped)
        ClearPlayerWantedLevel(PlayerId())

        ShutdownLoadingScreen()

        while (IsScreenFadingIn()) do
            Wait(0)
        end

        self:freeze(PlayerId(), false)

        if (callback) then
            callback()
        end
    end)
end