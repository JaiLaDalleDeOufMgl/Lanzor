AddEventHandler('spawnprops', function()
    local Object = sAdmin.KeyboardInput('Modele du props', 'Modele du props', '', 100)

    local Player = PlayerPedId()
    local Coords = GetEntityCoords(Player)
    local Heading = GetEntityHeading(Player)

    RequestModel(Object)
    while not HasModelLoaded(Object) do
        Wait(0)
    end

    local OffsetCoords = GetOffsetFromEntityInWorldCoords(Player, 0.0, 0.75, 0.0)
    local Prop = CreateObjectNoOffset(Object, OffsetCoords, false, true, false)
    SetEntityHeading(Prop, Heading)
    SetEntityCollision(Prop, false, true)
    SetEntityAlpha(Prop, 100)
    FreezeEntityPosition(Prop, true)
    SetModelAsNoLongerNeeded(Object)

    CreateThread(function()
        while true do
            Wait(0)

            local PropsWorld = {
                Object = Object,
                OffsetCoords = GetOffsetFromEntityInWorldCoords(Player, 0.0, 0.75, 0.0),
                Heading = GetEntityHeading(Player)
            }

            local retval, groundZ, normal = GetGroundZAndNormalFor_3dCoord(PropsWorld.OffsetCoords.x, PropsWorld.OffsetCoords.y, PropsWorld.OffsetCoords.z)
            PropsWorld.OffsetCoords = vector3(PropsWorld.OffsetCoords.x, PropsWorld.OffsetCoords.y,groundZ)

            ESX.ShowHelpNotification('Appuiyez sur E pour posser votre props')
            
			SetEntityCoordsNoOffset(Prop, PropsWorld.OffsetCoords)
			SetEntityHeading(Prop, PropsWorld.Heading)
            SetEntityCollision(Prop, false, true)

            SetEntityDrawOutline(Prop, true)
            SetEntityDrawOutlineColor(255,0,0,255)
            
            if (IsControlJustPressed(0, 38)) then
                local NetId = NetworkGetNetworkIdFromEntity(Prop)
                TriggerServerEvent('Gamemode:Props:AddProps', NetId)

                FreezeEntityPosition(Prop, true)
                SetEntityInvincible(Prop, true)
                ResetEntityAlpha(Prop)
                SetEntityDrawOutline(Prop, false)
                SetEntityCollision(Prop, true, true)

                break
            end

            if (IsControlJustPressed(0, 140)) then 
                DeleteObject(Prop)

                break
            end
        end
    end)
end)

AddEventHandler('RemoveProps', function(netId)
    CreateThread(function()
        SetNetworkIdCanMigrate(netId, true)

        local entity = NetworkGetNetworkIdFromEntity(netId)
        
        local Time = 0
        while (Time > 100 and not NetworkRequestControlOfEntity(entity)) do
            NetworkRequestControlOfEntity(entity)
            Wait(1)
            Time += 1
        end

        SetEntityAsNoLongerNeeded(entity)

        local Time = 0
        while (Time < 100 and DoesEntityExist(entity)) do
            SetEntityAsNoLongerNeeded(entity)
            DeleteEntity(entity)
            DeleteObject(entity)

            if not DoesEntityExist(entity) then
                TriggerServerEvent('Gamemode:Props:RemoveAProps', netId)
            end

            SetEntityCoords(entity, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0)

            Wait(1)
            Time += 1
        end
    end)
end)