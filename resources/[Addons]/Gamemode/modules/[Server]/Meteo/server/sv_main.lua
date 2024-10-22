local CurrenWeather = nil
local BlackoutOver = false
local expiration = 0.5*60*60 -- 30 minutes
local baseTime = 0
local timeOffset = 0
local wtf = os.time() + expiration

local DynamicWeather = false


---FOR NOEL
local NoelTime = false
CurrenWeather = "XMAS"
TriggerClientEvent('Meteo:updateWeather', -1, "XMAS")
--

CreateThread(function()
    if (not NoelTime) then
        SetRandomMeteo()
    end

    while true do 
        Wait(10000)
        if wtf < os.time() then
            wtf = os.time() + expiration

            if (DynamicWeather and not NoelTime) then
                SetRandomMeteo()
            end
        end
    end
end)

CreateThread(function()
    while true do
        Wait(0)

        local newBaseTime = os.time(os.date("!*t"))/2 + 360

        if freezeTime then
            timeOffset = timeOffset + baseTime - newBaseTime			
        end
        baseTime = newBaseTime
    end
end)

CreateThread(function()
    while true do
        Citizen.Wait(5000)
        TriggerClientEvent('sMeteo:UpdateTime', -1, baseTime, timeOffset, freezeTime)
    end
end)

function SetRandomMeteo()
    local Percentage = math.random(1,100)

    if Percentage <= 50 then
        value = 'EXTRASUNNY'
    elseif Percentage >= 50 and Percentage <= 55 then 
        value = 'RAIN'
    elseif Percentage >= 55 and Percentage <= 58 then
        value = 'SMOG'
    elseif Percentage >= 58 and Percentage <= 61 then
        value = 'OVERCAST'
    elseif Percentage >= 61 and Percentage <= 64 then
        value = 'CLEAR'
    elseif Percentage >= 64 and Percentage <= 67 then
        value = 'CLOUDS'
    else
        value = 'EXTRASUNNY'
    end

    CurrenWeather = value
    TriggerClientEvent('Meteo:updateWeather', -1, CurrenWeather)
end

RegisterNetEvent('Meteo:RetrieveCurrentWeather')
AddEventHandler('Meteo:RetrieveCurrentWeather', function()
    TriggerClientEvent('Meteo:updateWeather', source, CurrenWeather)
end)

function ShiftToMinute(minute)
    timeOffset = timeOffset - ( ( (baseTime+timeOffset) % 60 ) - minute )
end

function ShiftToHour(hour)
    timeOffset = timeOffset - ( ( ((baseTime+timeOffset)/60) % 24 ) - hour ) * 60
end

RegisterCommand('time', function(source, args, rawCommand)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local permissions =  xPlayer.getGroup()

    if source == 0 or permissions ~= 'user' then
        if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil then
            local argh = tonumber(args[1])
            local argm = tonumber(args[2])

            if argh < 24 then
                ShiftToHour(argh)
            else
                ShiftToHour(0)
            end
            if argm < 60 then
                ShiftToMinute(argm)
            else
                ShiftToMinute(0)
            end

            local newtime = math.floor(((baseTime+timeOffset)/60)%24) .. ":"
            local minute = math.floor((baseTime+timeOffset)%60)
            if minute < 10 then
                newtime = newtime .. "0" .. minute
            else
                newtime = newtime .. minute
            end

            TriggerClientEvent('sMeteo:UpdateTime', -1, baseTime, timeOffset, freezeTime)
        end
    end
end)

RegisterCommand('freezetime', function(source, args)
    if source == 0 or permissions ~= 'user' then
        freezeTime = not freezeTime
    
        if freezeTime then
            print("Time is now frozen.")
        else
            print("Time is no longer frozen.")
        end
    end
end)

RegisterCommand('freezeweather', function(source, args)
    if source == 0 or permissions ~= 'user' then
        DynamicWeather = not DynamicWeather

        if not DynamicWeather then
            print("Weather is now frozen.")
        else
            print("Weather is no longer frozen.")
        end
    end
end)


local AvailableWeatherTypes = {
    'EXTRASUNNY', 
    'CLEAR', 
    'NEUTRAL', 
    'SMOG', 
    'FOGGY', 
    'OVERCAST', 
    'CLOUDS', 
    'CLEARING', 
    'RAIN', 
    'THUNDER', 
    'SNOW', 
    'BLIZZARD', 
    'SNOWLIGHT', 
    'XMAS', 
    'HALLOWEEN',
}

RegisterCommand('weather', function(source, args)
    if source == 0 or permissions ~= 'user' then
        for i,wtype in ipairs(AvailableWeatherTypes) do
            if wtype == string.upper(args[1]) then
                validWeatherType = true
            end
        end
        
        if validWeatherType then
            print("Weather has been updated.")
            CurrenWeather = string.upper(args[1])
            
            wtf = os.time() + expiration
            
            TriggerClientEvent('Meteo:updateWeather', -1, CurrenWeather)
        end
    end
end, false)