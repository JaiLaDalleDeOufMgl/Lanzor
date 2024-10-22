local RateLimite = 0
local MaxRateLimite = 2
local TimeRateLimite = 2000

function AddRateLimiteZone()
    RateLimite += 1
    SetTimeout(TimeRateLimite, function()
        RateLimite -= 1
    end)
end

CreateThread(function()
    MOD_Zones:loadDivider()
    MOD_Zones:loadDrawer()

    MOD_InteractionKey:addListerner(function()
        local coords = GetEntityCoords(PlayerPedId())

        for _, zone in pairs(MOD_Zones.drawing) do
            if #(coords - zone.coords) <= zone.interactDistance then
                if (RateLimite < MaxRateLimite) then
                    AddRateLimiteZone()
                    TriggerServerEvent('Gamemode:Zone:onInteraction', zone.id)
                end
            end
        end
    end)
end)