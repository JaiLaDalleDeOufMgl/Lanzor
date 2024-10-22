---
--- @author Dylan MALANDAIN, Kalyptus
--- @version 1.0.0
--- created at [24/05/2021 10:02]
---

local Menus = {}
local SubMenus = {}

local random = math.random

---Shared function
---@param template string ex: '4xxx-yxxx'
function GenUuid(template)
    local template = template or 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
end

---CreateMenu
---@param Title string
---@param Subtitle string
---@param X number
---@param Y number
---@param TextureDictionary string
---@param TextureName string
---@param R number
---@param G number
---@param B number
---@param A number
---@return RageUIMenus
---@public
function RageUIMenus:CreateMenu(Title, Subtitle, X, Y, TextureDictionary, TextureName, R, G, B, A)
	local Menu = {}
    setmetatable(Menu, RageUIMenus)
	Menu.Display = {};

	Menu.InstructionalButtons = {}

	Menu.Display.Header = true;
	Menu.Display.Subtitle = true;
	Menu.Display.Background = true;
	Menu.Display.Navigation = true;
	Menu.Display.InstructionalButton = true;
	Menu.Display.PageCounter = true;

	Menu.Title = Title or ""
	Menu.TitleFont = 1
	Menu.TitleScale = 1.2
	Menu.Subtitle = string.upper(Subtitle) or nil
	Menu.SubtitleHeight = -37
	Menu.Description = nil
	Menu.DescriptionHeight = RageUI.Settings.Items.Description.Background.Height
	Menu.X = X or 0
	Menu.Y = Y or 0
	Menu.Parent = nil
	Menu.WidthOffset = 0
	Menu.Open = false
	Menu.Controls = RageUI.Settings.Controls
	Menu.Index = 1
	Menu.Sprite = { Dictionary = TextureDictionary or "commonmenu", Texture = TextureName or "interaction_bgd", Color = { R = R, G = G, B = B, A = A } }
	Menu.Rectangle = nil
	Menu.Pagination = { Minimum = 1, Maximum = 10, Total = 10 }
	Menu.Safezone = true
	Menu.SafeZoneSize = nil
	Menu.EnableMouse = false
	Menu.Options = 0
	Menu.Closable = true
	Menu.Prioritaire = false
	Menu.LeftRightCharacter = false
    Menu.id = GenUuid("xx6xx-xxxxx")

	if string.starts(Menu.Subtitle, "~") then
		Menu.PageCounterColour = string.lower(string.sub(Menu.Subtitle, 1, 3))
	else
		Menu.PageCounterColour = ""
	end

	if Menu.Subtitle ~= "" then
		local SubtitleLineCount = Graphics.GetLineCount(Menu.Subtitle, Menu.X + RageUI.Settings.Items.Subtitle.Text.X, Menu.Y + RageUI.Settings.Items.Subtitle.Text.Y, 0, RageUI.Settings.Items.Subtitle.Text.Scale, 245, 245, 245, 255, nil, false, false, RageUI.Settings.Items.Subtitle.Background.Width + Menu.WidthOffset)

		if SubtitleLineCount > 1 then
			Menu.SubtitleHeight = 18 * SubtitleLineCount
		else
			Menu.SubtitleHeight = 0
		end
	end

	Citizen.CreateThread(function()
		if not HasScaleformMovieLoaded(Menu.InstructionalScaleform) then
			Menu.InstructionalScaleform = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
			while not HasScaleformMovieLoaded(Menu.InstructionalScaleform) do
				Citizen.Wait(0)
			end
		end
	end)

    Menus[Menu.id] = Menu
    SubMenus[Menu.id] = {}

	return Menu
end

function RageUI.CreateMenu(Title, Subtitle, X, Y, TextureDictionary, TextureName, R, G, B, A)
    return RageUIMenus:CreateMenu(Title, Subtitle, X, Y, TextureDictionary, TextureName, R, G, B, A)
end
---CreateSubMenu
---@param ParentMenu function
---@param Title string
---@param Subtitle string
---@param X number
---@param Y number
---@param TextureDictionary string
---@param TextureName string
---@param R number
---@param G number
---@param B number
---@param A number
---@return RageUIMenus
---@public
function RageUIMenus:CreateSubMenu(ParentMenu, Title, Subtitle, X, Y, TextureDictionary, TextureName, R, G, B, A)
	if ParentMenu ~= nil then
		if ParentMenu() then
			local Menu = RageUI.CreateMenu(Title or ParentMenu.Title, string.upper(Subtitle) or string.upper(ParentMenu.Subtitle), X or ParentMenu.X, Y or ParentMenu.Y)
			Menu.Parent = ParentMenu
			Menu.WidthOffset = ParentMenu.WidthOffset
			Menu.Safezone = ParentMenu.Safezone
			if ParentMenu.Sprite then
				Menu.Sprite = { Dictionary = TextureDictionary or ParentMenu.Sprite.Dictionary, Texture = TextureName or ParentMenu.Sprite.Texture, Color = { R = R or ParentMenu.Sprite.Color.R, G = G or ParentMenu.Sprite.Color.G, B = B or ParentMenu.Sprite.Color.B, A = A or ParentMenu.Sprite.Color.A } }
			else
				Menu.Rectangle = ParentMenu.Rectangle
			end
            table.insert(SubMenus[ParentMenu.id], Menu.id)
			return setmetatable(Menu, RageUIMenus)
		else
			return nil
		end
	else
		return nil
	end
