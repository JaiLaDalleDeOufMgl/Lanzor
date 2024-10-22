function _GamemodeVehicule:SetLocked(bool)
    SetVehicleDoorsLocked(self:GetHandle(), bool ~= nil and bool == true and 2 or 1)
end