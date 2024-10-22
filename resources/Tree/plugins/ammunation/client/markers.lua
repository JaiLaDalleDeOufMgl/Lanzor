
CreateThread(function()
    for k,v in pairs(SharedAmmunation.position) do 
        Tree.Function.Zone.create("Ammunation:"..k, v, 5.0, {
            onEnter = function()
                Tree.Function.While.addTick(0, 'drawmarker:'..k, function()
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour accéder au menu")
                    Tree.Function.Visual.drawMarker(v)
                end)
                Tree.Function.Zone.create('Ammunation:press:'..k, v, 2.5, {
                    onPress = function()
                        AmmunationMain()
                    end,
                    onExit = function()
                        Tree.Menu.CloseAll()
                    end
                })
            end,
            onExit = function()
                Tree.Function.While.removeTick('drawmarker:'..k)
                Tree.Function.Zone.delete('Ammunation:press:'..k)
            end
        })
        Tree.Function.Blips.create("Ammunation:"..k, v, 313, 1, "Armurerie")
    end
end)

RegisterNetEvent('tree:ammunation:useMunitions')
AddEventHandler('tree:ammunation:useMunitions', function()
	local playerPed = PlayerPedId()
	if IsPedArmed(playerPed, 4) then
		local hash = GetSelectedPedWeapon(playerPed)
        local modelWeapon = 416676503
        local modelGroupe = GetWeapontypeGroup(hash)
        if modelGroupe == modelWeapon then
            if hash then
                TriggerServerEvent('tree:ammunation:removeMunitions', 1)
                AddAmmoToPed(playerPed, hash, 1)
                ESX.ShowNotification("Vous avez "..Tree.Config.Serveur.color.."utilisé~s~ 1x munitions")
            else
                ESX.ShowNotification(Tree.Config.Serveur.color.."Action Impossible~s~ : Vous n'avez pas d'arme en main !")
            end
        else
            ESX.ShowNotification(Tree.Config.Serveur.color.."Action Impossible~s~ : Ce type de munition ne convient pas !")
        end
	else
		ESX.ShowNotification(Tree.Config.Serveur.color.."Action Impossible~s~ : Ce type de munition ne convient pas !")
	end
end)


RegisterNetEvent('tree:ammunation:useClip')
AddEventHandler('tree:ammunation:useClip', function()
	local playerPed = PlayerPedId()
	if IsPedArmed(playerPed, 4) then
		local hash = GetSelectedPedWeapon(playerPed)
        local modelWeapon = 416676503
        local modelGroupe = GetWeapontypeGroup(hash)
        if hash then
            TriggerServerEvent('tree:ammunation:removeClip', 12)
            AddAmmoToPed(playerPed, hash, 12)
            ESX.ShowNotification("Vous avez "..Tree.Config.Serveur.color.."utilisé~s~ 1x chargeur (x12)")
        else
            ESX.ShowNotification(Tree.Config.Serveur.color.."Action Impossible~s~ : Vous n'avez pas d'arme en main !")
        end
	else
		ESX.ShowNotification(Tree.Config.Serveur.color.."Action Impossible~s~ : Ce type de munition ne convient pas !")
	end
end)
