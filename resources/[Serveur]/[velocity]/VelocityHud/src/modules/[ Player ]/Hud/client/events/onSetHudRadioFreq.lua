MOD_HUD:onReady(function()
   AddEventHandler('Gamemode:Hud:SetHudRadioFreq', function(string)
        MOD_HUD.class:SetRadioFreq(string)
    end) 
end)