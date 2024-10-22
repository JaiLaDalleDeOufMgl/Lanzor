function _GamemodeVehicule:GetPlayerHasKey(license)
    if (self.owner == license) then
        return true
    end
end