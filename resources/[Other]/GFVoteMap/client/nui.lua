local isOpen = false

RegisterNUICallback('getVotingInfo', function(data, cb)
    if data then
        --TriggerServerEvent('Piwel_GFZone:Server:VoteForMap', data)
        TriggerServerEvent("Piwel_GFZone:Server:VoteForMap", data)
    end
    cb({})
end)

RegisterNetEvent('Piwel_GFZone:Client:UpdateVotes')
AddEventHandler('Piwel_GFZone:Client:UpdateVotes', function(new_votes)
    SendNUIMessage({action = 'updatevotes', votes = new_votes})
end)

RegisterNetEvent('Piwel_GFZone:Client:OpenVoteMenu')
AddEventHandler('Piwel_GFZone:Client:OpenVoteMenu', function(oldMap)
    SetNuiFocus(true, true)
    SendNUIMessage({action = 'show', excludeId = oldMap})
end)

RegisterNetEvent('Piwel_GFZone:Client:CloseVoteMenu')
AddEventHandler('Piwel_GFZone:Client:CloseVoteMenu', function(oldMap)
    SetNuiFocus(false, false)
    SendNUIMessage({action = 'hide'})
end)

-- Noti
function showNoti(ped)
    ---Returns a floating notification on coords
    ---@param message string
    ---@param coords number
    local function showFloatingNotification(message, coords)
        AddTextEntry('votingNoti', message)
        SetFloatingHelpTextWorldPosition(1, coords)
        SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
        BeginTextCommandDisplayHelp('votingNoti')
        EndTextCommandDisplayHelp(2, false, false, -1)
    end
    if not isOpen then
        CreateThread(function()
            while insidePoly do
                local coords = GetEntityCoords(ped)
                showFloatingNotification(Config.openText, vec3(coords.x, coords.y, coords.z + 1))
                if IsControlJustPressed(0, Config.openKey) then
                    isOpen = true
                    SetNuiFocus(isOpen, isOpen)
                    SendNUIMessage({action = 'show'})
                    break
                end
                Wait(5)
            end
        end)
    end
end

-- RegisterCommand('testnui', function()
--     SetNuiFocus(true, true)
--     SendNUIMessage({action = 'show'})
--     isOpen = true
-- end, false)

---Returns a GTA notification
---@param message string
local function showNotification(message)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(message)
    DrawNotification(0, 1)
end

RegisterNetEvent('ev:showNotification', function(message)
    showNotification(message)
end)