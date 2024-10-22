RegisterNetEvent('sAdmin:UpdateStaffBoardCount')
AddEventHandler('sAdmin:UpdateStaffBoardCount', function(myReports, AvgReports, playerName, gradeName, staffList)
    exports[exports.Tree:serveurConfig().Serveur.hudScript]:onSetStaffBoardInfos(myReports, AvgReports, SizeOfReport(), playerName, gradeName, sAdmin.inService, staffList)
end)