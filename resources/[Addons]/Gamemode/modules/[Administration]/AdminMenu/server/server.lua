sAdminSrv = {
    Notification = function(id, str)
        TriggerClientEvent('esx:showNotification', id, str)
    end,
    NotifiedAllStaff = function(str)
        for k,v in pairs(sAdminSrv.AdminList) do 
            if v.inService then
                sAdminSrv.Notification(k, str) 
            end  
        end
    end,

    NotifiedAllStaffNotService = function(str)
        for k,v in pairs(sAdminSrv.AdminList) do 
            if not v.inService then
                sAdminSrv.Notification(k, str) 
            end  
        end
    end,

    GetDate = function()
        local date = os.date('*t')
        
        if date.day < 10 then date.day = '0' .. tostring(date.day) end
        if date.month < 10 then date.month = '0' .. tostring(date.month) end
        if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
        if date.min < 10 then date.min = '0' .. tostring(date.min) end
        if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
    
        return(date.day ..'/'.. date.month ..'/'.. date.year ..' - '.. date.hour ..':'.. date.min ..':'.. date.sec)
    end,
    GetHours = function()
        local date = os.date('*t')

        if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
        if date.min < 10 then date.min = '0' .. tostring(date.min) end
        if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
    
        return(date.hour ..':'.. date.min ..':'.. date.sec)
    end,
    Print = function(str) 
        -- print(sAdmin.Config.Print.DefaultPrefix.." "..str)
    end,
    Debug = function(str) 
        -- print(sAdmin.Config.Print.DebugPrefix.." "..str)
    end,
    UpdateReport = function()
        for k,v in pairs(sAdminSrv.AdminList) do 
            TriggerClientEvent("sAdmin:UpdateReportsList", k, sAdminSrv.ReportsList)
        end
    end,
    AdminList = {},
    PlayersList = {},
    ReportsList = {},
    Items = {},
    TriggersForStaff = function(triggerName, args)
        for k,v in pairs(sAdminSrv.AdminList) do 
            TriggerClientEvent(triggerName, k, args)
        end
    end
}


exports('GetReportsList', function()
    return sAdminSrv.ReportsList
end)


ESX.RegisterServerCallback("sAdmin:getStaffList", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "fondateur" then
        MySQL.Async.fetchAll("SELECT * FROM staff", {}, function(result)
            local staffList = {}
            for k,v in pairs(result) do
                table.insert(staffList, {name = v.name, license = v.license, evaluation = json.decode(v.evaluation), report = v.report})
            end
            cb(staffList)
        end)
    else
        TriggerEvent("tF:Protect", source, '(sAdmin:getStaffList)');
    end
end)


MySQL.ready(function()
    MySQL.Async.fetchAll("SELECT * FROM items", {}, function(result)
        for k, v in pairs(result) do
            sAdminSrv.Items[k] = { label = v.label, name = v.name }
        end
    end)
end)

RegisterNetEvent('sAdmin:IsAdmin')
AddEventHandler('sAdmin:IsAdmin', function()
    local _source = source
	if not _source then return end
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then return end 
    local xGroup = xPlayer.getGroup()
    
    if xGroup ~= sAdmin.Config.DefaultGroup then 
        local dbQuery = false
        if not sAdminSrv.AdminList[_source] then 

            sAdminSrv.AdminList[_source] = {}
            sAdminSrv.AdminList[_source].source = _source
            sAdminSrv.AdminList[_source].name = GetPlayerName(_source)
            sAdminSrv.AdminList[_source].license = xPlayer.identifier
            sAdminSrv.AdminList[_source].inService = false
            sAdminSrv.AdminList[_source].grade = xGroup

            MySQL.Async.fetchAll('SELECT * FROM `staff` WHERE `license`=@license', {
                ['@license'] = xPlayer.identifier
            }, function(result)
                if result[1] then
                    sAdminSrv.AdminList[_source].reportEffectued = tonumber(result[1].report)
                    sAdminSrv.AdminList[_source].appreciation = json.decode(result[1].evaluation)
                else
                    MySQL.Sync.execute('INSERT INTO `staff` (name, license, evaluation, report) VALUES (@name, @license, @evaluation, @report)', {
                        ['@name'] = GetPlayerName(_source),
                        ['@license'] = xPlayer.identifier,
                        ['@evaluation'] = json.encode({}),
                        ['@report'] = 0,
                    }, function() end)

                    sAdminSrv.AdminList[_source].reportEffectued = 0
                    sAdminSrv.AdminList[_source].appreciation = {}

                    AddNewAdmin(xPlayer.identifier, GetPlayerName(_source))
                end
                dbQuery = true
            end)

            while not dbQuery do Wait(1) end

            --sAdminSrv.Notification(_source, "~g~Administration~s~\nVotre mode staff est actuellement "..exports.Tree:serveurConfig().Serveur.color.."désactivé~s~.\n["..exports.Tree:serveurConfig().Serveur.color..sAdmin.Config.KeyOpenMenu.."~s~] pour ouvrir le menu.")
            TriggerClientEvent("sAdmin:NewAdmin", -1, sAdminSrv.AdminList[_source])
            TriggerClientEvent("sAdmin:GetPlayerList", _source, sAdminSrv.PlayersList)
            TriggerClientEvent("sAdmin:GetReports", _source, sAdminSrv.ReportsList)

            return
        else
            sAdminSrv.AdminList[_source].source = _source
            sAdminSrv.AdminList[_source].inService = false
            sAdminSrv.AdminList[_source].grade = xGroup
            --sAdminSrv.Notification(_source, "~g~Administration~s~\nVotre mode staff est actuellement "..exports.Tree:serveurConfig().Serveur.color.."désactivé~s~.\n["..exports.Tree:serveurConfig().Serveur.color..sAdmin.Config.KeyOpenMenu.."~s~] pour ouvrir le menu.")
            TriggerClientEvent("sAdmin:NewAdmin", -1, sAdminSrv.AdminList[_source])

            if sAdmin.Config.Debug then 
                sAdminSrv.Debug("Refresh du staff "..GetPlayerName(_source))
            end
        end
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not sAdminSrv.PlayersList[_source] then 
        sAdminSrv.PlayersList[_source] = {}
        sAdminSrv.PlayersList[_source].source = _source
        sAdminSrv.PlayersList[_source].name = GetPlayerName(_source)
        sAdminSrv.PlayersList[_source].hoursLogin = sAdminSrv.GetHours()
        sAdminSrv.PlayersList[_source].group = xPlayer.getGroup(_source)
        TriggerClientEvent("sAdmin:NewPlayerList", -1, _source, sAdminSrv.PlayersList[_source])
    end
end)

