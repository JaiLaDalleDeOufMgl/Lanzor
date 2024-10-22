

BoatLegal = {}
BoatLegal.Config = {
    ["police"] = {
        menuPosition = vector3(-1005.05, -1398.90, 1.59),
        spawnPosition = vector4(-999.41, -1381.89, -0.47, 15.41),
        models = {
            "predator"
        }
    },

    ["fib"] = {
        menuPosition = vector3(2831.16, -671.11, 1.43),
        spawnPosition = vector4(2852.91, -669.80, 0.11, 274.05),
        models = {
            "dinghy4"
        }
    },

    ["bcso"] = {
        menuPosition = vector3(1586.185, 3900.34, 32.05),
        spawnPosition = vector4(1560.071, 3877.26, 29.91, 111.28),
        models = {
            "dinghy4"
        }
    },

    ["ambulance"] = {
        menuPosition = vector3(-1204.78, -1794.74, 3.90),
        spawnPosition = vector4(-1292.63, -1859.64, 0.79, 118.49),
        models = {
            "dinghy"
        }
    },
    playerLoad = {}
}

RegisterNetEvent("BoatLegal:Request:LoadConfig", function()
    local _src = source

    local xPlayer = ESX.GetPlayerFromId(_src)
    if (xPlayer ~= nil) then
        if (BoatLegal.Config.playerLoad[_src] == nil) then
            BoatLegal.Config.playerLoad[_src] = true
        else
            return
        end

        xPlayer.triggerEvent("BoatLegal:ClientReturn:Config", BoatLegal.Config)
    end
end)