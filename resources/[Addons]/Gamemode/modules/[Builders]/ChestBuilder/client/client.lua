CreateThread(function()
    ESX.PlayerData = ESX.GetPlayerData()
end)

local ChestServer = {}
local tempoTable = {}

local pos = nil
local job = nil
local MaxWeight = 0
local AccesBlackMoney = nil
local bpos = nil
local bjob = nil
local bMaxWeight = nil
local bAccesBlackMoney = nil

local currentmoney = 0
local currentbmoney = 0

local ChestBuilderMenu = RageUI.CreateMenu("", "Coffre Builder", 0, 0, 'commonmenu', 'interaction_bgd')
local ChestBuilderMenuInteract = RageUI.CreateSubMenu(ChestBuilderMenu, "", "Coffre Builder", 0, 0, 'commonmenu', 'interaction_bgd')
local ChestBuilderMenuChestIneract = RageUI.CreateSubMenu(ChestBuilderMenu, "", "Coffre Builder", 0, 0, 'commonmenu', 'interaction_bgd') 

local ChestMenu = RageUI.CreateMenu("", "Coffre", 0, 0, 'commonmenu', 'interaction_bgd')
local ChestMenuMyInventory = RageUI.CreateSubMenu(ChestMenu, "", "Votre Inventaire", 0, 0, 'commonmenu', 'interaction_bgd')
local ChestInventory = RageUI.CreateSubMenu(ChestMenu, "", "Inventaire du coffre", 0, 0, 'commonmenu', 'interaction_bgd')

ChestBuilderMenu.Closed = function()
    open = false
    pos = nil
    job = nil
    MaxWeight = 0
    AccesBlackMoney = nil
end
ChestMenu.Closed = function()
    open2 = false
    pos = nil
    job = nil
    MaxWeight = 0
    AccesBlackMoney = nil
end

RegisterNetEvent("ChestBuilder:OpenChestBuilder")
AddEventHandler("ChestBuilder:OpenChestBuilder", function()
    OpenChestBuilder()
end)

RegisterNetEvent("ChestBuilder:RefreshChest")
AddEventHandler("ChestBuilder:RefreshChest", function(SChestServer)
    ChestServer = SChestServer
end)
-- RegisterNetEvent("ChestBuilder:refreshMoney")
-- AddEventHandler("ChestBuilder:refreshMoney", function(type,money)
--     if type == "money" then
--         currentmoney = money
--     elseif type == "bmoney" then
--         currentbmoney = money
--     end
-- end)
   


