ConfigForWB = {
	Webhooks = {
		Kill = exports.Tree:serveurConfig().Logs.DeathsPlayers,
		Object = exports.Tree:serveurConfig().Logs.ObjectLogs,
		Jail = exports.Tree:serveurConfig().Logs.StaffJailPlayers,
		Staff = exports.Tree:serveurConfig().Logs.StaffDivers,
		Staff = exports.Tree:serveurConfig().Logs.EntreprisesDivers,
		Coffre = exports.Tree:serveurConfig().Logs.CoffreDivers,
	},
}