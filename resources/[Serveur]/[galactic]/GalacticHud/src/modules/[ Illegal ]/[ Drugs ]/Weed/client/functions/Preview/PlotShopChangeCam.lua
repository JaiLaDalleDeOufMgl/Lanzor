local CamActive

function MOD_Weed:PlotShopChangeCam(plotId, size)
    DoScreenFadeOut(250)
    Wait(250)

    MOD_Weed:DeleteObjectPreview()

    local PlotList = Gamemode.enums.Labos.Types['weed']['plotManagement'].PlotList[size]
    local PlotCamCoords = PlotList[plotId].camera

    if (CamActive) then
        SetCamCoord(CamActive, vector3(PlotCamCoords.coords.x, PlotCamCoords.coords.y, PlotCamCoords.coords.z))
        SetCamRot(CamActive, PlotCamCoords.rotate, 0.0, PlotCamCoords.coords.w)
    else
        CamActive = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", PlotCamCoords.coords.x, PlotCamCoords.coords.y, PlotCamCoords.coords.z, PlotCamCoords.rotate, 0.0, PlotCamCoords.coords.w, 90.0, false, 0)
        SetCamActive(CamActive, true)
        RenderScriptCams(true, false, 1000, false, false)
    end

    DoScreenFadeIn(250)
    
    MOD_Weed:PlotPlaceSetupPreview(plotId)
end

function MOD_Weed:PlotShopDeleteCam()
    CamActive = false
    RenderScriptCams(false, false, 1, true, true)
    MOD_Weed:DeleteObjectPreview()
end