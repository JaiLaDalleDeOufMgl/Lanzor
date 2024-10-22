-- MENU FUNCTION --

local open = false 
local tequilalaMain2 = RageUI.CreateMenu('', 'Tequilala')
local subMenu5 = RageUI.CreateSubMenu(tequilalaMain2, "Annonces", "Interaction")
tequilalaMain2.Display.Header = true 
tequilalaMain2.Closed = function()
  open = false
end

function KeyboardInputTequilala(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
  
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
      Citizen.Wait(0)
    end
  
    if UpdateOnscreenKeyboard() ~= 2 then
      local result = GetOnscreenKeyboardResult()
      return result
    else
      return nil
    end
end

RegisterNetEvent("Tequilala:StartBoucleMoney")
AddEventHandler("Tequilala:StartBoucleMoney", function()
    StartInitMoneyYamok()
end)

CoordsThrowing = {
    vector3(111.08, -1287.938, 28.26024),
    vector3(107.4864, -1286.822, 28.26024),
    vector3(110.5594, -1291.388, 28.26024)
}

function StartInitMoneyYamok()
    initthrowingbillet = true
    Citizen.CreateThread(function()
        while initthrowingbillet do
            Wait(0)
            local ped = PlayerPedId()
            local pedcoords = GetEntityCoords(ped, false)
            for k,v in pairs(CoordsThrowing) do
                local distance = Vdist(pedcoords.x, pedcoords.y, pedcoords.z, v)
                DrawMarker(29, v, 0, 0, 0, 180.0,nil,nil, 0.3, 0.3, 0.3,250,0,255, 255, false, true, nil, true)
                if distance <= 1.5 then
                    ESX.ShowHelpNotification('Appuyez sur ~INPUT_PICKUP~ pour jeter de l\'argent à la stripteaseuse.')
                    if IsControlJustPressed(0, 51) then
                        ThrowMoney(v)
                    end
                end
            end
        end
    end)
end

local society = {
    label = "Tequilala",
    name = "tequilalajob",
}


function ThrowMoney(zone)
    RequestNamedPtfxAsset("core")
    cash = CreateObject(GetHashKey("prop_cash_pile_01"), 0, 0, 0, false, true, true) 
    AttachEntityToEntity(cash, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), 0.12, 0.028, 0.001, 300.00, 180.0, 20.0, true, true, false, true, 1, true)
    local lib, anim = 'anim@mp_player_intcelebrationfemale@raining_cash', 'raining_cash' do
    Citizen.Wait(900)
    ESX.Streaming.RequestAnimDict(lib, function()
    TaskPlayAnim(PlayerPedId(), lib, anim, 8.0 , -1 , -1 , 0 , 0 , false , false , false);
    Citizen.Wait(1000)
    UseParticleFxAssetNextCall("core")
    local fx = StartParticleFxNonLoopedOnEntity("ent_brk_banknotes", PlayerPedId(), 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, false, false, false)  --(effectName, entity, offsetX, offsetY, offsetZ, rotX, rotY, rotZ, scale, axisX, axisY, axisZ);
        end)
    end
    TriggerServerEvent('Tequilala:PayStrip')
    Citizen.Wait(4000)
    DeleteEntity(cash)
    Citizen.Wait(1000)
    --FS.TriggerServerEvent("Core:AddMoneyBusiness", zone, "deposit", society, "cash", 1000)
end

local IndexStrip = 1

