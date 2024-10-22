local societyJobsmoney = nil
local jobsData = {};

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer

    ESX.TriggerServerCallback('JobBuilder:getAllJobs', function(result)
        jobsData = result;
    end);

end)

RegisterNetEvent('jobbuilder:restarted', function(player)

    ESX.PlayerData = player

    ESX.TriggerServerCallback('JobBuilder:getAllJobs', function(result)
        jobsData = result;
    end);

end);

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)

    ESX.PlayerData.job = job

    ESX.TriggerServerCallback('JobBuilder:getAllJobs', function(result)
        jobsData = result;
    end);

end)

local function JobBuilderKeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end

local JobsEmployeList = {}
local JobBuilder = {
    Boss = {}
};

function MenuBoss(LabelJob)
  local MenuBoss = RageUIv1.CreateMenu("", LabelJob)
  local MenuGestEmployeJobs = RageUIv1.CreateSubMenu(MenuBoss, "", LabelJob)
  local MenuGestEmployeJobs2 = RageUIv1.CreateSubMenu(MenuGestEmployeJobs, "", LabelJob)
  RageUIv1.Visible(MenuBoss, not RageUIv1.Visible(MenuBoss))
            while MenuBoss do
                Citizen.Wait(0)
                    RageUIv1.IsVisible(MenuBoss, true, true, true, function()

                    if societyJobsmoney ~= nil then
                        RageUIv1.Button("Argent société :", nil, {RightLabel = "$" .. societyJobsmoney}, true, function()
                        end)
                    end

                    RageUIv1.Button("Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local Cbmoney = JobBuilderKeyboardInput("Combien ?", '' , 15)
                            Cbmoney = tonumber(Cbmoney)
                            if Cbmoney == nil then
                                RageUIv1.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('JobBuilder:withdrawMoney', JobBuilder.Boss.SocietyName, Cbmoney)
                                RefreshJobsMoney()
                            end
                        end
                    end)

                    RageUIv1.Button("Déposer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local Cbmoneyy = JobBuilderKeyboardInput("Montant", "", 10)
                            Cbmoneyy = tonumber(Cbmoneyy)
                            if Cbmoneyy == nil then
                                RageUIv1.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('JobBuilder:depositMoney', JobBuilder.Boss.SocietyName, Cbmoneyy)
                                RefreshJobsMoney()
                            end
                        end
                    end)


                    RageUIv1.Button("Gestion employés", nil, {RightLabel = "→→"}, true, function(Hovered,Active,Selected)
                        if Selected then
                            local GangName = JobBuilder.Boss.Name
                            loadEmployeJobs(GangName)
                        end
                    end, MenuGestEmployeJobs)

            end, function()
            end)

            RageUIv1.IsVisible(MenuGestEmployeJobs, true, true, true, function()

                if #JobsEmployeList == 0 then
                    RageUIv1.Separator("")
                    RageUIv1.Separator(exports.Tree:serveurConfig().Serveur.color.."Aucun Employé")
                    RageUIv1.Separator("")
                end

                for k,v in pairs(JobsEmployeList) do
                    RageUIv1.Button(v.Name, false, {RightLabel = exports.Tree:serveurConfig().Serveur.color.."→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            Ply = v
                        end
                    end, MenuGestEmployeJobs2)
                end

            end, function()
            end)

            RageUIv1.IsVisible(MenuGestEmployeJobs2, true, true, true, function()

                RageUIv1.Button("Virer "..exports.Tree:serveurConfig().Serveur.color..Ply.Name,nil, {RightLabel = exports.Tree:serveurConfig().Serveur.color.."→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('JobBuilder:Bossvirer', Ply.InfoMec)
                        RageUIv1.CloseAll()
                    end
                end)

                RageUIv1.Button("Promouvoir "..exports.Tree:serveurConfig().Serveur.color..Ply.Name,nil, {RightLabel = exports.Tree:serveurConfig().Serveur.color.."→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('JobBuilder:Bosspromouvoir', Ply.InfoMec)
                        RageUIv1.CloseAll()
                    end
                end)

                RageUIv1.Button("Destituer "..exports.Tree:serveurConfig().Serveur.color..Ply.Name,nil, {RightLabel = exports.Tree:serveurConfig().Serveur.color.."→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent('JobBuilder:Bossdestituer', Ply.InfoMec)
                        RageUIv1.CloseAll()
                    end
                end)

            end, function()
            end)

            if not RageUIv1.Visible(MenuBoss) and not RageUIv1.Visible(MenuGestEmployeJobs) and not RageUIv1.Visible(MenuGestEmployeJobs2) then
            MenuBoss = RMenu:DeleteType("MenuBoss", true)
        end
    end
end

function loadEmployeJobs(jobName)
    ESX.TriggerServerCallback('JobBuilder:GetJobsEmploye', function(Employe)
        JobsEmployeList = Employe
    end, jobName)
end

function RefreshJobsMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('JobBuilder:getSocietyMoney', function(money)
            UpdateSocietyJobsMoney(money)
        end, "society_"..ESX.PlayerData.job.name)
    end
end

function UpdateSocietyJobsMoney(money)
    societyJobsmoney = ESX.Math.GroupDigits(money)
end

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        for k,v in pairs(jobsData) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == v.Name and ESX.PlayerData.job.grade_name == 'boss' then
                
                local plyPos = GetEntityCoords(PlayerPedId())
                local Boss = vector3(json.decode(v.PosBoss).x, json.decode(v.PosBoss).y, json.decode(v.PosBoss).z)
                local dist = #(plyPos-Boss)
                if dist <= 20.0 then
                    Timer = 0
                    DrawMarker(2, Boss, 0, 0, 0, 0.0, nil, nil, 0.2, 0.2, 0.2, 0, 129, 211, 255, 0, 1, 0, 0, nil, nil, 0)
                end
                if dist <= 3.0 then
                    Timer = 0
                    ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour accéder aux actions patron")
                    if IsControlJustPressed(1,51) then
                        JobBuilder.Boss = v
                        -- ESX.OpenSocietyMenu(v.Name);
                        --RefreshJobsMoney()
                        --MenuBoss(v.Label)
                    end
                end
            end
        end
        Citizen.Wait(Timer)
    end
end);

exports("openBossMenu", function(label)
    MenuBoss(label)
end)