CreateThread(function()
    while true do
        Wait(0)
        
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsTryingToEnter(playerPed)
        if vehicle then
            local seat = GetSeatPedIsTryingToEnter(playerPed)
            local pedInSeat = GetPedInVehicleSeat(vehicle, seat)
            
            if pedInSeat ~= 0 and IsPedAPlayer(pedInSeat) then
                ClearPedTasksImmediately(playerPed)
            end
        end
    end
end)