function OpenChestBuilder()
	if open then
		open = false
		RageUI.Visible(ChestBuilderMenu,false)
		return
	else
		open = true
		RageUI.Visible(ChestBuilderMenu,true)
		CreateThread(function()
			while open do 
                if pos ~= nil then
                    bpos = "✅"
                else
                    bpos = "→"
                end
                if job ~= nil then
                    bjob = "✅"
                else
                    bjob = "→"
                end
                if MaxWeight ~= 0 then
                    bMaxWeight = "✅"
                else
                    bMaxWeight = "→"
                end
                if AccesBlackMoney == true then
                    bAccesBlackMoney = "✅"
                elseif AccesBlackMoney == false then
                    bAccesBlackMoney = "❌"
                else
                    bAccesBlackMoney = "→"
                end
				RageUI.IsVisible(ChestBuilderMenu,function() 
					RageUI.Button("Possition", pos, {RightLabel = bpos}, true, {
						onSelected = function()
							pos = GetEntityCoords(PlayerPedId())
						end
					})
                    RageUI.Button("Job", job, {RightLabel = bjob}, true, {
						onSelected = function()
							job = DEN:KeyboardInput("Job", "Job", 30)
						end
					})
                    RageUI.Button("Poid Maximal", MaxWeight.."KG", {RightLabel = bMaxWeight}, true, {
						onSelected = function()
							MaxWeight = DEN:KeyboardInput("Poid Maximal", "Poid Maximal", 30)
                            if tonumber(MaxWeight) ~= nil then
                                MaxWeight = tonumber(MaxWeight)
                            else
                                ESX.ShowNotification("Veuillez mettre un nombre")
                                MaxWeight = 0
                            end
						end
					})
                    RageUI.Button("Argent Sale (oui/non)", AccesBlackMoney, {RightLabel = bAccesBlackMoney}, true, {
						onSelected = function()
                            AccesBlackMoney = DEN:KeyboardInput("Argent Sale (oui/non)", "Argent Sale (oui/non)", 30)
                            if AccesBlackMoney == "oui" then
                                AccesBlackMoney = true
                            elseif AccesBlackMoney == "non" then
                                AccesBlackMoney = false
                            else
                                ESX.ShowNotification("Veuillez mettre oui ou non")
                                AccesBlackMoney = nil
                            end
                        end
					})
                    RageUI.Button("~g~Confirme la creation~s~", nil, {RightBadge = RageUI.BadgeStyle.Tick}, true, {
						onSelected = function()
                            if pos ~= nil and job ~= nil and MaxWeight ~= 0 then
                                TriggerServerEvent("ChestBuilder:CreateChest", pos, job, MaxWeight, AccesBlackMoney)
                                pos = nil
                                job = nil
                                MaxWeight = 0
                                AccesBlackMoney = false
                                ESX.ShowNotification("~g~Création effectué")
                            else
                                TriggerEvent('esx:showNotification', exports.Tree:serveurConfig().Serveur.color.."Veuillez remplir tous les champs~s~")
                            end
						end
					})
                    RageUI.Line()
                    RageUI.Button("Gestion Coffre", nil, {RightLabel = "→"}, true, {
						onSelected = function()
							
						end
					},ChestBuilderMenuInteract)

				end)
                RageUI.IsVisible(ChestBuilderMenuInteract,function()
                    for k,v in pairs(ChestServer) do
                        local tempWeigth = 0
                        for k,v in pairs(v.items) do
                            tempWeigth = tempWeigth + (v.weight * v.count)
                        end
                        RageUI.Button("Coffre : "..v.job, "Poid : "..tempWeigth.." KG / "..v.MaxWeight.." KG\nArgent Propre : ~g~"..v.money.."$~s~\nArgent Sale : "..exports.Tree:serveurConfig().Serveur.color..v.bmoney.." $~s~", {RightLabel = "ID : "..v.id}, true, {
                            onSelected = function()
                                tempoTable = v
                            end
                        },ChestBuilderMenuChestIneract)
                    end
                end) 
                RageUI.IsVisible(ChestBuilderMenuChestIneract,function()

                    RageUI.Button("Modifier la possition", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            Tpos = GetEntityCoords(PlayerPedId())
                            if Tpos ~= nil then
                                TriggerServerEvent("ChestBuilder:ModifStaff", tempoTable.id, nil,nil,nil,Tpos)
                                RageUI.GoBack()
                            end
                        end
                    })

                    RageUI.Button("Modifier le job", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            Tjob = DEN:KeyboardInput("Job", "Job", 30)
                            if Tjob ~= nil then
                                TriggerServerEvent("ChestBuilder:ModifStaff", tempoTable.id, Tjob)
                                RageUI.GoBack()
                            else
                                ESX.ShowNotification("Veuillez mettre un job")
                            end
                        end
                    })

                    RageUI.Button("Modifier le poid maximal", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            TMaxWeight = DEN:KeyboardInput("Poid Maximal", "Poid Maximal", 30)
                            if tonumber(TMaxWeight) ~= nil then
                                TriggerServerEvent("ChestBuilder:ModifStaff", tempoTable.id, nil, tonumber(TMaxWeight))
                                RageUI.GoBack()
                            else
                                ESX.ShowNotification("Veuillez mettre un nombre")
                            end
                        end
                    })

                    RageUI.Button("Modifier l'acces a l'argent sale (oui/non)", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            response = DEN:KeyboardInput("Argent Sale (oui/non)", "Argent Sale (oui/non)", 30)
                            if response == "oui" then
                                TriggerServerEvent("ChestBuilder:ModifStaff", tempoTable.id, nil,nil,true)

                                RageUI.GoBack()

                            elseif response == "non" then
                                TriggerServerEvent("ChestBuilder:ModifStaff", tempoTable.id, nil,nil, false)
                                RageUI.GoBack()
                            else
                                ESX.ShowNotification("Veuillez mettre oui ou non")
                            end
                        end
                    })
                    if tempoTable.accesbmoney ~= 0 then
                        RageUI.Line()

                        RageUI.Button("Déposer argent sale", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                local money = DEN:KeyboardInput("Nombre", "Combien voulez vous deposer ?", 30)
                                if tonumber(money) ~= nil then
                                    TriggerServerEvent("ChestBuilder:PutBlackMoney", tempoTable.id, tonumber(money))
                                    RageUI.GoBack()
                                else
                                    ESX.ShowNotification("Veuillez mettre un nombre")
                                end
                            end
                        })

                        RageUI.Button("Retirer argent sale", nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                local Rmoney = DEN:KeyboardInput("Nombre", "Combien voulez vous retirer ?", 30)
                                if tonumber(Rmoney) ~= nil then
                                    TriggerServerEvent("ChestBuilder:TakeBlackMoney", tempoTable.id, tonumber(Rmoney))
                                    RageUI.GoBack()
                                else
                                    ESX.ShowNotification("Veuillez mettre un nombre")
                                end
                            end
                        })


                    end
                    RageUI.Line()
                    RageUI.Button(exports.Tree:serveurConfig().Serveur.color.."Supprimer le coffre~s~", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            TriggerServerEvent("ChestBuilder:DeleteChest", tempoTable.id)
                            RageUI.GoBack()
                        end
                    })

                end)

				Wait(1)
			end
		end)
	end
end


CreateThread(function()
    while true do
        local tc = 1000
        local pos = GetEntityCoords(PlayerPedId())
        for k,v in pairs(ChestServer) do
            local posb = vector3(v.pos.x,v.pos.y,v.pos.z)
            local dif = #(pos - posb)

            if dif < 10 and v.job == ESX.PlayerData.job.name then
                tc = 1
                if dif < 2 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre")
                    DEN:Marker(posb.x,posb.y,posb.z)
                    if IsControlJustPressed(0, 38) then
                        currentmoney = v.money
                        currentbmoney = v.bmoney

                        TriggerServerEvent("Gamemode:Inventory:OpenSecondInventory", "coffrebuilder", v.id)
                    end
                end
            end
        end

        Wait(tc)
    end
end)