---

--- Create at [01/11/2022] 20:15:54

--- File name [_main]
---

Helipad = {}
Helipad.Config = {
    ["ambulance"] = {
        menuPosition = vector3(-1850.00, -354.93, 58.08),
        spawnPosition = vector4(-1867.50, -352.91, 58.09, 140.56),
        models = {
            "nksvolitoems"
        }
    },
    ["police"] = {
        menuPosition = vector3(458.93, -977.44, 43.69),
        spawnPosition = vector4(449.55, -981.07, 43.69, 176.840),
        models = {
            "polmav"
        }
    },
    ["bcso"] = {
        menuPosition = vector3(1832.306, 3684.211, 42.97942),
        spawnPosition = vector4(1824.308, 3686.504, 42.9794, 211.8868),
        models = {
            "bcsheriffheli"
        }
    },
    ["gouv"] = {
        menuPosition = vector3(-448.4686, 1137.1080, 327.6861),
        spawnPosition = vector4(-453.6555, 1145.2871, 327.6859, 314.7523),
        models = {
            "presheli"
        }
    },
    playerLoad = {}
}

RegisterNetEvent("Helipad:Request:LoadConfig", function()
    local _src = source

    local xPlayer = ESX.GetPlayerFromId(_src)
    if (xPlayer ~= nil) then
        if (Helipad.Config.playerLoad[_src] == nil) then
            Helipad.Config.playerLoad[_src] = true
        else
            return
        end

        xPlayer.triggerEvent("Helipad:ClientReturn:Config", Helipad.Config)
    end
end)