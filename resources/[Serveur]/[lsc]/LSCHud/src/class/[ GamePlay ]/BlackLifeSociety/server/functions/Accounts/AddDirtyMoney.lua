function GamemodeSociety:AddDirtyMoney(amount)
    self.dirty_money += tonumber(amount)

    self:Update("dirty_money", self.dirty_money)
end