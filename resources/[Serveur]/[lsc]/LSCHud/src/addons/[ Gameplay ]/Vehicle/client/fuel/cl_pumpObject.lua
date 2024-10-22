CreateThread(function()
    for _, pumps in pairs(Gamemode.enums.Vehicle.Fuel.addPumps) do
        CreateObject(GetHashKey(pumps.hash), pumps.x, pumps.y, pumps.z - 1.0, true, true, true)
    end
end)