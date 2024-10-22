

local filter = {dressing = {index = 1}}

---@author Razzway
---@type function Render:myDressingMenu
function Render:myDressingMenu()
    RageUIClothes.Separator(#_Razzway.Data.." / 10 Tenues")
    RageUIClothes.Line()
    if _Razzway.Data == nil then 
        _Razzway:refreshData()
        BLCCCCCCCCCC = false
        RageUIClothes.GoBack()
    elseif _Razzway.Data == {} then 
        RageUIClothes.Separator("Aucune tenue")
    else
        for _,v in pairs(_Razzway.Data) do
            if v.type == "outfit" then
                RageUIClothes.List('~c~→~s~ '..v.name, {
                    {Name = "~g~Mettre~s~", Type = 1},
                    {Name = exports.Tree:serveurConfig().Serveur.color.."Renommer~s~", Type = 2},
                    {Name = exports.Tree:serveurConfig().Serveur.color.."Supprimer~s~", Type = 3},
                }, filter.dressing.index, nil, {}, nil, {
                    onActive = function() Uclothes:OnRenderCam() end,
                    onListChange = function(Index, Item)
                        filter.dressing.index = Index;
                        selectedType = Item.Type;
                    end,
                    onSelected = function(Index, Item)
                        if selectedType == nil then selectedType = 1 end
                        if selectedType == 1 then
                            CreateThread(function()
                                TriggerEvent('skinchanger:getSkin', function(skin)
                                    TriggerEvent('skinchanger:loadClothes', skin, json.decode(v.data))
                                    Citizen.Wait(50)
                                    TriggerEvent('skinchanger:getSkin', function(skin_)
                                        TriggerServerEvent('esx_skin:save', skin_)
                                    end)
                                end)
                            end)
                            ESX.ShowNotification('~g~Vous avez enfilé la tenue : '..v.name)
                        end
                        if selectedType == 2 then
                            local newName = KeyboardInput('Nouveau nom à attribuer :','','', 20)
                            if newName == "" or newName == nil then
                                ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Attention !~s~\nVous devez attitré le nouveau nom de votre tenue pour l'enregistrer.")
                            else
                                CreateThread(function()
                                    TriggerEvent('skinchanger:getSkin', function(saveAppearance)
                                        Wait(25)
                                        TriggerServerEvent(_Prefix..":modifyData", v.id, newName)
                                        ESX.ShowNotification('~h~Vous avez attribué un nouveau nom à votre tenue :~h~\n- '..exports.Tree:serveurConfig().Serveur.color..'Ancien~s~ '..exports.Tree:serveurConfig().Serveur.color..'→~s~ ('..v.name..')\n- ~g~Nouveau~s~ '..exports.Tree:serveurConfig().Serveur.color..'→~s~ ('..newName..')')
                                    end)
                                    Wait(50)
                                    RageUIClothes.GoBack()
                                end)
                            end
                        end
                        if selectedType == 3 then
                            TriggerServerEvent(_Prefix..':deleteData', v.id)
                            ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Vêtement~s~\nLa tenue '..exports.Tree:serveurConfig().Serveur.color..''..v.name..'~s~ a correctement été '..exports.Tree:serveurConfig().Serveur.color..'supprimée~s~ de votre dressing.')
                            RageUIClothes.GoBack()
                        end
                    end,
                })
            end
        end       
    end
end