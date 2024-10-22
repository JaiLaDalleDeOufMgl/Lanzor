function _GamemodeStatus:remove(value)
    if self.val - value < 0 then
        self.val = 0
    else
        self.val = self.val - value
    end
end