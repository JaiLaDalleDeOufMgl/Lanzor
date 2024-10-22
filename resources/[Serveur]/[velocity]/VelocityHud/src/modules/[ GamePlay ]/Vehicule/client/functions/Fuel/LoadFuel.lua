CreateThread(function()
    while (not DecorIsRegisteredAsType("vehicle.fuel", 1)) do
        DecorRegister("vehicle.fuel", 1)
        Wait(500)
    end
end)