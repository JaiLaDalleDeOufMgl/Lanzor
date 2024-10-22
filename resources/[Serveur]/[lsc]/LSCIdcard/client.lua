local open = false

-- Open ID card
RegisterNetEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function( data, type)
	if (open) then open = false end

	open = true
	SendNUIMessage({
		action = "open",
		array  = data,
		type   = type
	})
	
	CreateThread(function()
		while (open) do
			Interval = 0
			if IsControlJustReleased(0, 322) and open or IsControlJustReleased(0, 177) and open then
				SendNUIMessage({
					action = "close"
				})
				open = false
			end

			Wait(0)
		end
	end)
end)