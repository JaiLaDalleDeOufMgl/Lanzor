

---@author Razzway
---@version 3.0
---@type function Render:myOutfitMenu
function Render:myOutfitMenu()
    RageUIClothes.Line()
    for _,outfit in pairs(CreatorConfig.outfit) do
        RageUIClothes.Button(outfit.label, nil, {}, true, {
            onActive = function() UtilsCreator:OnRenderCam() end,
            onSelected = function()
                UtilsCreator:applySkinSpecific(outfit)
            end
        })
    end
end