RegisterNetEvent("Tequilala:StartStrip")
AddEventHandler("Tequilala:StartStrip", function()
    local model = GetHashKey("csb_stripper_01")
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(10)
    end
    npc = CreatePed(1, "csb_stripper_01", 99.95526, -1294.306, 29.26352, 265.902, false, true)
    PedToNet(npc)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    TaskGoToCoordAnyMeans(npc, 108.7208, -1289.08, 29.2497, 265.902, 0, 0, 786603, 1.0)
    Wait(3000)
    RequestAnimDict("mini@strip_club@pole_dance@pole_dance3")
    while not HasAnimDictLoaded("mini@strip_club@pole_dance@pole_dance3") do
        Citizen.Wait(100)
    end
    netScene3 = CreateSynchronizedScene(108.7208, -1289.08, 29.2497, vec3(0.0, 0.0, 0.0), 2)
    TaskSynchronizedScene(npc, netScene3, "mini@strip_club@pole_dance@pole_dance3", "pd_dance_03", 1.0, -4.0, 261, 0, 0)
    SetSynchronizedSceneLooped(netScene, 1)
    SetModelAsNoLongerNeeded(model)
    inscene = true
end)

RegisterNetEvent("Tequilala:StopStrip")
AddEventHandler("Tequilala:StopStrip", function()
    ClearPedTasksImmediately(npc)
    TaskGoToCoordAnyMeans(npc, 99.95526, -1294.306, 29.26352, 265.902+180, 0, 0, 786603, 1.0)
    Wait(5000)
    DeleteEntity(npc)
	inscene = false
	initthrowingbillet = false
end)

function OpenMenutequilala()
	if open then 
		open = false
		RageUI.Visible(tequilalaMain2, false)
		return
	else
		open = true 
		RageUI.Visible(tequilalaMain2, true)
		CreateThread(function()
		while open do 
		   RageUI.IsVisible(tequilalaMain2,function() 

			RageUI.Separator("↓ Annonce Tequilala ↓")
			RageUI.Button("Annonce ~g~[Ouvertures]~s~", nil, {RightLabel = "→"}, true , {
				onSelected = function()
					TriggerServerEvent('Ouvre:tequilala')
				end
			})

			RageUI.Button("Annonce "..exports.Tree:serveurConfig().Serveur.color.."[Fermetures]"..exports.Tree:serveurConfig().Serveur.color.."", nil, {RightLabel = "→"}, true , {
				onSelected = function()
					TriggerServerEvent('Ferme:tequilala')
				end
			})

			RageUI.Button("Annonce "..exports.Tree:serveurConfig().Serveur.color.."[Recrutement]", nil, {RightLabel = "→"}, true , {
				onSelected = function()
					TriggerServerEvent('Recrutement:tequilala')
				end
			})
			
			RageUI.Separator("↓ Facture ↓")
			RageUI.Button("Faire une "..exports.Tree:serveurConfig().Serveur.color.."Facture", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local montant = KeyboardInputPolice("Montant:", 'Indiquez un montant', '', 6)
					local amount = 0;
                    if tonumber(montant) == nil then
                        ESX.ShowNotification("Montant invalide")
                        return false
                    else
                        amount = (tonumber(montant))
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						if closestPlayer == -1 or closestDistance > 3.0 then
							ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Personne autour de vous')
						else
              ESX.ShowNotification("~g~Facture envoyée avec succès !")
              TriggerServerEvent('sendLogs:Facture', GetPlayerServerId(closestPlayer), amount)
							TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'tequilala', 'Tequilala', amount)
						end
                    end
                end
            })
			end)

		 Wait(0)
		end
	 end)
  end
end




-- FUNCTION BILLING --

function OpenBillingMenu2()

	ESX.UI.Menu.Open(
	  'dialog', GetCurrentResourceName(), 'billing',
	  {
		title = "Facture"
	  },
	  function(data, menu)
	  
		local amount = tonumber(data.value)
		local player, distance = ESX.Game.GetClosestPlayer()
  
		if player ~= -1 and distance <= 3.0 then
  
		  menu.close()
		  if amount == nil then
			  ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Problèmes~s~: Montant invalide")
		  else
			local playerPed        = PlayerPedId()
			TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
			Citizen.Wait(5000)
			  TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'tequilala', ('tequilala'), amount)
		  end
  
		else
		  ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Problèmes~s~: Aucun joueur à proximitée")
		end
  
	  end,
	  function(data, menu)
		  menu.close()
	  end
	)
  end