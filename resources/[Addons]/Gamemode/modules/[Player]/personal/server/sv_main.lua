

local SharedGangs = {}

ESX.RegisterServerCallback('GetBills', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local bills = {}

	MySQL.Async.fetchAll('SELECT * FROM billing WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		for i = 1, #result, 1 do
			table.insert(bills, {
				id = result[i].id,
				label = result[i].label,
				amount = result[i].amount
			})
		end

		cb(bills)
	end)
end)

ESX.RegisterServerCallback('getGangsAccount', function(source, cb)
	MySQL.Async.fetchAll('SELECT * FROM gangs', {}, function(data)
        for k,v in pairs(data) do
            if not SharedGangs[v.name] then 
                SharedGangs[v.name] = {}
                SharedGangs[v.name].name = v.name 
                SharedGangs[v.name].label = v.label 
                SharedGangs[v.name].coords = json.decode(v.coords )
                SharedGangs[v.name].data = json.decode(v.data)
                SharedGangs[v.name].vehicle = json.decode(v.vehicle)
                TriggerEvent('esx_society:registerSociety', v.name, v.label, 'society_'..v.name, 'society_'..v.name, 'society_'..v.name, {type = 'public'})
            end
        end
		cb(SharedGangs)
        GangsLoaded = true
    end)
end)

