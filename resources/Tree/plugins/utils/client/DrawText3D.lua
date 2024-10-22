local textscreens = {
	{
		coords = vector3(-1024.187988, -1521.067871, 5.596044),
		text = "N'oublie pas de rejoindre notre discord !\n "..exports.Tree:serveurConfig().Serveur.discord,
		size = 8.0,
		font = 0,
		maxDistance = 10
	},
}

CreateThread(function()
    while true do
        local timer = 1000
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        for k,v in pairs(textscreens) do
            local dist = #(coords - v.coords)
            if dist <= v.maxDistance then
                timer = 0
                Tree.Function.Visual.drawText3D(v.coords, v.text)
            end
        end
        Wait(timer)
    end
end)