function OpenMenuHelipadFIB()
    local menu = RageUI.CreateMenu("", "Que voulez-vous prendre ?")

    RageUI.Visible(menu, not RageUI.Visible(menu))

    while menu do
        Wait(0)
        RageUI.IsVisible(menu, function()
        FreezeEntityPosition(PlayerPedId(), true)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fib'  then
            RageUI.Button("Sortir un Frogger", "Vous pouvez sortie l'Hélicoptère", {RightLabel = exports.Tree:serveurConfig().Serveur.color.."Accéder~s~ →"}, true, {
                onSelected = function()
                    local model = GetHashKey("fibfrogger")
                    RequestModel(model)
                    while not HasModelLoaded(model) do Citizen.Wait(10) end
                    local pos = GetEntityCoords(PlayerPedId())
                    local vehicle = CreateVehicle(model, 2511.367, -341.7484, 118.1853, 134.185, true, true)
                    RageUI.CloseAll()
                end
            })
        end
        end, function()
        end)

        if not RageUI.Visible(menu) then
            FreezeEntityPosition(PlayerPedId(), false)
            menu = RMenu:DeleteType('menu', true)
        end
    end
end