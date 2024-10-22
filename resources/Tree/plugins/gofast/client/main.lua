
local GoFastMenu = function()
    local MainMenuGoFast = Tree.Menu.CreateMenu("", "Boucherie")
    Tree.Menu.Visible(MainMenuGoFast, true)
    CreateThread(function()
        while MainMenuGoFast do
            MainMenuGoFast.Closed = function() 
                Tree.Menu.Visible(MainMenuGoFast, false)
                MainMenuGoFast = false
            end
            Tree.Menu.IsVisible(MainMenuGoFast, function()
                Tree.Menu.Button("Commencer un gofast", nil, {RightLabel = "→→→"}, true, {
                    onSelected = function()
                        StartGoFast()
                    end,
                })
            end, MainMenuGoFast)
            Wait(1)
        end
    end)
end


CreateThread(function()
    for k,v in pairs(SharedGoFast.positionGoFast) do 
        Tree.Function.Zone.create("GoFast:"..k, v, 5.0, {
            onEnter = function()
                Tree.Function.While.addTick(0, 'drawmarker:'..k, function()
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu")
                    Tree.Function.Visual.drawMarker(v)
                end)
                Tree.Function.Zone.create('GoFast:press:'..k, v, 2.5, {
                    onPress = function()
                        GoFastMenu()
                    end,
                    onExit = function()
                        Tree.Menu.CloseAll()
                    end
                })
            end,
            onExit = function()
                Tree.Function.While.removeTick('drawmarker:'..k)
                Tree.Function.Zone.delete('GoFast:press:'..k)
            end
        })
    end
end)

function StartGoFast()
    Tree.Menu.CloseAll()
    local randomIndex = math.random(1, #SharedGoFast.vehiclePossibles)
    local selectedVehicle = SharedGoFast.vehiclePossibles[randomIndex]
    TriggerServerEvent("Tree:GoFast:Start", selectedVehicle)
end

RegisterNetEvent("Tree:GoFast:Delivery", function(vehicle)
    local positionDelivery = math.random(1, #SharedGoFast.randomPosition)
    local position = SharedGoFast.randomPosition[positionDelivery]
    blipGoFast = AddBlipForCoord(position)
    SetBlipSprite(blipGoFast, 1)
    SetBlipScale(blipGoFast, 0.7)
    SetBlipColour(blipGoFast, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Livraison GoFast")
    EndTextCommandSetBlipName(blipGoFast)
    SetBlipRoute(blipGoFast, true)
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local distance = #(playerCoords - position)
        if distance < 10 then
            DrawMarker(22, position, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour livrer la marchandise")
            if IsControlJustPressed(0, 51) then
                if IsPedInAnyVehicle(playerPed, false) then
                    local veh = GetVehiclePedIsIn(playerPed, false)
                    local plate = GetVehicleNumberPlateText(veh)
                    if plate == " GOFAST " then
                        RemoveBlip(blipGoFast)
                        TriggerServerEvent("Tree:DeleteVehicle", vehicle)
                        TriggerServerEvent("Tree:GoFast:Finish")
                        break
                    else
                        ESX.ShowNotification("~r~Vous n'êtes pas dans le bon véhicule.")
                    end
                else
                    ESX.ShowNotification("~r~Vous n'êtes pas dans un véhicule.")
                end
            end
        end
        Wait(1)
    end
end)
