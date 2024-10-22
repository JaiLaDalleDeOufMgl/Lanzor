RegisterCommand('cc', function(source, args, rawCommand)
	local coords = GetEntityCoords(PlayerPedId())
	SendNUIMessage({
		coords = ""..coords.x..", "..coords.y..", "..coords.z..""
	})
end)

RegisterCommand('cch', function(source, args, rawCommand)
	local coords = GetEntityCoords(PlayerPedId())
	local heading = GetEntityHeading(PlayerPedId())
	SendNUIMessage({
		coords = ""..coords.x..", "..coords.y..", "..coords.z..", "..heading
	})
end)

