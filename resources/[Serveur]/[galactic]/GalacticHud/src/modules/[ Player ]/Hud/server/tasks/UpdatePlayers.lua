CreateThread(function()
    while (true) do
        TriggerClientEvent('Gamemode:Hud:UpdatePlayersCount', -1, GetNumPlayerIndices())

        Wait(10000)
    end
end)