
ESX = nil

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
end)

Config = {}

Config.ESXFramework = {
	newversion = false, -- use this if you using new esx version (if you get error with old esxsharedobjectmethod in console)
	getsharedobject = "esx:getSharedObject",
	resourcename = "Framework",
}

Config.Language = "English"

Config.InterfaceColor = "#731831" -- change interface color, color must be in hex

Config.HotTubSitDistance = 1.0

Config.HotTubCoverManagmentDistance = 1.0

Config.HotTubManagmentDistance = 1.0

Config.CoverManagmentCooldown = 60000

Config.TvCooldown = 5000

Config.ClothesWetting = true

Config.DefaultKeyBindCoverManagment = "E"

Config.DefaultKeyBindHotTubManagment = "G"

Config.DefaultKeyBindSit = "E"

Config.RemoveHottubCommand = "removehottub" -- command for remove hottub

Config.SitNotify = true

Config.HotTubSpawnDuration = 10 -- in seconds

Config.HotTubRemoveDuration = 10 -- in seconds

Config.DisableNozzlesSound = false -- it will disable sound but also particle!

Config.Target = false -- enable this if you want use target and 3d texts

Config.Targettype = "qtarget" -- types - qtarget, qbtarget

Config.TargetIcons = { -- icons must be from fontawesome.com/icons
	["covermanagmenticon"] = "fas fa-box-circle-check", -- Cover Managment Icon 
	["hottubmanagmenticon"] = "fas fa-box-circle-check", -- Hottub Managment Icon
	["siticon"] = "fas fa-box-circle-check", -- Sit Icon
}

Config.LightSpeed = { --in miliseconds
    {lightspeed = 500},
	{lightspeed = 1500},
	{lightspeed = 4500},
}

Config.CustomPedsOffsets = { -- offsets for custom ped models
    {
        pedmodel = "player_one", -- ped model name
		offset = vector3(0.0, 0.0, 0.05),  -- z offset
	},
}

Config.HotTubs = {
    {
        coords = vector3(-1826.69, -754.6, 8.2),
		rotation = vector3(0.0, 0.0, 50.0),
		objecthandler = nil,
		hottubstairs = true,
		hottubtype = 1,
		closed = true,
		manipulating = false,
		manipulatingplayerid = nil,
		covermanipulating = false,
		covermanipulatingplayerid = nil,	
		covercooldown = false,
		coverhandlers = {
			{handler = nil},
			{handler = nil},
		},
		spawnedbyplayer = false,
		light = false,
		lightrgb = false,
		lightrgbspeed = 1,
		lightselected = 1,
		lighthandlers = {
			{handler = nil}, 
			{handler = nil}, 
			{handler = nil}, 
			{handler = nil}, 
			{handler = nil}, 
			{handler = nil}, 
			{handler = nil}, 
			{handler = nil}, 
			{handler = nil}, 
			{handler = nil}, 
		},
		tvopened = false,
		tvhandler = nil,
		tvcooldown = false,
		nozzlesactivated = false,
		waterhandler = nil,
		waternozzlehandler = nil,		
		nozzles = {
			{handler = nil, offsetxcategory = "minus", offsetx = -0.54, offsetycategory = "minus", offsety = -1.58, rotation = vector3(0.0, 0.0, 0.0)},
			{handler = nil, offsetxcategory = "plus", offsetx = 0.51, offsetycategory = "minus", offsety = -1.58, rotation = vector3(0.0, 0.0, 0.0)},
			{handler = nil, offsetxcategory = "minus", offsetx = -0.54, offsetycategory = "plus", offsety = 1.58, rotation = vector3(0.0, 0.0, 180.0)},
			{handler = nil, offsetxcategory = "plus", offsetx = 0.51, offsetycategory = "plus", offsety = 1.58, rotation = vector3(0.0, 0.0, 180.0)},		
			{handler = nil, offsetxcategory = "minus", offsetx = -1.58, offsetycategory = "minus", offsety = -0.52, rotation = vector3(0.0, 0.0, 270.0)},
			{handler = nil, offsetxcategory = "plus", offsetx = 1.58, offsetycategory = "minus", offsety = -0.52, rotation = vector3(0.0, 0.0, 90.0)},
			{handler = nil, offsetxcategory = "minus", offsetx = -1.58, offsetycategory = "plus", offsety = 0.52, rotation = vector3(0.0, 0.0, 270.0)},
			{handler = nil, offsetxcategory = "plus", offsetx = 1.58, offsetycategory = "plus", offsety = 0.52, rotation = vector3(0.0, 0.0, 90.0)},		
		},				
		seats = {
			{taken = false, takenplayerid = nil, offsetx = 1.3, offsety = 0.5, heading = 100.0},
			{taken = false, takenplayerid = nil, offsetx = 1.3, offsety = -0.5, heading = 100.0},
			{taken = false, takenplayerid = nil, offsetx = -1.3, offsety = -0.5, heading = -80.0},
			{taken = false, takenplayerid = nil, offsetx = -1.3, offsety = 0.5, heading = -80.0},
			{taken = false, takenplayerid = nil, offsetx = -0.5, offsety = 1.3, heading = 180.0},	
			{taken = false, takenplayerid = nil, offsetx = 0.5, offsety = 1.3, heading = 180.0},
			{taken = false, takenplayerid = nil, offsetx = 0.5, offsety = -1.3, heading = 0.0},	
			{taken = false, takenplayerid = nil, offsetx = -0.5, offsety = -1.3, heading = 0.0},
		},		
    },			
}

function Notify(text)
	ESX.ShowNotification(text)
end

function DrawText3D(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords()) 
	if onScreen then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 240
		DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 255, 102, 255, 150)
	end
end