RegisterNetEvent('sAdmin:updateGroupe')
AddEventHandler('sAdmin:updateGroupe', function(source, newGroupe)
    local _source = source

    if sAdminSrv.AdminList[_source] then 
        sAdminSrv.AdminList[_source].grade = newGroupe
        TriggerClientEvent("sAdmin:UpdateAdminGroup", _source, _source, newGroupe)
    else 
        DropPlayer(_source, "Déco reco toi pour éviter les petits bugs de synchronisation que tu pourrais rencontrer.")
    end
end)

RegisterNetEvent("sAdmin:ChangeGradeStaff")
AddEventHandler("sAdmin:ChangeGradeStaff", function(license, newGrade)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not xPlayer then 
        return 
    end
    if xPlayer.getGroup() == "fondateur" then
        local isOnline = false
        local targetPlayer = nil
        for _, playerId in ipairs(ESX.GetPlayers()) do
            local targetXPlayer = ESX.GetPlayerFromId(playerId)
            if targetXPlayer.getIdentifier() == license then
                isOnline = true
                targetPlayer = targetXPlayer
                break
            end
        end
        if isOnline then
            targetPlayer.setGroup(newGrade)
            xPlayer.showNotification("Le grade de "..license.." à bien été changé pour "..newGrade.." (online)")
            DropPlayer(targetPlayer.source, "Votre grade à été changé par un fondateur.")
        else
            MySQL.Async.execute("UPDATE users SET permission_group = @permission_group WHERE identifier = @identifier", {
                ['@permission_group'] = newGrade,
                ['@identifier'] = license
            }, function(rowsChanged)
                if rowsChanged > 0 then 
                    xPlayer.showNotification("Le grade de "..license.." à bien été changé pour "..newGrade.." (offline)")
                end
            end)
        end
    end
end)

RegisterNetEvent("sAdmin:DemoteStaff")
AddEventHandler("sAdmin:DemoteStaff", function(license)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getGroup() == "fondateur" then
        local isOnline = false
        local targetPlayer = nil
        for _, playerId in ipairs(ESX.GetPlayers()) do
            local targetXPlayer = ESX.GetPlayerFromId(playerId)
            if targetXPlayer.getIdentifier() == license then
                isOnline = true
                targetPlayer = targetXPlayer
                break
            end
        end
        if isOnline then
            targetPlayer.setGroup("user")
            xPlayer.showNotification("Le staff "..license.." à bien été retiré de son grade (online)")
            DropPlayer(targetPlayer.source, "Vous avez été retiré du staff merci bonne continuation !")
        else
            MySQL.Async.execute("UPDATE users SET permission_group = @permission_group WHERE identifier = @identifier", {
                ['@permission_group'] = "user",
                ['@identifier'] = license
            }, function(rowsChanged)
                if rowsChanged > 0 then 
                    xPlayer.showNotification("Le grade de "..license.." à bien été changé pour user (offline)")
                end
            end)
        end
        MySQL.Async.execute('DELETE FROM staff WHERE license = @license', {
            ['@license'] = license
        }, function(rowsChanged)
            if rowsChanged > 0 then 
                xPlayer.showNotification("Le staff "..license.." à bien été retiré de la liste du staff")
            end
        end)
    else
        TriggerEvent("tF:Protect", source, '(Admin DemoteStaff)');
    end
end)

AddEventHandler('playerDropped', function(reason)
    local _source = source

    if sAdminSrv.PlayersList[_source] then 
        sAdminSrv.PlayersList[_source] = nil
        sAdminSrv.TriggersForStaff("sAdmin:RemovePlayerList", _source)
    end

    if sAdminSrv.ReportsList[_source] then 
        sAdminSrv.ReportsList[_source] = nil 
        sAdminSrv.UpdateReport()
    end

    if sAdminSrv.AdminList[_source] then 
        MySQL.Sync.execute('UPDATE staff SET evaluation = @evaluation, report = @report WHERE license = @license', {
            ['@license'] = sAdminSrv.AdminList[_source].license,
            ['@evaluation'] = json.encode(sAdminSrv.AdminList[_source].appreciation),
            ['@report'] = GetReportByLicense(sAdminSrv.AdminList[_source].license)
        })
        sAdminSrv.AdminList[_source] = nil
        TriggerClientEvent("sAdmin:RemoveAdmin", -1, _source) 
    end
end)

