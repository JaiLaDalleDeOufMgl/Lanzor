---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Dylan Malandain.
--- DateTime: 21/04/2019 21:20
---

---round
---@param num number
---@param numDecimalPlaces number
---@return number
---@public
function math.round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

---starts
---@param String string
---@param Start number
---@return number
---@public
function string.starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

---@type table
RageUIv5.Menus = setmetatable({}, RageUIv5.Menus)

---@type table
---@return boolean
RageUIv5.Menus.__call = function()
    return true
end

---@type table
RageUIv5.Menus.__index = RageUIv5.Menus

---@type table
RageUIv5.CurrentMenu = nil

---@type table
RageUIv5.NextMenu = nil

---@type number
RageUIv5.Options = 0

---@type number
RageUIv5.ItemOffset = 0

---@type number
RageUIv5.StatisticPanelCount = 0

---@type table
RageUIv5.UI = {
    Current = "RageUIv5",
    Style = {
        RageUIv5 = {
            Width = 0
        },
        NativeUI = {
            Width = 0
        }
    }
}

---@type table
RageUIv5.Settings = {
    Debug = false,
    Controls = {
        Up = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 172 },
                { 1, 172 },
                { 2, 172 },
                { 0, 241 },
                { 1, 241 },
                { 2, 241 },
            },
        },
        Down = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 173 },
                { 1, 173 },
                { 2, 173 },
                { 0, 242 },
                { 1, 242 },
                { 2, 242 },
            },
        },
        Left = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 174 },
                { 1, 174 },
                { 2, 174 },
            },
        },
        Right = {
            Enabled = true,
            Pressed = false,
            Active = false,
            Keys = {
                { 0, 175 },
                { 1, 175 },
                { 2, 175 },
            },
        },
        SliderLeft = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 174 },
                { 1, 174 },
                { 2, 174 },
            },
        },
        SliderRight = {
            Enabled = true,
            Pressed = false,
            Active = false,
            Keys = {
                { 0, 175 },
                { 1, 175 },
                { 2, 175 },
            },
        },
        Select = {
            Enabled = true,
            Pressed = false,
            Active = false,
            Keys = {
                { 0, 201 },
                { 1, 201 },
                { 2, 201 },
            },
        },
        Back = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 177 },
                { 1, 177 },
                { 2, 177 },
                { 0, 199 },
                { 1, 199 },
                { 2, 199 },
            },
        },
        Click = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 24 },
            },
        },
        Enabled = {
            Controller = {
                { 0, 2 }, -- Look Up and Down
                { 0, 1 }, -- Look Left and Right
                { 0, 25 }, -- Aim
                { 0, 24 }, -- Attack
            },
            Keyboard = {
                { 0, 201 }, -- Select
                { 0, 195 }, -- X axis
                { 0, 196 }, -- Y axis
                { 0, 187 }, -- Down
                { 0, 188 }, -- Up
                { 0, 189 }, -- Left
                { 0, 190 }, -- Right
                { 0, 202 }, -- Back
                { 0, 217 }, -- Select
                { 0, 242 }, -- Scroll down
                { 0, 241 }, -- Scroll up
                { 0, 239 }, -- Cursor X
                { 0, 240 }, -- Cursor Y
                { 0, 31 }, -- Move Up and Down
                { 0, 30 }, -- Move Left and Right
                { 0, 21 }, -- Sprint
                { 0, 22 }, -- Jump
                { 0, 23 }, -- Enter
                { 0, 75 }, -- Exit Vehicle
                { 0, 71 }, -- Accelerate Vehicle
                { 0, 72 }, -- Vehicle Brake
                { 0, 59 }, -- Move Vehicle Left and Right
                { 0, 89 }, -- Fly Yaw Left
                { 0, 9 }, -- Fly Left and Right
                { 0, 8 }, -- Fly Up and Down
                { 0, 90 }, -- Fly Yaw Right
                { 0, 76 }, -- Vehicle Handbrake
            },
        },
    },
    Audio = {
        Id = nil,
        Use = "RageUIv5",
        RageUIv5 = {
            UpDown = {
                audioName = "HUD_FREEMODE_SOUNDSET",
                audioRef = "NAV_UP_DOWN",
            },
            LeftRight = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "NAV_LEFT_RIGHT",
            },
            Select = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "SELECT",
            },
            Back = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "BACK",
            },
            Error = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "ERROR",
            },
            Slider = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "CONTINUOUS_SLIDER",
                Id = nil
            },
        },
        NativeUI = {
            UpDown = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "NAV_UP_DOWN",
            },
            LeftRight = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "NAV_LEFT_RIGHT",
            },
            Select = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "SELECT",
            },
            Back = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "BACK",
            },
            Error = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "ERROR",
            },
            Slider = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "CONTINUOUS_SLIDER",
                Id = nil
            },
        }
    },
    Items = {
        Title = {
            Background = { Width = 431, Height = 107 },
            Text = { X = 215, Y = 20, Scale = 1.15 },
        },
        Subtitle = {
            Background = { Width = 431, Height = 37 },
            Text = { X = 8, Y = 3, Scale = 0.35 },
            PreText = { X = 425, Y = 3, Scale = 0.35 },
        },
        Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 0, Width = 431 },
        Navigation = {
            Rectangle = { Width = 431, Height = 18 },
            Offset = 5,
            Arrows = { Dictionary = "commonmenu", Texture = "shop_arrows_upanddown", X = 190, Y = -6, Width = 50, Height = 50 },
        },
        Description = {
            Bar = { Y = 4, Width = 431, Height = 4 },
            Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 30 },
            Text = { X = 8, Y = 10, Scale = 0.35 },
        },
    },
    Panels = {
        Grid = {
            Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 275 },
            Grid = { Dictionary = "pause_menu_pages_char_mom_dad", Texture = "nose_grid", X = 115.5, Y = 47.5, Width = 200, Height = 200 },
            Circle = { Dictionary = "mpinventory", Texture = "in_world_circle", X = 115.5, Y = 47.5, Width = 20, Height = 20 },
            Text = {
                Top = { X = 215.5, Y = 15, Scale = 0.35 },
                Bottom = { X = 215.5, Y = 250, Scale = 0.35 },
                Left = { X = 57.75, Y = 130, Scale = 0.35 },
                Right = { X = 373.25, Y = 130, Scale = 0.35 },
            },
        },
        Percentage = {
            Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 76 },
            Bar = { X = 9, Y = 50, Width = 413, Height = 10 },
            Text = {
                Left = { X = 25, Y = 15, Scale = 0.35 },
                Middle = { X = 215.5, Y = 15, Scale = 0.35 },
                Right = { X = 398, Y = 15, Scale = 0.35 },
            },
        },
    },
}

