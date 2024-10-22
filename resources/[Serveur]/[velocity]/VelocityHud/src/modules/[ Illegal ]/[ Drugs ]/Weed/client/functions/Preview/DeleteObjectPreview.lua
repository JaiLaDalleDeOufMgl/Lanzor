function MOD_Weed:DeleteObjectPreview()
    for _, obj in pairs(MOD_Weed.LabData.ObjectPreview) do
        DeleteObject(obj)
    end
end