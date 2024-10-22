local isPrivate = false

CreateThread(function()
    while true do
        if IsPedInAnyVehicle(PlayerPedId()) then
            DisableControlAction(0, 346, true)
            DisableControlAction(0, 347, true)
            if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()), -1) == PlayerPedId() then
                DisableControlAction(0, 330, true)
                DisableControlAction(0, 68, true)
                DisableControlAction(0, 25, true)
                DisablePlayerFiring(PlayerPedId(), true)
                isPrivate = true
            else
                if isPrivate then
                    DisablePlayerFiring(PlayerPedId(), false)
                    isPrivate = false
                end
            end
        else
            Wait(1000)
        end

        Wait(0)
    end
end)