

function sendLogsToDiscordForKill(name,message,color)
    date_local1 = os.date('%H:%M:%S', os.time())
    local date_local = date_local1
    local DiscordWebHook = ConfigForWB.Webhooks.Kill
    -- Modify here your discordWebHook username = name, content = message,embeds = embeds
  
  local embeds = {
      {
          ["title"]=message,
          ["type"]="rich",
          ["color"] =color,
          ["footer"]=  {
              ["text"]= "Heure: " ..date_local.. "",
         },
      }
  }
  
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end 

function sendLogsToDiscordForGiveObject(name,message,color)
    date_local1 = os.date('%H:%M:%S', os.time())
    local date_local = date_local1
    local DiscordWebHook = ConfigForWB.Webhooks.Object
    -- Modify here your discordWebHook username = name, content = message,embeds = embeds
  
  local embeds = {
      {
          ["title"]=message,
          ["type"]="rich",
          ["color"] =color,
          ["footer"]=  {
              ["text"]= "Heure: " ..date_local.. "",
         },
      }
  }
  
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function sendLogsToDiscordForGiveWeapon(name,message,color)
    date_local1 = os.date('%H:%M:%S', os.time())
    local date_local = date_local1
    local DiscordWebHook = exports.Tree:serveurConfig().Logs.GiveWeapons
    -- Modify here your discordWebHook username = name, content = message,embeds = embeds
  
  local embeds = {
      {
          ["title"]=message,
          ["type"]="rich",
          ["color"] =color,
          ["footer"]=  {
              ["text"]= "Heure: " ..date_local.. "",
         },
      }
  }
  
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function sendLogsToDiscordForStaffActions(name,message,color)
    date_local1 = os.date('%H:%M:%S', os.time())
    local date_local = date_local1
    local DiscordWebHook = ConfigForWB.Webhooks.Staff
    -- Modify here your discordWebHook username = name, content = message,embeds = embeds
  
  local embeds = {
      {
          ["title"]=message,
          ["type"]="rich",
          ["color"] =color,
          ["footer"]=  {
              ["text"]= "Heure: " ..date_local.. "",
         },
      }
  }
  
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function sendLogsToDiscordForEntreprises(name,message,color)
    date_local1 = os.date('%H:%M:%S', os.time())
    local date_local = date_local1
    local DiscordWebHook = ConfigForWB.Webhooks.Entreprises
    -- Modify here your discordWebHook username = name, content = message,embeds = embeds
  
  local embeds = {
      {
          ["title"]=message,
          ["type"]="rich",
          ["color"] =color,
          ["footer"]=  {
              ["text"]= "Heure: " ..date_local.. "",
         },
      }
  }
  
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function sendLogsToDiscordForCoffre(name,message,color)
    date_local1 = os.date('%H:%M:%S', os.time())
    local date_local = date_local1
    local DiscordWebHook = ConfigForWB.Webhooks.Coffre
    -- Modify here your discordWebHook username = name, content = message,embeds = embeds
  
  local embeds = {
      {
          ["title"]=message,
          ["type"]="rich",
          ["color"] =color,
          ["footer"]=  {
              ["text"]= "Heure: " ..date_local.. "",
         },
      }
  }
  
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end


function SendLogsOther(name, title, message, web)
    local local_date = os.date('%H:%M:%S', os.time())
  
	local embeds = {
		{
			["title"]= title,
			["description"]= message,
			["type"]= "rich",
			["color"] = 16776960,
			["footer"]=  {
                ["text"] = "Powered by "..exports.Tree:serveurConfig().Serveur.label.." | "..local_date.."",
			},
		}
	}
  
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(web, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end