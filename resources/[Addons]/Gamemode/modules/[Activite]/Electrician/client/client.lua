local echelleprops, missionstarted, Gvehicle, echelleplaced, SelectedPos, finishedTakeNow = false, false, nil, false, nil, false
local mainpos, mainposh = vector3(737.58, 134.20, 80.71), 239.24

local AllPoses = {}

RegisterNetEvent("gamemode:receiveposesechelles", function(cb)
    AllPoses = cb
end)

CreateThread(function()
    local blippara = AddBlipForCoord(737.58, 134.20, 79.71)
    SetBlipSprite(blippara, 354)
    SetBlipDisplay(blippara, 4)
    SetBlipScale(blippara, 0.9)
    SetBlipColour(blippara, 46)
    SetBlipAsShortRange(blippara, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("[Métier LIBRE] Electricien")
    EndTextCommandSetBlipName(blippara)
    while true do 
        Wait(1)
        local dist = Vdist2(GetEntityCoords(PlayerPedId()), mainpos)
        if dist < 100 then 
            if dist < 2.0 then 
                if not echelleprops and not missionstarted then 
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour commencer la mission")
                    if IsControlJustPressed(0, 38) then 
                        RequestModel(GetHashKey('burrito'))
                        while not HasModelLoaded(GetHashKey('burrito')) do
                            Wait(100)
                        end
                        Gvehicle = CreateVehicle(GetHashKey('burrito'), 738.29, 128.59, 80.16, mainposh, true, false)
                        SetEntityAsMissionEntity(Gvehicle, true, true)
                        SetVehicleHasBeenOwnedByPlayer(Gvehicle, true)
                        SetVehicleLivery(Gvehicle, 4)
                        local randommm = math.random(1, #AllPoses)
                        SelectedPos = AllPoses[randommm]
                        missionstarted = true
                        -- print(SelectedPos.done)
                        SetNewWaypoint(SelectedPos.x, SelectedPos.y)
                        ESX.ShowNotification("Vous avez commencé la mission. Un point a été placé sur votre carte.")
                    end
                else
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour stop l'echelle")
                    if IsControlJustPressed(0, 38) then 
                        DetachEntity(echelleprops)
                        if DoesEntityExist(echelleprops) then 
                            DeleteEntity(echelleprops) 
                        end 
                        if DoesEntityExist(Gvehicle) then 
                            DeleteEntity(Gvehicle)
                        end
                        missionstarted = false
                        echelleprops = false
                    end
                end
            end
        else
            if not missionstarted then
                Wait(2000)
            end
        end

        if missionstarted then 
            if SelectedPos then
                if echelleplaced then 
                    DrawMarker(2, SelectedPos.x, SelectedPos.y, SelectedPos.z +3.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 150)
                    local distb = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), SelectedPos.x, SelectedPos.y, SelectedPos.z+3.0, true)
                    if distb < 1.3 then 
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour reparer le lampadaire")
                        if IsControlJustPressed(0,38) then
                            -- print("pressed")
                            RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
                            while not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@") do
                                Wait(1)
                            end
                            FreezeEntityPosition(PlayerPedId(), true)
                            TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, 8.0, -1, 49, 0, false, false, false)
                            Wait(5000)
                            FreezeEntityPosition(PlayerPedId(), false)
                            ClearPedTasks(PlayerPedId())
                            for k,v in pairs(AllPoses) do 
                                if v.x == SelectedPos.x and v.y == SelectedPos.y then 
                                    v.done = true
                                end
                            end
                            local trys = 1
                            repeat 
                                local randommm = math.random(1, #AllPoses)
                                SelectedPos = AllPoses[randommm]
                                trys = trys + 1
                                if trys > #AllPoses*2 then 
                                    ESX.ShowNotification("Vous avez fait toutes vos missions.")
                                    missionstarted = false
                                    echelleplaced = false 
                                    if DoesEntityExist(echelleprops) then 
                                        DeleteEntity(echelleprops) 
                                    end
                                    SetEntityAsNoLongerNeeded(Gvehicle)
                                    break
                                end
                            until not SelectedPos.done
                            TriggerServerEvent("echelle:finish", SelectedPos)
                            ESX.ShowNotification("Vous avez réparé le lampadaire.\nDescendez de l'échelle pour continuer la mission.")
                            finishedTakeNow = true
                        end
                    end
                    if finishedTakeNow then 
                        if GetEntityHeightAboveGround(PlayerPedId()) < 1.2 then
                            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour prendre l'echelle")
                            if IsControlJustPressed(0,38) then 
                                FreezeEntityPosition(PlayerPedId(), true)
                                TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 8.0, 8.0, -1, 49, 0, false, false, false)
                                Wait(3500)
                                FreezeEntityPosition(PlayerPedId(), false)
                                ClearPedTasks(PlayerPedId())
                                if DoesEntityExist(echelleprops) then 
                                    DeleteEntity(echelleprops) 
                                    echelleprops = nil
                                end 
                                echelleplaced = false 
                                finishedTakeNow = false
                                SetNewWaypoint(SelectedPos.x, SelectedPos.y)
                                ESX.ShowNotification("Vous avez un nouveau point, votre echelle a été rangée dans votre camion.")
                            end          
                        end
                    end
                else
                    DrawMarker(20, SelectedPos.x, SelectedPos.y, SelectedPos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 1, 0, 150)
                end
                if not DoesEntityExist(Gvehicle) then 
                    ESX.ShowNotification("Mission annulée.\nVous avez perdu votre véhicule.")
                    missionstarted = false
                    echelleplaced = false 
                    if DoesEntityExist(echelleprops) then 
                        DeleteEntity(echelleprops) 
                        echelleprops = nil
                    end
                end
                local distPos = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), SelectedPos.x, SelectedPos.y, SelectedPos.z, false)
                if distPos < 2.9 then 
                    if echelleprops then 
                        if not echelleplaced then
                            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour placer l'echelle")
                            if IsControlJustPressed(0,38) then 
                                DetachEntity(echelleprops)
                                FreezeEntityPosition(echelleprops, true)
                                SetEntityDynamic(echelleprops, true)
                                SetEntityCoords(echelleprops, SelectedPos.x, SelectedPos.y, SelectedPos.z+3.8)
                                SetEntityHeading(echelleprops, SelectedPos.h)
                                echelleplaced = true
                            end
                        end
                    else
                        ESX.ShowHelpNotification("Allez prendre l'échelle à l'arrière de la camionnette.")
                    end
                end
            end

            if not echelleprops then 
                local vehcoords = GetEntityCoords(Gvehicle)
                local trunkpos = GetWorldPositionOfEntityBone(Gvehicle, GetEntityBoneIndexByName(Gvehicle, "taillight_l"))
                local distvehcoords = Vdist2(GetEntityCoords(PlayerPedId()), trunkpos)
                if distvehcoords < 2.0 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour prendre l'echelle")
                    if IsControlJustPressed(0, 38) then
                        RequestModel(GetHashKey("dt1_08_ladder_005"))
                        while not HasModelLoaded(GetHashKey("dt1_08_ladder_005")) do
                            Wait(55)
                        end
                        echelleprops = CreateObject(GetHashKey("dt1_08_ladder_005"), GetEntityCoords(PlayerPedId()), true, false)
                        SetEntityAsMissionEntity(echelleprops, true, true)
                        SetEntityDynamic(echelleprops, true)
                        AttachEntityToEntity(echelleprops, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                    end
                end
            else
                local vehcoords = GetEntityCoords(Gvehicle)
                local trunkpos = GetWorldPositionOfEntityBone(Gvehicle, GetEntityBoneIndexByName(Gvehicle, "taillight_l"))
                local distvehcoords = Vdist2(GetEntityCoords(PlayerPedId()), trunkpos)
                if distvehcoords < 2.0 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ranger l'echelle")
                    if IsControlJustPressed(0, 38) then
                        if DoesEntityExist(echelleprops) then 
                            DeleteEntity(echelleprops)
                        end
                        echelleprops = false
                    end
                end
            end
        end
    end
end)