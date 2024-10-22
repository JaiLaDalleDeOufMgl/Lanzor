local function getDoorsStatus(vehicle)
    return GetVehicleDoorLockStatus(vehicle);
end

local function playerIsInVehicle()
    if (IsPedInAnyVehicle(PlayerPedId())) then
        return true
    end
end

local function getVehicleAndPlayer()
    local isInVehicle = false;
    local vehicle;
    local distance;
    if (playerIsInVehicle()) then

        vehicle = GetVehiclePedIsIn(PlayerPedId());
        isInVehicle = true;

    else

        vehicle, distance = API_Vehicles:getClosest(GetEntityCoords(PlayerPedId()));;

        if (distance ~= -1 and distance < 5) then
            isInVehicle = true;
        else
            vehicle = nil;
        end

    end

    return vehicle, isInVehicle;
end

local function keyAnimation(vehicle)
    local plyPed = PlayerPedId();

    API_Streaming:requestAnimDict("anim@mp_player_intmenu@key_fob@", function()
        API_Streaming:Spawn(GetHashKey("p_car_keys_01"), vector3(0.0, 0.0, 0.0), function(object)
            SetEntityCollision(object, false, false);
            AttachEntityToEntity(object, plyPed, GetPedBoneIndex(plyPed, 57005), 0.09, 0.03, -0.02, -76.0, 13.0, 28.0, false, true, true, true, 0, true);

            SetCurrentPedWeapon(plyPed, GetHashKey("WEAPON_UNARMED"), true);
            ClearPedTasks(plyPed);
            TaskTurnPedToFaceEntity(plyPed, vehicle, 500);

            TaskPlayAnim(plyPed, "anim@mp_player_intmenu@key_fob@", "fob_click", 3.0, 3.0, 1000, 16);
            RemoveAnimDict("anim@mp_player_intmenu@key_fob@");
            PlaySoundFromEntity(-1, "Remote_Control_Fob", vehicle, "PI_Menu_Sounds", true, 0);
            Wait(1250);

            DetachEntity(object, false, false);
            DeleteObject(object);
        end);
    end);
end

local function changeLockStatus(vehicle)

    local locked = getDoorsStatus(vehicle);

    if (locked == 1 or locked == 0) then
        SetVehicleDoorsLocked(vehicle, 2)

        TriggerServerEvent('Gamemode:Keys:LockVehicle', GetVehicleNumberPlateText(vehicle))
        PlayVehicleDoorCloseSound(vehicle, 1);
        ESX.ShowNotification("Vous avez "..exports.Tree:serveurConfig().Serveur.color.."verrouiller~s~ votre véhicule");
    elseif (locked == 2) then
        SetVehicleDoorsLocked(vehicle, 1)
        
        TriggerServerEvent('Gamemode:Keys:UnlockVehicle', GetVehicleNumberPlateText(vehicle))

        PlayVehicleDoorOpenSound(vehicle, 0);
        ESX.ShowNotification("Vous avez ~g~déverrouiller~s~ votre véhicule");
    end
end

RegisterNetEvent('Gamemode:Keys:VehiclePlayerKey')
AddEventHandler('Gamemode:Keys:VehiclePlayerKey', function()
    local vehicle, inveh = getVehicleAndPlayer();

    if (vehicle) then
        if (not inveh) then
            keyAnimation(vehicle);
        end
        changeLockStatus(vehicle);
        keyAnimation(vehicle);
    end
end)