end

function RageUI.CreateSubMenu(ParentMenu, Title, Subtitle, X, Y, TextureDictionary, TextureName, R, G, B, A)
    return RageUIMenus:CreateSubMenu(ParentMenu, Title, Subtitle, X, Y, TextureDictionary, TextureName, R, G, B, A)
end
---SetSubtitle
---@param Subtitle string
---@return nil
---@public
function RageUIMenus:SetSubtitle(Subtitle)
	self.Subtitle = string.upper(Subtitle) or string.upper(self.Subtitle)
	if string.starts(self.Subtitle, "~") then
		self.PageCounterColour = string.lower(string.sub(self.Subtitle, 1, 3))
	else
		self.PageCounterColour = ""
	end
	if self.Subtitle ~= "" then
		local SubtitleLineCount = Graphics.GetLineCount(self.Subtitle, self.X + RageUI.Settings.Items.Subtitle.Text.X, self.Y + RageUI.Settings.Items.Subtitle.Text.Y, 0, RageUI.Settings.Items.Subtitle.Text.Scale, 245, 245, 245, 255, nil, false, false, RageUI.Settings.Items.Subtitle.Background.Width + self.WidthOffset)

		if SubtitleLineCount > 1 then
			self.SubtitleHeight = 18 * SubtitleLineCount
		else
			self.SubtitleHeight = 0
		end
	else
		self.SubtitleHeight = -37
	end
end

function RageUIMenus:AddInstructionButton(button)
	if type(button) == "table" and #button == 2 then
		table.insert(self.InstructionalButtons, button)
		self.UpdateInstructionalButtons(true);
	end
end

function RageUIMenus:RemoveInstructionButton(button)
	if type(button) == "table" then
		for i = 1, #self.InstructionalButtons do
			if button == self.InstructionalButtons[i] then
				table.remove(self.InstructionalButtons, i)
				self.UpdateInstructionalButtons(true);
				break
			end
		end
	else
		if tonumber(button) then
			if self.InstructionalButtons[tonumber(button)] then
				table.remove(self.InstructionalButtons, tonumber(button))
				self.UpdateInstructionalButtons(true);
			end
		end
	end
end