function RageUIv5.SetScaleformParams(scaleform, data)
    data = data or {}
    for k, v in pairs(data) do
        PushScaleformMovieFunction(scaleform, v.name)
        if v.param then
            for _, par in pairs(v.param) do
                if math.type(par) == "integer" then
                    PushScaleformMovieFunctionParameterInt(par)
                elseif type(par) == "boolean" then
                    PushScaleformMovieFunctionParameterBool(par)
                elseif math.type(par) == "float" then
                    PushScaleformMovieFunctionParameterFloat(par)
                elseif type(par) == "string" then
                    PushScaleformMovieFunctionParameterString(par)
                end
            end
        end
        if v.func then
            v.func()
        end
        PopScaleformMovieFunctionVoid()
    end
end

---Visible
---@param Menu function
---@param Value boolean
---@return table
---@public
function RageUIv5.Visible(Menu, Value)
    if Menu ~= nil then
        if Menu() then
            if type(Value) == "boolean" then
                if Value then
                    if RageUIv5.CurrentMenu ~= nil then
			if RageUIv5.CurrentMenu.Closed ~= nil then
                            RageUIv5.CurrentMenu.Closed()
                        end
                        RageUIv5.CurrentMenu.Open = not Value
                    end
                    Menu:UpdateInstructionalButtons(Value);
                    Menu:UpdateCursorStyle();
                    RageUIv5.CurrentMenu = Menu
                    menuOpen = true
                else
                    menuOpen = false
                    RageUIv5.CurrentMenu = nil
                end
                Menu.Open = Value
                RageUIv5.Options = 0
                RageUIv5.ItemOffset = 0
                RageUIv5.LastControl = false
            else
                return Menu.Open
            end
        end
    end
