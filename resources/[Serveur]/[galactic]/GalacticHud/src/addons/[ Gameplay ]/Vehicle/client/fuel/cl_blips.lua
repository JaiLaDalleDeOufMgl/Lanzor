local function LoadBlips()

    for _, coords in pairs(Gamemode.enums.Vehicle.Fuel.blipLocations) do
        local blip = AddBlipForCoord(coords)
        SetBlipSprite(blip, 361)
        SetBlipScale(blip, 0.5)
        SetBlipColour(blip, 1)
        SetBlipDisplay(blip, 4)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Station Essence")
        EndTextCommandSetBlipName(blip)
    end

end

CreateThread(function()
    Wait(2000)
	LoadBlips()
end)