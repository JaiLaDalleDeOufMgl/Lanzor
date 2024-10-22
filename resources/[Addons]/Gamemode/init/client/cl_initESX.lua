ESXLoaded = false
ESX = nil

RegisterCommand('refresh', function()
	LoadESX()
	TriggerServerEvent("Core:RequestAdmin")
end)

societymoney = 0
gangmoney = 0

function LoadESX()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end    
    
	ESX.PlayerData = ESX.GetPlayerData()

	while ESX.PlayerData == nil do 
		Wait(1)
	end

	Wait(500)
	ReplaceHudColourWithRgba(116, exports.Tree:serveurConfig().Serveur.colorMarkers.r, exports.Tree:serveurConfig().Serveur.colorMarkers.g, exports.Tree:serveurConfig().Serveur.colorMarkers.b, exports.Tree:serveurConfig().Serveur.colorMarkers.a)
	-- SetWeaponsNoAutoswap(true)

    ESXLoaded = true
end

-- RegisterNetEvent('esx:playerLoaded')
-- AddEventHandler('esx:playerLoaded', function(xPlayer)
-- 	Wait(1000)
-- 	LoadESX()
-- end)

CreateThread(function()
	LoadESX()
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	ESX.PlayerData.job.name = ESX.PlayerData.job.name
	ESX.PlayerData.job.label = ESX.PlayerData.job.label
	ESX.PlayerData.job.grade_name = ESX.PlayerData.job.grade_name
	if ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            societymoney = ESX.Math.GroupDigits(money)
        end, ESX.PlayerData.job.name)
    end
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	ESX.PlayerData.job2 = job2
	ESX.PlayerData.job2.name = ESX.PlayerData.job2.name
	ESX.PlayerData.job2.label = ESX.PlayerData.job2.label
	ESX.PlayerData.job2.grade_name = ESX.PlayerData.job2.grade_name
	if ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            gangmoney = ESX.Math.GroupDigits(money)
        end, ESX.PlayerData.job2.name)
    end
end)

RegisterNetEvent('esx:setMaxWeight')
AddEventHandler('esx:setMaxWeight', function(newMaxWeight)
	ESX.PlayerData.maxWeight = newMaxWeight
end)

RegisterNetEvent('esx_addonaccount:setMoney')
AddEventHandler('esx_addonaccount:setMoney', function(society, money)
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' and 'society_' .. ESX.PlayerData.job.name == society then
		societymoney = ESX.Math.GroupDigits(money)
	end

	if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' and 'society_' .. ESX.PlayerData.job2.name == society then
		gangmoney = ESX.Math.GroupDigits(money)
	end
end)

RegisterNetEvent('esx:setGroup')
AddEventHandler('esx:setGroup', function(group, lastGroup)
	ESX.PlayerData.group = group
end)

RegisterNetEvent('esx:activateMoney')
AddEventHandler('esx:activateMoney', function(money)
    ESX.PlayerData.money = money
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	for i = 1, #ESX.PlayerData.accounts, 1 do
		if ESX.PlayerData.accounts[i].name == account.name then
			ESX.PlayerData.accounts[i] = account
			break
		end
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)    
    LoadESX()
end)