end

function RageUIv5.CloseAll()
    menuOpen = false
    if RageUIv5.CurrentMenu ~= nil then
        local parent = RageUIv5.CurrentMenu.Parent
        while parent ~= nil do
            parent.Index = 1
            parent.Pagination.Minimum = 1
            parent.Pagination.Maximum = 10
            parent = parent.Parent
        end
        RageUIv5.CurrentMenu.Index = 1
        RageUIv5.CurrentMenu.Pagination.Minimum = 1
        RageUIv5.CurrentMenu.Pagination.Maximum = 10
        RageUIv5.CurrentMenu.Open = false
        RageUIv5.CurrentMenu = nil
    end
    RageUIv5.Options = 0
    RageUIv5.ItemOffset = 0
    ResetScriptGfxAlign()
end

---Banner
---@return nil
---@public
---@param Enabled boolean
function RageUIv5.Banner(Enabled)
    if type(Enabled) == "boolean" then
        if Enabled == true then


            if RageUIv5.CurrentMenu ~= nil then
                if RageUIv5.CurrentMenu() then


                    RageUIv5.ItemsSafeZone(RageUIv5.CurrentMenu)

                    if RageUIv5.CurrentMenu.Sprite then
                        RenderSprite(RageUIv5.CurrentMenu.Sprite.Dictionary, RageUIv5.CurrentMenu.Sprite.Texture, RageUIv5.CurrentMenu.X, RageUIv5.CurrentMenu.Y, RageUIv5.Settings.Items.Title.Background.Width + RageUIv5.CurrentMenu.WidthOffset, RageUIv5.Settings.Items.Title.Background.Height, nil)
                    else
                        RenderRectangle(RageUIv5.CurrentMenu.X, RageUIv5.CurrentMenu.Y, RageUIv5.Settings.Items.Title.Background.Width + RageUIv5.CurrentMenu.WidthOffset, RageUIv5.Settings.Items.Title.Background.Height, RageUIv5.CurrentMenu.Rectangle.R, RageUIv5.CurrentMenu.Rectangle.G, RageUIv5.CurrentMenu.Rectangle.B, RageUIv5.CurrentMenu.Rectangle.A)
                    end
                    RenderText(RageUIv5.CurrentMenu.Title, RageUIv5.CurrentMenu.X + RageUIv5.Settings.Items.Title.Text.X + (RageUIv5.CurrentMenu.WidthOffset / 2), RageUIv5.CurrentMenu.Y + RageUIv5.Settings.Items.Title.Text.Y, 1, RageUIv5.Settings.Items.Title.Text.Scale, 255, 255, 255, 255, 1)
                    RageUIv5.ItemOffset = RageUIv5.ItemOffset + RageUIv5.Settings.Items.Title.Background.Height
                end
            end
        end
    else
        error("Enabled is not boolean")
    end
end

---CloseAll -- TODO 
---@return nil
---@public
-- function RageUIv5:CloseAll()
--     RageUIv5.PlaySound(RageUIv5.Settings.Audio.Library, RageUIv5.Settings.Audio.Back)
--     RageUIv5.NextMenu = nil
--     RageUIv5.Visible(RageUIv5.CurrentMenu, false)
-- end

