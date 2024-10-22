function _GamemodeStatus:add(value)
    if self.val + value > ConfigGamemodeHud.status.StatusMax then
        self.val = ConfigGamemodeHud.status.StatusMax
    else
        self.val = self.val + value
    end
end