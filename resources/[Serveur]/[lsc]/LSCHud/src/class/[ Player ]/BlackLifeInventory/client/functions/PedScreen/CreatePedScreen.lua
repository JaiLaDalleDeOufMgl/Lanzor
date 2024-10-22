function _GamemodeInventory:CreatePedScreen()
    if (self.CurrentPedPreview) then return end

    CreateThread(function()
        SetFrontendActive(true)
        ReplaceHudColourWithRgba(117, 0, 0, 0, 0)
        ActivateFrontendMenu(GetHashKey("FE_MENU_VERSION_EMPTY_NO_BACKGROUND"), true, -1)
    
        Wait(100)
    
        SetMouseCursorVisibleInMenus(false)
    
        self.CurrentPedPreview = ClonePed(PlayerPedId(), GetEntityHeading(PlayerPedId()), true, false)
        local x,y,z = table.unpack(GetEntityCoords(self.CurrentPedPreview))
        SetEntityVisible(self.CurrentPedPreview, false, false)
        NetworkSetEntityInvisibleToNetwork(self.CurrentPedPreview, false)
    
        SetEntityCoords(self.CurrentPedPreview, x,y,z - 10)
        FreezeEntityPosition(self.CurrentPedPreview, true)
    
        Wait(100)
    
        SetPedAsNoLongerNeeded(self.CurrentPedPreview)
        GivePedToPauseMenu(self.CurrentPedPreview, 0.5)
    
        SetPauseMenuPedLighting(true)
        SetPauseMenuPedSleepState(true)
        

        
        local dict = "amb@world_human_hang_out_street@female_arms_crossed@base"
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(100)
        end
        TaskPlayAnim(self.CurrentPedPreview, dict, "base", 8.0, 8.0, -1, 50, 0, false, false, false)
    end)
end