function MOD_Player:Process()
    local playerPed = PlayerPedId();
    MOD_Player.death = true;

    CreateThread(function()
        while IsPedFatallyInjured(playerPed) do
            Wait(300);
        end

        TriggerServerEvent("Gamemode:Player:onRevive")
        MOD_Player.death = false;
    end);
end