ESX.AddGroupCommand('sGangBuilder', 'gerant', function(source, args, user)

	local payload = {}

	for _, gang in pairs(MOD_GangBuilder:getAllGangs()) do
		payload[#payload + 1] = gang:minify()
	end

	TriggerClientEvent('Gamemode:GangBuilder:OpenGangBuilder', source, payload)
end, { help = "GangBuilder" })