---@return void
function _GamemodeHud:RemoveHelpNotifVisible()

    sendUIMessage({
        HelpNotifShow = false
    })

end