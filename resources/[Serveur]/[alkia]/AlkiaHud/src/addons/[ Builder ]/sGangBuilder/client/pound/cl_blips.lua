local PoundGangZones = Gamemode.enums.Pound.GangZones
local PoundGangBlips = Gamemode.enums.Pound.GangBlips

CreateThread(function()
    for i=1, #PoundGangZones do

        local blip = AddBlipForCoord(PoundGangZones[i]['Menu'].x, PoundGangZones[i]['Menu'].y, PoundGangZones[i]['Menu'].z)
        SetBlipSprite(blip, PoundGangBlips.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipColour(blip, PoundGangBlips.color)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 0.5)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(PoundGangBlips.label)
        EndTextCommandSetBlipName(blip)
    end
end)