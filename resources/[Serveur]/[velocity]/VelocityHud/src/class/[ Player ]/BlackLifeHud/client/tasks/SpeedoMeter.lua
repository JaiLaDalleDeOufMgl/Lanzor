function _GamemodeHud:LoadTaskSpeedoMeter()

    CreateThread(function()
        while (true) do
            local interval = 1000

            local PlayerPed = PlayerPedId()
            local isInVehicle = IsPedInAnyVehicle(PlayerPed, false)

            if (isInVehicle) then
                interval = 100

                if (not self.StateSpeedoMeter) then
                    self:SetSpeedoMeterVisible(true)
                end

                local vehicle = GetVehiclePedIsIn(PlayerPed, false)
                local fuel = MOD_Vehicle:GetFuel(vehicle)
                local speed = math.ceil(GetEntitySpeed(vehicle) * 3.6)
                local gear = GetVehicleCurrentGear(vehicle)

                
                self:GetVehicleCurrentGear(gear)
                self:SetSpeedoMeterValueSpeed(speed)
                self:SetSpeedoMeterValueFuel(math.ceil(fuel))
            else
                if (self.StateSpeedoMeter) then
                    self:SetSpeedoMeterVisible(false)
                end
            end

            Wait(interval)
        end
    end)

end