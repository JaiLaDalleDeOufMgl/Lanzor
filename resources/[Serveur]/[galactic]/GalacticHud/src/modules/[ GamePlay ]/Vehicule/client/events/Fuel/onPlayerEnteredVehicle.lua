AddEventHandler('gameEventTriggered', function(name, args)

    if (name == "CEventNetworkPlayerEnteredVehicle") then

        local PlayerId = PlayerId()
        local PlayerPed = PlayerPedId()

        if (args[1] == PlayerId) then

            if (args[2] == GetVehiclePedIsIn(PlayerPed, false)) then

                local vehicle_class = GetVehicleClass(args[2])
                local vehicle_fuel = MOD_Vehicle:GetFuel(args[2])

                while (GetVehiclePedIsIn(PlayerPed, false) ~= 0 and GetVehiclePedIsIn(PlayerPed, false) == args[2] and MOD_Vehicle:IsInVehicle(-1)) do
                    local Interval = 1000


                    vehicle_fuel = MOD_Vehicle:GetFuel(args[2])

                    if (vehicle_fuel < 1.0) then
                        Interval = 0
                        SetVehicleEngineOn(args[2], false, true, true)
                    else
                        if (GetIsVehicleEngineRunning(args[2])) then
                            local fuel_new_value = (vehicle_fuel - Gamemode.enums.Vehicle.Usage[math.round(GetVehicleCurrentRpm(args[2], 1))] * (Gamemode.enums.Vehicle.Consumption[vehicle_class] or 1.0) / 10)
                            MOD_Vehicle:SetFuel(args[2], fuel_new_value)
                        end
                    end

                    Wait(Interval)
                end

            end

        end

    end
end)