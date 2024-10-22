
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)
local mainGestionVehicule = Tree.ContextUI:CreateMenu(2, "Gestion Véhicule")
local mainMenuPortes = Tree.ContextUI:CreateSubMenu(mainGestionVehicule)
local isAdmin = false

CreateThread(function()
    ESX.TriggerServerCallback("tree:context:checkPerm", function(canOpen)
        isAdmin = canOpen
    end)
end)



Tree.ContextUI:IsVisible(mainGestionVehicule, function(Entity)


    if (not DoesEntityExist(Entity.ID)) then
        Tree.ContextUI.Focus = false
        return
    end

    Tree.ContextUI:Button("Nom : "..GetDisplayNameFromVehicleModel(Entity.Model), nil)
    Tree.ContextUI:Button("ID : "..Entity.ID, nil)
    Tree.ContextUI:Button("Plaque : "..GetVehicleNumberPlateText(Entity.ID), nil)
    Tree.ContextUI:Button("Véhicule fermé : "..(GetVehicleDoorLockStatus(Entity.ID) == 2 and "Oui" or "Non"), nil)
    Tree.ContextUI:Button("Véhicule démarré : "..(GetIsVehicleEngineRunning(Entity.ID) and "Oui" or "Non"), nil)
    Tree.ContextUI:Button("Portes", nil, function(onSelected)
        if (onSelected) then

        end
    end, mainMenuPortes)
    if isAdmin then 
        Tree.ContextUI:Button("Supprimer", nil, function(onSelected)
            if (onSelected) then
                TriggerServerEvent("tree:context:deleteVehicle", Entity.NetID)
            end
        end)

        Tree.ContextUI:Button("Réparer", nil, function(onSelected)
            if (onSelected) then
                SetVehicleFixed(Entity.ID)
                SetVehicleDeformationFixed(Entity.ID)
            end
        end)

        Tree.ContextUI:Button("Nettoyer", nil, function(onSelected)
            if (onSelected) then
                SetVehicleDirtLevel(Entity.ID, 0)
            end
        end)
        Tree.ContextUI:Button("Custom", nil, function(onSelected)
            if (onSelected) then
                ESX.Game.SetVehicleProperties(Entity.ID, {
                    modEngine = 4,
                    modBrakes = 4,
                    modTransmission = 4,
                    modSuspension = 4,
                    modTurbo = true,
                    modArmor = 4,
                    modXenon = true,
                    modFrontWheels = 0,
                    modBackWheels = 0,
                    modPlateHolder = 1,
                    modVanityPlate = 1,
                    modTrimA = 0,
                    modOrnaments = 0,
                    modDashboard = 0,
                    modDial = 0,
                    modDoorSpeaker = 0,
                    modSeats = 0,
                    modSteeringWheel = 0,
                    modShifterLeavers = 0,
                    modAPlate = 0,
                    modSpeakers = 0,
                    modTrunk = 0,
                    modHydrolic = 0,
                    modEngineBlock = 0,
                    modAirFilter = 0,
                    modStruts = 0,
                    modArchCover = 0,
                    modAerials = 0,
                    modTrimB = 0,
                    modTank = 0,
                    modWindows = 0,
                    modLivery = 0,
                })
            end
        end)

        Tree.ContextUI:Button("Freeze", nil, function(onSelected)
            if (onSelected) then
                TriggerServerEvent("tree:context:freezeVehicle", Entity.NetID)
            end
        end)
        Tree.ContextUI:Button("Retourner à 180°", nil, function(onSelected)
            if (onSelected) then
                SetEntityHeading(Entity.ID, GetEntityHeading(Entity.ID) + 180.0)
            end
        end)
    end
end)

Tree.ContextUI:IsVisible(mainMenuPortes, function(Entity)

    Tree.ContextUI:Button("Avant Gauche", nil, function(onSelected)
        if (onSelected) then
            if (GetVehicleDoorAngleRatio(Entity.ID, 0) == 0) then
                SetVehicleDoorOpen(Entity.ID, 0, false, false)
            else
                SetVehicleDoorShut(Entity.ID, 0, false)
            end
        end
    end)

    Tree.ContextUI:Button("Avant Droite", nil, function(onSelected)
        if (onSelected) then
            if (GetVehicleDoorAngleRatio(Entity.ID, 1) == 0) then
                SetVehicleDoorOpen(Entity.ID, 1, false, false)
            else
                SetVehicleDoorShut(Entity.ID, 1, false)
            end
        end
    end)

    Tree.ContextUI:Button("Arrière Gauche", nil, function(onSelected)
        if (onSelected) then
            if (GetVehicleDoorAngleRatio(Entity.ID, 2) == 0) then
                SetVehicleDoorOpen(Entity.ID, 2, false, false)
            else
                SetVehicleDoorShut(Entity.ID, 2, false)
            end
        end
    end)

    Tree.ContextUI:Button("Arrière Droite", nil, function(onSelected)
        if (onSelected) then
            if (GetVehicleDoorAngleRatio(Entity.ID, 3) == 0) then
                SetVehicleDoorOpen(Entity.ID, 3, false, false)
            else
                SetVehicleDoorShut(Entity.ID, 3, false)
            end
        end
    end)

    Tree.ContextUI:Button("Capot", nil, function(onSelected)
        if (onSelected) then
            if (GetVehicleDoorAngleRatio(Entity.ID, 4) == 0) then
                SetVehicleDoorOpen(Entity.ID, 4, false, false)
            else
                SetVehicleDoorShut(Entity.ID, 4, false)
            end
        end
    end)

    Tree.ContextUI:Button("Coffre", nil, function(onSelected)
        if (onSelected) then
            if (GetVehicleDoorAngleRatio(Entity.ID, 5) == 0) then
                SetVehicleDoorOpen(Entity.ID, 5, false, false)
            else
                SetVehicleDoorShut(Entity.ID, 5, false)
            end
        end 
    end)

end)

Keys.Register("LMENU", "LMENU", "Enable / disable focus mode.", function()
    Tree.ContextUI.Focus = not Tree.ContextUI.Focus;
end)
