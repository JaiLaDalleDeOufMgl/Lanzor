Tree.Skinchanger = {}
Tree.Skinchanger.Components = {
    {name = 'sex',				value = 0},
	{name = 'face',				value = 0},
	{name = 'skin',				value = 0},
	{name = 'hair_1',			value = 0},
	{name = 'hair_2',			value = 0},
	{name = 'hair_color_1',		value = 0},
	{name = 'hair_color_2',		value = 0},
	{name = 'tshirt_1',			value = 0},
	{name = 'tshirt_2',			value = 0},
	{name = 'torso_1',			value = 0},
	{name = 'torso_2',			value = 0},
	{name = 'decals_1',			value = 0},
	{name = 'decals_2',			value = 0},
	{name = 'arms',				value = 0},
	{name = 'arms_2',			value = 0},
	{name = 'pants_1',			value = 0},
	{name = 'pants_2',			value = 0},
	{name = 'shoes_1',			value = 0},
	{name = 'shoes_2',			value = 0},
	{name = 'mask_1',			value = 0},
	{name = 'mask_2',			value = 0},
	{name = 'bproof_1',			value = 0},
	{name = 'bproof_2',			value = 0},
	{name = 'chain_1',			value = 0},
	{name = 'chain_2',			value = 0},
	{name = 'helmet_1',			value = -1},
	{name = 'helmet_2',			value = 0},
	{name = 'glasses_1',		value = 0},
	{name = 'glasses_2',		value = 0},
	{name = 'watches_1',		value = -1},
	{name = 'watches_2',		value = 0},
	{name = 'bracelets_1',		value = -1},
	{name = 'bracelets_2',		value = 0},
	{name = 'bags_1',			value = 0},
	{name = 'bags_2',			value = 0},
	{name = 'eye_color',		value = 0},
	{name = 'eyebrows_2',		value = 0},
	{name = 'eyebrows_1',		value = 0},
	{name = 'eyebrows_3',		value = 0},
	{name = 'eyebrows_4',		value = 0},
	{name = 'makeup_1',			value = 0},
	{name = 'makeup_2',			value = 0},
	{name = 'makeup_3',			value = 0},
	{name = 'makeup_4',			value = 0},
	{name = 'lipstick_1',		value = 0},
	{name = 'lipstick_2',		value = 0},
	{name = 'lipstick_3',		value = 0},
	{name = 'lipstick_4',		value = 0},
	{name = 'ears_1',			value = -1},
	{name = 'ears_2',			value = 0},
	{name = 'chest_1',			value = 0},
	{name = 'chest_2',			value = 0},
	{name = 'chest_3',			value = 0},
	{name = 'bodyb_1',			value = 0},
	{name = 'bodyb_2',			value = 0},
	{name = 'age_1',			value = 0},
	{name = 'age_2',			value = 0},
	{name = 'blemishes_1',		value = 0},
	{name = 'blemishes_2',		value = 0},
	{name = 'blush_1',			value = 0},
	{name = 'blush_2',			value = 0},
	{name = 'blush_3',			value = 0},
	{name = 'complexion_1',		value = 0},
	{name = 'complexion_2',		value = 0},
	{name = 'sun_1',			value = 0},
	{name = 'sun_2',			value = 0},
	{name = 'moles_1',			value = 0},
	{name = 'moles_2',			value = 0},
	{name = 'beard_1',			value = 0},
	{name = 'beard_2',			value = 0},
	{name = 'beard_3',			value = 0},
	{name = 'beard_4',			value = 0},
	{name = 'mom',				value = 0.0},
	{name = 'dad',				value = 0.0},
	{name = 'nose_1',			value = 0.0},
	{name = 'nose_2',			value = 0.0},
	{name = 'nose_3',			value = 0.0},
	{name = 'nose_4',			value = 0.0},
	{name = 'nose_5',			value = 0.0},
	{name = 'nose_6',			value = 0.0},
	{name = 'eyebrows_5',		value = 0.0},
	{name = 'eyebrows_6',		value = 0.0},
	{name = 'cheeks_1',			value = 0.0},
	{name = 'cheeks_2',			value = 0.0},
	{name = 'cheeks_3',			value = 0.0},
	{name = 'eye_open',			value = 0.0},
	{name = 'lips_thick',		value = 0.0},
	{name = 'jaw_1',			value = 0.0},
	{name = 'jaw_2',			value = 0.0},
	{name = 'chin_height',		value = 0.0},
	{name = 'chin_lenght',		value = 0.0},
	{name = 'chin_width',		value = 0.0},
	{name = 'chin_hole',		value = 0.0},
	{name = 'neck_thick',		value = 0.0},
}
Tree.Skinchanger.Characters = {}
Tree.Skinchanger.loadSkin = nil
Tree.Skinchanger.loadClothes = nil
Tree.Skinchanger.lastSex = nil