function DrawMissionText(msg, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(msg)
    DrawSubtitleTimed(time and math.ceil(time) or 0, true)
end



PermanentWeapon = {
	['WEAPON_ASSAULTRIFLE'] = false,
	['WEAPON_PAN'] = true,
	['WEAPON_KATANA'] = true,
	['WEAPON_TRIDAGGER'] = true,
	['WEAPON_LUCILE'] = true,
	['WEAPON_BAYONET'] = true,
	['WEAPON_KARAMBIT'] = true,
    ['WEAPON_HEAVYSNIPER'] = true,
    ['WEAPON_CARBINERIFLE_MK2'] = true,
    ['WEAPON_ASSAULTSHOTGUN'] = true,
    ['WEAPON_SPECIALCARBINE'] = true,
    ['WEAPON_COMBATPDW'] = true,
    ['WEAPON_REVOLVER_MK2'] = true,
    ['WEAPON_BAT'] = true,
    ['WEAPON_MARSKSMANRIFLE'] = true,
    ['weapon_combatmg_mk2'] = true,
    ['WEAPON_M4A1FM'] = true,
    ['WEAPON_SCAR17FM'] = true,
    ['weapon_heavyshotgun'] = true,
    ['weapon_heavysniper_mk2'] = true,
	['WEAPON_MP5SDFM'] = true,
	['WEAPON_SR25'] = true,
	['WEAPON_MIDASGUN'] = true,
	['WEAPON_GOLDM'] = true,
	['WEAPON_REDL'] = true,
	['WEAPON_AKORUS'] = true,
	['WEAPON_MILITARM4'] = true,
	['WEAPON_PREDATOR'] = true,
	['WEAPON_BLASTAK'] = true,
	['WEAPON_BLASTM4'] = true,
	['WEAPON_BLACKSNIPER'] = true,
	['WEAPON_CHAINSAW'] = true,
	['WEAPON_DESERTPURPLE'] = true,
	['WEAPON_REVOLVERVAMP'] = true,
	['WEAPON_SPIDERAK'] = true,
	['WEAPON_PUMPKIN'] = true,
	['WEAPON_BONEPER'] = true,
	['WEAPON_SIG550'] = true,
	['WEAPON_REVOLVERULTRA'] = true,
	['WEAPON_COACHGUN'] = true,
	['WEAPON_SHOTGUNK'] = true,
	['WEAPON_VSCO'] = true,
	['WEAPON_BLUERIOT'] = true,
	['WEAPON_ANCIENT'] = true,
	['WEAPON_SNAKE'] = true,
	['WEAPON_HELL'] = true,
	['WEAPON_OBLIVION'] = true,
	['WEAPON_KINETIC'] = true,
	['WEAPON_TEC9M'] = true,
	['WEAPON_TEC9MF'] = true,
	['WEAPON_TEC9MB'] = true,
	['WEAPON_SCARSC'] = true,
	['WEAPON_SOVEREIGN'] = true,
	['WEAPON_GLOCK17'] = true,
	['WEAPON_ALIEN'] = true,
	['WEAPON_MIDGARD'] = true,
	['WEAPON_MAZE'] = true,
	['WEAPON_PENIS'] = true,
	['WEAPON_SPECIALHAMMER'] = true,
	['WEAPON_GUARD'] = true,
	['WEAPON_GRAU'] = true,
	['WEAPON_SCAR17'] = true,
	['WEAPON_M19'] = true,
	['WEAPON_UZILS'] = true,
	['WEAPON_DESERTNIKE'] = true,
	['WEAPON_GLOCKDM'] = true,
	['WEAPON_M4BEAST'] = true,
	['WEAPON_M4GOLDBEAST'] = true,
	['WEAPON_HELLSNIPER'] = true,
	['WEAPON_357'] = true,
} 

CreateThread(function()
	local resList = {
		[3/2]   = "3:2",
		[4/3]   = "4:3",
		[5/3]   = "5:3",
		[5/4]   = "5:4",
		[16/9]  = "16:9",
		[16/10] = "16:10",
		[17/9]  = "17:9",
		[21/9]  = "21:9",
	}
	Wait(1.5 * 60 * 1000)
    while true do

		local aspectRatio = GetAspectRatio(false)
        if aspectRatio < 1.5 then
            local x, y = GetActiveScreenResolution()
            local aspectRatioText
            for ratio, text in pairs(resList) do
                if math.abs(aspectRatio - ratio) < 0.02 then
                    aspectRatioText = text
                    break
                end
            end
            aspectRatioText = aspectRatioText or string.format("%.2f", aspectRatio)
        end

        Wait(1000)
    end
end)