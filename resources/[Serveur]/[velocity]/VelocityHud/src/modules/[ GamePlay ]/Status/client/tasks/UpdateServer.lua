function MOD_Status:loadUpdateServer()
    Citizen.CreateThread(function()
        while true do
            Wait(ConfigGamemodeHud.status.UpdateInterval)

            TriggerServerEvent('Gamemode:Status:UpdateStatus', MOD_Status:getState())
        end
    end)
end