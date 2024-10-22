local Loaded = false

CreateThread(function()
    while true do
        Wait(100)
        FreezeEntityPosition(PlayerPedId(), false)
        local ped = PlayerId()
        ClearPedTasksImmediately(ped)
        RemoveAllPedWeapons(ped)
        ClearPlayerWantedLevel(PlayerId())
        ShutdownLoadingScreen()
        ShutdownLoadingScreenNui()
        if NetworkIsPlayerActive(PlayerId()) then
            TriggerServerEvent("Tree:Loaded")
            if Tree.Config.forceDefaultSpawn then
                SetEntityCoords(PlayerPedId(), Tree.Config.defaultSpawn.x, Tree.Config.defaultSpawn.y, Tree.Config.defaultSpawn.z)
                SetEntityHeading(PlayerPedId(), Tree.Config.defaultSpawn.heading)
            end
            break
        end
    end
end)

RegisterNetEvent("Tree:PlayerJoined", function(player)
    if not Loaded then
        Loaded = true
        TriggerEvent("Tree:Load:Plugins")
        Wait(100)
        TriggerEvent("Tree:PlayerLoaded")
    end
end)