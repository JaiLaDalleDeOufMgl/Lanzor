Config = {}

Config.Debug = false

-- 0 standalone
-- 1 ESX
-- 2 QBCore
Config.FrameWork = 1

Config.GetQBCoreObject = function()
    -- Choose your objectType or made here your own.
    local objectType = 1

    if objectType == 1 then
        return exports['qb-core']:GetCoreObject()
    end

    if objectType == 2 then
        return exports['qb-core']:GetSharedObject()
    end

    if objectType == 3 then
        local QBCore = nil
        local breakPoint = 0
        while not QBCore do
            Wait(100)
            TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)

            breakPoint = breakPoint + 1
            if breakPoint == 25 then
                print(string.format("^1[%s]^7 Could not load the sharedobject, are you sure it is called ^1˙QBCore:GetObject˙^7?", GetCurrentResourceName()))
                break
            end
        end

        return QBCore
    end
end

-- this is domain name so allow anything that you would like to be allowed
Config.WhitelistedURL = {
    "youtube",
    "youtu",
    "discordapp",
}

-- Key to open menu
Config.KeyToOpen = "E"

-- Locale for script
Config.Locale = "en"

-- ESX shared object (is no needed, its prebuilded only)
Config.ESX = 'esx:getSharedObject'

-- how much volume will adjust each +/- button
Config.VolumeAdjust = 0.01

-- Do we want cached music for dj mixes?
Config.AllowCachedMusic = true

-- DJ mixer list
Config.MixerList = {
    vanila = {
        mixer = {
            {
                pos = vector3(141.93222045898, -1335.7468261719, 20.322467803955),
                distance = 5,
            },
            jobs = {"unicorn"}
        },
        speaker = {
            {
                pos = vector3(138.15225219727, -1337.0081787109, 20.282640457153),
                distance = 40,
            },
        },
        -- max value is 1.0
        -- 1.0 = 100% volume
        defaultVolume = 0.5,
    },
    bahamas = {
        mixer = {
            {
                pos = vector3(120.72, -1281.12, 29.48),
                distance = 5,
            },
            jobs = {"bahamas2"}
        },
        speaker = {
            {
                pos = vector3(120.72, -1281.12, 29.48),
                distance = 25,
            },
        },
        -- max value is 1.0
        -- 1.0 = 100% volume
        defaultVolume = 0.5,
    },
    malibu = {
        mixer = {
            {
                pos = vector3(-802.72058105469, -1238.1318359375, 7.2310180664062),
                distance = 5,
            },
            jobs = {"bahamas"}
        },
        speaker = {
            {
                pos = vector3(-804.58178710938, -1236.4981689453, 6.6100602149963),
                distance = 40,
            },
        },
        -- max value is 1.0
        -- 1.0 = 100% volume
        defaultVolume = 0.5,
    },
    tequila = {
        mixer = {
            {
                pos = vector3(-561.24682617188, 281.64108276367, 85.676452636719),
                distance = 5,
            },
            jobs = {"tequilala"}
        },
        speaker = {
            {
                pos = vector3(-551.69885253906, 284.2197265625, 82.976547241211),
                distance = 40,
            },
        },
        -- max value is 1.0
        -- 1.0 = 100% volume
        defaultVolume = 0.5,
    },
}

-- How much ofter the player position is updated ?
Config.RefreshTime = 300

-- how much close player has to be to the sound before starting updating position ?
Config.distanceBeforeUpdatingPos = 40

-- Message list
Config.Messages = {
    ["streamer_on"]  = "Streamer mode is on. From now you will not hear any music/sound.",
    ["streamer_off"] = "Streamer mode is off. From now you will be able to listen to music that players might play.",
}

-- external xsound?
Config.UseExternalxSound = false

-- if you want to use high_3dsounds
Config.UseHighSound = false

-- if you want to use mx-surround
Config.MXSurround = false

-- name of the lib
Config.xSoundName = "xsound"

if Config.MXSurround then
    Config.UseExternalxSound = true
    Config.xSoundName = "mx-surround"
end

if Config.UseHighSound then
    Config.xSoundName = "high_3dsounds"
    Config.UseExternalxSound = true
end