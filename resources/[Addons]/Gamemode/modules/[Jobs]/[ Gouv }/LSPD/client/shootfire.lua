local jobWhiteList = {
    ["police"] = true,
    ["bcso"] = true,
    ["fib"] = true,
}

CreateThread(function()
    local timer = 500
    while true do
        if IsAimCamActive() then 
            timer = 0
            if IsPedShooting(PlayerPedId()) then
                local coords = GetEntityCoords(PlayerPedId())
                local chance = math.random(1, 10)
                if chance == 1 then
                    local job = ESX.PlayerData.job.name
                    if not jobWhiteList[job] then
                        TriggerServerEvent("Police:ShotFire", coords)
                    end
                end
            end
        else
            timer = 500
        end
        Wait(timer)
    end
end)


RegisterNetEvent("Police:ShotFire", function(coords)
    ESX.ShowNotification("~r~Un tir a été signalé à la police veuillez vous rendre sur place vérifier votre GPS")
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, 161)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Tir en cours")
    EndTextCommandSetBlipName(blip)
    Wait(15000)
    RemoveBlip(blip)
end)