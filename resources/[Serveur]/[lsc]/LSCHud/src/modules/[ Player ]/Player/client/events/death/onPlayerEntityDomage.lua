AddEventHandler('gameEventTriggered', function(event, data)
    if (event == "CEventNetworkEntityDamage") then
        local victim, victimDied = data[1], data[4];

        if (not IsPedAPlayer(victim)) then return; end

        local player = PlayerId();
        local playerPed = PlayerPedId();
        local victimId = NetworkGetPlayerIndexFromPed(victim);
        local isDead = IsPedDeadOrDying(victim, true);
        local isInjured = IsPedFatallyInjured(victim);

        if victimDied and victimId == player and (isDead or isInjured)  then

            local killerEntity, deathCause = GetPedSourceOfDeath(playerPed), GetPedCauseOfDeath(playerPed);
            local killerClientId = NetworkGetPlayerIndexFromPed(killerEntity);
            local killerIsActive = NetworkIsPlayerActive(killerClientId);
            local killerServeId = GetPlayerServerId(killerClientId);

            if (killerEntity ~= playerPed and killerClientId and killerIsActive) then
                MOD_Player:HasBeenKilledByPlayer(killerServeId, killerClientId, deathCause);
            else
                MOD_Player:HasBeenKilled(deathCause);
            end
        end
    end
end)