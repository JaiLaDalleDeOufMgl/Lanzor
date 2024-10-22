

local isFalling = false

Keys.Register("J", "Tomber", "Tomber au sol", function()
    CreateThread(function()
        FallAnimation()
    end)
end)

function FallAnimation()
    local ped = PlayerPedId()
    if DoesEntityExist(ped) and not IsEntityDead(ped) and not IsPedInAnyVehicle(ped, true) then 
        Citizen.CreateThread(function()
            if isFalling then
                isFalling = false
            else
                isFalling = true
                SetPedToRagdoll(ped, 100, 100, 0, 0, 0, 0)
                while isFalling do
                    Citizen.Wait(10)
                    ResetPedRagdollTimer(ped)
                end
            end
        end)
    end 
end