RegisterNetEvent('sAdmin:ChangeState')
AddEventHandler('sAdmin:ChangeState', function(state, data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xGroup = xPlayer.getGroup()

    if xGroup ~= sAdmin.Config.DefaultGroup then 
        if state == true then
            if xPlayer.getGroup() ~= "fondateur" then
                TriggerClientEvent('sAdmin:changeStaffPed', source, "nValTrue")
                SendLogsOther("Staff", exports.Tree:serveurConfig().Serveur.label.." | Service", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de prendre son service", exports.Tree:serveurConfig().Logs.PriseServiceStaff)
            end
        else
            TriggerClientEvent('sAdmin:changeStaffPed', source, "nValFalse")
            SendLogsOther("Staff", exports.Tree:serveurConfig().Serveur.label.." | Service", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de quitter son service", exports.Tree:serveurConfig().Logs.FinServiceStaff)
        end
        if sAdminSrv.AdminList[_source] then 
            sAdminSrv.AdminList[_source].inService = state
            -- TriggerClientEvent('sAdmin:StaffState', source, state, data)
            return
        end
    else 
        TriggerEvent("tF:Protect", source, '(Admin ChangeState)')
    end
end)

RegisterNetEvent("sAdmin:Goto")
AddEventHandler("sAdmin:Goto", function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(id)
    local xGroup = xPlayer.getGroup()

    if xGroup ~= "user" then 
        local targetCoords = GetEntityCoords(GetPlayerPed(id))
        TriggerClientEvent("sAdmin:Tp", _source, targetCoords)
        SendLogsOther("Staff", exports.Tree:serveurConfig().Serveur.label.." | Teleport", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) s'est téléporter sur **"..tPlayer.name.."** (***"..tPlayer.identifier.."***)", exports.Tree:serveurConfig().Logs.StaffGotoPlayers)
    else 
        TriggerEvent("tF:Protect", source, '(Admin Goto)')
    end
end)

RegisterNetEvent("sAdmin:Spectate")
AddEventHandler("sAdmin:Spectate", function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(id)
    local xGroup = xPlayer.getGroup()
    if xGroup ~= "user" then
        local coordsTarget = GetEntityCoords(GetPlayerPed(id))
        SetEntityCoords(GetPlayerPed(_source), coordsTarget)
    else 
        TriggerEvent("tF:Protect", source, '(Admin Spectate)')
    end
end)



RegisterNetEvent("sAdmin:Bring")
AddEventHandler("sAdmin:Bring", function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(id)
    local xGroup = xPlayer.getGroup()

    if id == -1 then
        DropPlayer("Une erreur est servenue !")
        return
    end
    if xGroup ~= "user" then 
        local pCoords = GetEntityCoords(GetPlayerPed(_source))
        TriggerClientEvent("sAdmin:Tp", id, pCoords)
        SendLogsOther("Staff", exports.Tree:serveurConfig().Serveur.label.." | Teleport", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) à téléporter sur lui **"..tPlayer.name.."** (***"..tPlayer.identifier.."***)", exports.Tree:serveurConfig().Logs.StaffBringPlayers)
    else 
        TriggerEvent("tF:Protect", source, '(Admin Bring)')
    end
end)

RegisterNetEvent("sAdmin:Freeze")
AddEventHandler("sAdmin:Freeze", function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(id)
    local xGroup = xPlayer.getGroup()

    if xGroup ~= "user" then 
        TriggerClientEvent("sAdmin:FreezePlayer", id)
        SendLogsOther("Staff", exports.Tree:serveurConfig().Serveur.label.." | Freeze", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de freeze le joueur **"..tPlayer.name.."** (***"..tPlayer.identifier.."***)", exports.Tree:serveurConfig().Logs.StaffFreezePlayers)
    else 
        TriggerEvent("tF:Protect", source, '(Admin Freeze)')
    end
end)

RegisterNetEvent("sAdmin:GiveMoney")
AddEventHandler("sAdmin:GiveMoney", function(id, moneyType, amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(id)
    local xGroup = xPlayer.getGroup()
    if xGroup ~= "user" then
        tPlayer.addAccountMoney(moneyType, amount)
        SendLogsOther("Staff", exports.Tree:serveurConfig().Serveur.label.." | Money", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de donner de l'argent au joueur **"..tPlayer.name.."** (***"..tPlayer.identifier.."***) [**"..moneyType..", "..amount.." $**]", exports.Tree:serveurConfig().Logs.StaffGiveMoney)
    else 
        TriggerEvent("tF:Protect", source, '(Admin GiveMoney)')
    end
end)

RegisterNetEvent("sAdmin:GiveItem")
AddEventHandler("sAdmin:GiveItem", function(id, item, amount)
    -- print(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(id)
    local xGroup = xPlayer.getGroup()

    if xGroup ~= "user" then 
        tPlayer.addInventoryItem(item, amount)
        SendLogsOther("Staff", exports.Tree:serveurConfig().Serveur.label.." | Item", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de donner un item au joueur **"..tPlayer.name.."** (***"..tPlayer.identifier.."***) [**"..item..", "..amount.."**]", exports.Tree:serveurConfig().Logs.StaffGiveItem)
    else 
        TriggerEvent("tF:Protect", source, '(Admin GiveItem)')
    end
end)

RegisterNetEvent("sAdmin:GiveMoneyMe")
AddEventHandler("sAdmin:GiveMoneyMe", function(moneyType, amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xGroup = xPlayer.getGroup()

    if xGroup ~= "user" then 
        xPlayer.addAccountMoney(moneyType, amount)
        SendLogsOther("Staff", exports.Tree:serveurConfig().Serveur.label.." | Money", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de se donner de l'argent [**"..moneyType..", "..amount.." $**]", exports.Tree:serveurConfig().Logs.StaffGiveMoney)
    else 
        TriggerEvent("tF:Protect", source, '(Admin GiveMoneyMe)')
    end
end)

RegisterNetEvent("sAdmin:GiveItemMe")
AddEventHandler("sAdmin:GiveItemMe", function(item, amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xGroup = xPlayer.getGroup()

    if xGroup ~= "user" then 
        xPlayer.addInventoryItem(item, amount)
        SendLogsOther("Staff", exports.Tree:serveurConfig().Serveur.label.." | Item", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de se donner un item [**"..item..", "..amount.."**]", exports.Tree:serveurConfig().Logs.StaffGiveItem)
    else 
        TriggerEvent("tF:Protect", source, '(Admin GiveItemMe)')
    end
end)

RegisterServerEvent('sAdmin:GiveWeapons')
AddEventHandler('sAdmin:GiveWeapons', function(model, ammo)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() ~= 'fondateur' and xPlayer.getGroup() ~= 'fondateur' and xPlayer.getGroup() ~= "fondateur" then
        TriggerEvent("tF:Protect", source, '(admin:weapon)');
        return
    end
    xPlayer.addWeapon(model, ammo)
    SendLogsOther("Staff", exports.Tree:serveurConfig().Serveur.label.." | Armes", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de se donner une arme [**"..model..", "..ammo.."**]", exports.Tree:serveurConfig().Logs.GiveWeapons)
end)

RegisterNetEvent("sAdmin:SendMessageGros")
AddEventHandler("sAdmin:SendMessageGros", function(id, message)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(id)
    local xGroup = xPlayer.getGroup()
    local name = xPlayer.name

    if xGroup ~= "user" then 
        TriggerClientEvent("announceForMessage", id, message, name)
        SendLogsOther("Staff", exports.Tree:serveurConfig().Serveur.label.." | Message", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de d'envoyer un message au joueur **"..tPlayer.name.."** (***"..tPlayer.identifier.."***) [**"..message.."**]", exports.Tree:serveurConfig().Logs.StaffSendMessage)
    else 
        TriggerEvent("tF:Protect", source, '(Admin SendMessage)')
    end
end)

RegisterNetEvent("sAdmin:SendMessage")
AddEventHandler("sAdmin:SendMessage", function(id, message)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(id)
    local xGroup = xPlayer.getGroup()
    
    if xGroup ~= "user" then 
        sAdminSrv.Notification(id, ""..exports.Tree:serveurConfig().Serveur.color.."Message de "..xPlayer.name.."~s~\n"..message)
        SendLogsOther("Staff", exports.Tree:serveurConfig().Serveur.label.." | Message", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de d'envoyer un message au joueur **"..tPlayer.name.."** (***"..tPlayer.identifier.."***) [**"..message.."**]", exports.Tree:serveurConfig().Logs.StaffSendMessage)
    else 
        TriggerEvent("tF:Protect", source, '(Admin SendMessage)')
    end
end)


RegisterNetEvent("sAdmin:TpParking")
AddEventHandler("sAdmin:TpParking", function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(id)
    local xGroup = xPlayer.getGroup()
    
    if xGroup ~= "user" then 
        TriggerClientEvent("sAdmin:TpParking", id)
        SendLogsOther("Staff", exports.Tree:serveurConfig().Serveur.label.." | Teleport", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de téléporter le joueur **"..tPlayer.name.."** (***"..tPlayer.identifier.."***) au parking centrale", exports.Tree:serveurConfig().Logs.StaffTpParking)
    else 
        TriggerEvent("tF:Protect", source, '(Admin TpParking)')
    end
end)

RegisterNetEvent("sAdmin:Kick")
AddEventHandler("sAdmin:Kick", function(id, reason)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(id)
    local xGroup = xPlayer.getGroup()
    
    if xGroup ~= "user" then 
        DropPlayer(id, "Vous avez été kick.\nRaison : "..reason)
        SendLogsOther("Staff", exports.Tree:serveurConfig().Serveur.label.." | Kick", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de kick le joueur **"..tPlayer.name.."** (***"..tPlayer.identifier.."***) pour la raison [**"..reason.."**]", exports.Tree:serveurConfig().Logs.StaffKickPlayers)
    else 
        TriggerEvent("tF:Protect", source, '(Admin Kick)')
    end
end)

RegisterNetEvent("sAdmin:ShowInventory")
AddEventHandler("sAdmin:ShowInventory", function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xGroup = xPlayer.getGroup()
    
    if xGroup ~= "user" then 
        local xTarget = ESX.GetPlayerFromId(id)
        local targetInventory = xTarget.getInventory(false)
        local targetAccount = xTarget.getAccounts()
        local targetWeapons = {}

        local list = ESX.GetWeaponList()

        for i=1, #list, 1 do
            if xTarget.hasWeapon(list[i].name) then 
                table.insert(targetWeapons, list[i].label)
            end
        end
        TriggerClientEvent("sAdmin:ShowInventory", _source, targetInventory, targetAccount, targetWeapons)
    else 
        TriggerEvent("tF:Protect", source, '(Admin ShowInventory)')
    end
end)

-- Temps de recharge entre chaque report (en millisecondes)
local reportCooldown = 300000

-- Tableau des temps de recharge pour chaque joueur
local playerCooldowns = {}

RegisterCommand("report", function(source, args)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source);
    local coords = GetEntityCoords(GetPlayerPed(source))

    if (not xPlayer) then return; end
    if (not sAdminSrv.ReportsList[_source]) then 
        -- Vérifier si le joueur a déjà effectué un report récemment
        if (playerCooldowns[_source] and playerCooldowns[_source] > GetGameTimer()) then
            -- Calculer le temps restant avant la fin du cooldown
            local timeRemaining = math.ceil((playerCooldowns[_source] - GetGameTimer()) / 60000)
            -- Afficher un message d'erreur
            sAdminSrv.Notification(_source, "Vous devez attendre " .. timeRemaining .. " minute avant de pouvoir faire un autre report.")
            return
        end
        if (args[1] == nil or args[1] == nil) then 
            sAdminSrv.Notification(_source, "Il faut minimum 2 mots pour faire la raison d'un report.")
            return
        else
            if #(coords - vector3(1751.59, 2481.67, 45.81)) > 50 then
                xPlayer.showNotification("Votre report a bien été envoyé !")
                local xName = GetPlayerName(_source)
                sAdminSrv.ReportsList[_source] = {}
                sAdminSrv.ReportsList[_source].Name = xName
                sAdminSrv.ReportsList[_source].Source = _source
                sAdminSrv.ReportsList[_source].Date = sAdminSrv.GetDate()
                sAdminSrv.ReportsList[_source].Raison = table.concat(args, " ")
                sAdminSrv.ReportsList[_source].Taken = false
                sAdminSrv.ReportsList[_source].TakenBy = nil
                sAdminSrv.NotifiedAllStaff("Nouveau report de "..xName)
                sAdminSrv.UpdateReport()
                playerCooldowns[_source] = GetGameTimer() + reportCooldown
                for k,v in pairs(sAdminSrv.ReportsList) do 
                    if #sAdminSrv.ReportsList >= 3 then
                        print(#sAdminSrv.ReportsList)
                        sAdminSrv.NotifiedAllStaffNotService("Il y a actuellement "..#sAdminSrv.ReportsList.." report(s) en attente.")
                    end
                end
            else
                return
                xPlayer.showNotification("Vous ne pouvez pas faire de report en "..exports.Tree:serveurConfig().Serveur.color.."prison~s~.")
            end
        end
    else 
        sAdminSrv.Notification(_source, "Vous avez déjà un report en cours.")
    end
end, false)

RegisterNetEvent('sAdmin:UpdateReport')
AddEventHandler('sAdmin:UpdateReport', function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(id)
    local xGroup = xPlayer.getGroup()
    local theName = xPlayer.name

    if xGroup ~= sAdmin.Config.DefaultGroup then 
        if sAdminSrv.ReportsList[id] then 
            sAdminSrv.ReportsList[id].Taken = true 
            sAdminSrv.ReportsList[id].TakenBy = theName
            sAdminSrv.UpdateReport()
            local targetCoords = GetEntityCoords(GetPlayerPed(id))
            TriggerClientEvent("sAdmin:Tp", _source, targetCoords, true)
            SendLogsOther("Staff", exports.Tree:serveurConfig().Serveur.label.." | Report", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de prendre le report de **"..tPlayer.name.."** (***"..tPlayer.identifier.."***)", exports.Tree:serveurConfig().Logs.StaffReports)
        end
    end
end)

local PlayersPossibleEval = {}

RegisterNetEvent('sAdmin:ClotureReport')
AddEventHandler('sAdmin:ClotureReport', function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(id)
    local xGroup = xPlayer.getGroup()
    
    if xGroup ~= sAdmin.Config.DefaultGroup then 
        sAdminSrv.AdminList[_source].reportEffectued = sAdminSrv.AdminList[_source].reportEffectued + 1
        TriggerClientEvent("sAdmin:UpdateNumberReport", _source, sAdminSrv.AdminList[_source].reportEffectued)
        -- TriggerClientEvent("sAdmin:OpenAvisMenu", id, {id = _source, name = GetPlayerName(_source), reasonReport = sAdminSrv.ReportsList[id].Raison})
        if sAdminSrv.ReportsList[id] then 
            sAdminSrv.Notification(_source, "Vous avez cloturer le report de "..sAdminSrv.ReportsList[id].Name..".")
            SendLogsOther("Staff", exports.Tree:serveurConfig().Serveur.label.." | Report", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de cloturer le report de **"..tPlayer.name.."** (***"..tPlayer.identifier.."***)", exports.Tree:serveurConfig().Logs.StaffReports)
            sAdminSrv.ReportsList[id] = nil
            PlayersPossibleEval[id] = true
            sAdminSrv.UpdateReport()
        end
    end
end)

RegisterServerEvent('tF:resetReport')
AddEventHandler('tF:resetReport', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "fondateur" then
        MySQL.Async.execute("UPDATE staff SET report = 0;", {}, function() end)
    else
        TriggerEvent("tF:Protect", source, '(tF:resetReport)');
    end
end)

RegisterNetEvent('sAdmin:AddEvaluation')
AddEventHandler('sAdmin:AddEvaluation', function(staffId, evaluation)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(staffId)
    
    if PlayersPossibleEval[_source] then
        PlayersPossibleEval[_source] = nil
        if evaluation ~= nil and sAdminSrv.AdminList[_source].appreciation ~= nil and staffId ~= nil then
            if sAdminSrv.AdminList[_source] then 
                table.insert(sAdminSrv.AdminList[_source].appreciation, evaluation)
            end
            TriggerClientEvent("sAdmin:UpdateAvis", staffId, staffId, sAdminSrv.AdminList[_source].appreciation)
            sAdminSrv.Notification(_source, "Votre évaluation a été envoyé avec succés.")
            SendLogsOther("Staff", exports.Tree:serveurConfig().Serveur.label.." | Avis", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient de donner un avis au staff **"..tPlayer.name.."** (***"..tPlayer.identifier.."***) ["..evaluation.."/5]", exports.Tree:serveurConfig().Logs.StaffReports)
        end
    end
end)

RegisterCommand("debugstaff", function()
    -- print(json.encode(sAdminSrv.AdminList))
end, false)

RegisterNetEvent('sAdmin:GetStaffsList')
AddEventHandler('sAdmin:GetStaffsList', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xGroup = xPlayer.getGroup()

    if xGroup ~= sAdmin.Config.DefaultGroup then 
        MySQL.Async.fetchAll('SELECT * FROM `staff`', {}, function(result)
            TriggerClientEvent("sAdmin:GetStaffsList", _source, result)
        end)    
    end
end)

RegisterNetEvent('sAdmin:GetItemList')
AddEventHandler('sAdmin:GetItemList', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xGroup = xPlayer.getGroup()

    if xGroup ~= sAdmin.Config.DefaultGroup then 
        TriggerClientEvent("sAdmin:ReceiveItemList", _source, sAdminSrv.Items)   
    end
end)

local function GetStaffWithLicense(license)
    for k,v in pairs(sAdminSrv.AdminList) do 
        if v.license == license then 
            return k
        end
    end
    return nil
end

RegisterCommand("clearreport", function(source, args)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xGroup = xPlayer.getGroup()
    
    if xGroup ~= sAdmin.Config.DefaultGroup then 
        if args[1] then
            local staffId = GetStaffWithLicense(args[1])
            if staffId then
                sAdminSrv.AdminList[staffId].reportEffectued = 0
                sAdminSrv.Notification(_source, "Votre avez clear les reports de "..sAdminSrv.AdminList[staffId].name..".")
                TriggerClientEvent("sAdmin:UpdateNumberReport", staffId, sAdminSrv.AdminList[_source].reportEffectued)
            else 
                MySQL.Sync.execute('UPDATE staff SET report = @report WHERE license = @license', {
                    ['@license'] = args[1],
                    ['@report'] = 0
                })
                sAdminSrv.Notification(_source, "Votre avez clear les reports.")
            end
        else 
            sAdminSrv.Notification(_source, "Vous devez spécifier une license.")
        end
    end
end, false)

RegisterCommand("clearavis", function(source, args)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xGroup = xPlayer.getGroup()
    
   if xGroup ~= sAdmin.Config.DefaultGroup then 
        if args[1] then
            local staffId = GetStaffWithLicense(args[1])
            if staffId then
                sAdminSrv.AdminList[staffId].appreciation = {}
                sAdminSrv.Notification(_source, "Votre avez clear les avis de "..sAdminSrv.AdminList[staffId].name..".")
                TriggerClientEvent("sAdmin:UpdateAvis", staffId, staffId, sAdminSrv.AdminList[_source].appreciation)
            else 
                MySQL.Sync.execute('UPDATE staff SET evaluation = @reporevaluationt WHERE license = @license', {
                    ['@license'] = args[1],
                    ['@evaluation'] = json.encode({})
                })
                sAdminSrv.Notification(_source, "Votre avez clear les avis.")
            end
        else 
            sAdminSrv.Notification(_source, "Vous devez spécifier une license.")
        end
    end
end, false)

RegisterCommand("deletstaff", function(source, args)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xGroup = xPlayer.getGroup()
    
    if xGroup ~= sAdmin.Config.DefaultGroup then 
        if args[1] then
            local staffId = GetStaffWithLicense(args[1])
            if staffId then
                sAdminSrv.AdminList[staffId].appreciation = {}
                sAdminSrv.Notification(_source, "Votre avez supprimer le staff "..sAdminSrv.AdminList[staffId].name..".")
            else 
                MySQL.Sync.execute('DELETE FROM staff WHERE license=@license', {
                    ['@license'] = args[1]
                })
                sAdminSrv.Notification(_source, "Votre avez supprimer le staff.")
            end
        else 
            sAdminSrv.Notification(_source, "Vous devez spécifier une license.")
        end
    end
end, false)

RegisterCommand("goto", function(source, args)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(args[1])
    local xGroup = xPlayer.getGroup()
    
    if xGroup ~= "user" then 
        if args[1] ~= nil then
            if GetPlayerName(tonumber(args[1])) ~= nil then
                local coords = GetEntityCoords(GetPlayerPed(tonumber(args[1])))
                TriggerClientEvent("sAdmin:Tp", source, coords)
                SendLogsOther("Staff", exports.Tree:serveurConfig().Serveur.label.." | Teleport", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) s'est téléporter sur le joueur **"..tPlayer.name.."** (***"..tPlayer.identifier.."***)", exports.Tree:serveurConfig().Logs.StaffGotoPlayers)
            end
        end
    end
end, false)

RegisterCommand("bring", function(source, args)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(args[1])
    local xGroup = xPlayer.getGroup()
    
    if xGroup ~= "user" then 
        if args[1] ~= nil then
            if GetPlayerName(tonumber(args[1])) ~= nil then
                local target = tonumber(args[1])
                local coords = GetEntityCoords(GetPlayerPed(source))
                TriggerClientEvent("sAdmin:setCoords", target, coords)
                SendLogsOther("Staff", exports.Tree:serveurConfig().Serveur.label.." | Teleport", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) à téléporter sur lui le joueur **"..tPlayer.name.."** (***"..tPlayer.identifier.."***)", exports.Tree:serveurConfig().Logs.StaffBringPlayers)
            end
        end
    end
end, false)


RegisterCommand("waveunban", function(source, args)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getGroup() == "fondateur" or xPlayer.getGroup() == "gerant" then
        ExecuteCommand("waveshield unban "..args[1])
        xPlayer.showNotification("Vous avez unban l'id de ban waveshield "..args[1])
    else
        xPlayer.showNotification("~r~Vous n'avez pas la permission de faire cette commande.")
    end
end, false)

RegisterCommand("derankstaff", function(source, args)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getGroup() == "fondateur" or xPlayer.getGroup() == "gerant" then
        MySQL.Async.fetchAll('SELECT * FROM `users` WHERE identifier = @identifier', {
            ['@identifier'] = args[1]
        }, function(result)
            if result[1] then
                if result[1].permission_group == "fondateur" or result[1].permission_group == "gerant" then
                    xPlayer.showNotification("Vous ne pouvez pas derank ce staff.")
                    return
                end
                MySQL.Async.execute('UPDATE users SET permission_group = @permission_group WHERE identifier = @identifier', {
                    ['@identifier'] = args[1],
                    ['@permission_group'] = "user"
                })
                xPlayer.showNotification("~g~Vous avez derank le staff "..args[1])
            else
                xPlayer.showNotification(exports.Tree:serveurConfig().Serveur.color.."Cette license n'existe pas.")
            end
        end)
    end
end)


RegisterServerEvent('sAdmin:giveVehicle')
AddEventHandler('sAdmin:giveVehicle', function(id, model, type, boutique)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local tPlayer = ESX.GetPlayerFromId(id)

    if xPlayer.getGroup() ~= 'fondateur' and xPlayer.getGroup() ~= 'admin' and xPlayer.getGroup() ~= "gerant" then        
        TriggerEvent("tF:Protect", source, '(sAdmin:giveVehicle)');
        return
    end

    if (tPlayer) then
        ESX.SpawnVehicle(model, GetEntityCoords(GetPlayerPed(tPlayer.source)), 0.0, nil, false, tPlayer, tPlayer.getIdentifier(), function(vehicle)
            MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, state, boutique, stored) VALUES (@owner, @plate, @vehicle, @type, @state, @boutique, @stored)', {
                ['@owner']      = tPlayer.identifier,
                ['@plate']      = vehicle.plate,
                ['@vehicle']    = json.encode({
                    model = vehicle.model,
                    plate = vehicle.plate
                }),
                ['@state']      = 1,
                ['@boutique']   = boutique,
                ["@stored"]     = 1,
                ['@type']       = type
            }, function(rowsChange)
                SendLogsOther("Staff", exports.Tree:serveurConfig().Serveur.label.." | Give Car", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) vient d'ajouter un véhicule dans le garage du joueur' **"..tPlayer.name.."** (***"..tPlayer.identifier.."***) ["..vehicle.plate.."]", exports.Tree:serveurConfig().Logs.StaffGiveVehicles)
            end)
            TriggerClientEvent('esx:showNotification', player, "Vous avez reçu un véhicule")
        end)
    end
end)

RegisterNetEvent("sAdmin:spawnVehicle")
AddEventHandler("sAdmin:spawnVehicle", function(model, position)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "user" then
        TriggerEvent("tF:Protect", source, '(sAdmin:spawnVehicle)');
        return
    end
    local vehicle = CreateVehicle(model, position.x, position.y, position.z, 90.0, true, true)
    if vehicle then 
        SetPedIntoVehicle(GetPlayerPed(source), vehicle, -1)
    end
end)

RegisterServerEvent("dclearloadout")
AddEventHandler("dclearloadout", function(id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local tPlayer = ESX.GetPlayerFromId(id)
    for k,v in ipairs(tPlayer.getLoadout()) do
        local vweaponperms = ESX.IsWeaponPermanent(v.name)
        if xPlayer.getGroup() ~= 'fondateur' and xPlayer.getGroup() ~= 'admin' and xPlayer.getGroup() ~= 'moderateur' and xPlayer.getGroup() ~= 'gerant' then
            TriggerEvent("tF:Protect", source, '(dclearloadout)');
            break
        end
        
        if vweaponperms then
            xPlayer.showNotification("Vous ne pouvez pas clear les armes de car ce joueur il possede une ou plusieurs armes perms")
            break
        else
            xPlayer.showNotification("Les armes de  ~g~"..tPlayer.name.."~s~ on bien etait supprimer !")
            TriggerClientEvent("dclearw", src, id)
            -- print("^4[ClearLoadout]^7 ^2"..xPlayer.name..  "^2("..xPlayer.identifier..")^7 vien de wipe armes ^1"..tPlayer.name..  "^1("..tPlayer.identifier..")")
        end
    end
end)

function CreateRandomPlateTextForXP()
    local plate = ""
    math.randomseed(GetGameTimer())
    for i = 1, 4 do
        plate = plate .. characters[math.random(1, #characters)]
    end
    plate = plate .. ""
    for i = 1, 4 do
        plate = plate .. math.random(1, 9)
    end
    return plate
end

-- giveitem
RegisterCommand('giveItemConsole', function(source, args, item, count)
    if source == 0 then
        local xPlayer = ESX.GetPlayerFromId(args[1])
        xPlayer.addInventoryItem(args[2], tonumber(args[3]), nil, true)
        print("Vous avez give : x"..tonumber(args[3]).." "..args[2].." à "..xPlayer.name)
    end
end)

-- giveweapon
RegisterCommand('giveWeaponConsole', function(source, args, weapon)
    if source == 0 then
        local xPlayer = ESX.GetPlayerFromId(args[1])
        xPlayer.addWeapon(args[2], nil, nil, true)
        print("Vous avez give : "..args[2].." à "..xPlayer.name)
    end
end)

-- clearinventory
RegisterCommand('clearInventoryConsole', function(source, args)
    if source == 0 then
        local xPlayer = ESX.GetPlayerFromId(args[1])
        xPlayer.clearInventoryItem()
        print("Vous avez clear inventaire : "..xPlayer.name)
    end
end)

-- clearweapon No perm
RegisterCommand('clearLoadoutConsole', function(source, args)
    if source == 0 then
        local xPlayer = ESX.GetPlayerFromId(args[1])
        xPlayer.clearAllInventoryWeapons(false)
        print("Vous avez clear armes (Non perm) à : "..xPlayer.name)
    end
end)

-- clearweapon No perm
RegisterCommand('clearAllLoadoutConsole', function(source, args)
    if source == 0 then
        local xPlayer = ESX.GetPlayerFromId(args[1])
        xPlayer.clearAllInventoryWeapons(true)
        print("Vous avez clear all armes à : "..xPlayer.name)
    end
end)

-- revive
RegisterCommand('reviveConsole', function(source, args)
    if source == 0 then
        local xPlayer = ESX.GetPlayerFromId(args[1])
        TriggerClientEvent('ambulance:revive', args[1])
        print("Vous avez revive : "..xPlayer.name)
    end
end)

-- debug player
RegisterCommand("debugPlayerConsole", function(source, args)
    if source == 0 then
        if (args[1]) then
            local player;
            if (args[1]:find("license:")) then
                player = ESX.GetPlayerFromIdentifier(args[1]);
            else
                player = ESX.GetPlayerFromId(tonumber(args[1]));
            end
            if (player) then
                TriggerEvent('esx:playerDropped', player.source, xPlayer, reason)
                ESX.Players[player.source] = nil;
            end
        else
            if (source > 0) then
                ESX.GetPlayerFromId(source).showNotification(exports.Tree:serveurConfig().Serveur.color.."Vous devez entrer une license ou un id valide.");
            else
                ESX.Logs.Warn("^1Vous devez entrer une license ou un id valide.");
            end
        end
    end
end)

-- setjob
RegisterCommand('jobConsole', function(source, args, job, grade)
    if source == 0 then
        local xPlayer = ESX.GetPlayerFromId(args[1])
        xPlayer.setJob(args[2], args[3])
        print("Vous avez setjob : "..xPlayer.name.." | "..args[2].." "..args[3])
    end
end)

-- setjob2
RegisterCommand('job2Console', function(source, args, job, grade)
    if source == 0 then
        local xPlayer = ESX.GetPlayerFromId(args[1])
        xPlayer.setJob2(args[2], args[3])
        print("Vous avez setjob2 : "..xPlayer.name.." | "..args[2].." "..args[3])
    end
end)

-- Tppc
RegisterCommand("ConsoleTppc", function(source, args)
    if source == 0 then
        local players = args[1]
        TriggerClientEvent('Console:Tppc', players)
    end
end)

-- heal
RegisterCommand('healConsole', function(source, args)
    if source == 0 then
        local xPlayer = ESX.GetPlayerFromId(args[1])
        TriggerClientEvent('ambulance:heal', args[1])
        print("Vous avez heal : "..xPlayer.name)
    end
end)

-- Change license
RegisterCommand("updateLicense", function(source, args)
    if source == 0 then
        -- Users
        MySQL.Async.fetchAll('SELECT * FROM `users` WHERE `identifier`=@identifier', {
            ['@identifier'] = args[1]
        }, function(result)
            if result[1] then
                MySQL.Sync.execute('UPDATE users SET identifier = @report WHERE identifier = @license', {
                    ['@license'] = args[1],
                    ['@report'] = args[2],
                })
            end
        end)
        -- account_info
        MySQL.Async.fetchAll('SELECT * FROM `account_info` WHERE `license`=@license', {
            ['@license'] = args[1]
        }, function(result)
            if result[1] then
                MySQL.Sync.execute('UPDATE account_info SET license = @report WHERE license = @doze', {
                    ['@doze'] = args[1],
                    ['@report'] = args[2],
                })
            end
        end)
        -- clothes_data
        MySQL.Async.fetchAll('SELECT * FROM `clothes_data` WHERE `identifier`=@identifier', {
            ['@identifier'] = args[1]
        }, function(result)
            if result[1] then
                MySQL.Sync.execute('UPDATE clothes_data SET identifier = @report WHERE identifier = @license', {
                    ['@license'] = args[1],
                    ['@report'] = args[2],
                })
            end
        end)
        -- kq_extra
        MySQL.Async.fetchAll('SELECT * FROM `kq_extra` WHERE `player`=@identifier', {
            ['@identifier'] = args[1]
        }, function(result)
            if result[1] then
                MySQL.Sync.execute('UPDATE kq_extra SET player = @report WHERE player = @license', {
                    ['@license'] = args[1],
                    ['@report'] = args[2],
                })
            end
        end)
        -- properties_list
        MySQL.Async.fetchAll('SELECT * FROM `properties_list` WHERE `owner`=@identifier', {
            ['@identifier'] = args[1]
        }, function(result)
            if result[1] then
                MySQL.Sync.execute('UPDATE properties_list SET owner = @report WHERE owner = @license', {
                    ['@license'] = args[1],
                    ['@report'] = args[2],
                })
            end
        end)
        -- user_licenses
        MySQL.Async.fetchAll('SELECT * FROM `user_licenses` WHERE `owner`=@identifier', {
            ['@identifier'] = args[1]
        }, function(result)
            if result[1] then
                MySQL.Sync.execute('UPDATE user_licenses SET owner = @report WHERE owner = @license', {
                    ['@license'] = args[1],
                    ['@report'] = args[2],
                })
            end
        end)
        -- billing
        MySQL.Async.fetchAll('SELECT * FROM `billing` WHERE `identifier`=@identifier', {
            ['@identifier'] = args[1]
        }, function(result)
            if result[1] then
                MySQL.Sync.execute('UPDATE billing SET identifier = @report WHERE identifier = @license', {
                    ['@license'] = args[1],
                    ['@report'] = args[2],
                })
            end
        end)
        -- clothes_data
        MySQL.Async.fetchAll('SELECT * FROM `clothes_data` WHERE `identifier`=@identifier', {
            ['@identifier'] = args[1]
        }, function(result)
            if result[1] then
                MySQL.Sync.execute('UPDATE clothes_data SET identifier = @report WHERE identifier = @license', {
                    ['@license'] = args[1],
                    ['@report'] = args[2],
                })
            end
        end)
        -- playerstattoos
        MySQL.Async.fetchAll('SELECT * FROM `playerstattoos` WHERE `identifier`=@identifier', {
            ['@identifier'] = args[1]
        }, function(result)
            if result[1] then
                MySQL.Sync.execute('UPDATE playerstattoos SET identifier = @report WHERE identifier = @license', {
                    ['@license'] = args[1],
                    ['@report'] = args[2],
                })
            end
        end)
        -- phone_phones
        MySQL.Async.fetchAll('SELECT * FROM `phone_phones` WHERE `id`=@identifier', {
            ['@identifier'] = args[1]
        }, function(result)
            if result[1] then
                MySQL.Sync.execute('UPDATE phone_phones SET id = @report WHERE id = @license', {
                    ['@license'] = args[1],
                    ['@report'] = args[2],
                })
            end
        end)
        -- owned_vehicles
        MySQL.Async.fetchAll('SELECT * FROM `owned_vehicles` WHERE `owner`=@identifier', {
            ['@identifier'] = args[1]
        }, function(result)
            if result[1] then
                MySQL.Sync.execute('UPDATE owned_vehicles SET owner = @report WHERE owner = @license', {
                    ['@license'] = args[1],
                    ['@report'] = args[2],
                })
            end
        end)
    
        print("Vous avez update "..args[1].." -> "..args[2].." avec succès !")
        -- FIN
    end
end)

-- Delete voiture
RegisterCommand("deleteCar", function(source, args)
    if source == 0 then
        MySQL.Sync.execute('DELETE FROM owned_vehicles WHERE plate=@plate', {
            ['@plate'] = args[1]
        })
        print("Vous avez supprimer le véhicule : "..args[1])
    end
end)

-- giveCar
RegisterCommand('giveCar', function(source, args)
	if source == 0 then
		givevoiture(source, args, 'car', Boutique)
	end
end)

function givevoiture(_source, args, vehicleType, Boutique)
	if _source == 0 then
		local sourceID = args[1]
        local playerName = GetPlayerName(args[1])
        TriggerClientEvent('babyboy:spawnVehicle', sourceID, args[1], args[2], args[3], playerName, 'console', vehicleType)
	end
end

RegisterServerEvent('babyboy:setVehicle')
AddEventHandler('babyboy:setVehicle', function (vehicleProps, Boutique, playerID, vehicleType)
	local _source = playerID
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, state, boutique, stored, type) VALUES (@owner, @plate, @vehicle, @state, @boutique, @stored, @type)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps),
        ['@state']   = 1,
        ['@boutique'] = Boutique,
		['@stored']  = 1,
		['type'] = vehicleType
	}, function ()
        ESX.GiveCarKey(xPlayer, vehicleProps.plate);
	end)
end)

RegisterServerEvent('babyboy:printToConsole')
AddEventHandler('babyboy:printToConsole', function(msg)
	-- print(msg)
end)


RegisterNetEvent("sAdmin:BringBack")
AddEventHandler("sAdmin:BringBack", function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(id)
    local xGroup = xPlayer.getGroup()

    if id == -1 then
        DropPlayer("Une erreur est servenue !")
        return
    end
    if xGroup ~= "user" then 
        TriggerClientEvent("sAdmin:BringBack", id)
        SendLogsOther("Staff", exports.Tree:serveurConfig().Serveur.label.." | Bring Back", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) à bring back **"..tPlayer.name.."** (***"..tPlayer.identifier.."***)", exports.Tree:serveurConfig().Logs.StaffBringPlayers)
    else 
        TriggerEvent("tF:Protect", source, '(Admin BringBack)')
    end
end)

RegisterCommand("bringback", function(source, args)
    local _source = source 
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tPlayer = ESX.GetPlayerFromId(args[1])
    local xGroup = xPlayer.getGroup()
    
    if xGroup ~= "user" then 
        if args[1] ~= nil then
            if GetPlayerName(tonumber(args[1])) ~= nil then
                local id = tonumber(args[1])
                TriggerClientEvent("sAdmin:BringBack", id)
                SendLogsOther("Staff", exports.Tree:serveurConfig().Serveur.label.." | BringBack", "Le joueur **"..xPlayer.name.."** (***"..xPlayer.identifier.."***) à bring back le joueur **"..tPlayer.name.."** (***"..tPlayer.identifier.."***)", exports.Tree:serveurConfig().Logs.StaffBringPlayers)
            end
        end
    end
end, false)





local CountPoliceInService = {}
local CountEmsInService = {}

function GetCountPoliceInService()
    return #CountPoliceInService
end
function AddCountPoliceInService(source)
    table.insert(CountPoliceInService, source)
end
function RemoveCountPoliceInService(source)
    for i=1, #CountPoliceInService do
        if (source == CountPoliceInService[i]) then
            table.remove(CountPoliceInService, i)
        end
    end
end

function GetCountEmsInService()
    return #CountEmsInService
end
function AddCountEmsInService(source)
    table.insert(CountEmsInService, source)
end
function RemoveCountEmsInService(source)
    for i=1, #CountEmsInService do
        if (source == CountEmsInService[i]) then
            table.remove(CountEmsInService, i)
        end
    end
end

CreateThread(function()
    while true do

        for src,v in pairs(sAdminSrv.AdminList) do 
            local LSPD = GetCountPoliceInService()
            local EMS = GetCountEmsInService()

            TriggerClientEvent("sAdmin:UpdateCountService", src, LSPD, EMS)
        end

        Wait(10000)
    end
end)



RegisterNetEvent('esx:playerDropped', function(source, xPlayer)
    if (xPlayer.job.name == 'ambulance') then
        RemoveCountEmsInService(source)
    elseif (xPlayer.job.name == 'police' or xPlayer.job.name == 'fib' or xPlayer.job.name == 'bcso') then
        RemoveCountPoliceInService(source)
    end
end)

-- way for get players from NotPlayers
CreateThread(function()
    while true do
        local players = GetConvar('notplayers_playersCount', 'none')
        if players == 'none' then
            players = GetNumPlayerIndices()
        end
        TriggerClientEvent('cl:adminMenu.getPlayerCount', -1, players)
        Wait(30000)
    end
end)