---Subtitle
---@return nil
---@public
function RageUIv5.Subtitle()
    if RageUIv5.CurrentMenu ~= nil then
        if RageUIv5.CurrentMenu() then
            RageUIv5.ItemsSafeZone(RageUIv5.CurrentMenu)
            if RageUIv5.CurrentMenu.Subtitle ~= "" then
                RenderRectangle(RageUIv5.CurrentMenu.X, RageUIv5.CurrentMenu.Y + RageUIv5.ItemOffset, RageUIv5.Settings.Items.Subtitle.Background.Width + RageUIv5.CurrentMenu.WidthOffset, RageUIv5.Settings.Items.Subtitle.Background.Height + RageUIv5.CurrentMenu.SubtitleHeight, 0, 0, 0, 255)
                RenderText(RageUIv5.CurrentMenu.Subtitle, RageUIv5.CurrentMenu.X + RageUIv5.Settings.Items.Subtitle.Text.X, RageUIv5.CurrentMenu.Y + RageUIv5.Settings.Items.Subtitle.Text.Y + RageUIv5.ItemOffset, 0, RageUIv5.Settings.Items.Subtitle.Text.Scale, 245, 245, 245, 255, nil, false, false, RageUIv5.Settings.Items.Subtitle.Background.Width + RageUIv5.CurrentMenu.WidthOffset)
                if RageUIv5.CurrentMenu.Index > RageUIv5.CurrentMenu.Options or RageUIv5.CurrentMenu.Index < 0 then
                    RageUIv5.CurrentMenu.Index = 1
                end
                RageUIv5.RefreshPagination()
                if RageUIv5.CurrentMenu.PageCounter == nil then
                    RenderText(RageUIv5.CurrentMenu.PageCounterColour .. RageUIv5.CurrentMenu.Index .. " / " .. RageUIv5.CurrentMenu.Options, RageUIv5.CurrentMenu.X + RageUIv5.Settings.Items.Subtitle.PreText.X + RageUIv5.CurrentMenu.WidthOffset, RageUIv5.CurrentMenu.Y + RageUIv5.Settings.Items.Subtitle.PreText.Y + RageUIv5.ItemOffset, 0, RageUIv5.Settings.Items.Subtitle.PreText.Scale, 245, 245, 245, 255, 2)
                else
                    RenderText(RageUIv5.CurrentMenu.PageCounter, RageUIv5.CurrentMenu.X + RageUIv5.Settings.Items.Subtitle.PreText.X + RageUIv5.CurrentMenu.WidthOffset, RageUIv5.CurrentMenu.Y + RageUIv5.Settings.Items.Subtitle.PreText.Y + RageUIv5.ItemOffset, 0, RageUIv5.Settings.Items.Subtitle.PreText.Scale, 245, 245, 245, 255, 2)
                end
                RageUIv5.ItemOffset = RageUIv5.ItemOffset + RageUIv5.Settings.Items.Subtitle.Background.Height
            end
        end
    end
end

---Background
---@return nil
---@public
function RageUIv5.Background()
    if RageUIv5.CurrentMenu ~= nil then
        if RageUIv5.CurrentMenu() then
            RageUIv5.ItemsSafeZone(RageUIv5.CurrentMenu)
            SetScriptGfxDrawOrder(0)
            RenderSprite(RageUIv5.Settings.Items.Background.Dictionary, RageUIv5.Settings.Items.Background.Texture, RageUIv5.CurrentMenu.X, RageUIv5.CurrentMenu.Y + RageUIv5.Settings.Items.Background.Y + RageUIv5.CurrentMenu.SubtitleHeight, RageUIv5.Settings.Items.Background.Width + RageUIv5.CurrentMenu.WidthOffset, RageUIv5.ItemOffset, 0, 0, 0, 0, 255)
            SetScriptGfxDrawOrder(1)
        end
    end
end

---Description
---@return nil
---@public
function RageUIv5.Description()
    if RageUIv5.CurrentMenu ~= nil and RageUIv5.CurrentMenu.Description ~= nil then
        if RageUIv5.CurrentMenu() then
            RageUIv5.ItemsSafeZone(RageUIv5.CurrentMenu)
            RenderRectangle(RageUIv5.CurrentMenu.X, RageUIv5.CurrentMenu.Y + RageUIv5.Settings.Items.Description.Bar.Y + RageUIv5.CurrentMenu.SubtitleHeight + RageUIv5.ItemOffset, RageUIv5.Settings.Items.Description.Bar.Width + RageUIv5.CurrentMenu.WidthOffset, RageUIv5.Settings.Items.Description.Bar.Height, 0, 0, 0, 255)
            RenderSprite(RageUIv5.Settings.Items.Description.Background.Dictionary, RageUIv5.Settings.Items.Description.Background.Texture, RageUIv5.CurrentMenu.X, RageUIv5.CurrentMenu.Y + RageUIv5.Settings.Items.Description.Background.Y + RageUIv5.CurrentMenu.SubtitleHeight + RageUIv5.ItemOffset, RageUIv5.Settings.Items.Description.Background.Width + RageUIv5.CurrentMenu.WidthOffset, RageUIv5.CurrentMenu.DescriptionHeight, 0, 0, 0, 255)
            RenderText(RageUIv5.CurrentMenu.Description, RageUIv5.CurrentMenu.X + RageUIv5.Settings.Items.Description.Text.X, RageUIv5.CurrentMenu.Y + RageUIv5.Settings.Items.Description.Text.Y + RageUIv5.CurrentMenu.SubtitleHeight + RageUIv5.ItemOffset, 0, RageUIv5.Settings.Items.Description.Text.Scale, 255, 255, 255, 255, nil, false, false, RageUIv5.Settings.Items.Description.Background.Width + RageUIv5.CurrentMenu.WidthOffset - 8.0)
            RageUIv5.ItemOffset = RageUIv5.ItemOffset + RageUIv5.CurrentMenu.DescriptionHeight + RageUIv5.Settings.Items.Description.Bar.Y
        end
    end
