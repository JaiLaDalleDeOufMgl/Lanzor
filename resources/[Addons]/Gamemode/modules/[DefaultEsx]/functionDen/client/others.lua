local LoadPoint = {".", "..", "...", ""}
function DEN:LoadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(10)
    end
end

function DEN:LoadPtfx(ptfx)
    while not HasNamedPtfxAssetLoaded(ptfx) do
        RequestNamedPtfxAsset(ptfx)
        Wait(10)
    end
    UseParticleFxAssetNextCall(ptfx)
end



function DEN:loadDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end
function DEN:DrawMissionText(text,time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time and math.ceil(time) or 0, true)
end

function DEN:AddProgressBar(Text, r, g, b, a, Timing)
    if Timing then
        DEN:DeleteProgressBar()
        ActiveProgressBar = true
        Citizen.CreateThread(function()
            local Timing1, Timing2 = 0.0, GetGameTimer() + Timing
            local Point, AddLoadPoint = ""
            while ActiveProgressBar and (Timing1 < 1) do
                Citizen.Wait(0)
                if Timing1 < 1 then
                    Timing1 = 1 - ((Timing2 - GetGameTimer()) / Timing)
                end
                if not AddLoadPoint or GetGameTimer() >= AddLoadPoint then
                    AddLoadPoint = GetGameTimer() + 500
                    Point = LoadPoint[string.len(Point) + 1] or ""
                end
                DrawRect(0.5, 0.940, 0.15, 0.03, 0, 0, 0, 100)
                local y, endroit = 0.15 - 0.0025, 0.03 - 0.005
                local chance = math.max(0, math.min(y, y * Timing1))
                DrawRect((0.5 - y / 2) + chance / 2, 0.940, chance, endroit, r, g, b, a) -- 0,155,255,125
                DrawTextProgress(0.5, 0.940 - 0.0125, 0.3, (Text or "Action en cours") .. Point, 0, 0, false)
            end
            DEN:DeleteProgressBar()
        end)
    end
end
function DEN:DeleteProgressBar() 
    ActiveProgressBar = nil
end

function DEN:PlayerAnim(AnimeDict,AnimName,Time)
end

function DEN:TaskScenarioInplace(scenario,time)
    TaskStartScenarioInPlace(PlayerPedId(),scenario,-1,false);
    Wait(time)
    ClearPedTasks(PlayerPedId())
end
function DEN:Ragdoll(time)
    local rago = true 
    SetTimeout(time, function()
        rago = false
    end)
    CreateThread(function()
        while true do
            if rago then
                SetPedToRagdoll(PlayerPedId(),1000,1000,0,0,0,0)
                ResetPedRagdollTimer(PlayerPedId())
            else
                break
            end
            Wait(1)
        end
    end)

end

function DEN:KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry(TextEntry, ExampleText)
    DisplayOnscreenKeyboard(1, TextEntry, "", "", "", "", "", MaxStringLenght)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
        Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        return result
    end
end

function DEN:CreateObject(model,x,y,z,heading)
    local objectHash = GetHashKey(model)
    
    RequestModel(objectHash)
    while not HasModelLoaded(objectHash) do
        Citizen.Wait(0)
    end
    
    local spawnedObject = CreateObject(objectHash, x, y, z-1 , true, false, true)

    PlaceObjectOnGroundProperly(spawnedObject)
    SetModelAsNoLongerNeeded(objectHash)
    SetEntityHeading(spawnedObject, heading)
end

function DEN:DrawText3D(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
  
    SetTextScale(0.4, 0.4)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()
  
    AddTextComponentString(text)
    DrawText(_x, _y)
end
function DrawTextProgress(Text, Text3, Taille, Text2, Font, Justi, havetext)
    SetTextFont(Font)
    SetTextScale(Taille, Taille)
    SetTextColour(255, 255, 255, 255)
    SetTextJustification(Justi or 1)
    SetTextEntry("STRING")
    if havetext then SetTextWrap(Text, Text + .1) end
    AddTextComponentString(Text2)
    DrawText(Text, Text3)
end
