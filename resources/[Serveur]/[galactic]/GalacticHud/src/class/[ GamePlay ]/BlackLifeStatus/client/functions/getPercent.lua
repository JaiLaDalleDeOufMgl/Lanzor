function _GamemodeStatus:getPercent()
    return (self.val / ConfigGamemodeHud.status.StatusMax) * 100
end