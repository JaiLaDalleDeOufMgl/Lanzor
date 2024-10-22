exports("onSetStaffBoardInfos", function(myReports, AvgReports, attenteReports, playerName, gradeName, staffMode, staffList)
    sendUIMessage({
        event = 'SetStaffBoardInfos',
        AdminBoardInfos = {
            myReports = myReports,
            avgReports = AvgReports,
            attenteReports = attenteReports,
            playerName = playerName,
            gradeName = gradeName,
            staffMode = staffMode,

            staffList = staffList
        }
    })
end)