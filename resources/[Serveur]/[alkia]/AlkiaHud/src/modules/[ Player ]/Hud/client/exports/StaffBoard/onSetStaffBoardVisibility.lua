exports("onSetStaffBoardVisibility", function(bool)
    sendUIMessage({
        ShowAdminBoard = bool
    })
end)