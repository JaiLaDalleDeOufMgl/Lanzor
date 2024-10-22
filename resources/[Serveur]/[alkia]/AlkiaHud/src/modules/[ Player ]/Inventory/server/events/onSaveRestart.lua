AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
	if (eventData.secondsRemaining == 60) then
		SetTimeout(30000)
        MOD_inventory:saveAllInventory()
	end
end)

AddEventHandler('txAdmin:events:serverShuttingDown', function()
	MOD_inventory:saveAllInventory()
end)