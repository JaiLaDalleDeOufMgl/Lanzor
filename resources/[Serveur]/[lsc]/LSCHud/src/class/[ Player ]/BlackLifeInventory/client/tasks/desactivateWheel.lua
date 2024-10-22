function _GamemodeInventory:desactivateWheel()
    CreateThread(function()
        while true do
            SetPedConfigFlag(GetPlayerPed(-1), 48, true)
    
            if (IsPedSittingInAnyVehicle(PlayerPedId())) then
                SetPedConfigFlag(GetPlayerPed(-1), 48, false)
            end
    
            Wait(800)
        end
    end)    
end