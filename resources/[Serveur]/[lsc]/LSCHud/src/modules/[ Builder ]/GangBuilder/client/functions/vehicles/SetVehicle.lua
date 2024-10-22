function MOD_GangBuilder:SetVehicle(plate, vehicle)
    if (self.data?.vehicles[plate]) then
        self.data?.vehicles[plate] = vehicle
    end
end