RegisterServerEvent('interact:sendLogsGive')
AddEventHandler('interact:sendLogsGive', function(item, quantity, closest)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local tPlayer = ESX.GetPlayerFromId(closest)
	local local_date = os.date('%H:%M:%S', os.time())
	local webhookLink = exports.Tree:serveurConfig().Logs.DonnerItemJoueur
	local content = {
		{
			["title"] = "**Don d'item :**",
			["fields"] = {
				{ name = "**- Date & Heure :**", value = local_date },
				{ name = "- Qui a donner :", value = xPlayer.name.." ["..source.."] ["..xPlayer.identifier.."]" },
				{ name = "- Item donner :", value = item.." x"..quantity },
				{ name = "- Qui a reçu :", value = tPlayer.name.." ["..closest.."] ["..tPlayer.identifier.."]" },
			},
			["type"]  = "rich",
			["color"] = 2061822,
			["footer"] =  {
			["text"] = "By Master | "..exports.Tree:serveurConfig().Serveur.label,
			},
		}
	}
	PerformHttpRequest(webhookLink, function(err, text, headers) end, 'POST', json.encode({username = "Logs PersonalMenu", embeds = content}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('tLogs:donArmes')
AddEventHandler('tLogs:donArmes', function(item, closest)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local tPlayer = ESX.GetPlayerFromId(closest)
	local local_date = os.date('%H:%M:%S', os.time())
	local webhookLink = exports.Tree:serveurConfig().Logs.DonnerItemJoueur
	local content = {
		{
			["title"] = "**Don d'armes :**",
			["fields"] = {
				{ name = "**- Date & Heure :**", value = local_date },
				{ name = "- Qui a donner :", value = xPlayer.name.." ["..source.."] ["..xPlayer.identifier.."]" },
				{ name = "- Armes donner :", value = item },
				{ name = "- Qui a reçu :", value = tPlayer.name.." ["..closest.."] ["..tPlayer.identifier.."]" },
			},
			["type"]  = "rich",
			["color"] = 2061822,
			["footer"] =  {
			["text"] = "By Master | "..exports.Tree:serveurConfig().Serveur.label,
			},
		}
	}
	PerformHttpRequest(webhookLink, function(err, text, headers) end, 'POST', json.encode({username = "Logs PersonalMenu", embeds = content}), { ['Content-Type'] = 'application/json' })

end)

RegisterServerEvent('interact:sendLogsJeter')
AddEventHandler('interact:sendLogsJeter', function(item, quantity, closest)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local local_date = os.date('%H:%M:%S', os.time())
	local webhookLink = exports.Tree:serveurConfig().Logs.JeterItemJoueur
	local content = {
		{
			["title"] = "**Drop argent [SALE] :**",
			["fields"] = {
				{ name = "**- Date & Heure :**", value = local_date },
				{ name = "- Qui a jetter :", value = xPlayer.name.." ["..source.."] ["..xPlayer.identifier.."]" },
				{ name = "- sommes jetter :", value = quantity.."$ "..item },
			},
			["type"]  = "rich",
			["color"] = 16711680,
			["footer"] =  {
			["text"] = "By Master | "..exports.Tree:serveurConfig().Serveur.label,
			},
		}
	}
	PerformHttpRequest(webhookLink, function(err, text, headers) end, 'POST', json.encode({username = "Logs PersonalMenu", embeds = content}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('recrutejoueur')
AddEventHandler('recrutejoueur', function(target, job, grade)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local _source = source

	local local_date = os.date('%H:%M:%S', os.time())

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local webhookLink = exports.Tree:serveurConfig().Logs.RecruterJoueurSociety
	
	targetXPlayer.setJob(job, grade)

	
		local content = {
			{
				["title"] = "**RC joueurs :**",
				["fields"] = {
					{ name = "**- Date & Heure :**", value = local_date },
					{ name = "- Joueurs RC :", value = targetXPlayer.name.." ["..target.."] ["..targetXPlayer.identifier.."]"},
					{ name = "- Nouveau job :", value = targetXPlayer.job.name.." - "..targetXPlayer.job.grade_name },
					{ name = "- Auteur du RC :", value = sourceXPlayer.name.." ["..source.."] ["..sourceXPlayer.identifier.."]" },
				},
				["type"]  = "rich",
				["color"] = 3130015,
				["footer"] =  {
				["text"] = "By Master | "..exports.Tree:serveurConfig().Serveur.label,
				},
			}
		}
		PerformHttpRequest(webhookLink, function(err, text, headers) end, 'POST', json.encode({username = "Logs RC ", embeds = content}), { ['Content-Type'] = 'application/json' })

 	TriggerClientEvent('tF:showNotification', source, 'Vous avez ~g~recruté~s~ ' .. targetXPlayer.name .. '.')
 	TriggerClientEvent('tF:showNotification', target, 'Vous avez été ~g~embauché~s~ par ' .. sourceXPlayer.name .. '.')
end)

-- RegisterServerEvent('recrutejoueur')
-- AddEventHandler('recrutejoueur', function(target, job, grade)
-- 	local sourceXPlayer = ESX.GetPlayerFromId(source)
-- 	local targetXPlayer = ESX.GetPlayerFromId(target)

-- 	if sourceXPlayer.job.grade_name == 'boss' then
-- 		targetXPlayer.setJob(job, grade)
-- 		TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous avez ~g~recruté ' .. targetXPlayer.name .. '.')
-- 		TriggerClientEvent('esx:showNotification', target, 'Vous avez été ~g~embauché par ' .. sourceXPlayer.name .. '.')
-- 	end
-- end)

RegisterServerEvent('virerjoueur')
AddEventHandler('virerjoueur', function(target)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if sourceXPlayer.job.grade_name == 'boss' and sourceXPlayer.job.name == targetXPlayer.job.name then
		targetXPlayer.setJob('unemployed', 0)
		TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous avez '..exports.Tree:serveurConfig().Serveur.color..'viré ' .. targetXPlayer.name .. '.')
		TriggerClientEvent('esx:showNotification', target, 'Vous avez été ~g~viré par ' .. sourceXPlayer.name .. '.')

		local local_date = os.date('%H:%M:%S', os.time())
		local webhookLink = exports.Tree:serveurConfig().Logs.VirerJoueurSociety
		local content = {
			{
				["title"] = "**Licenciement joueurs :**",
				["fields"] = {
					{ name = "**- Date & Heure :**", value = local_date },
					{ name = "- Joueurs rc :", value = targetXPlayer.name.." ["..target.."] ["..targetXPlayer.identifier.."]"},
					{ name = "- Nouveau job :", value = targetXPlayer.job.name.." - "..targetXPlayer.job.grade_name },
					{ name = "- auteur du licenciement :", value = sourceXPlayer.name.." ["..source.."] ["..sourceXPlayer.identifier.."]" },
				},
				["type"]  = "rich",
				["color"] = 3093151,
				["footer"] =  {
				["text"] = "By Master | "..exports.Tree:serveurConfig().Serveur.label,
				},
			}
		}
		PerformHttpRequest(webhookLink, function(err, text, headers) end, 'POST', json.encode({username = "Logs licenciement ", embeds = content}), { ['Content-Type'] = 'application/json' })
	else
		TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas '..exports.Tree:serveurConfig().Serveur.color..'l\'autorisation.')
	end
end)

RegisterServerEvent('c26bgdtoklmtbr:{-pp}')
AddEventHandler('c26bgdtoklmtbr:{-pp}', function(target)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if (targetXPlayer.job.grade == tonumber(getMaximumGrade(sourceXPlayer.job.name)) - 1) then
		TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous devez demander une autorisation du '..exports.Tree:serveurConfig().Serveur.color..'Gouvernement.')
	else
		if sourceXPlayer.job.grade_name == 'boss' and sourceXPlayer.job.name == targetXPlayer.job.name then
			targetXPlayer.setJob(sourceXPlayer.job.name, tonumber(targetXPlayer.job.grade) + 1)
		

			TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous avez ~g~promu ' .. targetXPlayer.name.." ~s~" .. targetXPlayer.job.grade_label)
			TriggerClientEvent('esx:showNotification', target, 'Vous avez été ~g~promu par ' .. sourceXPlayer.name .. '.')
			local local_date = os.date('%H:%M:%S', os.time())
			local webhookLink = exports.Tree:serveurConfig().Logs.PromotionJoueurSociety
			local content = {
				{
					["title"] = "**Promotion joueurs :**",
					["fields"] = {
						{ name = "**- Date & Heure :**", value = local_date },
						{ name = "- Joueurs promu :", value = targetXPlayer.name.." ["..target.."] ["..targetXPlayer.identifier.."]"},
						{ name = "- Nouveau job :", value = targetXPlayer.job.name.." - "..targetXPlayer.job.grade_label},
						{ name = "- auteur du UP :", value = sourceXPlayer.name.." ["..sourceXPlayer.identifier.."]" },
					},
					["type"]  = "rich",
					["color"] = 16187381,
					["footer"] =  {
					["text"] = "By Master | "..exports.Tree:serveurConfig().Serveur.label,
					},
				}
			}
			PerformHttpRequest(webhookLink, function(err, text, headers) end, 'POST', json.encode({username = "Logs RankUp ", embeds = content}), { ['Content-Type'] = 'application/json' })
		else
			TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas '..exports.Tree:serveurConfig().Serveur.color..'l\'autorisation.')
		end
	end
end)

RegisterServerEvent('f45bgdtj78ql:[tl-yu]')
AddEventHandler('f45bgdtj78ql:[tl-yu]', function(target)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if (targetXPlayer.job.grade == 0) then
		TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous ne pouvez pas '..exports.Tree:serveurConfig().Serveur.color..'rétrograder davantage.')
	else
		if sourceXPlayer.job.grade_name == 'boss' and sourceXPlayer.job.name == targetXPlayer.job.name then
			targetXPlayer.setJob(targetXPlayer.job.name, tonumber(targetXPlayer.job.grade) - 1)

			TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous avez '..exports.Tree:serveurConfig().Serveur.color..'rétrogradé ' .. targetXPlayer.name .. '.')
			TriggerClientEvent('esx:showNotification', target, 'Vous avez été '..exports.Tree:serveurConfig().Serveur.color..'rétrogradé par ' .. sourceXPlayer.name .. '.')

			local local_date = os.date('%H:%M:%S', os.time())
			local webhookLink = exports.Tree:serveurConfig().Logs.DerankJoueurSociety
			local content = {
				{
					["title"] = "**Derank joueurs :**",
					["fields"] = {
						{ name = "**- Date & Heure :**", value = local_date },
						{ name = "- Joueurs Derank :", value = targetXPlayer.name.." ["..target.."] ["..targetXPlayer.identifier.."]"},
						{ name = "- Nouveau job :", value = targetXPlayer.job.name.." - "..targetXPlayer.job.grade_name },
						{ name = "- auteur du Derank :", value = sourceXPlayer.name.." ["..sourceXPlayer.identifier.."]" },
					},
					["type"]  = "rich",
					["color"] = 16122101,
					["footer"] =  {
					["text"] = "By Master | "..exports.Tree:serveurConfig().Serveur.label,
					},
				}
			}
			PerformHttpRequest(webhookLink, function(err, text, headers) end, 'POST', json.encode({username = "Logs Derank ", embeds = content}), { ['Content-Type'] = 'application/json' })

		else
			TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas '..exports.Tree:serveurConfig().Serveur.color..'l\'autorisation.')
		end
	end
end)


RegisterServerEvent('recrutejoueur2')
AddEventHandler('recrutejoueur2', function(target, job, grade)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if sourceXPlayer.job.grade_name == 'boss' then
		targetXPlayer.setJob(job, grade)
		TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous avez ~g~recruté ' .. targetXPlayer.name .. '.')
		TriggerClientEvent('esx:showNotification', target, 'Vous avez été ~g~embauché par ' .. sourceXPlayer.name .. '.')
	end
end)

RegisterServerEvent('virerjoueur2')
AddEventHandler('virerjoueur2', function(target)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if sourceXPlayer.job.grade_name == 'boss' and sourceXPlayer.job.name == targetXPlayer.job.name then
		targetXPlayer.setJob('unemployed', 0)
		TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous avez '..exports.Tree:serveurConfig().Serveur.color..'viré ' .. targetXPlayer.name .. '.')
		TriggerClientEvent('esx:showNotification', target, 'Vous avez été ~g~viré par ' .. sourceXPlayer.name .. '.')

		local local_date = os.date('%H:%M:%S', os.time())
		local webhookLink = exports.Tree:serveurConfig().Logs.VirerJoueurSociety
		local content = {
			{
				["title"] = "**Licenciement joueurs :**",
				["fields"] = {
					{ name = "**- Date & Heure :**", value = local_date },
					{ name = "- Joueurs rc :", value = targetXPlayer.name.." ["..target.."] ["..targetXPlayer.identifier.."]"},
					{ name = "- Nouveau job :", value = targetXPlayer.job.name.." - "..targetXPlayer.job.grade_name },
					{ name = "- auteur du licenciement :", value = sourceXPlayer.name.." ["..source.."] ["..sourceXPlayer.identifier.."]" },
				},
				["type"]  = "rich",
				["color"] = 3093151,
				["footer"] =  {
				["text"] = "By Master | "..exports.Tree:serveurConfig().Serveur.label,
				},
			}
		}
		PerformHttpRequest(webhookLink, function(err, text, headers) end, 'POST', json.encode({username = "Logs licenciement ", embeds = content}), { ['Content-Type'] = 'application/json' })
	else
		TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas '..exports.Tree:serveurConfig().Serveur.color..'l\'autorisation.')
	end
end)

RegisterServerEvent('c26bgdtoklmtbr:{-pp}2')
AddEventHandler('c26bgdtoklmtbr:{-pp}2', function(target)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if (targetXPlayer.job.grade == tonumber(getMaximumGrade(sourceXPlayer.job.name)) - 1) then
		TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous devez demander une autorisation du '..exports.Tree:serveurConfig().Serveur.color..'Gouvernement.')
	else
		if sourceXPlayer.job.grade_name == 'boss' and sourceXPlayer.job.name == targetXPlayer.job.name then
			targetXPlayer.setJob(sourceXPlayer.job.name, tonumber(targetXPlayer.job.grade) + 1)

			TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous avez ~g~promu ' .. sourceXPlayer.name.." ~s~" .. tonumber(sourceXPlayer.job.grade_label) + 1)
			TriggerClientEvent('esx:showNotification', target, 'Vous avez été ~g~promu par ' .. sourceXPlayer.name .. '.')
	local local_date = os.date('%H:%M:%S', os.time())
	local webhookLink = exports.Tree:serveurConfig().Logs.PromotionJoueurSociety
	local content = {
		{
			["title"] = "**Promotion joueurs :**",
			["fields"] = {
				{ name = "**- Date & Heure :**", value = local_date },
				{ name = "- Joueurs promu :", value = targetXPlayer.name.." ["..target.."] ["..targetXPlayer.identifier.."]"},
				{ name = "- Nouveau job :", value = targetXPlayer.job.name.." - "..targetXPlayer.job.grade },
				{ name = "- auteur du UP :", value = sourceXPlayer.name.." ["..sourceXPlayer.identifier.."]" },
			},
			["type"]  = "rich",
			["color"] = 16187381,
			["footer"] =  {
			["text"] = "By Master | "..exports.Tree:serveurConfig().Serveur.label,
			},
		}
	}
	PerformHttpRequest(webhookLink, function(err, text, headers) end, 'POST', json.encode({username = "Logs RankUp ", embeds = content}), { ['Content-Type'] = 'application/json' })

		else
			TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas '..exports.Tree:serveurConfig().Serveur.color..'l\'autorisation.')
		end
	end
end)

RegisterServerEvent('f45bgdtj78ql:[tl-yu]2')
AddEventHandler('f45bgdtj78ql:[tl-yu]2', function(target)
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if (targetXPlayer.job.grade == 0) then
		TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous ne pouvez pas '..exports.Tree:serveurConfig().Serveur.color..'rétrograder davantage.')
	else
		if sourceXPlayer.job.grade_name == 'boss' and sourceXPlayer.job.name == targetXPlayer.job.name then
			targetXPlayer.setJob(targetXPlayer.job.name, tonumber(targetXPlayer.job.grade) - 1)

			TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous avez '..exports.Tree:serveurConfig().Serveur.color..'rétrogradé ' .. targetXPlayer.name .. '.')
			TriggerClientEvent('esx:showNotification', target, 'Vous avez été '..exports.Tree:serveurConfig().Serveur.color..'rétrogradé par ' .. sourceXPlayer.name .. '.')

			local local_date = os.date('%H:%M:%S', os.time())
			local webhookLink = exports.Tree:serveurConfig().Logs.DerankJoueurSociety
			local content = {
				{
					["title"] = "**Derank joueurs :**",
					["fields"] = {
						{ name = "**- Date & Heure :**", value = local_date },
						{ name = "- Joueurs Derank :", value = targetXPlayer.name.." ["..target.."] ["..targetXPlayer.identifier.."]"},
						{ name = "- Nouveau job :", value = targetXPlayer.job.name.." - "..targetXPlayer.job.grade_name },
						{ name = "- auteur du Derank :", value = sourceXPlayer.name.." ["..sourceXPlayer.identifier.."]" },
					},
					["type"]  = "rich",
					["color"] = 16122101,
					["footer"] =  {
					["text"] = "By Master | "..exports.Tree:serveurConfig().Serveur.label,
					},
				}
			}
			PerformHttpRequest(webhookLink, function(err, text, headers) end, 'POST', json.encode({username = "Logs Derank ", embeds = content}), { ['Content-Type'] = 'application/json' })

		else
			TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas '..exports.Tree:serveurConfig().Serveur.color..'l\'autorisation.')
		end
	end
end)

RegisterServerEvent('babyboy:customAnnonce')
AddEventHandler('babyboy:customAnnonce', function(msg)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.grade_name == 'boss' then
        TriggerClientEvent("esx:showNotification", -1, ""..xPlayer.job.label.."\n : ~o~"..msg)
    else
        return
    end
end)

function getMaximumGrade(jobname)
    local result = MySQL.Sync.fetchAll("SELECT * FROM job_grades WHERE job_name=@jobname  ORDER BY `grade` DESC ;", {
        ['@jobname'] = jobname
    })
    if result[1] ~= nil then
        return result[1].grade
    end
    return nil
end


ESX.RegisterUsableItem("idcard", function(source)
    TriggerClientEvent('view:idcard', source)
end)

ESX.RegisterUsableItem("weapon", function(source)
    TriggerClientEvent('view:ppa', source)
end)

ESX.RegisterUsableItem("drive", function(source)
    TriggerClientEvent('view:permis', source)
end)