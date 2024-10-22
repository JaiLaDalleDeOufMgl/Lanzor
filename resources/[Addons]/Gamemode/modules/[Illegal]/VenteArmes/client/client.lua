local acces = false
local VdaPos = 0
local VdaMenu = RageUI.CreateMenu("", "Vendeur d'armes illégal", 0, 0, 'commonmenu', 'interaction_bgd')
VdaMenu.Closed = function()
    open = false
end
function OpenVdaMenu(lvl)
    if open then
        open = false
        RageUI.Visible(VdaMenu,false)
        return
    else
        open = true
        RageUI.Visible(VdaMenu,true)
        CreateThread(function()
            while open do 
                local dist = #(GetEntityCoords(PlayerPedId()) - VdaPos)
                if dist > 5.0 then
                    RageUI.CloseAll()
                    open = false
                end
                RageUI.IsVisible(VdaMenu,function()
                    RageUI.Separator("Vda Niveau : "..exports.Tree:serveurConfig().Serveur.color..""..lvl)
                    RageUI.Line()
                    if lvl == 1 then
                        RageUI.Separator("Armes en vente ")
                        RageUI.Line()
                        for k,v in pairs (ConfigVDA.WeaponSell) do
                            RageUI.Button(v.WeaponLabel, nil, {RightLabel = exports.Tree:serveurConfig().Serveur.color..""..v.price.."$"}, true, {
                                onSelected = function()
                                    TriggerServerEvent("Vda:BuyWeapon", v.WeaponName, v.price,v.WeaponLabel)
                                end
                            })
                        end
                        RageUI.Line()
                        RageUI.Separator("Objets en vente")
                        RageUI.Line()
                        for k,v in pairs (ConfigVDA.ItemSell) do
                            RageUI.Button(v.ItemLabel, nil, {RightLabel = exports.Tree:serveurConfig().Serveur.color..""..v.price.."$"}, true, {
                                onSelected = function()
                                    TriggerServerEvent("Vda:BuyItem", v.ItemName, v.price,v.ItemLabel)
                                end
                            })
                        end
                    elseif lvl == 2 then 
                        RageUI.Separator(" Armes en vente ")
                        RageUI.Line()
                        for k,v in pairs (ConfigVDA.WeaponSellV2) do
                            RageUI.Button(v.WeaponLabel, nil, {RightLabel = exports.Tree:serveurConfig().Serveur.color..""..v.price.."$"}, true, {
                                onSelected = function()
                                    TriggerServerEvent("Vda:BuyWeapon", v.WeaponName, v.price,v.WeaponLabel)
                                end
                            })
                        end
                        RageUI.Line()
                        -- RageUI.Separator("↓ Objets en vente ↓")
                        -- RageUI.Line()
                        -- for k,v in pairs (ConfigVDA.ItemSellV2) do
                        --     RageUI.Button(v.ItemLabel, nil, {RightLabel = exports.Tree:serveurConfig().Serveur.color..""..v.price.."$"}, true, {
                        --         onSelected = function()
                        --             TriggerServerEvent("Vda:BuyItem", v.ItemName, v.price,v.ItemLabel)
                        --         end
                        --     })
                        -- end
                    end
                    
                end)
                Wait(1)
            end
        end)
    end
end
RegisterNetEvent("Vda:OpenMenu")
AddEventHandler("Vda:OpenMenu", function(lvl)
    OpenVdaMenu(lvl)
end)

-- RegisterNetEvent("Vda:AddBlips")
-- AddEventHandler("Vda:AddBlips", function()
--     AddBlips()
-- end)

-- function AddBlips()
--     CreateThread(function()
--         local blip = AddBlipForCoord(VdaPos.x, VdaPos.y, VdaPos.z)
--         SetBlipSprite(blip, 567)
--         SetBlipDisplay(blip, 4)
--         SetBlipScale(blip, 0.8)
--         SetBlipColour(blip, 1)
--         SetBlipAsShortRange(blip, true)
--         BeginTextCommandSetBlipName("STRING")
--         AddTextComponentString("Vendeur d'armes illégal")
--         EndTextCommandSetBlipName(blip)
--     end)

-- end

function GetVdaCoords()
    ESX.TriggerServerCallback('Vda:GetVdaCoords', function(cb)
        VdaPos = cb
    end)
end


CreateThread(function()
    GetVdaCoords()
    Wait(2000)
    while true do
        local interval = 800
        local pCoords = GetEntityCoords(PlayerPedId())
        local dst = #(pCoords - VdaPos)
        if dst < 5.0 then
            interval = 1
            DEN:Marker(VdaPos.x, VdaPos.y, VdaPos.z)
            if dst < 1.0 then
                interval = 1
                if not RageUI.Visible(VdaMenu) then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour parler au "..exports.Tree:serveurConfig().Serveur.color.."Vendeur d'armes")
                end
                if IsControlJustPressed(1, 51) then
                    TriggerServerEvent("Vda:CheckAccess")
                end
            end
        end
    
        Wait(interval)
    end
end)