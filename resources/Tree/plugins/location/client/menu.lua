
RegisterNetEvent("tree:location:spawnVehicleLocation", function(model, spawnVehicle)
    local model = GetHashKey(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    local vehicle = CreateVehicle(model, spawnVehicle, spawnVehicle, true, false)
    SetVehicleNumberPlateText(vehicle, "LOCATION")
    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
    Tree.Menu.CloseAll()
end)


local LocationMainMenu = function(items)
    Tree.Menu.CloseAll()
    local MainMenuLocation = Tree.Menu.CreateMenu("", "Location")
    Tree.Menu.Visible(MainMenuLocation, true)
    CreateThread(function()
        while MainMenuLocation do
            MainMenuLocation.Closed = function() 
                Tree.Menu.Visible(MainMenuLocation, false)
                MainMenuLocation = false
            end
            Tree.Menu.IsVisible(MainMenuLocation, function()
                for _,v in pairs(items) do
                    Tree.Menu.Button(v.label, nil, {RightLabel = "~g~"..v.price.."$"}, true, {
                        onSelected = function()
                            TriggerServerEvent("tree:location:buyVehicleLocation", v)
                        end,
                    })
                end
            end, MainMenuLocation)

            Wait(1)
        end
    end)
end

