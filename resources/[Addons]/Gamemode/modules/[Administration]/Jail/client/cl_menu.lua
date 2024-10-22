

ESX = nil
local jail = 0
CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Wait(100)
    end
    while ESX.GetPlayerData().job == nil do
        Wait(100)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)
local open = false

ConfigJailMenu = {
    {JailLabel = "NoPain 1ère fois", JailTache = 10},
    {JailLabel = "NoPain 2ère fois", JailTache = 25},
    {JailLabel = "NoPain 3ère fois", JailTache = 75},
    {JailLabel = "NoPain 4ère fois", JailTache = 150},
    {JailLabel = "No Fear 1ème fois", JailTache = 10},
    {JailLabel = "No Fear 2ème fois", JailTache = 25},
    {JailLabel = "No Fear 3ème fois", JailTache = 75},
    {JailLabel = "No Fear 4ème fois", JailTache = 150},
    {JailLabel = "Vocal HRP 1ème fois", JailTache = 10},
    {JailLabel = "Vocal HRP 2ème fois", JailTache = 25},
    {JailLabel = "Vocal HRP 3ème fois", JailTache = 75},
    {JailLabel = "Vocal HRP 4ème fois", JailTache = 150},
    {JailLabel = "Conduite HRP 1ème fois", JailTache = 10},
    {JailLabel = "Conduite HRP 2ème fois", JailTache = 25},
    {JailLabel = "Conduite HRP 3ème fois", JailTache = 75},
    {JailLabel = "Conduite HRP 4ème fois", JailTache = 150},
    {JailLabel = "Copbait 1ème fois", JailTache = 10},
    {JailLabel = "Copbait 2ème fois", JailTache = 25},
    {JailLabel = "Copbait 3ème fois", JailTache = 75},
    {JailLabel = "Copbait 4ème fois", JailTache = 150},
    {JailLabel = "Freekill 1ème fois", JailTache = 50},
    {JailLabel = "Freekill 2ème fois", JailTache = 150},
    {JailLabel = "Freekill 3ème fois", JailTache = 500},
    {JailLabel = "Troll 1ème fois", JailTache = 50},
    {JailLabel = "Troll 2ème fois", JailTache = 150},
    {JailLabel = "Troll 3ème fois", JailTache = 500},
    {JailLabel = "Refus de scène 1ème fois", JailTache = 50},
    {JailLabel = "Refus de scène 2ème fois", JailTache = 150},
    {JailLabel = "Refus de scène 3ème fois", JailTache = 500},
    {JailLabel = "Force RP 1ème fois", JailTache = 50},
    {JailLabel = "Force RP 2ème fois", JailTache = 150},
    {JailLabel = "Force RP 3ème fois", JailTache = 500},
    {JailLabel = "Stream Hack 1ème fois", JailTache = 50},
    {JailLabel = "Stream Hack 2ème fois", JailTache = 150},
    {JailLabel = "Stream Hack 3ème fois", JailTache = 500},
    {JailLabel = "Sex RP 1ème fois", JailTache = 50},
    {JailLabel = "Sex RP 2ème fois", JailTache = 150},
    {JailLabel = "Sex RP 3ème fois", JailTache = 500},
}

RegisterNetEvent("JailMenu:OpenMenu")
AddEventHandler("JailMenu:OpenMenu", function(id)
    OpenJailMenu(id)
end)

RegisterNetEvent("JailMenu:AddJailCounter")
AddEventHandler("JailMenu:AddJailCounter", function()
    if jail == 0 then
        jail = jail + 1
        inTimeJail()
    else
        jail = jail + 1
    end
end)
local JailMenu = RageUI.CreateMenu("", "Jail Menu", 0, 0, 'commonmenu', 'interaction_bgd')

function OpenJailMenu(id)
	if open then
		open = false
		RageUI.Visible(JailMenu,false)
		return
	else
		open = true
		RageUI.Visible(JailMenu,true)
		CreateThread(function()
			while open do

				RageUI.IsVisible(JailMenu,function() 
                    RageUI.Separator("ID sélectionné : "..exports.Tree:serveurConfig().Serveur.color..""..id.."~s~")
					for k,v in pairs(ConfigJailMenu) do
                        RageUI.Button(v.JailLabel.." | "..exports.Tree:serveurConfig().Serveur.color..""..v.JailTache.."~s~ Tache", nil, {RightLabel = "→→→"}, true, {
                            onSelected = function()
                                TriggerServerEvent("JailMenu:JailPlayer", id, v.JailTache, v.JailLabel)
                                ESX.ShowNotification("~o~Vous avez jail l'ID "..id.." pour "..v.JailTache.." taches ~s~")
                                open = false
                            end
                        })
                    end
                    RageUI.Button("Taches Personalisé", nil, {RightLabel = "→→→"}, true, {
                        onSelected = function()
                            local TacheRaison = DEN:KeyboardInput("Raison", "Entre la raison du jail", 30)
                            local tacheNumber = DEN:KeyboardInput("Tache", "Entre le nombre de taches", 30)
                            if TacheRaison ~= nil then
                                if tonumber(tacheNumber) ~= nil then
                                    TriggerServerEvent("JailMenu:JailPlayer", id, tacheNumber, TacheRaison)
                                    ESX.ShowNotification("~o~Vous avez jail l'ID "..id.." pour "..tacheNumber.." taches ~s~")
                                    open = false
                                else
                                    ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Veuillez entrer un nombre de tache valide")
                                end
                            else
                                ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Veuillez entrer une raison valide")
                            end
                        end
                    })
				end)
				Citizen.Wait(1)
			end
		end)
	end
end

function inTimeJail()
    local timer = 180000
    while timer > 0 do
        if jail >= 10 then
            TriggerServerEvent("JailMenu:AntiMassJail")
        end
        if timer <= 1000 then
            jail = 0
        end
        timer = timer - 1000
        Wait(1000)
    end
end