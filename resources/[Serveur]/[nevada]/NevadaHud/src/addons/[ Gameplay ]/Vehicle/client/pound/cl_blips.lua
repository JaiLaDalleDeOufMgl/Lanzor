local PoundZones = Gamemode.enums.Pound.Zones
local PoundBlips = Gamemode.enums.Pound.Blips

local function LoadBlips()
    for i=1, #PoundZones do
        local blip = AddBlipForCoord(PoundZones[i]['Menu'].x, PoundZones[i]['Menu'].y, PoundZones[i]['Menu'].z)
        SetBlipSprite(blip, PoundBlips[PoundZones[i]['type']].sprite)
        SetBlipColour(blip, PoundBlips[PoundZones[i]['type']].color)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 0.5)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(PoundBlips[PoundZones[i]['type']].label)
        EndTextCommandSetBlipName(blip)
    end
end


CreateThread(function()
    Wait(2000)
	LoadBlips()
end)