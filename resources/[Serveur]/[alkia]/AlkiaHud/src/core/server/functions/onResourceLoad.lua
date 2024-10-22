function Gamemode:onGamemodeReady(callback)
    AddEventHandler('Gamemode:IsReady', function()
        callback()
    end)
end