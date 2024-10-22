---@type xPlayer
function CreatePlayer(source, identifier, userData)
	---@class xPlayer
	local self = {};

	self.source = source
	self.identifier = identifier

	self.character_id = userData.character_id
	self.name = userData.name

	self.permission_group = userData.permission_group
	self.permission_level = userData.permission_level

	self.accounts = userData.accounts

	self.job = userData.job
	self.job2 = userData.job2
	
	self.lastPosition = userData.lastPosition

	self.firstname = userData.firstname;
	self.lastname = userData.lastname;

	self.positionSaveReady = false

	self.removeAccountsNameFistLoad = function(accountName)
		for i=1, #self.accounts, 1 do
			if (self.accounts[i] ~= nil) then
				if (self.accounts[i].name == accountName) then
					table.remove(self.accounts, i)
				end
			end
		end
	end

	---------Babyboy
	local defaultSlots = 50
	exports[exports.Tree:serveurConfig().Serveur.hudScript]:LoadPlayerInventory(self.identifier, userData.inventory, userData.clothes, defaultSlots, Config.MaxWeight, self)

	self.ReloadInventoryPlayer = function()
		exports[exports.Tree:serveurConfig().Serveur.hudScript]:LoadPlayerInventory(self.identifier, userData.inventory, userData.clothes, defaultSlots, Config.MaxWeight, self)
	end

	----INV

	self.SecondInvData = {}

	self.setSecondInvData = function(data)
		self.SecondInvData = data
	end
	self.getSecondInvData = function()
		return self.SecondInvData
	end

	self.getInventory = function()
		return exports[exports.Tree:serveurConfig().Serveur.hudScript]:getInventory(self.identifier)
	end
	self.getInventoryClothes = function()
		return exports[exports.Tree:serveurConfig().Serveur.hudScript]:getInventoryClothes(self.identifier)
	end
	self.getInventoryItem = function(name)
		return exports[exports.Tree:serveurConfig().Serveur.hudScript]:getInventoryItem(self.identifier, name)
	end

	self.saveInventory = function()
		return exports[exports.Tree:serveurConfig().Serveur.hudScript]:saveInventory(self.identifier)
	end
	self.saveClothes = function()
		return exports[exports.Tree:serveurConfig().Serveur.hudScript]:saveClothes(self.identifier)
	end

	self.addInventoryItem = function(name, count, extra, bypass)
		if type(name) ~= 'string' then return end
		if type(count) ~= 'number' then return end

		exports[exports.Tree:serveurConfig().Serveur.hudScript]:addInventoryItem(self.identifier, name, count, extra, bypass)
	end

	self.removeInventoryItemAtSlot = function(slot, count)
		if type(slot) ~= 'number' then return end
		if type(count) ~= 'number' then return end
		
		return exports[exports.Tree:serveurConfig().Serveur.hudScript]:removeInventoryItemAtSlot(self.identifier, slot, count)
	end

	self.removeInventoryItem = function(name, count, extra)
		if type(name) ~= 'string' then return end
		if type(count) ~= 'number' then return end
		
		exports[exports.Tree:serveurConfig().Serveur.hudScript]:removeInventoryItem(self.identifier, name, count, extra)
	end

	self.clearInventoryItem = function()
		exports[exports.Tree:serveurConfig().Serveur.hudScript]:clearInventoryItem(self.identifier)
	end

	self.isFreeSlotOrSameItem = function(droppedTo, name)
		return exports[exports.Tree:serveurConfig().Serveur.hudScript]:isFreeSlotOrSameItem(self.identifier, droppedTo, name)
	end
	self.addItemToSlot = function(droppedTo, count, seconditem)
		exports[exports.Tree:serveurConfig().Serveur.hudScript]:addItemToSlot(self.identifier, droppedTo, count, seconditem)
	end

	self.setInventoryItem = function(name, count, identifier)
		local item = self.getInventoryItem(name, identifier)

		if item and count >= 0 then
			count = ESX.Math.Round(count)

			if count > item.count then
				self.addInventoryItem(item.name, count - item.count)
			else
				self.removeInventoryItem(item.name, item.count - count)
			end
		end
	end

	self.hasInventoryItem = function(name)
		for i = 1, #self.inventory, 1 do
			if self.inventory[i].name == name then
				return true
			end
		end

		return false
	end

	self.getWeight = function()
		return exports[exports.Tree:serveurConfig().Serveur.hudScript]:getWeight(self.identifier)
	end
	self.getMaxWeight = function()
		return exports[exports.Tree:serveurConfig().Serveur.hudScript]:getMaxWeight(self.identifier)
	end
	self.canCarryItem = function(name, count)
		return exports[exports.Tree:serveurConfig().Serveur.hudScript]:canCarryItem(self.identifier, name, count)
	end

	self.canSwapItem = function(firstItem, firstItemCount, testItem, testItemCount)
		local firstItemObject = self.getInventoryItem(firstItem)

		if firstItemObject.count >= firstItemCount then
			local weightWithoutFirstItem = ESX.Math.Round(self.getWeight() - (ESX.Items[firstItem].weight * firstItemCount))
			local weightWithTestItem = ESX.Math.Round(weightWithoutFirstItem + (ESX.Items[testItem].weight * testItemCount))

			return weightWithTestItem <= self.maxWeight
		end

		return false
	end

	self.clearAllInventoryWeapons = function(perma)
		return exports[exports.Tree:serveurConfig().Serveur.hudScript]:clearAllInventoryWeapons(self.identifier, perma)
	end
	
	self.addWeapon = function(weaponName, ammo, addArgs, bypass)
		if type(weaponName) ~= 'string' then return end
		weaponName = string.lower(weaponName);

		local Data = {
			originOwner = self.identifier
		}

		if (exports[exports.Tree:serveurConfig().Serveur.hudScript]:getWeaponIsPerma(weaponName)) then
			Data.antiActions = 'perma'
		end

		if (addArgs ~= nil) then
			if (next(addArgs) ~= nil) then
				for key, value in pairs(addArgs) do
					Data[key] = value
				end
			end
		end

		exports[exports.Tree:serveurConfig().Serveur.hudScript]:addInventoryItem(self.identifier, weaponName, 1, Data, bypass)
	end

	self.removeWeaponSystem = function(weaponName)
		if type(weaponName) ~= 'string' then return end
		exports[exports.Tree:serveurConfig().Serveur.hudScript]:removeWeaponSystem(self.identifier, weaponName)
	end

	self.CurrentWeaponId = nil
	self.getCurrentWeaponId = function()
		return CurrentWeaponId
	end
	self.setCurrentWeaponId = function(id)
		CurrentWeaponId = id
	end

	self.getWeaponsById = function(id)
		return exports[exports.Tree:serveurConfig().Serveur.hudScript]:getWeaponsById(self.identifier, id)
	end

	self.setWeaponsAmmoById = function(id, ammo)
		exports[exports.Tree:serveurConfig().Serveur.hudScript]:setWeaponsAmmoById(self.identifier, id, ammo)
	end

	self.getAccount = function(accountName)
		if (accountName == 'bank') then
			for i = 1, #self.accounts, 1 do
				if self.accounts[i].name == accountName then
					return self.accounts[i]
				end
			end
		else
			return exports[exports.Tree:serveurConfig().Serveur.hudScript]:getAccount(self.identifier, accountName)
		end
	end
	self.addAccountMoney = function(accountName, money)
		money = ESX.Math.Check(ESX.Math.Round(money))
	
		if money > 0 then
			local account = self.getAccount(accountName)

			if account then
				if (accountName == 'bank') then
					local newMoney = ESX.Math.Check(account.money + money)
					account.money = newMoney

					self.triggerEvent('esx:setAccountMoney', account)
				else
					exports[exports.Tree:serveurConfig().Serveur.hudScript]:addInventoryItem(self.identifier, accountName, money)
				end
			end
		end
	end
	self.removeAccountMoney = function(accountName, money)
		money = ESX.Math.Check(ESX.Math.Round(money))
	
		if money > 0 then
			local account = self.getAccount(accountName)

			if account then
				if (accountName == 'bank') then
					local newMoney = ESX.Math.Check(account.money - money)

					account.money = newMoney
					self.triggerEvent('esx:setAccountMoney', account)
				else
					exports[exports.Tree:serveurConfig().Serveur.hudScript]:removeInventoryItem(self.identifier, accountName, money)
				end
			end
		end
	end




	self.getAccounts = function(minimal)
		if minimal then
			local minimalAccounts = {}

			for i = 1, #self.accounts, 1 do
				table.insert(minimalAccounts, {
					name = self.accounts[i].name,
					money = self.accounts[i].money
				})
			end

			return minimalAccounts
		else
			return self.accounts
		end
	end

	self.setAccountMoney = function(accountName, money)
		money = ESX.Math.Check(ESX.Math.Round(money))
	
		if money >= 0 then
			local account = self.getAccount(accountName)

			if account then
				account.money = money
				self.triggerEvent('esx:setAccountMoney', account)
			end
		end
	end

	---------END





	ExecuteCommand(('add_principal identifier.%s group.%s'):format(self.identifier, self.permission_group))

	---@return string
	self.getFirstName = function()
		return self.firstname;
	end

	---@return string
	self.getLastName = function()
		return self.lastname;
	end

	self.triggerEvent = function(eventName, ...)
		TriggerClientEvent(eventName, self.source, ...)
	end

	self.chatMessage = function(msg, author, color)
		self.triggerEvent('chat:addMessage', {color = color or {0, 0, 0}, args = {author or 'SYSTEME', msg or ''}})
	end

	self.kick = function(reason)
		DropPlayer(self.source, reason)
	end

	self.set = function(key, value)
		self[key] = value
	end

	self.get = function(key)
		return self[key]
	end

	self.getLevel = function()
		return self.permission_level
	end

	self.setLevel = function(level)
		local lastLevel = permission_level

		if type(level) == "number" then
			self.permission_level = level

			TriggerEvent('esx:setLevel', self.source, self.permission_level, lastLevel)
			self.triggerEvent('esx:setLevel', self.permission_level, lastLevel)
		end
	end

	self.getGroup = function()
		return self.permission_group
	end

	self.setGroup = function(groupName)
		local lastGroup = self.permission_group;

		if ESX.Groups[groupName] then
			self.permission_group = groupName

			for k, v in pairs(ESX.Groups) do
				ExecuteCommand(('remove_principal identifier.%s group.%s'):format(self.identifier, k))
			end

			ExecuteCommand(('add_principal identifier.%s group.%s'):format(self.identifier, groupName))

			-- TriggerEvent('esx:setGroup', self.source, self.permission_group, lastGroup);
			self.triggerEvent('esx:setGroup', self.permission_group, lastGroup);
		else
			-- print(('[^3WARNING^7] Ignoring invalid .setGroup() usage for "%s"'):format(self.identifier))
		end
	end

	self.getIdentifier = function()
		return self.identifier
	end

	self.getJob = function()
		return self.job
	end

	self.getJob2 = function()
		return self.job2
	end

	self.getUniqueId = function()
		return self.uniqueid
	end

	self.getName = function()
		return self.name
	end

	self.setName = function(name)
		self.name = name
	end

	self.getCoords = function()
		local coords = GetEntityCoords(GetPlayerPed(self.source))

		if type(coords) ~= 'vector3' or ((coords.x >= -1.0 and coords.x <= 1.0) and (coords.y >= -1.0 and coords.y <= 1.0) and (coords.z >= -1.0 and coords.z <= 1.0)) then
			coords = self.getLastPosition()
		end

		return coords
	end

	self.getLastPosition = function()
		return self.lastPosition
	end

	self.setLastPosition = function(coords)
		self.lastPosition = coords
	end


	self.setJob = function(job, grade)
		grade = tostring(grade)
		local lastJob = json.decode(json.encode(self.job))

		if ESX.DoesJobExist(job, grade) then
			local jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]
			local skins = ESX.ConvertJobSkins(gradeObject);

			self.job.id = jobObject.id or nil
			self.job.name = jobObject.name
			self.job.label = jobObject.label
			self.job.canWashMoney = jobObject.canWashMoney
			self.job.canUseOffshore = jobObject.canUseOffshore

			self.job.grade = tonumber(grade)
			self.job.grade_name = gradeObject.name
			self.job.grade_label = gradeObject.label
			self.job.grade_salary = gradeObject.salary

			if gradeObject.skin_male then
				self.job.skin_male = skins["male"];
			end

			if gradeObject.skin_female then
				self.job.skin_female = skins["female"];
			end

			TriggerEvent('esx:setJob', self.source, self.job, lastJob)
			self.triggerEvent('esx:setJob', self.job)
		else
			-- print(('[^3WARNING^7] Ignoring invalid .setJob() usage for "%s"'):format(self.identifier))
		end
	end

	self.setJob2 = function(job2, grade2)
		grade2 = tostring(grade2)
		local lastJob2 = json.decode(json.encode(self.job2))

		if ESX.DoesJobExist(job2, grade2) then
			local job2Object, grade2Object = ESX.Jobs[job2], ESX.Jobs[job2].grades[grade2]

			local skins = ESX.ConvertJobSkins(grade2Object);

			self.job2.id = job2Object.id
			self.job2.name = job2Object.name
			self.job2.label = job2Object.label
			self.job2.canWashMoney = job2Object.canWashMoney
			self.job2.canUseOffshore = job2Object.canUseOffshore

			self.job2.grade = tonumber(grade2)
			self.job2.grade_name = grade2Object.name
			self.job2.grade_label = grade2Object.label
			self.job2.grade_salary = grade2Object.salary

			if grade2Object.skin_male ~= nil then
				self.job2.skin_male = skins["male"];
			end

			if grade2Object.skin_female ~= nil then
				self.job2.skin_female = skins["female"];
			end

			TriggerEvent('esx:setJob2', self.source, self.job2, lastJob2)
			self.triggerEvent('esx:setJob2', self.job2)
		else
			-- print(('[^3WARNING^7] Ignoring invalid .setJob() usage for "%s"'):format(self.identifier))
		end
	end

	self.showNotification = function(msg, hudColorIndex)
		self.triggerEvent('esx:showNotification', msg, hudColorIndex)
	end

	self.showAdvancedNotification = function(title, subject, msg, icon, iconType, hudColorIndex)
		self.triggerEvent('esx:showAdvancedNotification', title, subject, msg, icon, iconType, hudColorIndex)
	end

	self.showHelpNotification = function(msg)
		self.triggerEvent('esx:showHelpNotification', msg)
	end

	---@param time number
	---@param message string
	self.ban = function(time, message)
		exports["WaveShield"]:banPlayer(self.source, message, "Protect Trigger", "Main", time)
	end

	return self
end
