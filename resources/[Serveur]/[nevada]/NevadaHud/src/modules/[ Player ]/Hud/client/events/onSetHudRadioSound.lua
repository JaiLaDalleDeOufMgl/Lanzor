MOD_HUD:onReady(function()
    AddEventHandler('Gamemode:Hud:SetHudRadioSound', function(sound, valume)
         MOD_HUD.class:SetRadioSound(sound, valume)
     end) 
 end)