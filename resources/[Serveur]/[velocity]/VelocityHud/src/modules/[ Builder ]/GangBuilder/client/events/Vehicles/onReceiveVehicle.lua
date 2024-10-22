RegisterNetEvent('Gamemode:GangBuilder:ReceiveVehicle')
AddEventHandler('Gamemode:GangBuilder:ReceiveVehicle', function(plate, vehicle)
    MOD_GangBuilder:SetVehicle(plate, vehicle)
end)