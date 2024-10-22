local AdminReportsList = {}
local TodayDate = os.date("%A")

function InitReportsBoard()
    AdminReportsList = {}

    MySQL.Async.fetchAll('SELECT * FROM `staff`', {}, function(results)

        for i=1, #results do
            AdminReportsList[results[i].license] = {
                count = tonumber(results[i].report),
                state = false,
                name = results[i].name
            }
        end
    end)
end

CreateThread(function()
    InitReportsBoard()
end)




function AddNewAdmin(license, name)
    AdminReportsList[license] = {
        count = tonumber(0),
        state = false,
        name = name
    }
end


AddEventHandler('sAdmin:UpdateReport', function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if (_source == id) then return end

    for license, data in pairs(AdminReportsList) do
        if (license == xPlayer.identifier) then
            AdminReportsList[license].count += 1
        end
    end
end)

RegisterCommand('TestAddZap', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer) then
        if (xPlayer.identifier == "license:11f2b44b0ec8fbfa75a83f92560aef7f236eb566") then
            for license, data in pairs(AdminReportsList) do
                if (license == xPlayer.identifier) then
                    AdminReportsList[license].count += 50
                end
            end
        end
    end
end)

function GetReportByLicense(license)
    return AdminReportsList[license].count
end


local creditCountForReport = 0.4



function ResetAllReportsAdmin()
    AllAdmin = {}

    for license, data in pairs(AdminReportsList) do
        local result = MySQL.Sync.fetchAll('SELECT permission_group, fivem FROM users WHERE identifier=@identifier', { ['@identifier'] = license })

        if (result[1] ~= nil) then
            local Credit = (AdminReportsList[license].count * creditCountForReport)

            if (result[1].permission_group == "helper") then
                Credit = Credit * 1.025
            elseif (result[1].permission_group == "moderateur") then
                Credit = Credit * 1.05
            elseif (result[1].permission_group == "admin") then
                Credit = Credit * 1.1
            end

            Credit = Credit * 2

            table.insert(AllAdmin, {
                playerName = AdminReportsList[license].name,
                staffMode = AdminReportsList[license].state,
                reportCount = AdminReportsList[license].count,
                credit = math.ceil(Credit)
            })

            -- if (result[1].fivem) then
            --     if (AdminReportsList[license].count > 100) then
            --         MySQL.Sync.execute("INSERT INTO tebex_players_wallet (identifiers, transaction, price, currency, points) VALUES (@identifiers, @transaction, @price, @currency, @points)", {
            --             ["@identifiers"] = result[1].fivem,
            --             ["@transaction"] = 'Ajout de coins via la console (Reports de la semaine)',
            --             ["@price"] = 0,
            --             ["@currency"] = 'Points',
            --             ["@points"] = Credit
            --         })
                
            --     end
            -- end

            local xPly = ESX.GetPlayerFromIdentifier(license)
            if (xPly) then
                if (sAdminSrv) then
                    if (sAdminSrv.AdminList[xPly.source]) then
                        sAdminSrv.AdminList[xPly.source].reportEffectued = 0
                    end
                end
            end
        end
    end

    exports['Gamemode']:SendStaffBoard(AllAdmin)

    MySQL.Async.fetchAll('SELECT * FROM `staff`', {}, function(results)
        for i=1, #results do

            MySQL.Async.fetchAll('SELECT permission_group FROM users WHERE identifier=@identifier', {
                ['@identifier'] = results[i].license
            }, function(result)

                if (result[1] ~= nil) then
                    if (result[1].permission_group == "user") then
                        MySQL.Async.fetchAll('DELETE FROM staff WHERE license=@license', {
                            ['@license'] = results[i].license
                        })
                    end
                end
            end)
        end
    end)

    MySQL.Sync.execute('UPDATE staff SET report = @report', {
        ['@report'] = 0
    })

    Wait(1000)

    InitReportsBoard()
end


CreateThread(function()
    Wait(5000)
    while true do

        if (TodayDate ~= os.date("%A") and os.date("%A") == "Saturday") then
            TodayDate = os.date("%A")

            print('Reset des reports de la semaine')
            ResetAllReportsAdmin()
        end

        Wait(15000)
    end
end)


RegisterCommand('resetallreports', function()
    print('Reset des reports de la semaine')
    ResetAllReportsAdmin()
end, true)


AddEventHandler('sAdmin:ChangeState', function(state)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if (AdminReportsList[xPlayer.identifier]) then
        AdminReportsList[xPlayer.identifier].state = state
    end
end)

function GetAvgReports()
    local TotalStaff = 0
    local TotalReports = 0

    for license, data in pairs(AdminReportsList) do
        TotalStaff +=1
        
        TotalReports += data.count
    end

    return math.ceil(TotalReports / TotalStaff)
end

function GetAllAdminInfos(xPlayer)
    local AllAdmin = {}

    for license, data in pairs(AdminReportsList) do
        local xPly = ESX.GetPlayerFromIdentifier(license)

        if (xPly and xPlayer.identifier ~= xPly.identifier) then
            if (xPly.getGroup() ~= "user") then
                table.insert(AllAdmin, {
                    gradeName = xPly.getGroup(),
                    playerName = xPly.name,

                    staffMode = AdminReportsList[license].state,

                    reportCount = AdminReportsList[license].count
                })
            end
        end
    end

    return AllAdmin
end

CreateThread(function()
    while true do

        for src, v in pairs(sAdminSrv.AdminList) do 
            local xPlayer = ESX.GetPlayerFromId(src)

            if (xPlayer) then
                local AllAdmin = GetAllAdminInfos(xPlayer)
                local AvgReports = GetAvgReports()

                TriggerClientEvent("sAdmin:UpdateStaffBoardCount", src, AdminReportsList[xPlayer.identifier].count, AvgReports, xPlayer.name, xPlayer.getGroup(), AllAdmin)
            end
        end

        Wait(10000)
    end
end)


exports('GetStaffBoard', function()
    AllAdmin = {}

    for license, data in pairs(AdminReportsList) do
        local xPly = ESX.GetPlayerFromIdentifier(license)

        local GradeName = "Pas CO"

        if (xPly) then
            GradeName = xPly.getGroup()

            table.insert(AllAdmin, {
                gradeName = GradeName,
                playerName = AdminReportsList[license].name,
    
                staffMode = AdminReportsList[license].state,
    
                reportCount = AdminReportsList[license].count
            })
        end
    end

    return AllAdmin
end)