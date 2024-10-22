RegisterNetEvent('sendLogs:Facture')
AddEventHandler('sendLogs:Facture', function(player, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local tPlayer = ESX.GetPlayerFromId(player)

    if xPlayer.job.name == "police" then
        logsAllJob("[Facture "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Citoyen facturer : **"..tPlayer.getFirstName().." "..tPlayer.getLastName().." - ("..tPlayer.name..")\n\n**Montant de la facture : **"..amount.."$", exports.Tree:serveurConfig().Logs.FactureLogs)
    end
    if xPlayer.job.name == "avocat" then
        logsAllJob("[Facture "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Citoyen facturer : **"..tPlayer.getFirstName().." "..tPlayer.getLastName().." - ("..tPlayer.name..")\n\n**Montant de la facture : **"..amount.."$", exports.Tree:serveurConfig().Logs.FactureLogs)
    end
    if xPlayer.job.name == "ambulance" then
        logsAllJob("[Facture "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Citoyen facturer : **"..tPlayer.getFirstName().." "..tPlayer.getLastName().." - ("..tPlayer.name..")\n\n**Montant de la facture : **"..amount.."$", exports.Tree:serveurConfig().Logs.FactureLogs)
    end
    if xPlayer.job.name == "burgershot" then
        logsAllJob("[Facture "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Citoyen facturer : **"..tPlayer.getFirstName().." "..tPlayer.getLastName().." - ("..tPlayer.name..")\n\n**Montant de la facture : **"..amount.."$", exports.Tree:serveurConfig().Logs.FactureLogs)
    end
    if xPlayer.job.name == "journalist" then
        logsAllJob("[Facture "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Citoyen facturer : **"..tPlayer.getFirstName().." "..tPlayer.getLastName().." - ("..tPlayer.name..")\n\n**Montant de la facture : **"..amount.."$", exports.Tree:serveurConfig().Logs.FactureLogs)
    end
    if xPlayer.job.name == "label" then
        logsAllJob("[Facture "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Citoyen facturer : **"..tPlayer.getFirstName().." "..tPlayer.getLastName().." - ("..tPlayer.name..")\n\n**Montant de la facture : **"..amount.."$", exports.Tree:serveurConfig().Logs.FactureLogs)
    end
    if xPlayer.job.name == "ltd_sud" then
        logsAllJob("[Facture "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Citoyen facturer : **"..tPlayer.getFirstName().." "..tPlayer.getLastName().." - ("..tPlayer.name..")\n\n**Montant de la facture : **"..amount.."$", exports.Tree:serveurConfig().Logs.FactureLogs)
    end
    if xPlayer.job.name == "mecano" then
        logsAllJob("[Facture "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Citoyen facturer : **"..tPlayer.getFirstName().." "..tPlayer.getLastName().." - ("..tPlayer.name..")\n\n**Montant de la facture : **"..amount.."$", exports.Tree:serveurConfig().Logs.FactureLogs)
    end
    if xPlayer.job.name == "mecano2" then
        logsAllJob("[Facture "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Citoyen facturer : **"..tPlayer.getFirstName().." "..tPlayer.getLastName().." - ("..tPlayer.name..")\n\n**Montant de la facture : **"..amount.."$", exports.Tree:serveurConfig().Logs.FactureLogs)
    end
    if xPlayer.job.name == "taxi" then
        logsAllJob("[Facture "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Citoyen facturer : **"..tPlayer.getFirstName().." "..tPlayer.getLastName().." - ("..tPlayer.name..")\n\n**Montant de la facture : **"..amount.."$", exports.Tree:serveurConfig().Logs.FactureLogs)
    end
    if xPlayer.job.name == "tequilala" then
        logsAllJob("[Facture "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Citoyen facturer : **"..tPlayer.getFirstName().." "..tPlayer.getLastName().." - ("..tPlayer.name..")\n\n**Montant de la facture : **"..amount.."$", exports.Tree:serveurConfig().Logs.FactureLogs)
    end
    if xPlayer.job.name == "unicorn" then
        logsAllJob("[Facture "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Citoyen facturer : **"..tPlayer.getFirstName().." "..tPlayer.getLastName().." - ("..tPlayer.name..")\n\n**Montant de la facture : **"..amount.."$", exports.Tree:serveurConfig().Logs.FactureLogs)
    end
end)


RegisterNetEvent('sendLogs:ServiceYes')
AddEventHandler('sendLogs:ServiceYes', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name == "avocat" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", exports.Tree:serveurConfig().Logs.JobPriseService)
    end
    if xPlayer.job.name == "ambulance" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", exports.Tree:serveurConfig().Logs.JobPriseService)
    end
    if xPlayer.job.name == "police" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", exports.Tree:serveurConfig().Logs.JobPriseService)
    end
    if xPlayer.job.name == "bcso" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", exports.Tree:serveurConfig().Logs.JobPriseService)
    end
    if xPlayer.job.name == "burgershot" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", exports.Tree:serveurConfig().Logs.JobPriseService)
    end
    if xPlayer.job.name == "journalist" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", exports.Tree:serveurConfig().Logs.JobPriseService)
    end
    if xPlayer.job.name == "realestateagent" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", exports.Tree:serveurConfig().Logs.JobPriseService)
    end
    if xPlayer.job.name == "label" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", exports.Tree:serveurConfig().Logs.JobPriseService)
    end
    if xPlayer.job.name == "ltd_sud" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", exports.Tree:serveurConfig().Logs.JobPriseService)
    end
    if xPlayer.job.name == "mecano" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", exports.Tree:serveurConfig().Logs.JobPriseService)
    end
    if xPlayer.job.name == "mecano2" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", exports.Tree:serveurConfig().Logs.JobPriseService)
    end
    if xPlayer.job.name == "taxi" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", exports.Tree:serveurConfig().Logs.JobPriseService)
    end
    if xPlayer.job.name == "tequilala" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", exports.Tree:serveurConfig().Logs.JobPriseService)
    end
    if xPlayer.job.name == "unicorn" then
        logsPriseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", exports.Tree:serveurConfig().Logs.JobPriseService)
    end
end)


RegisterNetEvent('sendLogs:ServiceNo')
AddEventHandler('sendLogs:ServiceNo', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name == "avocat" then
        logsCloseService("[Fin de Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre sa fin de service !", exports.Tree:serveurConfig().Logs.JobFinService)
    end
    if xPlayer.job.name == "ambulance" then
        logsCloseService("[Fin de Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre sa fin de service !", exports.Tree:serveurConfig().Logs.JobFinService)
    end
    if xPlayer.job.name == "burgershot" then
        logsCloseService("[Fin de Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre sa fin de service !", exports.Tree:serveurConfig().Logs.JobFinService)
    end
    if xPlayer.job.name == "journalist" then
        logsCloseService("[Fin de Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre sa fin de service !", exports.Tree:serveurConfig().Logs.JobFinService)
    end
    if xPlayer.job.name == "realestateagent" then
        logsCloseService("[Fin de Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre sa fin de service !", exports.Tree:serveurConfig().Logs.JobFinService)
    end
    if xPlayer.job.name == "label" then
        logsCloseService("[Fin de Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre sa fin de service !", exports.Tree:serveurConfig().Logs.JobFinService)
    end
    if xPlayer.job.name == "ltd_sud" then
        logsCloseService("[Fin de Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre sa fin de service !", exports.Tree:serveurConfig().Logs.JobFinService)
    end
    if xPlayer.job.name == "mecano" then
        logsCloseService("[Fin de Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre sa fin de service !", exports.Tree:serveurConfig().Logs.JobFinService)
    end
    if xPlayer.job.name == "mecano2" then
        logsCloseService("[Fin de Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre sa fin de service !", exports.Tree:serveurConfig().Logs.JobFinService)
    end
    if xPlayer.job.name == "taxi" then
        logsCloseService("[Fin de Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre sa fin de service !", exports.Tree:serveurConfig().Logs.JobFinService)
    end
    if xPlayer.job.name == "tequilala" then
        logsCloseService("[Fin de Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre sa fin de service !", exports.Tree:serveurConfig().Logs.JobFinService)
    end
    if xPlayer.job.name == "unicorn" then
        logsCloseService("[Fin de Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre sa fin de service !", exports.Tree:serveurConfig().Logs.JobFinService)
    end
    if xPlayer.job.name == "police" then
        logsCloseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", exports.Tree:serveurConfig().Logs.JobFinService)
    end
    if xPlayer.job.name == "bcso" then
        logsCloseService("[Prise Service - "..xPlayer.job.label.."] \n\n**Employé :** "..xPlayer.getFirstName().." "..xPlayer.getLastName().." - ("..xPlayer.name..")\n\n**Service en cours :** Viens de prendre son service !", exports.Tree:serveurConfig().Logs.JobFinService)
    end
end)


function logsCloseService(message,url)
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] = 16713003,
            ["footer"]=  {
                ["text"]= "By Master | "..exports.Tree:serveurConfig().Serveur.label,
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs ", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function logsPriseService(message,url)
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] = 389692,
            ["footer"]=  {
                ["text"]= "By Master | "..exports.Tree:serveurConfig().Serveur.label,
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs ", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function logsAllJob(message,url)
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] = 2061822,
            ["footer"]=  {
                ["text"]= "By Master | "..exports.Tree:serveurConfig().Serveur.label,
            },
        }
    }
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = "Logs ", embeds = embeds}), { ['Content-Type'] = 'application/json' })
end