CreateThread(function ()
    for i=1, #Tree.Skinchanger.Components, 1 do
        Tree.Skinchanger.Components[Tree.Skinchanger.Components[i].name] = Tree.Skinchanger.Components[i].value
    end
end)

function Tree.Skinchanger.LoadModel(isMale, cb)
    local character 
    if isMale then
        character = "mp_m_freemode_01"
    else
        character = "mp_f_freemode_01"
    end

    RequestModel(GetHashKey(character))
    CreateThread(function ()
        while not HasModelLoaded(characterModel) do RequestModel(GetHashKey(character)) Wait(1) end

        if IsModelInCdimage(character) and IsModelValid(character) then
            SetPlayerModel(PlayerId(), character)
            SetPedDefaultComponentVariation(PlayerPedId())
        end

        SetModelAsNoLongerNeeded(character)
        if cb ~= nil then
            cb()
        end
        TriggerEvent('Tree:Skinchanger:modelLoaded')
    end)
end

function Tree.Skinchanger.ApplySkin(skin, clothes)
    local playerPed = PlayerPedId()
    for k,v in pairs(skin) do
        Tree.Skinchanger.Characters[k] = v
    end
    if clothes ~= nil then

		for k,v in pairs(clothes) do
			if
                k ~= 'sex'				and
                k ~= 'mom'				and
                k ~= 'dad'				and
                k ~= 'age_1'			and
                k ~= 'age_2'			and
                k ~= 'eye_color'		and
                k ~= 'beard_1'			and
                k ~= 'beard_2'			and
                k ~= 'beard_3'			and
                k ~= 'beard_4'			and
                k ~= 'hair_1'			and
                k ~= 'hair_2'			and
                k ~= 'hair_color_1'		and
                k ~= 'hair_color_2'		and
                k ~= 'eyebrows_1'		and
                k ~= 'eyebrows_2'		and
                k ~= 'eyebrows_3'		and
                k ~= 'eyebrows_4'		and
                k ~= 'makeup_1'			and
                k ~= 'makeup_2'			and
                k ~= 'makeup_3'			and
                k ~= 'makeup_4'			and
                k ~= 'lipstick_1'		and
                k ~= 'lipstick_2'		and
                k ~= 'lipstick_3'		and
                k ~= 'lipstick_4'		and
                k ~= 'blemishes_1'		and
                k ~= 'blemishes_2'		and
                k ~= 'blush_1'			and
                k ~= 'blush_2'			and
                k ~= 'blush_3'			and
                k ~= 'complexion_1'		and
                k ~= 'complexion_2'		and
                k ~= 'sun_1'			and
                k ~= 'sun_2'			and
                k ~= 'moles_1'			and
                k ~= 'moles_2'			and
                k ~= 'chest_1'			and
                k ~= 'chest_2'			and
                k ~= 'chest_3'			and
                k ~= 'bodyb_1'			and
                k ~= 'bodyb_2'			and
                k ~= 'nose_1'			and
                k ~= 'nose_2'			and
                k ~= 'nose_3'			and
                k ~= 'nose_4'			and
                k ~= 'nose_5'			and
                k ~= 'nose_6'			and
                k ~= 'eyebrows_5'		and
                k ~= 'eyebrows_6'		and
                k ~= 'cheeks_3'			and
                k ~= 'cheeks_2'			and
                k ~= 'cheeks_1'			and
                k ~= 'eye_open'			and
                k ~= 'lips_thick'		and
                k ~= 'jaw_1'			and
                k ~= 'jaw_2'			and
                k ~= 'chin_height'		and
                k ~= 'chin_width'		and
                k ~= 'chin_hole'		and
                k ~= 'face_ped'		and
                k ~= 'mask_ped'		and
                k ~= 'neck_thick'			
		    then
			    Tree.Skinchanger.Tree.Skinchanger.Characters[k] = v
            end
		end
	end
    	SetPedHeadBlendData(playerPed, Tree.Skinchanger.Characters['dad'], Tree.Skinchanger.Characters['mom'], nil, 0, 0, nil, Tree.Skinchanger.Characters['face'], false, nil, true)
        local face_weight = (Tree.Skinchanger.Characters['face_md_weight'] / 100) + 0.0
        local skin_weight = (Tree.Skinchanger.Characters['skin_md_weight'] / 100) + 0.0
        SetPedHeadBlendData(playerPed, Tree.Skinchanger.Characters['mom'], Tree.Skinchanger.Characters['dad'], 0, Tree.Skinchanger.Characters['mom'], Tree.Skinchanger.Characters['dad'], 0,
            face_weight, skin_weight, 0.0, false)
        SetPedFaceFeature			(playerPed,			0,								(Tree.Skinchanger.Characters['nose_1'] / 10) + 0.0)			-- Nose Width
        SetPedFaceFeature			(playerPed,			1,								(Tree.Skinchanger.Characters['nose_2'] / 10) + 0.0)			-- Nose Peak Height
        SetPedFaceFeature			(playerPed,			2,								(Tree.Skinchanger.Characters['nose_3'] / 10) + 0.0)			-- Nose Peak Length
        SetPedFaceFeature			(playerPed,			3,								(Tree.Skinchanger.Characters['nose_4'] / 10) + 0.0)			-- Nose Bone Height
        SetPedFaceFeature			(playerPed,			4,								(Tree.Skinchanger.Characters['nose_5'] / 10) + 0.0)			-- Nose Peak Lowering
        SetPedFaceFeature			(playerPed,			5,								(Tree.Skinchanger.Characters['nose_6'] / 10) + 0.0)			-- Nose Bone Twist
        SetPedFaceFeature			(playerPed,			6,								(Tree.Skinchanger.Characters['eyebrows_5'] / 10) + 0.0)		-- Eyebrow height
        SetPedFaceFeature			(playerPed,			7,								(Tree.Skinchanger.Characters['eyebrows_6'] / 10) + 0.0)		-- Eyebrow depth
        SetPedFaceFeature			(playerPed,			9,								(Tree.Skinchanger.Characters['cheeks_1'] / 10) + 0.0)			-- Cheekbones Height
        SetPedFaceFeature			(playerPed,			8,								(Tree.Skinchanger.Characters['cheeks_2'] / 10) + 0.0)			-- Cheekbones Width
        SetPedFaceFeature			(playerPed,			10,								(Tree.Skinchanger.Characters['cheeks_3'] / 10) + 0.0)			-- Cheeks Width
    
        SetPedFaceFeature			(playerPed,			11,								(Tree.Skinchanger.Characters['eye_open'] / 10) + 0.0)		-- Eyes squint
        SetPedFaceFeature			(playerPed,			12,								(Tree.Skinchanger.Characters['lips_thick'] / 10) + 0.0)	-- Lip Fullness
        SetPedFaceFeature			(playerPed,			13,								(Tree.Skinchanger.Characters['jaw_1'] / 10) + 0.0)			-- Jaw Bone Width
        SetPedFaceFeature			(playerPed,			14,								(Tree.Skinchanger.Characters['jaw_2'] / 10) + 0.0)			-- Jaw Bone Length
        SetPedFaceFeature			(playerPed,			15,								(Tree.Skinchanger.Characters['chin_height'] / 10) + 0.0)			-- Chin Height
        SetPedFaceFeature			(playerPed,			16,								(Tree.Skinchanger.Characters['chin_lenght'] / 10) + 0.0)			-- Chin Length
        SetPedFaceFeature			(playerPed,			17,								(Tree.Skinchanger.Characters['chin_width'] / 10) + 0.0)			-- Chin Width
        SetPedFaceFeature			(playerPed,			18,								(Tree.Skinchanger.Characters['chin_hole'] / 10) + 0.0)			-- Chin Hole Size
        SetPedFaceFeature			(playerPed,			19,								(Tree.Skinchanger.Characters['neck_thick'] / 10) + 0.0)	-- Neck Thickness
    
        SetPedHairColor				(playerPed,			Tree.Skinchanger.Characters['hair_color_1'],		Tree.Skinchanger.Characters['hair_color_2'])					-- Hair Color
        SetPedHeadOverlay			(playerPed, 3,		Tree.Skinchanger.Characters['age_1'],				(Tree.Skinchanger.Characters['age_2'] / 10) + 0.0)			-- Age + opacity
        SetPedHeadOverlay			(playerPed, 1,		Tree.Skinchanger.Characters['beard_1'],			(Tree.Skinchanger.Characters['beard_2'] / 10) + 0.0)			-- Beard + opacity
        SetPedEyeColor				(playerPed,			Tree.Skinchanger.Characters['eye_color'], 0, 1)												-- Eyes color
        SetPedHeadOverlay			(playerPed, 2,		Tree.Skinchanger.Characters['eyebrows_1'],		(Tree.Skinchanger.Characters['eyebrows_2'] / 10) + 0.0)		-- Eyebrows + opacity
        SetPedHeadOverlay			(playerPed, 4,		Tree.Skinchanger.Characters['makeup_1'],			(Tree.Skinchanger.Characters['makeup_2'] / 10) + 0.0)			-- Makeup + opacity
        SetPedHeadOverlay			(playerPed, 8,		Tree.Skinchanger.Characters['lipstick_1'],		(Tree.Skinchanger.Characters['lipstick_2'] / 10) + 0.0)		-- Lipstick + opacity
        SetPedComponentVariation	(playerPed, 2,		Tree.Skinchanger.Characters['hair_1'],			Tree.Skinchanger.Characters['hair_2'], 2)						-- Hair
        SetPedComponentVariation	(playerPed, 0,		Tree.Skinchanger.Characters['face_ped'],			Tree.Skinchanger.Characters['face_ped2'], 2)						-- PEd
        SetPedComponentVariation	(playerPed, 1,		Tree.Skinchanger.Characters['mask_ped'],			Tree.Skinchanger.Characters['mask_ped'], 2)						-- PEd
        SetPedHeadOverlayColor		(playerPed, 1, 1,	Tree.Skinchanger.Characters['beard_3'],			Tree.Skinchanger.Characters['beard_4'])						-- Beard Color
        SetPedHeadOverlayColor		(playerPed, 2, 1,	Tree.Skinchanger.Characters['eyebrows_3'],		Tree.Skinchanger.Characters['eyebrows_4'])					-- Eyebrows Color
        SetPedHeadOverlayColor		(playerPed, 4, 1,	Tree.Skinchanger.Characters['makeup_3'],			Tree.Skinchanger.Characters['makeup_4'])						-- Makeup Color
        SetPedHeadOverlayColor		(playerPed, 8, 1,	Tree.Skinchanger.Characters['lipstick_3'],		Tree.Skinchanger.Characters['lipstick_4'])					-- Lipstick Color
        SetPedHeadOverlay			(playerPed, 5,		Tree.Skinchanger.Characters['blush_1'],			(Tree.Skinchanger.Characters['blush_2'] / 10) + 0.0)			-- Blush + opacity
        SetPedHeadOverlayColor		(playerPed, 5, 2,	Tree.Skinchanger.Characters['blush_3'])														-- Blush Color
        SetPedHeadOverlay			(playerPed, 6,		Tree.Skinchanger.Characters['complexion_1'],		(Tree.Skinchanger.Characters['complexion_2'] / 10) + 0.0)		-- Complexion + opacity
        SetPedHeadOverlay			(playerPed, 7,		Tree.Skinchanger.Characters['sun_1'],				(Tree.Skinchanger.Characters['sun_2'] / 10) + 0.0)			-- Sun Damage + opacity
        SetPedHeadOverlay			(playerPed, 9,		Tree.Skinchanger.Characters['moles_1'],			(Tree.Skinchanger.Characters['moles_2'] / 10) + 0.0)			-- Moles/Freckles + opacity
        SetPedHeadOverlay			(playerPed, 0,		Tree.Skinchanger.Characters['blemishes_1'],		(Tree.Skinchanger.Characters['blemishes_2'] / 10) + 0.0)		-- Blemishes + opacity
        SetPedHeadOverlay			(playerPed, 10,		Tree.Skinchanger.Characters['chest_1'],			(Tree.Skinchanger.Characters['chest_2'] / 10) + 0.0)			-- Chest Hair + opacity
        SetPedHeadOverlayColor		(playerPed, 10, 1,	Tree.Skinchanger.Characters['chest_3'])														-- Torso Color
        SetPedHeadOverlay			(playerPed, 11,		Tree.Skinchanger.Characters['bodyb_1'],			(Tree.Skinchanger.Characters['bodyb_2'] / 10) + 0.0)			-- Body Blemishes + opacity
    
        if Tree.Skinchanger.Characters['ears_1'] == -1 then
            ClearPedProp(playerPed, 2)
        else
            SetPedPropIndex			(playerPed, 2,		Tree.Skinchanger.Characters['ears_1'],			Tree.Skinchanger.Characters['ears_2'], 2)						-- Ears Accessories
        end
    
        SetPedComponentVariation	(playerPed, 8,		Tree.Skinchanger.Characters['tshirt_1'],			Tree.Skinchanger.Characters['tshirt_2'], 2)					-- Tshirt
        SetPedComponentVariation	(playerPed, 11,		Tree.Skinchanger.Characters['torso_1'],			Tree.Skinchanger.Characters['torso_2'], 2)					-- torso parts
        SetPedComponentVariation	(playerPed, 3,		Tree.Skinchanger.Characters['arms'],				Tree.Skinchanger.Characters['arms_2'], 2)						-- Amrs
        SetPedComponentVariation	(playerPed, 10,		Tree.Skinchanger.Characters['decals_1'],			Tree.Skinchanger.Characters['decals_2'], 2)					-- decals
        SetPedComponentVariation	(playerPed, 4,		Tree.Skinchanger.Characters['pants_1'],			Tree.Skinchanger.Characters['pants_2'], 2)					-- pants
        SetPedComponentVariation	(playerPed, 6,		Tree.Skinchanger.Characters['shoes_1'],			Tree.Skinchanger.Characters['shoes_2'], 2)					-- shoes
        SetPedComponentVariation	(playerPed, 1,		Tree.Skinchanger.Characters['mask_1'],			Tree.Skinchanger.Characters['mask_2'], 2)						-- mask
        SetPedComponentVariation	(playerPed, 9,		Tree.Skinchanger.Characters['bproof_1'],			Tree.Skinchanger.Characters['bproof_2'], 2)					-- bulletproof
        SetPedComponentVariation	(playerPed, 7,		Tree.Skinchanger.Characters['chain_1'],			Tree.Skinchanger.Characters['chain_2'], 2)					-- chain
        SetPedComponentVariation	(playerPed, 5,		Tree.Skinchanger.Characters['bags_1'],			Tree.Skinchanger.Characters['bags_2'], 2)						-- Bag
    
        if Tree.Skinchanger.Characters['helmet_1'] == -1 then
            ClearPedProp(playerPed, 0)
        else
            SetPedPropIndex			(playerPed, 0,		Tree.Skinchanger.Characters['helmet_1'],			Tree.Skinchanger.Characters['helmet_2'], 2)					-- Helmet
        end
    
        if Tree.Skinchanger.Characters['glasses_1'] == -1 then
            ClearPedProp(playerPed, 1)
        else
            SetPedPropIndex			(playerPed, 1,		Tree.Skinchanger.Characters['glasses_1'],			Tree.Skinchanger.Characters['glasses_2'], 2)					-- Glasses
        end
    
        if Tree.Skinchanger.Characters['watches_1'] == -1 then
            ClearPedProp(playerPed, 6)
        else
            SetPedPropIndex			(playerPed, 6,		Tree.Skinchanger.Characters['watches_1'],			Tree.Skinchanger.Characters['watches_2'], 2)					-- Watches
        end
    
        if Tree.Skinchanger.Characters['bracelets_1'] == -1 then
            ClearPedProp(playerPed,	7)
        else
            SetPedPropIndex			(playerPed, 7,		Tree.Skinchanger.Characters['bracelets_1'],		Tree.Skinchanger.Characters['bracelets_2'], 2)				-- Bracelets
        end
