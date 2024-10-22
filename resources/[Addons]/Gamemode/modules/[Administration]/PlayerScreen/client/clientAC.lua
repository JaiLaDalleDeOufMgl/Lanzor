Citizen.CreateThread(function()
	while ESX == nil do
		Wait(500)
	end

	ESX.TriggerServerCallback('screenshot:getwebhook', function(aaa)
        WebHook = aaa
    end)
end)

RegisterNetEvent("GameCore:GetScreen")
AddEventHandler("GameCore:GetScreen", function()
    exports['screenshot-basic']:requestScreenshotUpload(WebHook, "files[]", function(data)
    end)
end)