function RageUIMenus:UpdateInstructionalButtons(Visible)
	if not Visible then
		return
	end

	BeginScaleformMovieMethod(self.InstructionalScaleform, "CLEAR_ALL")
	EndScaleformMovieMethod()

	BeginScaleformMovieMethod(self.InstructionalScaleform, "TOGGLE_MOUSE_BUTTONS")
	ScaleformMovieMethodAddParamInt(0)
	EndScaleformMovieMethod()

	BeginScaleformMovieMethod(self.InstructionalScaleform, "CREATE_CONTAINER")
	EndScaleformMovieMethod()

	BeginScaleformMovieMethod(self.InstructionalScaleform, "SET_DATA_SLOT")
	ScaleformMovieMethodAddParamInt(0)
	PushScaleformMovieMethodParameterButtonName(GetControlInstructionalButton(2, 176, 0))
	PushScaleformMovieMethodParameterString(GetLabelText("HUD_INPUT2"))
	EndScaleformMovieMethod()



	if self.Closable then
		BeginScaleformMovieMethod(self.InstructionalScaleform, "SET_DATA_SLOT")
		ScaleformMovieMethodAddParamInt(1)
		PushScaleformMovieMethodParameterButtonName(GetControlInstructionalButton(2, 177, 0))
		PushScaleformMovieMethodParameterString(GetLabelText("HUD_INPUT3"))
		EndScaleformMovieMethod()
	end

	if self.LeftRightCharacter then
		self:AddInstructionButton({GetControlInstructionalButton(0, 35, true), "Tourner à droite"})
		self:AddInstructionButton({GetControlInstructionalButton(0, 34, true), "Tourner à gauche"})
	end

	local count = 2

	if (self.InstructionalButtons ~= nil) then
		for i = 1, #self.InstructionalButtons do
			if self.InstructionalButtons[i] then
				if #self.InstructionalButtons[i] == 2 then
					BeginScaleformMovieMethod(self.InstructionalScaleform, "SET_DATA_SLOT")
					ScaleformMovieMethodAddParamInt(count)
					PushScaleformMovieMethodParameterButtonName(self.InstructionalButtons[i][1])
					PushScaleformMovieMethodParameterString(self.InstructionalButtons[i][2])
					EndScaleformMovieMethod()
					count = count + 1
				end
			end
		end
	end

	BeginScaleformMovieMethod(self.InstructionalScaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
	ScaleformMovieMethodAddParamInt(-1)
	EndScaleformMovieMethod()


	
end

-- ---IsVisible
-- ---@param Item fun(Item:Items)
-- ---@param Panel fun(Panel:Panels
-- function RageUIMenus:IsVisible(Item, Panel)
-- 	if (RageUI.Visible(self)) and (UpdateOnscreenKeyboard() ~= 0) and (UpdateOnscreenKeyboard() ~= 3) then
-- 		RageUI.Banner()
-- 		RageUI.Subtitle()
-- 		Item(Items);
-- 		RageUI.Background();
-- 		RageUI.Navigation();
-- 		RageUI.Description();
-- 		Panel(Panels);
-- 		RageUI.PoolMenus.Timer = 1
-- 		RageUI.Render()
-- 	end
-- end


---@param Items fun(Items: Items)
---@param Panels fun(Panels: Panels)
---@param onClose function
function RageUIMenus:IsVisible(Items, Panels, onClose)
    if type(Items) == "function" and ((Panels and type(Panels) == "function") or true) then
        self.func = Items
        self.panels = Panels
        self.Closed = onClose
    else
        error("Type is not function (Items or panels)")
    end
end

function RageUIMenus:KeysRegister(Controls, ControlName, Description, Action)
	RegisterKeyMapping(string.format('riv-%s', ControlName), Description, "keyboard", Controls)
	RegisterCommand(string.format('riv-%s', ControlName), function(source, args)
		if (Action ~= nil) then
			Action();
		end
	end, false)
end





function RageUIMenus:getSubMenus()
    if #SubMenus[self.id] > 0 then
        for _, submenu in pairs(SubMenus[self.id]) do
            RageUI.IsVisible(Menus[submenu])
            Menus[submenu]:getSubMenus()
        end
    end
end

function RageUIMenus:open(position, interactDistance, ...)
	local payload = {...}
    CreateThread(function()


        if RageUI.GetCurrentMenu() == nil and not IsPauseMenuActive() then
            --if player:canOpenMenu() then
                --OPEN
                -- local Audio = RageUI.Settings.Audio
                Audio.PlaySound(RageUI.Settings.Audio.Select.audioName, RageUI.Settings.Audio.Select.audioRef)
                RageUI.Visible(self, true)
                CreateThread(function()
                    while RageUI.CurrentMenu ~= nil do
                        -- RageUI.DisableControlsOnMenu()
                        RageUI.IsVisible(self, table.unpack(payload))
                        self:getSubMenus()

						if (RageUI.CurrentMenu ~= nil and RageUI.CurrentMenu.LeftRightCharacter) then
							local Heading = GetEntityHeading(PlayerPedId())
							if IsDisabledControlPressed(1, 34) then
								SetEntityHeading(PlayerPedId(), Heading - 2)
							end
					
							if IsDisabledControlPressed(0, 9) then
								SetEntityHeading(PlayerPedId(), Heading + 2)
							end
						end

						if (position) then
							local PlayerPos = GetEntityCoords(PlayerPedId())
							local distance = #(PlayerPos - position)
				
							if (distance > (interactDistance + 1.5)) then
								RageUI.Visible(self, false)
							end
						end

						-- if MOD_Cache:get("isdead") then
							-- RageUI.Visible(self, false)
						-- end
							
                        Wait(1)
                    end
                end)
            --end
        end
    end)
end

function RageUIMenus:close()
    if RageUI.GetCurrentMenu() == self then
        --if self.Closed then self.Closed() end
        RageUI.Visible(self, false)
        self.Index = 1
        self.Pagination.Minimum = 1
        self.Pagination.Maximum = self.Pagination.Total
        RageUI.CurrentMenu = nil
        ResetScriptGfxAlign()
        -- local Audio = RageUI.Settings.Audio
        Audio.PlaySound(RageUI.Settings.Audio.Select.audioName, RageUI.Settings.Audio.Select.audioRef)
        return
    end
    if #SubMenus[self.id] > 0 then
        for _, submenu in pairs(SubMenus[self.id]) do
            if RageUI.GetCurrentMenu() ~= nil then
                Menus[submenu]:close()
            end
        end
    end
end

function RageUIMenus:toggle(position, interactDistance, ...)
	local payload = {...}
    CreateThread(function()

        if RageUI.GetCurrentMenu() ~= nil then
			if self.Prioritaire then
				Audio.PlaySound(RageUI.Settings.Audio.Back.audioName, RageUI.Settings.Audio.Back.audioRef)
				RageUI.GetCurrentMenu():close()
				self:open(position, interactDistance, table.unpack(payload))
			end
        else
            -- if not MOD_Cache:get("isdead") then
                self:open(position, interactDistance, table.unpack(payload))
            -- end
        end
    end)
end