end

function Tree.Skinchanger.GetMaxValues()
    local playerPed = PlayerPedId()
    local data = {
		sex				= 626,
		mom				= 45, -- numbers 21-41 and 45 are female (22 total)
		dad				= 44, -- numbers 0-20 and 42-44 are male (24 total)
		skin			= 45,
		age_1			= GetNumHeadOverlayValues(3)-1,
		age_2			= 10,
		beard_1			= GetNumHeadOverlayValues(1)-1,
		beard_2			= 10,
		beard_3			= GetNumHairColors()-1,
		beard_4			= GetNumHairColors()-1,
		hair_1			= GetNumberOfPedDrawableVariations		(playerPed, 2) - 1,
		hair_2			= GetNumberOfPedTextureVariations		(playerPed, 2, Tree.Skinchanger.Characters['hair_1']) - 1,
		hair_color_1	= GetNumHairColors()-1,
		hair_color_2	= GetNumHairColors()-1,
		eye_color		= 31,
		eyebrows_1		= GetNumHeadOverlayValues(2)-1,
		eyebrows_2		= 10,
		eyebrows_3		= GetNumHairColors()-1,
		eyebrows_4		= GetNumHairColors()-1,
		makeup_1		= GetNumHeadOverlayValues(4)-1,
		makeup_2		= 10,
		makeup_3		= GetNumHairColors()-1,
		makeup_4		= GetNumHairColors()-1,
		lipstick_1		= GetNumHeadOverlayValues(8)-1,
		lipstick_2		= 10,
		lipstick_3		= GetNumHairColors()-1,
		lipstick_4		= GetNumHairColors()-1,
		blemishes_1		= GetNumHeadOverlayValues(0)-1,
		blemishes_2		= 10,
		blush_1			= GetNumHeadOverlayValues(5)-1,
		blush_2			= 10,
		blush_3			= GetNumHairColors()-1,
		complexion_1	= GetNumHeadOverlayValues(6)-1,
		complexion_2	= 10,
		sun_1			= GetNumHeadOverlayValues(7)-1,
		sun_2			= 10,
		moles_1			= GetNumHeadOverlayValues(9)-1,
		moles_2			= 10,
		chest_1			= GetNumHeadOverlayValues(10)-1,
		chest_2			= 10,
		chest_3			= GetNumHairColors()-1,
		bodyb_1			= GetNumHeadOverlayValues(11)-1,
		bodyb_2			= 10,
		ears_1			= GetNumberOfPedPropDrawableVariations	(playerPed, 1) - 1,
		ears_2			= GetNumberOfPedPropTextureVariations	(playerPed, 1, Tree.Skinchanger.Characters['ears_1'] - 1),
		tshirt_1		= GetNumberOfPedDrawableVariations		(playerPed, 8) - 1,
		tshirt_2		= GetNumberOfPedTextureVariations		(playerPed, 8, Tree.Skinchanger.Characters['tshirt_1']) - 1,
		torso_1			= GetNumberOfPedDrawableVariations		(playerPed, 11) - 1,
		torso_2			= GetNumberOfPedTextureVariations		(playerPed, 11, Tree.Skinchanger.Characters['torso_1']) - 1,
		decals_1		= GetNumberOfPedDrawableVariations		(playerPed, 10) - 1,
		decals_2		= GetNumberOfPedTextureVariations		(playerPed, 10, Tree.Skinchanger.Characters['decals_1']) - 1,
		arms			= GetNumberOfPedDrawableVariations		(playerPed, 3) - 1,
		arms_2			= 10,
		pants_1			= GetNumberOfPedDrawableVariations		(playerPed, 4) - 1,
		pants_2			= GetNumberOfPedTextureVariations		(playerPed, 4, Tree.Skinchanger.Characters['pants_1']) - 1,
		shoes_1			= GetNumberOfPedDrawableVariations		(playerPed, 6) - 1,
		shoes_2			= GetNumberOfPedTextureVariations		(playerPed, 6, Tree.Skinchanger.Characters['shoes_1']) - 1,
		mask_1			= GetNumberOfPedDrawableVariations		(playerPed, 1) - 1,
		mask_2			= GetNumberOfPedTextureVariations		(playerPed, 1, Tree.Skinchanger.Characters['mask_1']) - 1,
		bproof_1		= GetNumberOfPedDrawableVariations		(playerPed, 9) - 1,
		bproof_2		= GetNumberOfPedTextureVariations		(playerPed, 9, Tree.Skinchanger.Characters['bproof_1']) - 1,
		chain_1			= GetNumberOfPedDrawableVariations		(playerPed, 7) - 1,
		chain_2			= GetNumberOfPedTextureVariations		(playerPed, 7, Tree.Skinchanger.Characters['chain_1']) - 1,
		bags_1			= GetNumberOfPedDrawableVariations		(playerPed, 5) - 1,
		bags_2			= GetNumberOfPedTextureVariations		(playerPed, 5, Tree.Skinchanger.Characters['bags_1']) - 1,
		helmet_1		= GetNumberOfPedPropDrawableVariations	(playerPed, 0) - 1,
		helmet_2		= GetNumberOfPedPropTextureVariations	(playerPed, 0, Tree.Skinchanger.Characters['helmet_1']) - 1,
		glasses_1		= GetNumberOfPedPropDrawableVariations	(playerPed, 1) - 1,
		glasses_2		= GetNumberOfPedPropTextureVariations	(playerPed, 1, Tree.Skinchanger.Characters['glasses_1'] - 1),
		watches_1		= GetNumberOfPedPropDrawableVariations	(playerPed, 6) - 1,
		watches_2		= GetNumberOfPedPropTextureVariations	(playerPed, 6, Tree.Skinchanger.Characters['watches_1']) - 1,
		bracelets_1		= GetNumberOfPedPropDrawableVariations	(playerPed, 7) - 1,
		bracelets_2		= GetNumberOfPedPropTextureVariations	(playerPed, 7, Tree.Skinchanger.Characters['bracelets_1'] - 1),
		nose_1	= 10,	
		nose_2	=	10,	
		nose_3	=	10,
		nose_4	=	10,
		nose_5	=		10,
		nose_6	=	10,
		eyebrows_5	=	10,
		eyebrows_6	=	10,
		cheeks_3 =		10,
		cheeks_2 =			10,
		cheeks_1 = 			10,
		eye_open = 		10,
		lips_thick = 		10,
		jaw_1 =10,
		jaw_2 =	10,	
		chin_height	=	10,
		chin_width =		10,
		chin_hole =	10,
		neck_thick	=10
	}
    return data
