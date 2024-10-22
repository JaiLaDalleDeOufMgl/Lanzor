KeyboardInput = function (textEntry, inputText, maxLength)
    AddTextEntry('FMMC_KEY_TIP1', textEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", inputText, "", "", "", maxLength)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Wait(1)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(100)
        return result
    else
        Wait(100)
        return nil
    end
end


----CHANGE NAME SERVER
Citizen.CreateThread(function()
    Wait(1000)

    sendUIMessage({
        event = "SetServerName",
        name = "SERVER-NAME"
    })
end)