end

---Render
---@param instructionalButton boolean
---@return nil
---@public
function RageUIv5.Render(instructionalButton)
    if RageUIv5.CurrentMenu ~= nil then
        if RageUIv5.CurrentMenu() then
            if RageUIv5.CurrentMenu.Safezone then
                ResetScriptGfxAlign()
            end
            if (instructionalButton) then
                DrawScaleformMovieFullscreen(RageUIv5.CurrentMenu.InstructionalScaleform, 255, 255, 255, 255, 0)
            end
            RageUIv5.CurrentMenu.Options = RageUIv5.Options
            RageUIv5.CurrentMenu.SafeZoneSize = nil
            RageUIv5.Controls()
            RageUIv5.Options = 0
            RageUIv5.StatisticPanelCount = 0
            RageUIv5.ItemOffset = 0
            if RageUIv5.CurrentMenu.Controls.Back.Enabled and RageUIv5.CurrentMenu.Closable then
                if RageUIv5.CurrentMenu.Controls.Back.Pressed then
                    RageUIv5.CurrentMenu.Controls.Back.Pressed = false
                    local Audio = RageUIv5.Settings.Audio
                    RageUIv5.PlaySound(Audio[Audio.Use].Back.audioName, Audio[Audio.Use].Back.audioRef)
                    collectgarbage()
                    if RageUIv5.CurrentMenu.Closed ~= nil then
                        RageUIv5.CurrentMenu.Closed()
                    end
                    if RageUIv5.CurrentMenu.Parent ~= nil then
                        if RageUIv5.CurrentMenu.Parent() then
                            RageUIv5.NextMenu = RageUIv5.CurrentMenu.Parent
                            RageUIv5.CurrentMenu:UpdateCursorStyle()
                        else
                            --print('xxx') Debug print
                            RageUIv5.NextMenu = nil
                            RageUIv5.Visible(RageUIv5.CurrentMenu, false)
                        end
                    else
                        --print('zz') Debug print
                        RageUIv5.NextMenu = nil
                        RageUIv5.Visible(RageUIv5.CurrentMenu, false)
                    end
                end
            end
            if RageUIv5.NextMenu ~= nil then
                if RageUIv5.NextMenu() then
                    RageUIv5.Visible(RageUIv5.CurrentMenu, false)
                    RageUIv5.Visible(RageUIv5.NextMenu, true)
                    RageUIv5.CurrentMenu.Controls.Select.Active = false
                    RageUIv5.NextMenu = nil
                    RageUIv5.LastControl = false
                end
            end
        end
    end
end

---ItemsDescription
---@param CurrentMenu table
---@param Description string
---@param Selected boolean
---@return nil
---@public
function RageUIv5.ItemsDescription(CurrentMenu, Description, Selected)
    ---@type table
    if Description ~= "" or Description ~= nil then
        local SettingsDescription = RageUIv5.Settings.Items.Description;
        if Selected and CurrentMenu.Description ~= Description then
            CurrentMenu.Description = Description or nil
            ---@type number
            local DescriptionLineCount = GetLineCount(CurrentMenu.Description, CurrentMenu.X + SettingsDescription.Text.X, CurrentMenu.Y + SettingsDescription.Text.Y + CurrentMenu.SubtitleHeight + RageUIv5.ItemOffset, 0, SettingsDescription.Text.Scale, 255, 255, 255, 255, nil, false, false, SettingsDescription.Background.Width + (CurrentMenu.WidthOffset - 5.0))
            if DescriptionLineCount > 1 then
                CurrentMenu.DescriptionHeight = SettingsDescription.Background.Height * DescriptionLineCount
            else
                CurrentMenu.DescriptionHeight = SettingsDescription.Background.Height + 7
            end
        end
    end
