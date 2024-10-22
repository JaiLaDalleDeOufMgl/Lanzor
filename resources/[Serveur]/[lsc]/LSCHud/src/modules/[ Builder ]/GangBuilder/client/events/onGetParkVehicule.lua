RegisterNetEvent('Gamemode:GangBuilder:GetParkVehicule')
AddEventHandler('Gamemode:GangBuilder:GetParkVehicule', function(gangId)
    local veh = GetVehiclePedIsIn(PlayerPedId())

    if (veh) then
        TriggerServerEvent('Gamemode:GangBuilder:ParkVehicule', GetVehicleNumberPlateText(veh), gangId, API_Vehicles:getProperties(veh))
    end
end)