local onlinePlayers = 0

RegisterNetEvent('Gamemode:Hud:UpdatePlayersCount')
AddEventHandler('Gamemode:Hud:UpdatePlayersCount', function(int)
	onlinePlayers = int
end)

CreateThread(function()
    while true do
        AddTextEntry('FE_THDR_GTAO', (exports.Tree:serveurConfig().Serveur.color..exports.Tree:serveurConfig().Serveur.label..' ~s~| ['..exports.Tree:serveurConfig().Serveur.color..GetPlayerServerId(PlayerId())..'~s~] | ['..exports.Tree:serveurConfig().Serveur.color..GetPlayerName(PlayerId()))..'~s~] | ['..exports.Tree:serveurConfig().Serveur.color..onlinePlayers..'~s~] Joueurs | '..exports.Tree:serveurConfig().Serveur.discord)
        AddTextEntry('PM_PANE_KEYS', 'Configurer vos Touches')
        AddTextEntry('PM_PANE_AUD', 'Audio & Son')
        AddTextEntry('PM_PANE_GTAO', 'Touches Basique')
        AddTextEntry('PM_PANE_CFX', exports.Tree:serveurConfig().Serveur.color..exports.Tree:serveurConfig().Serveur.label..'~s~')
        AddTextEntry('PM_PANE_LEAVE', 'Retourner sur la liste des serveurs.')
        AddTextEntry('PM_PANE_QUIT', 'Quitter '..exports.Tree:serveurConfig().Serveur.color..exports.Tree:serveurConfig().Serveur.label..'~s~')
        AddTextEntry('PM_SCR_MAP', 'Carte de Los Santos ∑')
        AddTextEntry('PM_SCR_GAM', 'Prendre l\'avion')
        AddTextEntry('PM_SCR_INF', 'Logs')
        AddTextEntry('PM_SCR_SET', 'Configuration')
        AddTextEntry('PM_SCR_STA', 'Statistiques')
        AddTextEntry('PM_SCR_RPL', '')
        Wait(1000)
    end
end)

CreateThread(function()
	while true do
		SetDiscordAppId(exports.Tree:serveurConfig().Serveur.discordid)
		SetDiscordRichPresenceAsset('logo')
		SetDiscordRichPresenceAssetText(exports.Tree:serveurConfig().Serveur.label..", rejoignez-nous !")
		SetRichPresence(GetPlayerName(PlayerId()) .." ["..GetPlayerServerId(PlayerId()).."] - "..onlinePlayers.." joueurs")
		Wait(5000)
        SetDiscordRichPresenceAction(0, exports.Tree:serveurConfig().Serveur.discordButtonOne, exports.Tree:serveurConfig().Serveur.discordButtonOneLink)
		SetDiscordRichPresenceAction(1, exports.Tree:serveurConfig().Serveur.discordButtonTwo, exports.Tree:serveurConfig().Serveur.discordButtonTwoLink)
	end
end)