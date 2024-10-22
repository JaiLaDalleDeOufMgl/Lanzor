Admin = {}
Admin.Cam = nil 
Admin.CamTarget = {}
local pPos = nil

-- Stop spectate
function Admin:ExitSpectate()
    PlayerInSpec = false

    local pPed = PlayerPedId()
    SetEntityVisible(pPed, true, true)
    SetEntityInvincible(pPed, false)
    SetEntityCollision(pPed, true, true)

    -- if DoesEntityExist(Admin.CamTarget.PedHandle) then
    --     SetCamCoord(Admin.Cam, GetEntityCoords(Admin.CamTarget.PedHandle))
    -- end
    NetworkSetInSpectatorMode(0, pPed)
    --SetCamActive(Admin.Cam, true)
    --RenderScriptCams(true, false, 0, true, true)
    RenderScriptCams(false, false, 0, false, false)
    Admin:DestroyCam()
    Admin.CamTarget = {}
    Wait(1000)
    FreezeEntityPosition(pPed, false)
    Wait(500)
    SetEntityCoords(pPed, pPos)
    pPos = nil
end

-- Start spectate
function Admin:StartSpectate(player)
    PlayerInSpec = true
    RageUI.CloseAll()
    local pPed = PlayerPedId()
    TriggerServerEvent('sAdmin:Spectate', player.id)
    SetEntityVisible(pPed, false, false)
    SetEntityInvincible(pPed, true)
    SetEntityCollision(pPed, false, false)
    FreezeEntityPosition(pPed, true)
    pPos = GetEntityCoords(pPed)
    Admin.CamTarget = player
    Admin.CamTarget.PedHandle = player.ped
    if not DoesEntityExist(Admin.CamTarget.PedHandle) then
        ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color.."Vous etes trop loin de la cible.")
        return
    end
    NetworkSetInSpectatorMode(1, Admin.CamTarget.PedHandle)
    SetCamActive(Admin.Cam, false)
    RenderScriptCams(false, false, 0, false, false)
    ClearFocus()
end



-- Create Cam
function Admin:CreateCam()
    Admin.Cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamActive(Admin.Cam, true)
    RenderScriptCams(true, false, 0, true, true)
end

-- Destroy Cam
function Admin:DestroyCam()
    DestroyCam(Admin.Cam)
    RenderScriptCams(false, false, 0, false, false)
    ClearFocus()
    if NetworkIsInSpectatorMode() then
        NetworkSetInSpectatorMode(false, Admin.CamTarget.id and GetPlayerPed(Admin.CamTarget.id) or 0)
    end
    Admin.Cam = nil
    Admin.CamTarget = {}
end

function GetSpecateBoolStaff()
    return PlayerInSpec
end