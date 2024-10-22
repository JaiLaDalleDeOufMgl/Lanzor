local GarageZones = Gamemode.enums.Garage.Zones
local GarageBlips = Gamemode.enums.Garage.BlipsList

local function LoadBlips()
    for i=1, #GarageZones do

        local blip = AddBlipForCoord(GarageZones[i]['Spawn'].x, GarageZones[i]['Spawn'].y, GarageZones[i]['Spawn'].z)
        SetBlipSprite(blip, GarageBlips[GarageZones[i]["Type"]].sprite)
        SetBlipDisplay(blip, 4)
        SetBlipColour(blip, GarageBlips[GarageZones[i]["Type"]].color)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 0.5)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(GarageBlips[GarageZones[i]["Type"]].label)
        EndTextCommandSetBlipName(blip)
    end
end

CreateThread(function()
    Wait(2000)
	LoadBlips()
end)