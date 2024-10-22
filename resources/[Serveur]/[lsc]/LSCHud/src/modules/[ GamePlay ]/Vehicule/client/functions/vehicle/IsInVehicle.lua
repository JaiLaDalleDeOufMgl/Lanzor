function MOD_Vehicle:IsInVehicle(seat)
    local PlayerPed = PlayerPedId()

    return GetVehiclePedIsIn(PlayerPed, false) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPed, false), seat) == PlayerPed
end