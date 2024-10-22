
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local mainPeds = Tree.ContextUI:CreateMenu(1, "Gestion Joueurs")
local mainAnimations = Tree.ContextUI:CreateSubMenu(mainPeds)
local isAdmin = false

CreateThread(function()
    ESX.TriggerServerCallback("tree:context:checkPerm", function(canOpen)
        isAdmin = canOpen
    end)
end)



Tree.ContextUI:IsVisible(mainPeds, function(Entity)
    Tree.ContextUI:Button("ID Model : "..Entity.ID, nil)
    Tree.ContextUI:Button("ID : "..GetPlayerServerId(NetworkGetPlayerIndexFromPed(Entity.ID)), nil)
    Tree.ContextUI:Button("Animations", nil, function(onSelected)
        if (onSelected) then

        end
    end, mainAnimations)
    if isAdmin then 
        Tree.ContextUI:Button("Supprimer", nil, function(onSelected)
            if (onSelected) then
                TriggerServerEvent("tree:context:deletePed", Entity.ID)
            end
        end)
        Tree.ContextUI:Button("Prendre l'apparence", nil, function(onSelected)
            if (onSelected) then
                local model = GetEntityModel(Entity.ID)
                RequestModel(model)
                while not HasModelLoaded(model) do
                    Wait(0)
                end
                SetPlayerModel(PlayerId(), model)
            end
        end)
        Tree.ContextUI:Button("Téléporter sur lui", nil, function(onSelected)
            if (onSelected) then
                local coords = GetEntityCoords(Entity.ID)
                TriggerServerEvent("tree:context:teleport", coords)
            end
        end)
        Tree.ContextUI:Button("Téléporter à moi", nil, function(onSelected)
            if (onSelected) then
                local player = GetPlayerServerId(NetworkGetPlayerIndexFromPed(Entity.ID))
                local coords = GetEntityCoords(PlayerPedId())
                TriggerServerEvent("tree:context:bring", coords, player)
            end
        end)
        Tree.ContextUI:Button("Freeze", nil, function(onSelected)
            if (onSelected) then
                local player = GetPlayerServerId(NetworkGetPlayerIndexFromPed(Entity.ID))
                TriggerServerEvent("tree:context:freezePlayer", player)
            end
        end)
    end
end)


Tree.ContextUI:IsVisible(mainAnimations, function(Entity)
    Tree.ContextUI:Button("Donner une claque", nil, function(onSelected)
        if (onSelected) then
            local PlayerPedId = PlayerPedId()
            local coords = GetEntityCoords(PlayerPedId)
            local forward = GetEntityForwardVector(PlayerPedId)
            local x, y, z = table.unpack(coords + forward * 1.0)
            TaskGoStraightToCoord(PlayerPedId, x, y, z, 1.0, -1, GetEntityHeading(PlayerPedId), 0.0)
            Wait(1000)
            TaskPlayAnim(PlayerPedId, "melee@unarmed@streamed_variations", "plyr_takedown_front_slap", 8.0, 8.0, -1, 0, 0, 0, 0, 0)
            Wait(1000)
            ClearPedTasks(PlayerPedId)
        end
    end)
    Tree.ContextUI:Button("Serrer la main", nil, function(onSelected)
        if (onSelected) then
            local PlayerPedId = PlayerPedId()
            local coords = GetEntityCoords(PlayerPedId)
            local forward = GetEntityForwardVector(PlayerPedId)
            local x, y, z = table.unpack(coords + forward * 1.0)
            TaskGoStraightToCoord(PlayerPedId, x, y, z, 1.0, -1, GetEntityHeading(PlayerPedId), 0.0)
            Wait(1000)
            TaskPlayAnim(PlayerPedId, "mp_common", "givetake1_a", 8.0, 8.0, -1, 0, 0, 0, 0, 0)
            Wait(1000)
            ClearPedTasks(PlayerPedId)
        end
    end)
end)


Keys.Register("LMENU", "LMENU", "Enable / disable focus mode.", function()
    Tree.ContextUI.Focus = not Tree.ContextUI.Focus;
end)
