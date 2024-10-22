exports("onAddNotification", function(title, message, level, timer)
    MOD_HUD.class:AddNotification(title, message, level, (timer * 1000))
end)