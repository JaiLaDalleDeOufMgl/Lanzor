---@return void
function _GamemodeHud:SetHelpNotifVisible(message)

    sendUIMessage({
        HelpNotifShow = true,
        HelpText = message
    })

end