end

---MouseBounds
---@param CurrentMenu table
---@param Selected boolean
---@param Option number
---@param SettingsButton table
---@return boolean
---@public
function RageUIv5.ItemsMouseBounds(CurrentMenu, Selected, Option, SettingsButton)
    ---@type boolean
    local Hovered = false
    Hovered = RageUIv5.IsMouseInBounds(CurrentMenu.X + CurrentMenu.SafeZoneSize.X, CurrentMenu.Y + SettingsButton.Rectangle.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUIv5.ItemOffset, SettingsButton.Rectangle.Width + CurrentMenu.WidthOffset, SettingsButton.Rectangle.Height)
    if Hovered and not Selected then
        RenderRectangle(CurrentMenu.X, CurrentMenu.Y + SettingsButton.Rectangle.Y + CurrentMenu.SubtitleHeight + RageUIv5.ItemOffset, SettingsButton.Rectangle.Width + CurrentMenu.WidthOffset, SettingsButton.Rectangle.Height, 255, 255, 255, 20)
        if CurrentMenu.Controls.Click.Active then
            CurrentMenu.Index = Option
            local Audio = RageUIv5.Settings.Audio
            RageUIv5.PlaySound(Audio[Audio.Use].Error.audioName, Audio[Audio.Use].Error.audioRef)
        end
    end
    return Hovered;
end

---ItemsSafeZone
---@param CurrentMenu table
---@return nil
---@public
function RageUIv5.ItemsSafeZone(CurrentMenu)
    if not CurrentMenu.SafeZoneSize then
        CurrentMenu.SafeZoneSize = { X = 0, Y = 0 }
        if CurrentMenu.Safezone then
            CurrentMenu.SafeZoneSize = RageUIv5.GetSafeZoneBounds()
            SetScriptGfxAlign(76, 84)
            SetScriptGfxAlignParams(0, 0, 0, 0)
        end
    end
end

function RageUIv5.CurrentIsEqualTo(Current, To, Style, DefaultStyle)
    if (Current == To) then
        return Style;
    else
        return DefaultStyle or {};
    end
end

function RageUIv5.RefreshPagination()
    if (RageUIv5.CurrentMenu ~= nil) then
        if (RageUIv5.CurrentMenu.Index > 10) then
            local offset = RageUIv5.CurrentMenu.Index - 10
            RageUIv5.CurrentMenu.Pagination.Minimum = 1 + offset
            RageUIv5.CurrentMenu.Pagination.Maximum = 10 + offset
        else
            RageUIv5.CurrentMenu.Pagination.Minimum = 1
            RageUIv5.CurrentMenu.Pagination.Maximum = 10
        end
    end
end

function RageUIv5.IsVisible(menu, header, instructional, items, panels)
    if (RageUIv5.Visible(menu)) then
        if (header == true) then
            RageUIv5.Banner(true)
        end
        RageUIv5.Subtitle()
        if (items ~= nil) then
            items()
        end
        RageUIv5.Background();
        RageUIv5.Navigation();
        RageUIv5.Description();
        if (panels ~= nil) then
            panels()
        end
        RageUIv5.Render(instructional or false)
    end
end


---CreateWhile
---@param wait number
---@param menu table
---@param key number
---@param closure function
---@return void
---@public
function RageUIv5.CreateWhile(wait, menu, key, closure)
    Citizen.CreateThread(function()
        while (true) do
            Citizen.Wait(wait or 0.1)

            if (key ~= nil) then
                if IsControlJustPressed(1, key) then
                    RageUIv5.Visible(menu, not RageUIv5.Visible(menu))
                end
            end

            closure()
        end
    end)
end

---SetStyleAudio
---@param StyleAudio string
---@return void
---@public
function RageUIv5.SetStyleAudio(StyleAudio)
    RageUIv5.Settings.Audio.Use = StyleAudio or "RageUIv5"
end

function RageUIv5.GetStyleAudio()
    return RageUIv5.Settings.Audio.Use or "RageUIv5"
end
