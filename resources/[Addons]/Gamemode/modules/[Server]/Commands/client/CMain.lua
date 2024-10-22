

local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config.Get.ESX, function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().group == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setGroup')
AddEventHandler('esx:setGroup', function(group, lastGroup)
	PlayerData.group = group
end)

RegisterNUICallback('close', function(data, cb)
	SetNuiFocus(false)
end)

RegisterNUICallback('set', function(data, cb)
	TriggerServerEvent('es_admin:set', data.target, data.command, data.param)
end)