end

---@param callback fun(components: table, maxValues: table)
function Tree.Skinchanger.GetData(callback)
    local components = json.decode(Tree.Skinchanger.Components)

    for k,v in pairs(Tree.Skinchanger.Characters) do
        for i=1, #components, 1 do
            if k == components[i].name then
                components[i].value = v
            end
        end
    end
    callback(components, Tree.Skinchanger.GetMaxValues())
end

function Tree.Skinchanger.Change(key, value)
    Tree.Skinchanger.Characters[key] = value
    if key == "sex" then
        Tree.Skinchanger.LoadSkin()
    end
end

function Tree.Skinchanger.LoadSkin(skin, cb)
    local character
    if skin["sex"] ~= Tree.Skinchanger.lastSex then
        Tree.Skinchanger.loadSkin = skin

        if skin['sex'] == 0 then
            Tree.Skinchanger.loadModel(true, cb)
        elseif skin['sex'] == 1 then
            Tree.Skinchanger.loadModel(false, cb)
        else
            character = Tree.Config.Skinchanger.PedList[skin["sex"] - 1]
        end
        RequestModel(character)
    else
        Tree.Skinchanger.ApplySkin(skin)

        if cb ~= nil then
            cb()
        end
    end

    Tree.Skinchanger.lastSex = skin['sex']

    CreateThread(function ()
        if IsModelInCdimage(character) and IsModelValid(character) then
            while not HasModelLoaded(character) do Wait(0) end

            SetPlayerModel(PlayerId(), character)
            SetPedDefaultComponentVariation(PlayerPedId())
            SetModelAsNoLongerNeeded(character)
            TriggerEvent("Tree:Skinchanger:modelLoaded")
        end
    end)
end


AddEventHandler('Tree:Skinchanger:modelLoaded', function ()
    ClearPedProp(PlayerPedId(), 0)
    if Tree.Skinchanger.LoadSkin ~= nil then
        Tree.Skinchanger.ApplySkin(Tree.Skinchanger.LoadSkin)
        Tree.Skinchanger.LoadSkin = nil
    end
    if Tree.Skinchanger.loadClothes ~= nil then
        Tree.Skinchanger.ApplySkin(Tree.Skinchanger.loadSkin, Tree.Skinchanger.loadClothes)
        Tree.Skinchanger.loadClothes = nil
    end
end)