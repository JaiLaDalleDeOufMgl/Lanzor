---@class Tree.Menu
Tree.Menu = {}

---@class Item
Tree.Menu.Item = {}

---@class Panel
Tree.Menu.Panel = {}

---@class Window
Tree.Menu.Window = {}

---@class TMenu
TMenu = setmetatable({}, TMenu)

---@type table
local TotalMenus = {}

---Add
---@param Type string
---@param Name string
---@param Menu table
---@return TMenu
---@public
function TMenu.Add(Type, Name, Menu)
    if TMenu[Type] ~= nil then
        TMenu[Type][Name] = {
            Menu = Menu
        }
    else
        TMenu[Type] = {}
        TMenu[Type][Name] = {
            Menu = Menu
        }
    end
    return table.insert(TotalMenus, Menu)
end

---Get
---@param Type string
---@param Name string
---@return table
---@public
function TMenu:Get(Type, Name)
    if self[Type] ~= nil and self[Type][Name] ~= nil then
        return self[Type][Name].Menu
    end
end

---GetType
---@param Type string
---@return table
---@public
function TMenu:GetType(Type)
    if self[Type] ~= nil then
        return self[Type]
    end
end

---Settings
---@param Type string
---@param Name string
---@param Settings string
---@param Value any optional
---@return void
---@public
function TMenu:Settings(Type, Name, Settings, Value)
    if Value ~= nil then
        self[Type][Name][Settings] = Value
    else
        return self[Type][Name][Settings]
    end
end

---Delete
---@param Type string
---@param Name string
---@return void
---@public
function TMenu:Delete(Type, Name)
    self[Type][Name] = nil
    collectgarbage()
end

---DeleteType
---@param Type string
---@return void
---@public
function TMenu:DeleteType(Type)
    self[Type] = nil
    collectgarbage()
end

function math.round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function string.starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

---@class Tree.MenuMenus
Tree.Menu.Menus = setmetatable({}, Tree.Menu.Menus)

---@type table
---@return boolean
Tree.Menu.Menus.__call = function()
    return true
end

---@type table
Tree.Menu.Menus.__index = Tree.Menu.Menus

---@type table
Tree.Menu.CurrentMenu = nil

---@type table
Tree.Menu.NextMenu = nil

---@type number
Tree.Menu.Options = 0

---@type number
Tree.Menu.ItemOffset = 0

---@type number
Tree.Menu.StatisticPanelCount = 0

---@class UISize
Tree.Menu.UI = {
    Current = "NativeUI",
    Style = {
        RageUI = {
            Width = 0
        },
        NativeUI = {
            Width = 0
        }
    }
}

---@class Settings
Tree.Menu.Settings = {
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
        Use = "RageUI",
        RageUI = {
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
function Tree.Menu.SetScaleformParams(scaleform, data)
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
function Tree.Menu.IsMouseInBounds(X, Y, Width, Height)
    local GetControlNormal = IsControlEnabled(2, 239) and GetControlNormal or GetDisabledControlNormal
    local MX, MY = math.round(GetControlNormal(2, 239) * 1920) / 1920, math.round(GetControlNormal(2, 240) * 1080) / 1080
    X, Y = X / 1920, Y / 1080
    Width, Height = Width / 1920, Height / 1080
    return (MX >= X and MX <= X + Width) and (MY > Y and MY < Y + Height)
end

function Tree.Menu.GetSafeZoneBounds()
    local SafeSize = GetSafeZoneSize()
    SafeSize = math.round(SafeSize, 2)
    SafeSize = (SafeSize * 100) - 90
    SafeSize = 10 - SafeSize

    local W, H = 1920, 1080

    return { X = math.round(SafeSize * ((W / H) * 5.4)), Y = math.round(SafeSize * 5.4) }
end

function Tree.Menu.Visible(Menu, Value)
    if Menu ~= nil and Menu() then
        if Value == true or Value == false then
            if Value then
                if Tree.Menu.CurrentMenu ~= nil then
                    if Tree.Menu.CurrentMenu.Closed ~= nil then
                        Tree.Menu.CurrentMenu.Closed()
                    end
                    Tree.Menu.CurrentMenu.Open = not Value
                    Menu:UpdateInstructionalButtons(Value);
                    Menu:UpdateCursorStyle();

                end
                Tree.Menu.CurrentMenu = Menu
            else
                Tree.Menu.CurrentMenu = nil
            end
            Menu.Open = Value
            Tree.Menu.Options = 0
            Tree.Menu.ItemOffset = 0
            Tree.Menu.LastControl = false
        else
            return Menu.Open
        end
    end
end

function Tree.Menu.CloseAll()
    if Tree.Menu.CurrentMenu ~= nil then
        local parent = Tree.Menu.CurrentMenu.Parent
        while parent ~= nil do
            parent.Index = 1
            parent.Pagination.Minimum = 1
            parent.Pagination.Maximum = parent.Pagination.Total
            parent = parent.Parent
        end
        Tree.Menu.CurrentMenu.Index = 1
        Tree.Menu.CurrentMenu.Pagination.Minimum = 1
        Tree.Menu.CurrentMenu.Pagination.Maximum = Tree.Menu.CurrentMenu.Pagination.Total
        Tree.Menu.CurrentMenu.Open = false
        Tree.Menu.CurrentMenu = nil
    end
    Tree.Menu.Options = 0
    Tree.Menu.ItemOffset = 0
    ResetScriptGfxAlign()
end

function Tree.Menu.Banner()
    local CurrentMenu = Tree.Menu.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() and (CurrentMenu.Display.Header) then
            Tree.Menu.ItemsSafeZone(CurrentMenu)
            if CurrentMenu.Sprite ~= nil then
                if CurrentMenu.Sprite.Dictionary ~= nil then
                    if CurrentMenu.Sprite.Dictionary == "commonmenu" then
                        RenderSprite(CurrentMenu.Sprite.Dictionary, CurrentMenu.Sprite.Texture, CurrentMenu.X, CurrentMenu.Y, Tree.Menu.Settings.Items.Title.Background.Width + CurrentMenu.WidthOffset, Tree.Menu.Settings.Items.Title.Background.Height, CurrentMenu.Sprite.Color.R,CurrentMenu.Sprite.Color.G,CurrentMenu.Sprite.Color.B,CurrentMenu.Sprite.Color.A)
                    else
                        RenderSprite(CurrentMenu.Sprite.Dictionary, CurrentMenu.Sprite.Texture, CurrentMenu.X, CurrentMenu.Y, Tree.Menu.Settings.Items.Title.Background.Width + CurrentMenu.WidthOffset, Tree.Menu.Settings.Items.Title.Background.Height, nil)
                    end
                else
                    RenderRectangle(CurrentMenu.X, CurrentMenu.Y, Tree.Menu.Settings.Items.Title.Background.Width + CurrentMenu.WidthOffset, Tree.Menu.Settings.Items.Title.Background.Height, CurrentMenu.Rectangle.R, CurrentMenu.Rectangle.G, CurrentMenu.Rectangle.B, CurrentMenu.Rectangle.A)
                end
            else
                RenderRectangle(CurrentMenu.X, CurrentMenu.Y, Tree.Menu.Settings.Items.Title.Background.Width + CurrentMenu.WidthOffset, Tree.Menu.Settings.Items.Title.Background.Height, CurrentMenu.Rectangle.R, CurrentMenu.Rectangle.G, CurrentMenu.Rectangle.B, CurrentMenu.Rectangle.A)
            end
            RenderText(CurrentMenu.Title, CurrentMenu.X + Tree.Menu.Settings.Items.Title.Text.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Tree.Menu.Settings.Items.Title.Text.Y, CurrentMenu.TitleFont, CurrentMenu.TitleScale, 255, 255, 255, 255, 1)
            Tree.Menu.ItemOffset = Tree.Menu.ItemOffset + Tree.Menu.Settings.Items.Title.Background.Height
        end
    end
end

function Tree.Menu.Subtitle()
    local CurrentMenu = Tree.Menu.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() and (CurrentMenu.Display.Subtitle) then
            Tree.Menu.ItemsSafeZone(CurrentMenu)
            if CurrentMenu.Subtitle ~= "" then
                RenderRectangle(CurrentMenu.X, CurrentMenu.Y + Tree.Menu.ItemOffset, Tree.Menu.Settings.Items.Subtitle.Background.Width + CurrentMenu.WidthOffset, Tree.Menu.Settings.Items.Subtitle.Background.Height + CurrentMenu.SubtitleHeight, 0, 0, 0, 255)
                RenderText(CurrentMenu.PageCounterColour .. CurrentMenu.Subtitle, CurrentMenu.X + Tree.Menu.Settings.Items.Subtitle.Text.X, CurrentMenu.Y + Tree.Menu.Settings.Items.Subtitle.Text.Y + Tree.Menu.ItemOffset, 0, Tree.Menu.Settings.Items.Subtitle.Text.Scale, 245, 245, 245, 255, nil, false, false, Tree.Menu.Settings.Items.Subtitle.Background.Width + CurrentMenu.WidthOffset)
                if CurrentMenu.Index > CurrentMenu.Options or CurrentMenu.Index < 0 then
                    CurrentMenu.Index = 1
                end
                if (CurrentMenu ~= nil) then
                    if (CurrentMenu.Index > CurrentMenu.Pagination.Total) then
                        local offset = CurrentMenu.Index - CurrentMenu.Pagination.Total
                        CurrentMenu.Pagination.Minimum = 1 + offset
                        CurrentMenu.Pagination.Maximum = CurrentMenu.Pagination.Total + offset
                    else
                        CurrentMenu.Pagination.Minimum = 1
                        CurrentMenu.Pagination.Maximum = CurrentMenu.Pagination.Total
                    end
                end
                
                if CurrentMenu.Display.PageCounter then
                    if CurrentMenu.PageCounter == nil then
                        RenderText(CurrentMenu.PageCounterColour .. CurrentMenu.Index .. " / " .. CurrentMenu.Options, CurrentMenu.X + Tree.Menu.Settings.Items.Subtitle.PreText.X + CurrentMenu.WidthOffset, CurrentMenu.Y + Tree.Menu.Settings.Items.Subtitle.PreText.Y + Tree.Menu.ItemOffset, 0, Tree.Menu.Settings.Items.Subtitle.PreText.Scale, 245, 245, 245, 255, 2)
                    else
                        RenderText(CurrentMenu.PageCounter, CurrentMenu.X + Tree.Menu.Settings.Items.Subtitle.PreText.X + CurrentMenu.WidthOffset, CurrentMenu.Y + Tree.Menu.Settings.Items.Subtitle.PreText.Y + Tree.Menu.ItemOffset, 0, Tree.Menu.Settings.Items.Subtitle.PreText.Scale, 245, 245, 245, 255, 2)
                    end
                end
                Tree.Menu.ItemOffset = Tree.Menu.ItemOffset + Tree.Menu.Settings.Items.Subtitle.Background.Height
            end
        end
    end
end

function Tree.Menu.Background()
    local CurrentMenu = Tree.Menu.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() and (CurrentMenu.Display.Background) then
            Tree.Menu.ItemsSafeZone(CurrentMenu)
            SetScriptGfxDrawOrder(0)
            RenderSprite(Tree.Menu.Settings.Items.Background.Dictionary, Tree.Menu.Settings.Items.Background.Texture, CurrentMenu.X, CurrentMenu.Y + Tree.Menu.Settings.Items.Background.Y + CurrentMenu.SubtitleHeight, Tree.Menu.Settings.Items.Background.Width + CurrentMenu.WidthOffset, Tree.Menu.ItemOffset, 0, 0, 0, 0, 255)
            SetScriptGfxDrawOrder(1)
        end
    end
end

function Tree.Menu.Description()
    local CurrentMenu = Tree.Menu.CurrentMenu;
    local Description = Tree.Menu.Settings.Items.Description;
    if CurrentMenu ~= nil and CurrentMenu.Description ~= nil then
        if CurrentMenu() then
            Tree.Menu.ItemsSafeZone(CurrentMenu)
            RenderRectangle(CurrentMenu.X, CurrentMenu.Y + Description.Bar.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Description.Bar.Width + CurrentMenu.WidthOffset, Description.Bar.Height, 0, 0, 0, 255)
            RenderSprite(Description.Background.Dictionary, Description.Background.Texture, CurrentMenu.X, CurrentMenu.Y + Description.Background.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Description.Background.Width + CurrentMenu.WidthOffset, CurrentMenu.DescriptionHeight, 0, 0, 0, 255)
            RenderText(CurrentMenu.Description, CurrentMenu.X + Description.Text.X, CurrentMenu.Y + Description.Text.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, Description.Text.Scale, 255, 255, 255, 255, nil, false, false, Description.Background.Width + CurrentMenu.WidthOffset - 8.0)
            Tree.Menu.ItemOffset = Tree.Menu.ItemOffset + CurrentMenu.DescriptionHeight + Description.Bar.Y
        end
    end
end

function Tree.Menu.Render()
    local CurrentMenu = Tree.Menu.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            if CurrentMenu.Safezone then
                ResetScriptGfxAlign()
            end

            if (CurrentMenu.Display.InstructionalButton) then
                if not CurrentMenu.InitScaleform then
                    CurrentMenu:UpdateInstructionalButtons(true)
                    CurrentMenu.InitScaleform = true
                end
                DrawScaleformMovieFullscreen(CurrentMenu.InstructionalScaleform, 255, 255, 255, 255, 0)
            end
            CurrentMenu.Options = Tree.Menu.Options
            CurrentMenu.SafeZoneSize = nil
            Tree.Menu.Controls()
            Tree.Menu.Options = 0
            Tree.Menu.StatisticPanelCount = 0
            Tree.Menu.ItemOffset = 0
            if CurrentMenu.Controls.Back.Enabled then
                if CurrentMenu.Controls.Back.Pressed and CurrentMenu.Closable then
                    CurrentMenu.Controls.Back.Pressed = false
                    local Audio = Tree.Menu.Settings.Audio
                    Tree.Gui.Audio.PlaySound(Audio[Audio.Use].Back.audioName, Audio[Audio.Use].Back.audioRef)

                    if CurrentMenu.Closed ~= nil then
                        collectgarbage()
                        CurrentMenu.Closed()
                    end

                    if CurrentMenu.Parent ~= nil then
                        if CurrentMenu.Parent() then
                            Tree.Menu.NextMenu = CurrentMenu.Parent
                            CurrentMenu:UpdateCursorStyle()
                        else
                            Tree.Menu.NextMenu = nil
                            Tree.Menu.Visible(CurrentMenu, false)
                        end
                    else
                        Tree.Menu.NextMenu = nil
                        Tree.Menu.Visible(CurrentMenu, false)
                    end
                elseif CurrentMenu.Controls.Back.Pressed and not CurrentMenu.Closable then
                    CurrentMenu.Controls.Back.Pressed = false
                end
            end
            if Tree.Menu.NextMenu ~= nil then
                if Tree.Menu.NextMenu() then
                    Tree.Menu.Visible(CurrentMenu, false)
                    Tree.Menu.Visible(Tree.Menu.NextMenu, true)
                    CurrentMenu.Controls.Select.Active = false
                    Tree.Menu.NextMenu = nil
                    Tree.Menu.LastControl = false
                end
            end
        end
    end
end

function Tree.Menu.ItemsDescription(CurrentMenu, Description, Selected)
    ---@type table
    if Description ~= "" or Description ~= nil then
        local SettingsDescription = Tree.Menu.Settings.Items.Description;
        if Selected and CurrentMenu.Description ~= Description then
            CurrentMenu.Description = Description or nil
            ---@type number
            local DescriptionLineCount = GetLineCount(CurrentMenu.Description, CurrentMenu.X + SettingsDescription.Text.X, CurrentMenu.Y + SettingsDescription.Text.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsDescription.Text.Scale, 255, 255, 255, 255, nil, false, false, SettingsDescription.Background.Width + (CurrentMenu.WidthOffset - 5.0))
            if DescriptionLineCount > 1 then
                CurrentMenu.DescriptionHeight = SettingsDescription.Background.Height * DescriptionLineCount
            else
                CurrentMenu.DescriptionHeight = SettingsDescription.Background.Height + 7
            end
        end
    end
end

function Tree.Menu.ItemsMouseBounds(CurrentMenu, Selected, Option, SettingsButton)
    ---@type boolean
    local Hovered = false
    Hovered = Tree.Menu.IsMouseInBounds(CurrentMenu.X + CurrentMenu.SafeZoneSize.X, CurrentMenu.Y + SettingsButton.Rectangle.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsButton.Rectangle.Width + CurrentMenu.WidthOffset, SettingsButton.Rectangle.Height)
    if Hovered and not Selected then
        RenderRectangle(CurrentMenu.X, CurrentMenu.Y + SettingsButton.Rectangle.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsButton.Rectangle.Width + CurrentMenu.WidthOffset, SettingsButton.Rectangle.Height, 255, 255, 255, 20)
        if CurrentMenu.Controls.Click.Active then
            CurrentMenu.Index = Option
            local Audio = Tree.Menu.Settings.Audio
            Tree.Gui.Audio.PlaySound(Audio[Audio.Use].UpDown.audioName, Audio[Audio.Use].UpDown.audioRef)
        end
    end
    return Hovered;
end

function Tree.Menu.ItemsSafeZone(CurrentMenu)
    if not CurrentMenu.SafeZoneSize then
        CurrentMenu.SafeZoneSize = { X = 0, Y = 0 }
        if CurrentMenu.Safezone then
            CurrentMenu.SafeZoneSize = Tree.Menu.GetSafeZoneBounds()
            SetScriptGfxAlign(76, 84)
            SetScriptGfxAlignParams(0, 0, 0, 0)
        end
    end
end

function Tree.Menu.CurrentIsEqualTo(Current, To, Style, DefaultStyle)
    return Current == To and Style or DefaultStyle or {};
end

function Tree.Menu.IsVisible(Menu, Items, Panels)
    if (Tree.Menu.Visible(Menu)) and (UpdateOnscreenKeyboard() ~= 0) and (UpdateOnscreenKeyboard() ~= 3) then
        Tree.Menu.Banner()
        Tree.Menu.Subtitle()
        if (Items ~= nil) then
            Items()
        end
        Tree.Menu.Background();
        Tree.Menu.Navigation();
        Tree.Menu.Description();
        if (Panels ~= nil) then
            Panels()
        end
        Tree.Menu.Render()
    end
end

---SetStyleAudio
---@param StyleAudio string
---@return void
---@public
function Tree.Menu.SetStyleAudio(StyleAudio)
    Tree.Menu.Settings.Audio.Use = StyleAudio or "Tree.Menu"
end

function Tree.Menu.GetStyleAudio()
    return Tree.Menu.Settings.Audio.Use or "Tree.Menu"
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
---@return Tree.MenuMenus
---@public
function Tree.Menu.CreateMenu(Title, Subtitle, X, Y, TextureDictionary, TextureName, R, G, B, A)

    ---@type table
    local Menu = {}
    Menu.Display = {};

    Menu.InstructionalButtons = {}

    Menu.Display.Header = true;
    Menu.Display.Subtitle = false;
    Menu.Display.Background = true;
    Menu.Display.Navigation = true;
    Menu.Display.InstructionalButton = true;
    Menu.Display.PageCounter = true;

    Menu.Title = Title or ""
    Menu.TitleFont = 6
    Menu.TitleScale = 1.0
    Menu.Subtitle = string.upper(Subtitle) or nil
    Menu.SubtitleHeight = -37
    Menu.Description = nil
    Menu.DescriptionHeight = Tree.Menu.Settings.Items.Description.Background.Height
    Menu.X = X or 0
    Menu.Y = Y or 0
    Menu.Parent = nil
    Menu.WidthOffset = Tree.Menu.UI.Style[Tree.Menu.UI.Current].Width
    Menu.Open = false
    Menu.Controls = Tree.Menu.Settings.Controls
    Menu.Index = 1
    Menu.Sprite = { Dictionary = TextureDictionary or "commonmenu", Texture = TextureName or "interaction_bgd", Color = { R = R, G = G, B = B, A = A } }
    Menu.Rectangle = nil
    Menu.Pagination = { Minimum = 1, Maximum = 16, Total = 16 }
    Menu.Safezone = true
    Menu.SafeZoneSize = nil
    Menu.EnableMouse = false
    Menu.Options = 0
    Menu.Closable = true
    Menu.InstructionalScaleform = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
    Menu.CursorStyle = 1

    if string.starts(Menu.Subtitle, "~") then
        Menu.PageCounterColour = string.lower(string.sub(Menu.Subtitle, 1, 3))
    else
        Menu.PageCounterColour = ""
    end

    if Menu.Subtitle ~= "" then
        local SubtitleLineCount = GetLineCount(Menu.Subtitle, Menu.X + Tree.Menu.Settings.Items.Subtitle.Text.X, Menu.Y + Tree.Menu.Settings.Items.Subtitle.Text.Y, 0, Tree.Menu.Settings.Items.Subtitle.Text.Scale, 245, 245, 245, 255, nil, false, false, Tree.Menu.Settings.Items.Subtitle.Background.Width + Menu.WidthOffset)

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

    return setmetatable(Menu, Tree.Menu.Menus)
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
---@return Tree.MenuMenus
---@public
function Tree.Menu.CreateSubMenu(ParentMenu, Title, Subtitle, X, Y, TextureDictionary, TextureName, R, G, B, A)
    if ParentMenu ~= nil then
        if ParentMenu() then
            local Menu = Tree.Menu.CreateMenu(Title or ParentMenu.Title, string.upper(Subtitle) or string.upper(ParentMenu.Subtitle), X or ParentMenu.X, Y or ParentMenu.Y)
            Menu.Parent = ParentMenu
            Menu.WidthOffset = ParentMenu.WidthOffset
            Menu.Safezone = ParentMenu.Safezone
            if ParentMenu.Sprite then
                Menu.Sprite = { Dictionary = TextureDictionary or ParentMenu.Sprite.Dictionary, Texture = TextureName or ParentMenu.Sprite.Texture, Color = { R = R or ParentMenu.Sprite.Color.R, G = G or ParentMenu.Sprite.Color.G, B = B or ParentMenu.Sprite.Color.B, A = A or ParentMenu.Sprite.Color.A } }
            else
                Menu.Rectangle = ParentMenu.Rectangle
            end
            return setmetatable(Menu, Tree.Menu.Menus)
        else
            return nil
        end
    else
        return nil
    end
end

function Tree.Menu.Menus:DisplayHeader(boolean)
    self.Display.Header = boolean;
    return self.Display.Header;
end

function Tree.Menu.Menus:DisplaySubtitle(boolean)
    self.Display.Subtitle = boolean;
    return self.Display.Subtitle;
end

function Tree.Menu.Menus:DisplayNavigation(boolean)
    self.Display.Navigation = boolean;
    return self.Display.Navigation;
end

function Tree.Menu.Menus:DisplayInstructionalButton(boolean)
    self.Display.InstructionalButton = boolean;
    return self.Display.InstructionalButton;
end

function Tree.Menu.Menus:DisplayPageCounter(boolean)
    self.Display.PageCounter= boolean;
    return self.Display.PageCounter;
end

---SetTitle
---@param Title string
---@return nil
---@public
function Tree.Menu.Menus:SetTitle(Title)
    self.Title = Title
end

function Tree.Menu.Menus:SetStyleSize(Value)
    local witdh
    if Value >= 0 and Value <= 100 then
        witdh = Value
    else
        witdh = 100
    end
    self.WidthOffset = witdh
end

---GetStyleSize
---@return any
---@public
function Tree.Menu.Menus:GetStyleSize()
    if (self.WidthOffset == 100) then
        return "Tree.Menu"
    elseif (self.WidthOffset == 0) then
        return "NativeUI";
    else
        return self.WidthOffset;
    end
end

---SetStyleSize
---@param Int string
---@return void
---@public
function Tree.Menu.Menus:SetCursorStyle(Int)
    self.CursorStyle = Int or 1 or 0
    SetMouseCursorSprite(Int)
end

---ResetCursorStyle
---@return void
---@public
function Tree.Menu.Menus:ResetCursorStyle()
    self.CursorStyle = 1
    SetMouseCursorSprite(1)
end

---UpdateCursorStyle
---@return void
---@public
function Tree.Menu.Menus:UpdateCursorStyle()
    SetMouseCursorSprite(self.CursorStyle)
end

---RefreshIndex
---@return void
---@public
function Tree.Menu.Menus:RefreshIndex()
    self.Index = 1
end

---SetSubtitle
---@param Subtitle string
---@return nil
---@public
function Tree.Menu.Menus:SetSubtitle(Subtitle)

    self.Subtitle = string.upper(Subtitle) or string.upper(self.Subtitle)

    if string.starts(self.Subtitle, "~") then
        self.PageCounterColour = string.lower(string.sub(self.Subtitle, 1, 3))
    else
        self.PageCounterColour = ""
    end
    if self.Subtitle ~= "" then
        local SubtitleLineCount = GetLineCount(self.Subtitle, self.X + Tree.Menu.Settings.Items.Subtitle.Text.X, self.Y + Tree.Menu.Settings.Items.Subtitle.Text.Y, 0, Tree.Menu.Settings.Items.Subtitle.Text.Scale, 245, 245, 245, 255, nil, false, false, Tree.Menu.Settings.Items.Subtitle.Background.Width + self.WidthOffset)

        if SubtitleLineCount > 1 then
            self.SubtitleHeight = 18 * SubtitleLineCount
        else
            self.SubtitleHeight = 0
        end

    else
        self.SubtitleHeight = -37
    end
end

---PageCounter
---@param Subtitle string
---@return nil
---@public
function Tree.Menu.Menus:SetPageCounter(Subtitle)
    self.PageCounter = Subtitle
end

---EditSpriteColor
---@param Colors table
---@return nil
---@public
function Tree.Menu.Menus:EditSpriteColor(R, G, B, A)
    if self.Sprite.Dictionary == "commonmenu" then
        self.Sprite.Color = { R = tonumber(R) or 255, G = tonumber(G) or 255, B = tonumber(B) or 255, A = tonumber(A) or 255 }
    end
end
---SetPosition
---@param X number
---@param Y number
---@return nil
---@public
function Tree.Menu.Menus:SetPosition(X, Y)
    self.X = tonumber(X) or self.X
    self.Y = tonumber(Y) or self.Y
end

---SetTotalItemsPerPage
---@param Value number
---@return nil
---@public
function Tree.Menu.Menus:SetTotalItemsPerPage(Value)
    self.Pagination.Total = tonumber(Value) or self.Pagination.Total
end

---SetRectangleBanner
---@param R number
---@param G number
---@param B number
---@param A number
---@return nil
---@public
function Tree.Menu.Menus:SetRectangleBanner(R, G, B, A)
    self.Rectangle = { R = tonumber(R) or 255, G = tonumber(G) or 255, B = tonumber(B) or 255, A = tonumber(A) or 255 }
    self.Sprite = nil
end

---SetSpriteBanner
---@param TextureDictionary string
---@param Texture string
---@return nil
---@public
function Tree.Menu.Menus:SetSpriteBanner(TextureDictionary, Texture)
    self.Sprite = { Dictionary = TextureDictionary or "commonmenu", Texture = Texture or "interaction_bgd" }
    self.Rectangle = nil
end

function Tree.Menu.Menus:Closable(boolean)
    if type(boolean) == "boolean" then
        self.Closable = boolean
    else
        error("Type is not boolean")
    end
end

function Tree.Menu.Menus:AddInstructionButton(button)
    if type(button) == "table" and #button == 2 then
        table.insert(self.InstructionalButtons, button)
        self.UpdateInstructionalButtons(true);
    end
end

function Tree.Menu.Menus:RemoveInstructionButton(button)
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

function Tree.Menu.Menus:UpdateInstructionalButtons(Visible)

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



Tree.Menu.LastControl = false

local ControlActions = {
    'Left',
    'Right',
    'Select',
    'Click',
}

---GoUp
---@param Options number
---@return nil
---@public
function Tree.Menu.GoUp(Options)
    local CurrentMenu = Tree.Menu.CurrentMenu;
    if CurrentMenu ~= nil then
        Options = CurrentMenu.Options
        if CurrentMenu() then
            if (Options ~= 0) then
                if Options > CurrentMenu.Pagination.Total then
                    if CurrentMenu.Index <= CurrentMenu.Pagination.Minimum then
                        if CurrentMenu.Index == 1 then
                            CurrentMenu.Pagination.Minimum = Options - (CurrentMenu.Pagination.Total - 1)
                            CurrentMenu.Pagination.Maximum = Options
                            CurrentMenu.Index = Options
                        else
                            CurrentMenu.Pagination.Minimum = (CurrentMenu.Pagination.Minimum - 1)
                            CurrentMenu.Pagination.Maximum = (CurrentMenu.Pagination.Maximum - 1)
                            CurrentMenu.Index = CurrentMenu.Index - 1
                        end
                    else
                        CurrentMenu.Index = CurrentMenu.Index - 1
                    end
                else
                    if CurrentMenu.Index == 1 then
                        CurrentMenu.Pagination.Minimum = Options - (CurrentMenu.Pagination.Total - 1)
                        CurrentMenu.Pagination.Maximum = Options
                        CurrentMenu.Index = Options
                    else
                        CurrentMenu.Index = CurrentMenu.Index - 1
                    end
                end

                local Audio = Tree.Menu.Settings.Audio
                Tree.Gui.Audio.PlaySound(Audio[Audio.Use].UpDown.audioName, Audio[Audio.Use].UpDown.audioRef)
                Tree.Menu.LastControl = true
                if (CurrentMenu.onIndexChange ~= nil) then
                    Citizen.CreateThread(function()
                        CurrentMenu.onIndexChange(CurrentMenu.Index)
                    end)
                end
            else
                local Audio = Tree.Menu.Settings.Audio
                Tree.Gui.Audio.PlaySound(Audio[Audio.Use].Error.audioName, Audio[Audio.Use].Error.audioRef)
            end
        end
    end
end

---GoDown
---@param Options number
---@return nil
---@public
function Tree.Menu.GoDown(Options)
    local CurrentMenu = Tree.Menu.CurrentMenu;
    if CurrentMenu ~= nil then
        Options = CurrentMenu.Options
        if CurrentMenu() then
            if (Options ~= 0) then
                if Options > CurrentMenu.Pagination.Total then
                    if CurrentMenu.Index >= CurrentMenu.Pagination.Maximum then
                        if CurrentMenu.Index == Options then
                            CurrentMenu.Pagination.Minimum = 1
                            CurrentMenu.Pagination.Maximum = CurrentMenu.Pagination.Total
                            CurrentMenu.Index = 1
                        else
                            CurrentMenu.Pagination.Maximum = (CurrentMenu.Pagination.Maximum + 1)
                            CurrentMenu.Pagination.Minimum = CurrentMenu.Pagination.Maximum - (CurrentMenu.Pagination.Total - 1)
                            CurrentMenu.Index = CurrentMenu.Index + 1
                        end
                    else
                        CurrentMenu.Index = CurrentMenu.Index + 1
                    end
                else
                    if CurrentMenu.Index == Options then
                        CurrentMenu.Pagination.Minimum = 1
                        CurrentMenu.Pagination.Maximum = CurrentMenu.Pagination.Total
                        CurrentMenu.Index = 1
                    else
                        CurrentMenu.Index = CurrentMenu.Index + 1
                    end
                end
                local Audio = Tree.Menu.Settings.Audio
                Tree.Gui.Audio.PlaySound(Audio[Audio.Use].UpDown.audioName, Audio[Audio.Use].UpDown.audioRef)
                Tree.Menu.LastControl = false
                if (CurrentMenu.onIndexChange ~= nil) then
                    Citizen.CreateThread(function()
                        CurrentMenu.onIndexChange(CurrentMenu.Index)
                    end)
                end
            else
                local Audio = Tree.Menu.Settings.Audio
                Tree.Gui.Audio.PlaySound(Audio[Audio.Use].Error.audioName, Audio[Audio.Use].Error.audioRef)
            end
        end
    end
end

function Tree.Menu.GoActionControl(Controls, Action)
    if Controls[Action or 'Left'].Enabled then
        for Index = 1, #Controls[Action or 'Left'].Keys do
            if not Controls[Action or 'Left'].Pressed then
                if IsDisabledControlJustPressed(Controls[Action or 'Left'].Keys[Index][1], Controls[Action or 'Left'].Keys[Index][2]) then
                    Controls[Action or 'Left'].Pressed = true
                    Citizen.CreateThread(function()
                        Controls[Action or 'Left'].Active = true
                        Citizen.Wait(0.01)
                        Controls[Action or 'Left'].Active = false
                        Citizen.Wait(175)
                        while Controls[Action or 'Left'].Enabled and IsDisabledControlPressed(Controls[Action or 'Left'].Keys[Index][1], Controls[Action or 'Left'].Keys[Index][2]) do
                            Controls[Action or 'Left'].Active = true
                            Citizen.Wait(1)
                            Controls[Action or 'Left'].Active = false
                            Citizen.Wait(124)
                        end
                        Controls[Action or 'Left'].Pressed = false
                        if (Action ~= ControlActions[5]) then
                            Citizen.Wait(10)
                        end
                    end)
                    break
                end
            end
        end
    end
end

function Tree.Menu.GoActionControlSlider(Controls, Action)
    if Controls[Action].Enabled then
        for Index = 1, #Controls[Action].Keys do
            if not Controls[Action].Pressed then
                if IsDisabledControlJustPressed(Controls[Action].Keys[Index][1], Controls[Action].Keys[Index][2]) then
                    Controls[Action].Pressed = true
                    Citizen.CreateThread(function()
                        Controls[Action].Active = true
                        Citizen.Wait(1)
                        Controls[Action].Active = false
                        while Controls[Action].Enabled and IsDisabledControlPressed(Controls[Action].Keys[Index][1], Controls[Action].Keys[Index][2]) do
                            Controls[Action].Active = true
                            Citizen.Wait(1)
                            Controls[Action].Active = false
                        end
                        Controls[Action].Pressed = false
                    end)
                    break
                end
            end
        end
    end
end

---Controls
---@return nil
---@public
function Tree.Menu.Controls()
    local CurrentMenu = Tree.Menu.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            if CurrentMenu.Open then

                local Controls = CurrentMenu.Controls;
                ---@type number
                local Options = CurrentMenu.Options
                Tree.Menu.Options = CurrentMenu.Options
                if CurrentMenu.EnableMouse then
                    DisableAllControlActions(2)
                end

                if not IsInputDisabled(2) then
                    for Index = 1, #Controls.Enabled.Controller do
                        EnableControlAction(Controls.Enabled.Controller[Index][1], Controls.Enabled.Controller[Index][2], true)
                    end
                else
                    for Index = 1, #Controls.Enabled.Keyboard do
                        EnableControlAction(Controls.Enabled.Keyboard[Index][1], Controls.Enabled.Keyboard[Index][2], true)
                    end
                end

                if Controls.Up.Enabled then
                    for Index = 1, #Controls.Up.Keys do
                        if not Controls.Up.Pressed then
                            if IsDisabledControlJustPressed(Controls.Up.Keys[Index][1], Controls.Up.Keys[Index][2]) then
                                Controls.Up.Pressed = true
                                Citizen.CreateThread(function()
                                    Tree.Menu.GoUp(Options)
                                    Citizen.Wait(175)
                                    while Controls.Up.Enabled and IsDisabledControlPressed(Controls.Up.Keys[Index][1], Controls.Up.Keys[Index][2]) do
                                        Tree.Menu.GoUp(Options)
                                        Citizen.Wait(50)
                                    end
                                    Controls.Up.Pressed = false
                                end)
                                break
                            end
                        end
                    end
                end

                if Controls.Down.Enabled then
                    for Index = 1, #Controls.Down.Keys do
                        if not Controls.Down.Pressed then
                            if IsDisabledControlJustPressed(Controls.Down.Keys[Index][1], Controls.Down.Keys[Index][2]) then
                                Controls.Down.Pressed = true
                                Citizen.CreateThread(function()
                                    Tree.Menu.GoDown(Options)
                                    Citizen.Wait(175)
                                    while Controls.Down.Enabled and IsDisabledControlPressed(Controls.Down.Keys[Index][1], Controls.Down.Keys[Index][2]) do
                                        Tree.Menu.GoDown(Options)
                                        Citizen.Wait(50)
                                    end
                                    Controls.Down.Pressed = false
                                end)
                                break
                            end
                        end
                    end
                end

                for i = 1, #ControlActions do
                    Tree.Menu.GoActionControl(Controls, ControlActions[i])
                end

                Tree.Menu.GoActionControlSlider(Controls, 'SliderLeft')
                Tree.Menu.GoActionControlSlider(Controls, 'SliderRight')

                if Controls.Back.Enabled then
                    for Index = 1, #Controls.Back.Keys do
                        if not Controls.Back.Pressed then
                            if IsDisabledControlJustPressed(Controls.Back.Keys[Index][1], Controls.Back.Keys[Index][2]) then
                                Controls.Back.Pressed = true
                                Citizen.CreateThread(function()
                                    Citizen.Wait(175)
                                    Controls.Down.Pressed = false
                                end)
                                break
                            end
                        end
                    end
                end

            end
        end
    end
end

---Navigation
---@return nil
---@public
function Tree.Menu.Navigation()
    local CurrentMenu = Tree.Menu.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() and (CurrentMenu.Display.Navigation) then
            if CurrentMenu.EnableMouse then
                SetMouseCursorActiveThisFrame()
            end
            if Tree.Menu.Options > CurrentMenu.Pagination.Total then

                ---@type boolean
                local UpHovered = false

                ---@type boolean
                local DownHovered = false

                if not CurrentMenu.SafeZoneSize then
                    CurrentMenu.SafeZoneSize = { X = 0, Y = 0 }

                    if CurrentMenu.Safezone then
                        CurrentMenu.SafeZoneSize = Tree.Menu.GetSafeZoneBounds()

                        SetScriptGfxAlign(76, 84)
                        SetScriptGfxAlignParams(0, 0, 0, 0)
                    end
                end

                if CurrentMenu.EnableMouse then
                    UpHovered = Tree.Menu.IsMouseInBounds(CurrentMenu.X + CurrentMenu.SafeZoneSize.X, CurrentMenu.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Tree.Menu.Settings.Items.Navigation.Rectangle.Width + CurrentMenu.WidthOffset, Tree.Menu.Settings.Items.Navigation.Rectangle.Height)
                    DownHovered = Tree.Menu.IsMouseInBounds(CurrentMenu.X + CurrentMenu.SafeZoneSize.X, CurrentMenu.Y + Tree.Menu.Settings.Items.Navigation.Rectangle.Height + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Tree.Menu.Settings.Items.Navigation.Rectangle.Width + CurrentMenu.WidthOffset, Tree.Menu.Settings.Items.Navigation.Rectangle.Height)

                    if CurrentMenu.Controls.Click.Active then
                        if UpHovered then
                            Tree.Menu.GoUp(Tree.Menu.Options)
                        elseif DownHovered then
                            Tree.Menu.GoDown(Tree.Menu.Options)
                        end
                    end

                    if UpHovered then
                        RenderRectangle(CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Tree.Menu.Settings.Items.Navigation.Rectangle.Width + CurrentMenu.WidthOffset, Tree.Menu.Settings.Items.Navigation.Rectangle.Height, 30, 30, 30, 255)
                    else
                        RenderRectangle(CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Tree.Menu.Settings.Items.Navigation.Rectangle.Width + CurrentMenu.WidthOffset, Tree.Menu.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                    end

                    if DownHovered then
                        RenderRectangle(CurrentMenu.X, CurrentMenu.Y + Tree.Menu.Settings.Items.Navigation.Rectangle.Height + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Tree.Menu.Settings.Items.Navigation.Rectangle.Width + CurrentMenu.WidthOffset, Tree.Menu.Settings.Items.Navigation.Rectangle.Height, 30, 30, 30, 255)
                    else
                        RenderRectangle(CurrentMenu.X, CurrentMenu.Y + Tree.Menu.Settings.Items.Navigation.Rectangle.Height + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Tree.Menu.Settings.Items.Navigation.Rectangle.Width + CurrentMenu.WidthOffset, Tree.Menu.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                    end
                else
                    RenderRectangle(CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Tree.Menu.Settings.Items.Navigation.Rectangle.Width + CurrentMenu.WidthOffset, Tree.Menu.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                    RenderRectangle(CurrentMenu.X, CurrentMenu.Y + Tree.Menu.Settings.Items.Navigation.Rectangle.Height + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Tree.Menu.Settings.Items.Navigation.Rectangle.Width + CurrentMenu.WidthOffset, Tree.Menu.Settings.Items.Navigation.Rectangle.Height, 0, 0, 0, 200)
                end
                RenderSprite(Tree.Menu.Settings.Items.Navigation.Arrows.Dictionary, Tree.Menu.Settings.Items.Navigation.Arrows.Texture, CurrentMenu.X + Tree.Menu.Settings.Items.Navigation.Arrows.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Tree.Menu.Settings.Items.Navigation.Arrows.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Tree.Menu.Settings.Items.Navigation.Arrows.Width, Tree.Menu.Settings.Items.Navigation.Arrows.Height)
                Tree.Menu.ItemOffset = Tree.Menu.ItemOffset + (Tree.Menu.Settings.Items.Navigation.Rectangle.Height * 2)
            end
        end
    end
end

---GoBack
---@return nil
---@public
function Tree.Menu.GoBack()
    local CurrentMenu = Tree.Menu.CurrentMenu
    if CurrentMenu ~= nil then
        local Audio = Tree.Menu.Settings.Audio
        Tree.Gui.Audio.PlaySound(Audio[Audio.Use].Back.audioName, Audio[Audio.Use].Back.audioRef)
        if CurrentMenu.Parent ~= nil then
            if CurrentMenu.Parent() then
                Tree.Menu.NextMenu = CurrentMenu.Parent
            else
                Tree.Menu.NextMenu = nil
                Tree.Menu.Visible(CurrentMenu, false)
            end
        else
            Tree.Menu.NextMenu = nil
            Tree.Menu.Visible(CurrentMenu, false)
        end
    end
end

---@class Enum
local enums = {
    __index = function(table, key)
        if rawget(table.enums, key) then
            return key
        end
    end
}

---Enum
---@param t table
---@return Enum
function Tree.Menu.Enum(t)
    local e = { enums = t }
    return setmetatable(e, enums)
end

Tree.Menu.BadgeStyle = {
    -- DEFAULT BADGE
    None = function()
        return {
            BadgeTexture = "",
            BadgeDictionary = "commonmenu"
        }
    end,
    BronzeMedal = function()
        return {
            BadgeTexture = "mp_medal_bronze",
        }
    end,
    GoldMedal = function()
        return {
            BadgeTexture = "mp_medal_gold",
        }
    end,
    SilverMedal = function()
        return {
            BadgeTexture = "medal_silver",
        }
    end,
    Alert = function()
        return {
            BadgeTexture = "mp_alerttriangle",
        }
    end,
    Crown = function(Selected)
        return {
            BadgeTexture = "mp_hostcrown",
            BadgeColour = Selected and { R = 0, G = 0, B = 0, A = 255 } or { R = 255, G = 255, B = 255, A = 255 }
        }
    end,
    Ammo = function(Selected)
        return {
            BadgeTexture = Selected and "shop_ammo_icon_b" or "shop_ammo_icon_a",
        }
    end,
    Armour = function(Selected)
        return {
            BadgeTexture = Selected and "shop_armour_icon_b" or "shop_armour_icon_a",
        }
    end,
    Barber = function(Selected)
        return {
            BadgeTexture = Selected and "shop_barber_icon_b" or "shop_barber_icon_a",
        }
    end,
    Clothes = function(Selected)
        return {
            BadgeTexture = Selected and "shop_clothing_icon_b" or "shop_clothing_icon_a",
        }
    end,
    Franklin = function(Selected)
        return {
            BadgeTexture = Selected and "shop_franklin_icon_b" or "shop_franklin_icon_a",
        }
    end,
    Bike = function(Selected)
        return {
            BadgeTexture = Selected and "shop_garage_bike_icon_b" or "shop_garage_bike_icon_a",
        }
    end,
    Car = function(Selected)
        return {
            BadgeTexture = Selected and "shop_garage_icon_b" or "shop_garage_icon_a",
        }
    end,
    Boat = function(Selected)
        return {
            BadgeTexture = Selected and "mp_specitem_boat_black" or "mp_specitem_boat",
            BadgeDictionary = "mpinventory"
        }
    end,
    Heli = function(Selected)
        return {
            BadgeTexture = Selected and "mp_specitem_heli_black" or "mp_specitem_heli",
            BadgeDictionary = "mpinventory"
        }
    end,
    Plane = function(Selected)
        return {
            BadgeTexture = Selected and "mp_specitem_plane_black" or "mp_specitem_plane",
            BadgeDictionary = "mpinventory"
        }
    end,
    BoatPickup = function(Selected)
        return {
            BadgeTexture = Selected and "mp_specitem_boatpickup_black" or "mp_specitem_boatpickup",
            BadgeDictionary = "mpinventory"
        }
    end,
    Card = function(Selected)
        return {
            BadgeTexture = Selected and "mp_specitem_keycard_black" or "mp_specitem_keycard",
            BadgeDictionary = "mpinventory"
        }
    end,
    Gun = function(Selected)
        return {
            BadgeTexture = Selected and "shop_gunclub_icon_b" or "shop_gunclub_icon_a",
        }
    end,
    Heart = function(Selected)
        return {
            BadgeTexture = Selected and "shop_health_icon_b" or "shop_health_icon_a",
        }
    end,
    Makeup = function(Selected)
        return {
            BadgeTexture = Selected and "shop_makeup_icon_b" or "shop_makeup_icon_a",
        }
    end,
    Mask = function(Selected)
        return {
            BadgeTexture = Selected and "shop_mask_icon_b" or "shop_mask_icon_a",
        }
    end,
    Michael = function(Selected)
        return {
            BadgeTexture = Selected and "shop_michael_icon_b" or "shop_michael_icon_a",
        }
    end,
    Star = function()
        return {
            BadgeTexture = "shop_new_star",
        }
    end,
    Tattoo = function(Selected)
        return {
            BadgeTexture = Selected and "shop_tattoos_icon_b" or "shop_tattoos_icon_a",
        }
    end,
    Trevor = function(Selected)
        return {
            BadgeTexture = Selected and "shop_trevor_icon_b" or "shop_trevor_icon_a",
        }
    end,
    Lock = function(Selected)
        return {
            BadgeTexture = "shop_lock",
            BadgeColour = Selected and { R = 0, G = 0, B = 0, A = 255 } or { R = 255, G = 255, B = 255, A = 255 }
        }
    end,
    Tick = function(Selected)
        return {
            BadgeTexture = "shop_tick_icon",
            BadgeColour = Selected and { R = 0, G = 0, B = 0, A = 255 } or { R = 255, G = 255, B = 255, A = 255 }
        }
    end,
    Key = function(Selected)
        return {
            BadgeTexture = Selected and "mp_specitem_cuffkeys_black" or "mp_specitem_cuffkeys",
            BadgeDictionary = "mpinventory"
        }
    end,
    Coke = function(Selected)
        return {
            BadgeTexture = Selected and "mp_specitem_coke_black" or "mp_specitem_coke",
            BadgeDictionary = "mpinventory"
        }
    end,
    Heroin = function(Selected)
        return {
            BadgeTexture = Selected and "mp_specitem_heroin_black" or "mp_specitem_heroin",
            BadgeDictionary = "mpinventory"
        }
    end,
    Meth = function(Selected)
        return {
            BadgeTexture = Selected and "mp_specitem_meth_black" or "mp_specitem_meth",
            BadgeDictionary = "mpinventory"
        }
    end,
    Weed = function(Selected)
        return {
            BadgeTexture = Selected and "mp_specitem_weed_black" or "mp_specitem_weed",
            BadgeDictionary = "mpinventory"
        }
    end,
    Package = function(Selected)
        return {
            BadgeTexture = Selected and "mp_specitem_package_black" or "mp_specitem_package",
            BadgeDictionary = "mpinventory"
        }
    end,
    Cash = function(Selected)
        return {
            BadgeTexture = Selected and "mp_specitem_cash_black" or "mp_specitem_cash",
            BadgeDictionary = "mpinventory"
        }
    end,
    RP = function(Selected)
        return {
            BadgeTexture = "mp_anim_rp",
            BadgeDictionary = "mphud"
        }
    end,
    LSPD = function()
        return {
            BadgeTexture = "mpgroundlogo_cops",
            BadgeDictionary = "3dtextures"
        }
    end,
    Vagos = function()
        return {
            BadgeTexture = "mpgroundlogo_vagos",
            BadgeDictionary = "3dtextures"
        }
    end,
    Bikers = function()
        return {
            BadgeTexture = "mpgroundlogo_bikers",
            BadgeDictionary = "3dtextures"
        }
    end,

    -- CASINO
    Badbeat = function()
        return {
            BadgeTexture = "badbeat",
            BadgeDictionary = "mpawardcasino"
        }
    end,
    CashingOut = function()
        return {
            BadgeTexture = "cashingout",
            BadgeDictionary = "mpawardcasino"
        }
    end,
    FullHouse = function()
        return {
            BadgeTexture = "fullhouse",
            BadgeDictionary = "mpawardcasino"
        }
    end,
    HighRoller = function()
        return {
            BadgeTexture = "highroller",
            BadgeDictionary = "mpawardcasino"
        }
    end,
    HouseKeeping = function()
        return {
            BadgeTexture = "housekeeping",
            BadgeDictionary = "mpawardcasino"
        }
    end,
    LooseCheng = function()
        return {
            BadgeTexture = "loosecheng",
            BadgeDictionary = "mpawardcasino"
        }
    end,
    LuckyLucky = function()
        return {
            BadgeTexture = "luckylucky",
            BadgeDictionary = "mpawardcasino"
        }
    end,
    PlayToWin = function()
        return {
            BadgeTexture = "playtowin",
            BadgeDictionary = "mpawardcasino"
        }
    end,
    StraightFlush = function()
        return {
            BadgeTexture = "straightflush",
            BadgeDictionary = "mpawardcasino"
        }
    end,
    StrongArmTactics = function()
        return {
            BadgeTexture = "strongarmtactics",
            BadgeDictionary = "mpawardcasino"
        }
    end,
    TopPair = function()
        return {
            BadgeTexture = "toppair",
            BadgeDictionary = "mpawardcasino"
        }
    end,
}

Tree.Menu.ItemsColour = {
    PureWhite = { 255, 255, 255, 255 },
    White = { 240, 240, 240, 255 },
    Black = { 0, 0, 0, 255 },
    Grey = { 155, 155, 155, 255 },
    GreyLight = { 205, 205, 205, 255 },
    GreyDark = { 77, 77, 77, 255 },
    Red = { 224, 50, 50, 255 },
    RedLight = { 240, 153, 153, 255 },
    RedDark = { 112, 25, 25, 255 },
    Blue = { 93, 182, 229, 255 },
    BlueLight = { 174, 219, 242, 255 },
    BlueDark = { 47, 92, 115, 255 },
    Yellow = { 240, 200, 80, 255 },
    YellowLight = { 254, 235, 169, 255 },
    YellowDark = { 126, 107, 41, 255 },
    Orange = { 255, 133, 85, 255 },
    OrangeLight = { 255, 194, 170, 255 },
    OrangeDark = { 127, 66, 42, 255 },
    Green = { 114, 204, 114, 255 },
    GreenLight = { 185, 230, 185, 255 },
    GreenDark = { 57, 102, 57, 255 },
    Purple = { 132, 102, 226, 255 },
    PurpleLight = { 192, 179, 239, 255 },
    PurpleDark = { 67, 57, 111, 255 },
    Pink = { 203, 54, 148, 255 },
    RadarHealth = { 53, 154, 71, 255 },
    RadarArmour = { 93, 182, 229, 255 },
    RadarDamage = { 235, 36, 39, 255 },
    NetPlayer1 = { 194, 80, 80, 255 },
    NetPlayer2 = { 156, 110, 175, 255 },
    NetPlayer3 = { 255, 123, 196, 255 },
    NetPlayer4 = { 247, 159, 123, 255 },
    NetPlayer5 = { 178, 144, 132, 255 },
    NetPlayer6 = { 141, 206, 167, 255 },
    NetPlayer7 = { 113, 169, 175, 255 },
    NetPlayer8 = { 211, 209, 231, 255 },
    NetPlayer9 = { 144, 127, 153, 255 },
    NetPlayer10 = { 106, 196, 191, 255 },
    NetPlayer11 = { 214, 196, 153, 255 },
    NetPlayer12 = { 234, 142, 80, 255 },
    NetPlayer13 = { 152, 203, 234, 255 },
    NetPlayer14 = { 178, 98, 135, 255 },
    NetPlayer15 = { 144, 142, 122, 255 },
    NetPlayer16 = { 166, 117, 94, 255 },
    NetPlayer17 = { 175, 168, 168, 255 },
    NetPlayer18 = { 232, 142, 155, 255 },
    NetPlayer19 = { 187, 214, 91, 255 },
    NetPlayer20 = { 12, 123, 86, 255 },
    NetPlayer21 = { 123, 196, 255, 255 },
    NetPlayer22 = { 171, 60, 230, 255 },
    NetPlayer23 = { 206, 169, 13, 255 },
    NetPlayer24 = { 71, 99, 173, 255 },
    NetPlayer25 = { 42, 166, 185, 255 },
    NetPlayer26 = { 186, 157, 125, 255 },
    NetPlayer27 = { 201, 225, 255, 255 },
    NetPlayer28 = { 240, 240, 150, 255 },
    NetPlayer29 = { 237, 140, 161, 255 },
    NetPlayer30 = { 249, 138, 138, 255 },
    NetPlayer31 = { 252, 239, 166, 255 },
    NetPlayer32 = { 240, 240, 240, 255 },
    SimpleBlipDefault = { 159, 201, 166, 255 },
    MenuBlue = { 140, 140, 140, 255 },
    MenuGreyLight = { 140, 140, 140, 255 },
    MenuBlueExtraDark = { 40, 40, 40, 255 },
    MenuYellow = { 240, 160, 0, 255 },
    MenuYellowDark = { 240, 160, 0, 255 },
    MenuGreen = { 240, 160, 0, 255 },
    MenuGrey = { 140, 140, 140, 255 },
    MenuGreyDark = { 60, 60, 60, 255 },
    MenuHighlight = { 30, 30, 30, 255 },
    MenuStandard = { 140, 140, 140, 255 },
    MenuDimmed = { 75, 75, 75, 255 },
    MenuExtraDimmed = { 50, 50, 50, 255 },
    BriefTitle = { 95, 95, 95, 255 },
    MidGreyMp = { 100, 100, 100, 255 },
    NetPlayer1Dark = { 93, 39, 39, 255 },
    NetPlayer2Dark = { 77, 55, 89, 255 },
    NetPlayer3Dark = { 124, 62, 99, 255 },
    NetPlayer4Dark = { 120, 80, 80, 255 },
    NetPlayer5Dark = { 87, 72, 66, 255 },
    NetPlayer6Dark = { 74, 103, 83, 255 },
    NetPlayer7Dark = { 60, 85, 88, 255 },
    NetPlayer8Dark = { 105, 105, 64, 255 },
    NetPlayer9Dark = { 72, 63, 76, 255 },
    NetPlayer10Dark = { 53, 98, 95, 255 },
    NetPlayer11Dark = { 107, 98, 76, 255 },
    NetPlayer12Dark = { 117, 71, 40, 255 },
    NetPlayer13Dark = { 76, 101, 117, 255 },
    NetPlayer14Dark = { 65, 35, 47, 255 },
    NetPlayer15Dark = { 72, 71, 61, 255 },
    NetPlayer16Dark = { 85, 58, 47, 255 },
    NetPlayer17Dark = { 87, 84, 84, 255 },
    NetPlayer18Dark = { 116, 71, 77, 255 },
    NetPlayer19Dark = { 93, 107, 45, 255 },
    NetPlayer20Dark = { 6, 61, 43, 255 },
    NetPlayer21Dark = { 61, 98, 127, 255 },
    NetPlayer22Dark = { 85, 30, 115, 255 },
    NetPlayer23Dark = { 103, 84, 6, 255 },
    NetPlayer24Dark = { 35, 49, 86, 255 },
    NetPlayer25Dark = { 21, 83, 92, 255 },
    NetPlayer26Dark = { 93, 98, 62, 255 },
    NetPlayer27Dark = { 100, 112, 127, 255 },
    NetPlayer28Dark = { 120, 120, 75, 255 },
    NetPlayer29Dark = { 152, 76, 93, 255 },
    NetPlayer30Dark = { 124, 69, 69, 255 },
    NetPlayer31Dark = { 10, 43, 50, 255 },
    NetPlayer32Dark = { 95, 95, 10, 255 },
    Bronze = { 180, 130, 97, 255 },
    Silver = { 150, 153, 161, 255 },
    Gold = { 214, 181, 99, 255 },
    Platinum = { 166, 221, 190, 255 },
    Gang1 = { 29, 100, 153, 255 },
    Gang2 = { 214, 116, 15, 255 },
    Gang3 = { 135, 125, 142, 255 },
    Gang4 = { 229, 119, 185, 255 },
    SameCrew = { 252, 239, 166, 255 },
    Freemode = { 45, 110, 185, 255 },
    PauseBg = { 0, 0, 0, 255 },
    Friendly = { 93, 182, 229, 255 },
    Enemy = { 194, 80, 80, 255 },
    Location = { 240, 200, 80, 255 },
    Pickup = { 114, 204, 114, 255 },
    PauseSingleplayer = { 114, 204, 114, 255 },
    FreemodeDark = { 22, 55, 92, 255 },
    InactiveMission = { 154, 154, 154, 255 },
    Damage = { 194, 80, 80, 255 },
    PinkLight = { 252, 115, 201, 255 },
    PmMitemHighlight = { 252, 177, 49, 255 },
    ScriptVariable = { 0, 0, 0, 255 },
    Yoga = { 109, 247, 204, 255 },
    Tennis = { 241, 101, 34, 255 },
    Golf = { 214, 189, 97, 255 },
    ShootingRange = { 112, 25, 25, 255 },
    FlightSchool = { 47, 92, 115, 255 },
    NorthBlue = { 93, 182, 229, 255 },
    SocialClub = { 234, 153, 28, 255 },
    PlatformBlue = { 11, 55, 123, 255 },
    PlatformGreen = { 146, 200, 62, 255 },
    PlatformGrey = { 234, 153, 28, 255 },
    FacebookBlue = { 66, 89, 148, 255 },
    IngameBg = { 0, 0, 0, 255 },
    Darts = { 114, 204, 114, 255 },
    Waypoint = { 164, 76, 242, 255 },
    Michael = { 101, 180, 212, 255 },
    Franklin = { 171, 237, 171, 255 },
    Trevor = { 255, 163, 87, 255 },
    GolfP1 = { 240, 240, 240, 255 },
    GolfP2 = { 235, 239, 30, 255 },
    GolfP3 = { 255, 149, 14, 255 },
    GolfP4 = { 246, 60, 161, 255 },
    WaypointLight = { 210, 166, 249, 255 },
    WaypointDark = { 82, 38, 121, 255 },
    PanelLight = { 0, 0, 0, 255 },
    MichaelDark = { 72, 103, 116, 255 },
    FranklinDark = { 85, 118, 85, 255 },
    TrevorDark = { 127, 81, 43, 255 },
    ObjectiveRoute = { 240, 200, 80, 255 },
    PausemapTint = { 0, 0, 0, 255 },
    PauseDeselect = { 100, 100, 100, 255 },
    PmWeaponsPurchasable = { 45, 110, 185, 255 },
    PmWeaponsLocked = { 240, 240, 240, 255 },
    ScreenBg = { 0, 0, 0, 255 },
    Chop = { 224, 50, 50, 255 },
    PausemapTintHalf = { 0, 0, 0, 255 },
    NorthBlueOfficial = { 0, 71, 133, 255 },
    ScriptVariable2 = { 0, 0, 0, 255 },
    H = { 33, 118, 37, 255 },
    HDark = { 37, 102, 40, 255 },
    T = { 234, 153, 28, 255 },
    TDark = { 225, 140, 8, 255 },
    HShard = { 20, 40, 0, 255 },
    ControllerMichael = { 48, 255, 255, 255 },
    ControllerFranklin = { 48, 255, 0, 255 },
    ControllerTrevor = { 176, 80, 0, 255 },
    ControllerChop = { 127, 0, 0, 255 },
    VideoEditorVideo = { 53, 166, 224, 255 },
    VideoEditorAudio = { 162, 79, 157, 255 },
    VideoEditorText = { 104, 192, 141, 255 },
    HbBlue = { 29, 100, 153, 255 },
    HbYellow = { 234, 153, 28, 255 },
    VideoEditorScore = { 240, 160, 1, 255 },
    VideoEditorAudioFadeout = { 59, 34, 57, 255 },
    VideoEditorTextFadeout = { 41, 68, 53, 255 },
    VideoEditorScoreFadeout = { 82, 58, 10, 255 },
    HeistBackground = { 37, 102, 40, 255 },
    VideoEditorAmbient = { 240, 200, 80, 255 },
    VideoEditorAmbientFadeout = { 80, 70, 34, 255 },
    Gb = { 255, 133, 85, 255 },
    G = { 255, 194, 170, 255 },
    B = { 255, 133, 85, 255 },
    LowFlow = { 240, 200, 80, 255 },
    LowFlowDark = { 126, 107, 41, 255 },
    G1 = { 247, 159, 123, 255 },
    G2 = { 226, 134, 187, 255 },
    G3 = { 239, 238, 151, 255 },
    G4 = { 113, 169, 175, 255 },
    G5 = { 160, 140, 193, 255 },
    G6 = { 141, 206, 167, 255 },
    G7 = { 181, 214, 234, 255 },
    G8 = { 178, 144, 132, 255 },
    G9 = { 0, 132, 114, 255 },
    G10 = { 216, 85, 117, 255 },
    G11 = { 30, 100, 152, 255 },
    G12 = { 43, 181, 117, 255 },
    G13 = { 233, 141, 79, 255 },
    G14 = { 137, 210, 215, 255 },
    G15 = { 134, 125, 141, 255 },
    Adversary = { 109, 34, 33, 255 },
    DegenRed = { 255, 0, 0, 255 },
    DegenYellow = { 255, 255, 0, 255 },
    DegenGreen = { 0, 255, 0, 255 },
    DegenCyan = { 0, 255, 255, 255 },
    DegenBlue = { 0, 0, 255, 255 },
    DegenMagenta = { 255, 0, 255, 255 },
    Stunt1 = { 38, 136, 234, 255 },
    Stunt2 = { 224, 50, 50, 255 },
}

Tree.Menu.PanelColour = {
    HairCut = {
        { 28, 31, 33 }, -- 0
        { 39, 42, 44 }, -- 1
        { 49, 46, 44 }, -- 2
        { 53, 38, 28 }, -- 3
        { 75, 50, 31 }, -- 4
        { 92, 59, 36 }, -- 5
        { 109, 76, 53 }, -- 6
        { 107, 80, 59 }, -- 7
        { 118, 92, 69 }, -- 8
        { 127, 104, 78 }, -- 9
        { 153, 129, 93 }, -- 10
        { 167, 147, 105 }, -- 11
        { 175, 156, 112 }, -- 12
        { 187, 160, 99 }, -- 13
        { 214, 185, 123 }, -- 14
        { 218, 195, 142 }, -- 15
        { 159, 127, 89 }, -- 16
        { 132, 80, 57 }, -- 17
        { 104, 43, 31 }, -- 18
        { 97, 18, 12 }, -- 19
        { 100, 15, 10 }, -- 20
        { 124, 20, 15 }, -- 21
        { 160, 46, 25 }, -- 22
        { 182, 75, 40 }, -- 23
        { 162, 80, 47 }, -- 24
        { 170, 78, 43 }, -- 25
        { 98, 98, 98 }, -- 26
        { 128, 128, 128}, -- 27
        { 170, 170, 170 }, -- 28
        { 197, 197, 197 }, -- 29
        { 70, 57, 85 }, -- 30
        { 90, 63, 107 }, -- 31
        { 118, 60, 118 }, -- 32
        { 237, 116, 227 }, -- 33
        { 235, 75, 147 }, -- 34
        { 242, 153, 188 }, -- 35
        { 4, 149, 158 }, -- 36
        { 2, 95, 134 }, -- 37
        { 2, 57, 116 }, -- 38
        { 63, 161, 106 }, -- 39
        { 33, 124, 97 }, -- 40
        { 24, 92, 85 }, -- 41
        { 182, 192, 52 }, -- 42
        { 112, 169, 11 }, -- 43
        { 67, 157, 19 }, -- 44
        { 220, 184, 87 }, -- 45
        { 229, 177, 3 }, -- 46
        { 230, 145, 2 }, -- 47
        { 242, 136, 49 }, -- 48
        { 251, 128, 87 }, -- 49
        { 226, 139, 88 }, -- 50
        { 209, 89, 60 }, -- 51
        { 206, 49, 32 }, -- 52
        { 173, 9, 3 }, -- 53
        { 136, 3, 2 }, -- 54
        { 31, 24, 20 }, -- 55
        { 41, 31, 25 }, -- 56
        { 46, 34, 27 }, -- 57
        { 55, 41, 30 }, -- 58
        { 46, 34, 24 }, -- 59
        { 35, 27, 21 }, -- 60
        { 2, 2, 2 }, -- 61
        { 112, 108, 102 }, -- 62
        { 157, 122, 80 } -- 63
    },
    MakeUp = {
        { 153, 37, 50 }, -- 0
        { 200, 57, 93 }, -- 1
        { 189, 81, 108 }, -- 2
        { 184, 99, 122 }, -- 3
        { 166, 82, 107 }, -- 4
        { 177, 67, 76 }, -- 5
        { 127, 49, 51 }, -- 6
        { 164, 100, 93 }, -- 7
        { 193, 135, 121 }, -- 8
        { 203, 160, 150 }, -- 9
        { 198, 145, 143 }, -- 10
        { 171, 111, 99}, -- 11
        { 176, 96, 80 }, -- 12
        { 168, 76, 51 }, -- 13
        { 180, 113, 120 }, -- 14
        { 202, 127, 146 }, -- 15
        { 237, 156, 190 }, -- 16
        { 231, 117, 164 }, -- 17
        { 222, 62, 129 }, -- 18
        { 179, 76, 110 }, -- 19
        { 113, 39, 57 }, -- 20
        { 79, 31, 42 }, -- 21
        { 170, 34, 47 }, -- 22
        { 222, 32, 52 }, -- 23
        { 207, 8, 19 }, -- 24
        { 229, 84, 112 }, -- 25
        { 220, 63, 181 }, -- 26
        { 192, 39, 178 }, -- 27
        { 160, 28, 169 }, -- 28
        { 110, 24, 117 }, -- 29
        { 115, 20, 101 }, -- 30
        { 86, 22, 92 }, -- 31
        { 109, 26, 157 }, -- 32
        { 27, 55, 113 }, -- 33
        { 29, 78, 167 }, -- 34
        { 30, 116, 187 }, -- 35
        { 33, 163, 206 }, -- 36
        { 37, 194, 210 }, -- 37
        { 35, 204, 165 }, -- 38
        { 39, 192, 125 }, -- 39
        { 27, 156, 50 }, -- 40
        { 20, 134, 4 }, -- 41
        { 112, 208, 65 }, -- 42
        { 197, 234, 52 }, -- 43
        { 225, 227, 47 }, -- 44
        { 255, 221, 38 }, -- 45
        { 250, 192, 38 }, -- 46
        { 247, 138, 39 }, -- 47
        { 254, 89, 16 }, -- 48
        { 190, 110, 25 }, -- 49
        { 247, 201, 127 }, -- 50
        { 251, 229, 192 }, -- 51
        { 245, 245, 245 }, -- 52
        { 179, 180, 179 }, -- 53
        { 145, 145, 145 }, -- 54
        { 86, 78, 78 }, -- 55
        { 24, 14, 14 }, -- 56
        { 88, 150, 158 }, -- 57
        { 77, 111, 140 }, -- 58
        { 26, 43, 85 }, -- 59
        { 160, 126, 107 }, -- 60
        { 130, 99, 85 }, -- 61
        { 109, 83, 70 }, -- 62
        { 62, 45, 39 } -- 63
    }
}

---@type table
local SettingsButton = {
    Rectangle = { Y = 0, Width = 431, Height = 38 },
    Text = { X = 8, Y = 3, Scale = 0.33 },
    LeftBadge = { Y = -2, Width = 40, Height = 40 },
    RightBadge = { X = 385, Y = -2, Width = 40, Height = 40 },
    RightText = { X = 420, Y = 4, Scale = 0.35 },
    SelectedSprite = { Dictionary = "commonmenu", Texture = "gradient_nav", Y = 0, Width = 431, Height = 38 },
}

---ButtonWithStyle
---@param Label string
---@param Description string
---@param Style table
---@param Enabled boolean
---@param Callback function
---@param Submenu table
---@return nil
---@public
function Tree.Menu.Button(Label, Description, Style, Enabled, Action, Submenu)
    local CurrentMenu = Tree.Menu.CurrentMenu
    if CurrentMenu ~= nil and CurrentMenu() then
        ---@type number
        local Option = Tree.Menu.Options + 1

        if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
            ---@type boolean
            local Active = CurrentMenu.Index == Option

            Tree.Menu.ItemsSafeZone(CurrentMenu)

            local haveLeftBadge = Style.LeftBadge and Style.LeftBadge ~= Tree.Menu.BadgeStyle.None
            local haveRightBadge = (Style.RightBadge and Style.RightBadge ~= Tree.Menu.BadgeStyle.None) or (not Enabled and Style.LockBadge ~= Tree.Menu.BadgeStyle.None)
            local LeftBadgeOffset = haveLeftBadge and 27 or 0
            local RightBadgeOffset = haveRightBadge and 32 or 0
            if Style.Color and Style.Color.BackgroundColor then
                RenderRectangle(CurrentMenu.X, CurrentMenu.Y + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset, SettingsButton.SelectedSprite.Height, Style.Color.BackgroundColor[1], Style.Color.BackgroundColor[2], Style.Color.BackgroundColor[3], Style.Color.BackgroundColor[4])
            end
            if Active then
                if Style.Color and Style.Color.HightLightColor then
                    RenderRectangle(CurrentMenu.X, CurrentMenu.Y + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset, SettingsButton.SelectedSprite.Height, Style.Color.HightLightColor[1], Style.Color.HightLightColor[2], Style.Color.HightLightColor[3], Style.Color.HightLightColor[4])
                else
                    RenderSprite(SettingsButton.SelectedSprite.Dictionary, SettingsButton.SelectedSprite.Texture, CurrentMenu.X, CurrentMenu.Y + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset, SettingsButton.SelectedSprite.Height)
                end
            end
            if Enabled then
                if haveLeftBadge then
                    if (Style.LeftBadge ~= nil) then
                        local LeftBadge = Style.LeftBadge(Active)
                        RenderSprite(LeftBadge.BadgeDictionary or "commonmenu", LeftBadge.BadgeTexture or "", CurrentMenu.X, CurrentMenu.Y + SettingsButton.LeftBadge.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsButton.LeftBadge.Width, SettingsButton.LeftBadge.Height, 0, LeftBadge.BadgeColour and LeftBadge.BadgeColour.R or 255, LeftBadge.BadgeColour and LeftBadge.BadgeColour.G or 255, LeftBadge.BadgeColour and LeftBadge.BadgeColour.B or 255, LeftBadge.BadgeColour and LeftBadge.BadgeColour.A or 255)
                    end
                end
                if haveRightBadge then
                    if (Style.RightBadge ~= nil) then
                        local RightBadge = Style.RightBadge(Active)
                        RenderSprite(RightBadge.BadgeDictionary or "commonmenu", RightBadge.BadgeTexture or "", CurrentMenu.X + SettingsButton.RightBadge.X + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightBadge.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsButton.RightBadge.Width, SettingsButton.RightBadge.Height, 0, RightBadge.BadgeColour and RightBadge.BadgeColour.R or 255, RightBadge.BadgeColour and RightBadge.BadgeColour.G or 255, RightBadge.BadgeColour and RightBadge.BadgeColour.B or 255, RightBadge.BadgeColour and RightBadge.BadgeColour.A or 255)
                    end
                end
                if Style.RightLabel then
                    RenderText(Style.RightLabel, CurrentMenu.X + SettingsButton.RightText.X - RightBadgeOffset + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightText.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsButton.RightText.Scale, Active and 0 or 245, Active and 0 or 245, Active and 0 or 245, 255, 2)
                end
                RenderText(Label, CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsButton.Text.Scale, Active and 0 or 245, Active and 0 or 245, Active and 0 or 245, 255)
            else
                if haveRightBadge then
                    local RightBadge = Tree.Menu.BadgeStyle.Lock(Active)
                    RenderSprite(RightBadge.BadgeDictionary or "commonmenu", RightBadge.BadgeTexture or "", CurrentMenu.X + SettingsButton.RightBadge.X + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightBadge.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsButton.RightBadge.Width, SettingsButton.RightBadge.Height, 0, RightBadge.BadgeColour and RightBadge.BadgeColour.R or 255, RightBadge.BadgeColour and RightBadge.BadgeColour.G or 255, RightBadge.BadgeColour and RightBadge.BadgeColour.B or 255, RightBadge.BadgeColour and RightBadge.BadgeColour.A or 255)
                end

                RenderText(Label, CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsButton.Text.Scale, 163, 159, 148, 255)
            end
            Tree.Menu.ItemOffset = Tree.Menu.ItemOffset + SettingsButton.Rectangle.Height
            Tree.Menu.ItemsDescription(CurrentMenu, Description, Active);
            if Enabled then
                local Hovered = CurrentMenu.EnableMouse and (CurrentMenu.CursorStyle == 0 or CurrentMenu.CursorStyle == 1) and Tree.Menu.ItemsMouseBounds(CurrentMenu, Active, Option + 1, SettingsButton);
                local Selected = (CurrentMenu.Controls.Select.Active or (Hovered and CurrentMenu.Controls.Click.Active)) and Active
                if (Action.onHovered ~= nil) and Hovered then
                    Action.onHovered();
                end
                if (Action.onActive ~= nil) and Active then
                    Action.onActive();
                end
                if Selected then
                    local Audio = Tree.Menu.Settings.Audio
                    Tree.Gui.Audio.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef)
                    if (Action.onSelected ~= nil) then
                        Citizen.CreateThread(function()
                            Action.onSelected();
                        end)
                    end
                    if Submenu and Submenu() then
                        Tree.Menu.NextMenu = Submenu
                    end
                end
            end
        end
        Tree.Menu.Options = Tree.Menu.Options + 1
    end
end

---@type table
local SettingsButton = {
    Rectangle = { Y = 0, Width = 431, Height = 38 },
    Text = { X = 8, Y = 3, Scale = 0.33 },
    LeftBadge = { Y = -2, Width = 40, Height = 40 },
    RightBadge = { X = 385, Y = -2, Width = 40, Height = 40 },
    RightText = { X = 420, Y = 4, Scale = 0.35 },
    SelectedSprite = { Dictionary = "commonmenu", Texture = "gradient_nav", Y = 0, Width = 431, Height = 38 },
}

---@type table
local SettingsCheckbox = {
    Dictionary = "commonmenu", Textures = {
        "shop_box_blankb", -- 1
        "shop_box_tickb", -- 2
        "shop_box_blank", -- 3
        "shop_box_tick", -- 4
        "shop_box_crossb", -- 5
        "shop_box_cross", -- 6
    },
    X = 380, Y = -6, Width = 50, Height = 50
}

Tree.Menu.CheckboxStyle = {
    Tick = 1,
    Cross = 2
}

---StyleCheckBox
---@param Selected number
---@param Checked boolean
---@param Box number
---@param BoxSelect number
---@return nil
local function StyleCheckBox(Selected, Checked, Box, BoxSelect, OffSet)
    ---@type table
    local CurrentMenu = Tree.Menu.CurrentMenu;
    if OffSet == nil then
        OffSet = 0
    end
    if Selected then
        if Checked then
            RenderSprite(SettingsCheckbox.Dictionary, SettingsCheckbox.Textures[Box], CurrentMenu.X + SettingsCheckbox.X + CurrentMenu.WidthOffset - OffSet, CurrentMenu.Y + SettingsCheckbox.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsCheckbox.Width, SettingsCheckbox.Height)
        else
            RenderSprite(SettingsCheckbox.Dictionary, SettingsCheckbox.Textures[1], CurrentMenu.X + SettingsCheckbox.X + CurrentMenu.WidthOffset - OffSet, CurrentMenu.Y + SettingsCheckbox.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsCheckbox.Width, SettingsCheckbox.Height)
        end
    else
        if Checked then
            RenderSprite(SettingsCheckbox.Dictionary, SettingsCheckbox.Textures[BoxSelect], CurrentMenu.X + SettingsCheckbox.X + CurrentMenu.WidthOffset - OffSet, CurrentMenu.Y + SettingsCheckbox.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsCheckbox.Width, SettingsCheckbox.Height)
        else
            RenderSprite(SettingsCheckbox.Dictionary, SettingsCheckbox.Textures[3], CurrentMenu.X + SettingsCheckbox.X + CurrentMenu.WidthOffset - OffSet, CurrentMenu.Y + SettingsCheckbox.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsCheckbox.Width, SettingsCheckbox.Height)
        end
    end
end


function Tree.Menu.Checkbox(Label, Description, Checked, Style, Actions)
    ---@type table
    local CurrentMenu = Tree.Menu.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then

            ---@type number
            local Option = Tree.Menu.Options + 1
            if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
                ---@type number
                local Selected = CurrentMenu.Index == Option
                local LeftBadgeOffset = ((Style.LeftBadge == Tree.Menu.BadgeStyle.None or Style.LeftBadge == nil) and 0 or 27)
                local RightBadgeOffset = ((Style.RightBadge == Tree.Menu.BadgeStyle.None or Style.RightBadge == nil) and 0 or 32)
                local BoxOffset = 0
                Tree.Menu.ItemsSafeZone(CurrentMenu)

                local Hovered = false;

                ---@type boolean
                if CurrentMenu.EnableMouse == true and (CurrentMenu.CursorStyle == 0) or (CurrentMenu.CursorStyle == 1) then
                    Hovered = Tree.Menu.ItemsMouseBounds(CurrentMenu, Selected, Option, SettingsButton);
                end
                if Selected then
                    RenderSprite(SettingsButton.SelectedSprite.Dictionary, SettingsButton.SelectedSprite.Texture, CurrentMenu.X, CurrentMenu.Y + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset, SettingsButton.SelectedSprite.Height)
                end

                if type(Style) == "table" then
                    if Style.Enabled == true or Style.Enabled == nil then
                        if Selected then
                            RenderText(Label, CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsButton.Text.Scale, 0, 0, 0, 255)
                        else
                            RenderText(Label, CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsButton.Text.Scale, 245, 245, 245, 255)
                        end
                        if type(Style) == 'table' then
                            if Style.LeftBadge ~= nil then
                                if Style.LeftBadge ~= Tree.Menu.BadgeStyle.None then
                                    local BadgeData = Style.LeftBadge(Selected)
                                    RenderSprite(BadgeData.BadgeDictionary or "commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X, CurrentMenu.Y + SettingsButton.LeftBadge.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsButton.LeftBadge.Width, SettingsButton.LeftBadge.Height, 0, BadgeData.BadgeColour and BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.G or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.A or 255)
                                end
                            end
                            if Style.RightBadge ~= nil then
                                if Style.RightBadge ~= Tree.Menu.BadgeStyle.None then
                                    local BadgeData = Style.RightBadge(Selected)
                                    RenderSprite(BadgeData.BadgeDictionary or "commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X + SettingsButton.RightBadge.X + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightBadge.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsButton.RightBadge.Width, SettingsButton.RightBadge.Height, 0, BadgeData.BadgeColour and BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.G or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.A or 255)
                                end
                            end
                        end
                    else
                        ---@type table
                        local LeftBadge = Tree.Menu.BadgeStyle.Lock
                        ---@type number
                        local LeftBadgeOffset = ((LeftBadge == Tree.Menu.BadgeStyle.None or LeftBadge == nil) and 0 or 27)

                        if Selected then
                            RenderText(Label, CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsButton.Text.Scale, 0, 0, 0, 255)
                        else
                            RenderText(Label, CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsButton.Text.Scale, 163, 159, 148, 255)
                        end

                        if LeftBadge ~= Tree.Menu.BadgeStyle.None and LeftBadge ~= nil then
                            local BadgeData = LeftBadge(Selected)

                            RenderSprite(BadgeData.BadgeDictionary or "commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X, CurrentMenu.Y + SettingsButton.LeftBadge.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsButton.LeftBadge.Width, SettingsButton.LeftBadge.Height, 0, BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour.G or 255, BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour.A or 255)
                        end
                    end

                    if Style.Enabled == true or Style.Enabled == nil then
                        if Selected then
                            if Style.RightLabel ~= nil and Style.RightLabel ~= "" then

                                RenderText(Style.RightLabel, CurrentMenu.X + SettingsButton.RightText.X - RightBadgeOffset + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightText.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsButton.RightText.Scale, 0, 0, 0, 255, 2)
                                BoxOffset = MeasureStringWidth(Style.RightLabel, 0, 0.35)
                            end
                        else
                            if Style.RightLabel ~= nil and Style.RightLabel ~= "" then
                                RenderText(Style.RightLabel, CurrentMenu.X + SettingsButton.RightText.X - RightBadgeOffset + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightText.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsButton.RightText.Scale, 245, 245, 245, 255, 2)
                                BoxOffset = MeasureStringWidth(Style.RightLabel, 0, 0.35)
                            end
                        end
                    end

                    BoxOffset = RightBadgeOffset + BoxOffset
                    if Style.Style ~= nil then
                        if Style.Style == Tree.Menu.CheckboxStyle.Tick then
                            StyleCheckBox(Selected, Checked, 2, 4, BoxOffset)
                        elseif Style.Style == Tree.Menu.CheckboxStyle.Cross then
                            StyleCheckBox(Selected, Checked, 5, 6, BoxOffset)
                        else
                            StyleCheckBox(Selected, Checked, 2, 4, BoxOffset)
                        end
                    else
                        StyleCheckBox(Selected, Checked, 2, 4, BoxOffset)
                    end

                    if Selected and (CurrentMenu.Controls.Select.Active or (Hovered and CurrentMenu.Controls.Click.Active)) and (Style.Enabled == true or Style.Enabled == nil) then
                        local Audio = Tree.Menu.Settings.Audio
                        Tree.Gui.Audio.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef)
                        Checked = not Checked
                        if (Checked) then
                            if (Actions.onChecked ~= nil) then
                                Actions.onChecked();
                            end
                        else
                            if (Actions.onUnChecked ~= nil) then
                                Actions.onUnChecked();
                            end
                        end
                    end
                else
                    error("UICheckBox Style is not a `table`")
                end

                Tree.Menu.ItemOffset = Tree.Menu.ItemOffset + SettingsButton.Rectangle.Height

                Tree.Menu.ItemsDescription(CurrentMenu, Description, Selected)

                if (Actions.onSelected ~= nil) and (Selected) then
                    Actions.onSelected(Checked);
                end

            end
            Tree.Menu.Options = Tree.Menu.Options + 1
        end
    end
end

---@type table
local SettingsButton = {
    Rectangle = { Y = 0, Width = 431, Height = 38 },
    Text = { X = 8, Y = 3, Scale = 0.33 },
    LeftBadge = { Y = -2, Width = 40, Height = 40 },
    RightBadge = { X = 385, Y = -2, Width = 40, Height = 40 },
    RightText = { X = 420, Y = 4, Scale = 0.35 },
    SelectedSprite = { Dictionary = "commonmenu", Texture = "gradient_nav", Y = 0, Width = 431, Height = 38 },
}

---@type table
local SettingsList = {
    LeftArrow = { Dictionary = "commonmenu", Texture = "arrowleft", X = 378, Y = 3, Width = 30, Height = 30 },
    RightArrow = { Dictionary = "commonmenu", Texture = "arrowright", X = 400, Y = 3, Width = 30, Height = 30 },
    Text = { X = 403, Y = 3, Scale = 0.35 },
}

function Tree.Menu.List(Label, Items, Index, Description, Style, Enabled, Actions, Submenu)
    ---@type table
    local CurrentMenu = Tree.Menu.CurrentMenu;

    if CurrentMenu ~= nil then
        if CurrentMenu() then

            ---@type number
            local Option = Tree.Menu.Options + 1

            if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then

                ---@type number
                local Selected = CurrentMenu.Index == Option

                ---@type boolean
                local LeftArrowHovered, RightArrowHovered = false, false

                Tree.Menu.ItemsSafeZone(CurrentMenu)

                local Hovered = false;
                local LeftBadgeOffset = ((Style.LeftBadge == Tree.Menu.BadgeStyle.None or Style.LeftBadge == nil) and 0 or 27)
                local RightBadgeOffset = ((Style.RightBadge == Tree.Menu.BadgeStyle.None or Style.RightBadge == nil) and 0 or 32)
                local RightOffset = 0
                ---@type boolean
                if CurrentMenu.EnableMouse == true and (CurrentMenu.CursorStyle == 0) or (CurrentMenu.CursorStyle == 1) then
                    Hovered = Tree.Menu.ItemsMouseBounds(CurrentMenu, Selected, Option, SettingsButton);
                end
                local ListText = (type(Items[Index]) == "table") and string.format("← %s →", Items[Index].Name) or string.format("← %s →", Items[Index]) or "NIL"

                if Selected then
                    RenderSprite(SettingsButton.SelectedSprite.Dictionary, SettingsButton.SelectedSprite.Texture, CurrentMenu.X, CurrentMenu.Y + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset, SettingsButton.SelectedSprite.Height)
                end
                if Enabled == true or Enabled == nil then
                    if Selected then
                        if Style.RightLabel ~= nil and Style.RightLabel ~= "" then
                            RenderText(Style.RightLabel, CurrentMenu.X + SettingsButton.RightText.X - RightBadgeOffset + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightText.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsButton.RightText.Scale, 0, 0, 0, 255, 2)
                            RightOffset = MeasureStringWidth(Style.RightLabel, 0, 0.35)
                        end
                    else
                        if Style.RightLabel ~= nil and Style.RightLabel ~= "" then
                            RightOffset = MeasureStringWidth(Style.RightLabel, 0, 0.35)
                            RenderText(Style.RightLabel, CurrentMenu.X + SettingsButton.RightText.X - RightBadgeOffset + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightText.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsButton.RightText.Scale, 245, 245, 245, 255, 2)
                        end
                    end
                end
                RightOffset = RightBadgeOffset * 1.3 + RightOffset
                if Enabled == true or Enabled == nil then
                    if Selected then
                        RenderText(Label, CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsButton.Text.Scale, 0, 0, 0, 255)
                        RenderText(ListText, CurrentMenu.X + SettingsList.Text.X + 15 + CurrentMenu.WidthOffset - RightOffset, CurrentMenu.Y + SettingsList.Text.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsList.Text.Scale, 0, 0, 0, 255, 2)
                    else
                        RenderText(Label, CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsButton.Text.Scale, 245, 245, 245, 255)
                        RenderText(ListText, CurrentMenu.X + SettingsList.Text.X + 15 + CurrentMenu.WidthOffset - RightOffset, CurrentMenu.Y + SettingsList.Text.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsList.Text.Scale, 245, 245, 245, 255, 2)
                    end
                else
                    RenderText(Label, CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsButton.Text.Scale, 163, 159, 148, 255)
                    if Selected then
                        RenderText(ListText, CurrentMenu.X + SettingsList.Text.X + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsList.Text.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsList.Text.Scale, 163, 159, 148, 255, 2)
                    else
                        RenderText(ListText, CurrentMenu.X + SettingsList.Text.X + 15 + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsList.Text.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsList.Text.Scale, 163, 159, 148, 255, 2)
                    end
                end

                if type(Style) == "table" then
                    if Style.Enabled == true or Style.Enabled == nil then
                        if type(Style) == 'table' then
                            if Style.LeftBadge ~= nil then
                                if Style.LeftBadge ~= Tree.Menu.BadgeStyle.None then
                                    local BadgeData = Style.LeftBadge(Selected)

                                    RenderSprite(BadgeData.BadgeDictionary or "commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X, CurrentMenu.Y + SettingsButton.LeftBadge.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsButton.LeftBadge.Width, SettingsButton.LeftBadge.Height, 0, BadgeData.BadgeColour and BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.G or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.A or 255)
                                end
                            end

                            if Style.RightBadge ~= nil then
                                if Style.RightBadge ~= Tree.Menu.BadgeStyle.None then
                                    local BadgeData = Style.RightBadge(Selected)

                                    RenderSprite(BadgeData.BadgeDictionary or "commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X + SettingsButton.RightBadge.X + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightBadge.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsButton.RightBadge.Width, SettingsButton.RightBadge.Height, 0, BadgeData.BadgeColour and BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.G or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.A or 255)
                                end
                            end
                        end
                    else
                        ---@type table
                        local LeftBadge = Tree.Menu.BadgeStyle.Lock
                        ---@type number
                        if LeftBadge ~= Tree.Menu.BadgeStyle.None and LeftBadge ~= nil then
                            local BadgeData = LeftBadge(Selected)

                            RenderSprite(BadgeData.BadgeDictionary or "commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X, CurrentMenu.Y + SettingsButton.LeftBadge.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsButton.LeftBadge.Width, SettingsButton.LeftBadge.Height, 0, BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour.G or 255, BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour.A or 255)
                        end
                    end
                else
                    error("UICheckBox Style is not a `table`")
                end

                LeftArrowHovered = Tree.Menu.IsMouseInBounds(CurrentMenu.X + SettingsList.Text.X + CurrentMenu.WidthOffset - RightOffset + CurrentMenu.SafeZoneSize.X, CurrentMenu.Y + SettingsList.Text.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset + 2.5  + CurrentMenu.SafeZoneSize.Y , 15, 22.5)

                RightArrowHovered = Tree.Menu.IsMouseInBounds(CurrentMenu.X + SettingsList.Text.X + CurrentMenu.WidthOffset + CurrentMenu.SafeZoneSize.X - RightOffset - MeasureStringWidth(ListText, 0, SettingsList.Text.Scale), CurrentMenu.Y + SettingsList.Text.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset + 2.5 + CurrentMenu.SafeZoneSize.Y , 15, 22.5)
                Tree.Menu.ItemOffset = Tree.Menu.ItemOffset + SettingsButton.Rectangle.Height

                Tree.Menu.ItemsDescription(CurrentMenu, Description, Selected);

                if Selected and (CurrentMenu.Controls.Left.Active or (CurrentMenu.Controls.Click.Active and LeftArrowHovered)) and not (CurrentMenu.Controls.Right.Active or (CurrentMenu.Controls.Click.Active and RightArrowHovered)) then
                    Index = Index - 1
                    if Index < 1 then
                        Index = #Items
                    end
                    if (Actions.onListChange ~= nil) then
                        Actions.onListChange(Index, Items[Index]);
                    end
                    local Audio = Tree.Menu.Settings.Audio
                    Tree.Gui.Audio.PlaySound(Audio[Audio.Use].LeftRight.audioName, Audio[Audio.Use].LeftRight.audioRef)
                elseif Selected and (CurrentMenu.Controls.Right.Active or (CurrentMenu.Controls.Click.Active and RightArrowHovered)) and not (CurrentMenu.Controls.Left.Active or (CurrentMenu.Controls.Click.Active and LeftArrowHovered)) then
                    Index = Index + 1
                    if Index > #Items then
                        Index = 1
                    end
                    if (Actions.onListChange ~= nil) then
                        Actions.onListChange(Index, Items[Index]);
                    end
                    local Audio = Tree.Menu.Settings.Audio
                    Tree.Gui.Audio.PlaySound(Audio[Audio.Use].LeftRight.audioName, Audio[Audio.Use].LeftRight.audioRef)
                end

                if Selected and (CurrentMenu.Controls.Select.Active or ((Hovered and CurrentMenu.Controls.Click.Active) and (not LeftArrowHovered and not RightArrowHovered))) then
                    local Audio = Tree.Menu.Settings.Audio
                    Tree.Gui.Audio.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef)

                    if (Actions.onSelected ~= nil) then
                        Actions.onSelected(Index, Items[Index]);
                    end

                    if Submenu ~= nil and type(Submenu) == "table" then
                        Tree.Menu.NextMenu = Submenu[Index]
                    end
                elseif Selected then
                    if(Actions.onActive ~= nil) then
                        Actions.onActive()
                    end 
                end
            end

            Tree.Menu.Options = Tree.Menu.Options + 1
        end
    end
end



---@type table
local SettingsButton = {
    Rectangle = { Y = 0, Width = 431, Height = 38 },
    Text = { X = 8, Y = 3, Scale = 0.33 },
}

function Tree.Menu.Separator(Label)
    local CurrentMenu = Tree.Menu.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            local Option = Tree.Menu.Options + 1
            if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
                if (Label ~= nil) then
                    RenderText(Label, CurrentMenu.X + SettingsButton.Text.X + (CurrentMenu.WidthOffset * 2.5 ~= 0 and CurrentMenu.WidthOffset * 2.5 or 200), CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsButton.Text.Scale, 245, 245, 245, 255, 1)
                end
                Tree.Menu.ItemOffset = Tree.Menu.ItemOffset + SettingsButton.Rectangle.Height
                if (CurrentMenu.Index == Option) then
                    if (Tree.Menu.LastControl) then
                        CurrentMenu.Index = Option - 1
                        if (CurrentMenu.Index < 1) then
                            CurrentMenu.Index = Tree.Menu.CurrentMenu.Options
                        end
                    else
                        CurrentMenu.Index = Option + 1
                    end
                end
            end
            Tree.Menu.Options = Tree.Menu.Options + 1
        end
    end
end

---@type table
local SettingsButton = {
    Rectangle = { Y = 0, Width = 431, Height = 38 },
    Text = { X = 8, Y = 3, Scale = 0.33 },
    LeftBadge = { Y = -2, Width = 40, Height = 40 },
    RightBadge = { X = 385, Y = -2, Width = 40, Height = 40 },
    RightText = { X = 420, Y = 4, Scale = 0.35 },
    SelectedSprite = { Dictionary = "commonmenu", Texture = "gradient_nav", Y = 0, Width = 431, Height = 38 },
}

---@type table
local SettingsSlider = {
    Background = { X = 250, Y = 14.5, Width = 150, Height = 9 },
    Slider = { X = 250, Y = 14.5, Width = 75, Height = 9 },
    Divider = { X = 323.5, Y = 9, Width = 2.5, Height = 20 },
    LeftArrow = { Dictionary = "commonmenu", Texture = "arrowleft", X = 235, Y = 11.5, Width = 15, Height = 15 },
    RightArrow = { Dictionary = "commonmenu", Texture = "arrowright", X = 400, Y = 11.5, Width = 15, Height = 15 },
}

function Tree.Menu.Slider(Label, ProgressStart, ProgressMax, Description, Divider, Style, Enabled, Actions)

    ---@type table
    local CurrentMenu = Tree.Menu.CurrentMenu;
    local Audio = Tree.Menu.Settings.Audio
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            local Items = {}
            for i = 1, ProgressMax do
                table.insert(Items, i)
            end
            ---@type number
            local Option = Tree.Menu.Options + 1

            if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then

                ---@type number
                local Selected = CurrentMenu.Index == Option

                ---@type boolean
                local LeftArrowHovered, RightArrowHovered = false, false

                Tree.Menu.ItemsSafeZone(CurrentMenu)

                local Hovered = false;
                local LeftBadgeOffset = ((Style.LeftBadge == Tree.Menu.BadgeStyle.None or Style.LeftBadge == nil) and 0 or 27)
                local RightBadgeOffset = ((Style.RightBadge == Tree.Menu.BadgeStyle.None or Style.RightBadge == nil) and 0 or 32)
                local RightOffset = 0
                ---@type boolean
                if CurrentMenu.EnableMouse == true and (CurrentMenu.CursorStyle == 0) or (CurrentMenu.CursorStyle == 1) then
                    Hovered = Tree.Menu.ItemsMouseBounds(CurrentMenu, Selected, Option, SettingsButton);
                end

                if Selected then
                    RenderSprite(SettingsButton.SelectedSprite.Dictionary, SettingsButton.SelectedSprite.Texture, CurrentMenu.X, CurrentMenu.Y + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset, SettingsButton.SelectedSprite.Height)
                    LeftArrowHovered = Tree.Menu.IsMouseInBounds(CurrentMenu.X + SettingsSlider.LeftArrow.X + CurrentMenu.SafeZoneSize.X + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsSlider.LeftArrow.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsSlider.LeftArrow.Width, SettingsSlider.LeftArrow.Height)
                    RightArrowHovered = Tree.Menu.IsMouseInBounds(CurrentMenu.X + SettingsSlider.RightArrow.X + CurrentMenu.SafeZoneSize.X + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsSlider.RightArrow.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsSlider.RightArrow.Width, SettingsSlider.RightArrow.Height)
                end
                if Enabled == true or Enabled == nil then
                    if Selected then
                        if Style.RightLabel ~= nil and Style.RightLabel ~= "" then
                            RenderText(Style.RightLabel, CurrentMenu.X + SettingsButton.RightText.X - RightBadgeOffset + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightText.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsButton.RightText.Scale, 0, 0, 0, 255, 2)
                            RightOffset = MeasureStringWidth(Style.RightLabel, 0, 0.35)
                        end
                    else
                        if Style.RightLabel ~= nil and Style.RightLabel ~= "" then
                            RightOffset = MeasureStringWidth(Style.RightLabel, 0, 0.35)
                            RenderText(Style.RightLabel, CurrentMenu.X + SettingsButton.RightText.X - RightBadgeOffset + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightText.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsButton.RightText.Scale, 245, 245, 245, 255, 2)
                        end
                    end
                end
                RightOffset = RightOffset + RightBadgeOffset
                if Enabled == true or Enabled == nil then
                    if Selected then
                        RenderText(Label, CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsButton.Text.Scale, 0, 0, 0, 255)

                        RenderSprite(SettingsSlider.LeftArrow.Dictionary, SettingsSlider.LeftArrow.Texture, CurrentMenu.X + SettingsSlider.LeftArrow.X + CurrentMenu.WidthOffset - RightOffset, CurrentMenu.Y + SettingsSlider.LeftArrow.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsSlider.LeftArrow.Width, SettingsSlider.LeftArrow.Height, 0, 0, 0, 0, 255)
                        RenderSprite(SettingsSlider.RightArrow.Dictionary, SettingsSlider.RightArrow.Texture, CurrentMenu.X + SettingsSlider.RightArrow.X + CurrentMenu.WidthOffset - RightOffset, CurrentMenu.Y + SettingsSlider.RightArrow.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsSlider.RightArrow.Width, SettingsSlider.RightArrow.Height, 0, 0, 0, 0, 255)
                    else
                        RenderText(Label, CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsButton.Text.Scale, 245, 245, 245, 255)
                    end
                else
                    RenderText(Label, CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsButton.Text.Scale, 163, 159, 148, 255)

                    if Selected then
                        RenderSprite(SettingsSlider.LeftArrow.Dictionary, SettingsSlider.LeftArrow.Texture, CurrentMenu.X + SettingsSlider.LeftArrow.X + CurrentMenu.WidthOffset - RightOffset, CurrentMenu.Y + SettingsSlider.LeftArrow.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsSlider.LeftArrow.Width, SettingsSlider.LeftArrow.Height, 163, 159, 148, 255)
                        RenderSprite(SettingsSlider.RightArrow.Dictionary, SettingsSlider.RightArrow.Texture, CurrentMenu.X + SettingsSlider.RightArrow.X + CurrentMenu.WidthOffset - RightOffset, CurrentMenu.Y + SettingsSlider.RightArrow.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsSlider.RightArrow.Width, SettingsSlider.RightArrow.Height, 163, 159, 148, 255)
                    end
                end

                if type(Style) == "table" then
                    if Style.Enabled == true or Style.Enabled == nil then
                        if type(Style) == 'table' then
                            if Style.LeftBadge ~= nil then
                                if Style.LeftBadge ~= Tree.Menu.BadgeStyle.None then
                                    local BadgeData = Style.LeftBadge(Selected)

                                    RenderSprite(BadgeData.BadgeDictionary or "commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X, CurrentMenu.Y + SettingsButton.LeftBadge.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsButton.LeftBadge.Width, SettingsButton.LeftBadge.Height, 0, BadgeData.BadgeColour and BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.G or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.A or 255)
                                end
                            end

                            if Style.RightBadge ~= nil then
                                if Style.RightBadge ~= Tree.Menu.BadgeStyle.None then
                                    local BadgeData = Style.RightBadge(Selected)

                                    RenderSprite(BadgeData.BadgeDictionary or "commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X + SettingsButton.RightBadge.X + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightBadge.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsButton.RightBadge.Width, SettingsButton.RightBadge.Height, 0, BadgeData.BadgeColour and BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.G or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.A or 255)
                                end
                            end
                        end
                    else
                        ---@type table
                        local LeftBadge = Tree.Menu.BadgeStyle.Lock

                        if LeftBadge ~= Tree.Menu.BadgeStyle.None and LeftBadge ~= nil then
                            local BadgeData = LeftBadge(Selected)

                            RenderSprite(BadgeData.BadgeDictionary or "commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X, CurrentMenu.Y + SettingsButton.LeftBadge.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsButton.LeftBadge.Width, SettingsButton.LeftBadge.Height, 0, BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour.G or 255, BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour.A or 255)
                        end
                    end
                else
                    error("UICheckBox Style is not a `table`")
                end
                RenderRectangle(CurrentMenu.X + SettingsSlider.Background.X + CurrentMenu.WidthOffset - RightOffset, CurrentMenu.Y + SettingsSlider.Background.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsSlider.Background.Width, SettingsSlider.Background.Height, 4, 32, 57, 255)
                RenderRectangle(CurrentMenu.X + SettingsSlider.Slider.X + (((SettingsSlider.Background.Width - SettingsSlider.Slider.Width) / (#Items - 1)) * (ProgressStart - 1)) + CurrentMenu.WidthOffset - RightOffset, CurrentMenu.Y + SettingsSlider.Slider.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsSlider.Slider.Width, SettingsSlider.Slider.Height, 57, 116, 200, 255)
                if Divider then
                    RenderRectangle(CurrentMenu.X + SettingsSlider.Divider.X + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsSlider.Divider.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsSlider.Divider.Width, SettingsSlider.Divider.Height, 245, 245, 245, 255)
                end

                Tree.Menu.ItemOffset = Tree.Menu.ItemOffset + SettingsButton.Rectangle.Height

                Tree.Menu.ItemsDescription(CurrentMenu, Description, Selected);

                if Selected and (CurrentMenu.Controls.Left.Active or (CurrentMenu.Controls.Click.Active and LeftArrowHovered)) and not (CurrentMenu.Controls.Right.Active or (CurrentMenu.Controls.Click.Active and RightArrowHovered)) then
                    ProgressStart = ProgressStart - 1
                    if ProgressStart < 1 then
                        ProgressStart = #Items
                    end
                    if (Actions.onSliderChange ~= nil) then
                        Actions.onSliderChange(ProgressStart);
                    end
                    Tree.Gui.Audio.PlaySound(Audio[Audio.Use].LeftRight.audioName, Audio[Audio.Use].LeftRight.audioRef)
                elseif Selected and (CurrentMenu.Controls.Right.Active or (CurrentMenu.Controls.Click.Active and RightArrowHovered)) and not (CurrentMenu.Controls.Left.Active or (CurrentMenu.Controls.Click.Active and LeftArrowHovered)) then
                    ProgressStart = ProgressStart + 1
                    if ProgressStart > #Items then
                        ProgressStart = 1
                    end
                    if (Actions.onSliderChange ~= nil) then
                        Actions.onSliderChange(ProgressStart);
                    end
                    Tree.Gui.Audio.PlaySound(Audio[Audio.Use].LeftRight.audioName, Audio[Audio.Use].LeftRight.audioRef)
                end

                if Selected and (CurrentMenu.Controls.Select.Active or ((Hovered and CurrentMenu.Controls.Click.Active) and (not LeftArrowHovered and not RightArrowHovered))) then
                    if (Actions.onSelected ~= nil) then
                        Actions.onSelected(ProgressStart);
                    end
                    Tree.Gui.Audio.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef)
                elseif Selected then
                    if(Actions.onActive ~= nil) then
                        Actions.onActive()
                    end 
                end
            end

            Tree.Menu.Options = Tree.Menu.Options + 1
        end
    end
end

---@type table
local SettingsButton = {
    Rectangle = { Y = 0, Width = 431, Height = 38 },
    Text = { X = 8, Y = 3, Scale = 0.33 },
    SelectedSprite = { Dictionary = "commonmenu", Texture = "gradient_nav", Y = 0, Width = 431, Height = 38 },
}

---@type table
local SettingsSlider = {
    Background = { X = 250, Y = 14.5, Width = 150, Height = 9 },
    Slider = { X = 250, Y = 14.5, Width = 75, Height = 9 },
    Divider = { X = 323.5, Y = 9, Width = 2.5, Height = 20 },
    LeftArrow = { Dictionary = "mpleaderboard", Texture = "leaderboard_female_icon", X = 215, Y = 0, Width = 40, Height = 40 },
    RightArrow = { Dictionary = "mpleaderboard", Texture = "leaderboard_male_icon", X = 395, Y = 0, Width = 40, Height = 40 },
}

local Items = {}
for i = 1, 10 do
    table.insert(Items, i)
end

function Tree.Menu.UISliderHeritage(Label, ItemIndex, Description, Actions, Value)

    local CurrentMenu = Tree.Menu.CurrentMenu;
    local Audio = Tree.Menu.Settings.Audio

    if CurrentMenu ~= nil then
        if CurrentMenu() then

            ---@type number
            local Option = Tree.Menu.Options + 1

            if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then

                ---@type number
                local value = Value or 0.1
                local Selected = CurrentMenu.Index == Option

                ---@type boolean
                local LeftArrowHovered, RightArrowHovered = false, false

                Tree.Menu.ItemsSafeZone(CurrentMenu)

                local Hovered = false;
                local RightOffset = 0

                ---@type boolean
                if CurrentMenu.EnableMouse == true and (CurrentMenu.CursorStyle == 0) or (CurrentMenu.CursorStyle == 1) then
                    Hovered = Tree.Menu.ItemsMouseBounds(CurrentMenu, Selected, Option, SettingsButton);
                end

                if Selected then
                    RenderSprite(SettingsButton.SelectedSprite.Dictionary, SettingsButton.SelectedSprite.Texture, CurrentMenu.X, CurrentMenu.Y + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset, SettingsButton.SelectedSprite.Height)
                    LeftArrowHovered = Tree.Menu.IsMouseInBounds(CurrentMenu.X + SettingsSlider.LeftArrow.X + CurrentMenu.SafeZoneSize.X + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsSlider.LeftArrow.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsSlider.LeftArrow.Width, SettingsSlider.LeftArrow.Height)
                    RightArrowHovered = Tree.Menu.IsMouseInBounds(CurrentMenu.X + SettingsSlider.RightArrow.X + CurrentMenu.SafeZoneSize.X + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsSlider.RightArrow.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsSlider.RightArrow.Width, SettingsSlider.RightArrow.Height)
                end

                RightOffset = RightOffset

                if Selected then
                    RenderText(Label, CurrentMenu.X + SettingsButton.Text.X, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsButton.Text.Scale, 0, 0, 0, 255)

                    RenderSprite(SettingsSlider.LeftArrow.Dictionary, SettingsSlider.LeftArrow.Texture, CurrentMenu.X + SettingsSlider.LeftArrow.X + CurrentMenu.WidthOffset - RightOffset, CurrentMenu.Y + SettingsSlider.LeftArrow.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsSlider.LeftArrow.Width, SettingsSlider.LeftArrow.Height, 0, 0, 0, 0, 255)
                    RenderSprite(SettingsSlider.RightArrow.Dictionary, SettingsSlider.RightArrow.Texture, CurrentMenu.X + SettingsSlider.RightArrow.X + CurrentMenu.WidthOffset - RightOffset, CurrentMenu.Y + SettingsSlider.RightArrow.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsSlider.RightArrow.Width, SettingsSlider.RightArrow.Height, 0, 0, 0, 0, 255)
                else
                    RenderText(Label, CurrentMenu.X + SettingsButton.Text.X, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsButton.Text.Scale, 245, 245, 245, 255)

                    RenderSprite(SettingsSlider.LeftArrow.Dictionary, SettingsSlider.LeftArrow.Texture, CurrentMenu.X + SettingsSlider.LeftArrow.X + CurrentMenu.WidthOffset - RightOffset, CurrentMenu.Y + SettingsSlider.LeftArrow.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsSlider.LeftArrow.Width, SettingsSlider.LeftArrow.Height, 0, 255, 255, 255, 255)
                    RenderSprite(SettingsSlider.RightArrow.Dictionary, SettingsSlider.RightArrow.Texture, CurrentMenu.X + SettingsSlider.RightArrow.X + CurrentMenu.WidthOffset - RightOffset, CurrentMenu.Y + SettingsSlider.RightArrow.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsSlider.RightArrow.Width, SettingsSlider.RightArrow.Height, 0, 255, 255, 255, 255)
                end

                RenderRectangle(CurrentMenu.X + SettingsSlider.Background.X + CurrentMenu.WidthOffset - RightOffset, CurrentMenu.Y + SettingsSlider.Background.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsSlider.Background.Width, SettingsSlider.Background.Height, 4, 32, 57, 255)
                RenderRectangle(CurrentMenu.X + SettingsSlider.Slider.X + (((SettingsSlider.Background.Width - SettingsSlider.Slider.Width) / (#Items)) * (ItemIndex)) + CurrentMenu.WidthOffset - RightOffset, CurrentMenu.Y + SettingsSlider.Slider.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsSlider.Slider.Width, SettingsSlider.Slider.Height, 57, 116, 200, 255)

                RenderRectangle(CurrentMenu.X + SettingsSlider.Divider.X + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsSlider.Divider.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsSlider.Divider.Width, SettingsSlider.Divider.Height, 245, 245, 245, 255)

                Tree.Menu.ItemOffset = Tree.Menu.ItemOffset + SettingsButton.Rectangle.Height

                Tree.Menu.ItemsDescription(CurrentMenu, Description, Selected);

                if Selected and (CurrentMenu.Controls.SliderLeft.Active or (CurrentMenu.Controls.Click.Active and LeftArrowHovered)) and not (CurrentMenu.Controls.SliderRight.Active or (CurrentMenu.Controls.Click.Active and RightArrowHovered)) then
                    ItemIndex = ItemIndex - value
                    if ItemIndex < 0.1 then
                        ItemIndex = 0.0
                    else
                        Tree.Gui.Audio.PlaySound(Audio[Audio.Use].Slider.audioName, Audio[Audio.Use].Slider.audioRef, true)
                    end
                    if (Actions.onSliderChange ~= nil) then
                        Actions.onSliderChange(ItemIndex / 10, ItemIndex);
                    end
                elseif Selected and (CurrentMenu.Controls.SliderRight.Active or (CurrentMenu.Controls.Click.Active and RightArrowHovered)) and not (CurrentMenu.Controls.SliderLeft.Active or (CurrentMenu.Controls.Click.Active and LeftArrowHovered)) then
                    ItemIndex = ItemIndex + value
                    if ItemIndex > #Items then
                        ItemIndex = 10
                    else
                        Tree.Gui.Audio.PlaySound(Audio[Audio.Use].Slider.audioName, Audio[Audio.Use].Slider.audioRef, true)
                    end
                    if (Actions.onSliderChange ~= nil) then
                        Actions.onSliderChange(ItemIndex / 10, ItemIndex);
                    end
                end

                if Selected and (CurrentMenu.Controls.Select.Active or ((Hovered and CurrentMenu.Controls.Click.Active) and (not LeftArrowHovered and not RightArrowHovered))) then
                    if (Actions.onSelected ~= nil) then
                        Actions.onSelected(ItemIndex / 10, ItemIndex);
                    end
                    Tree.Gui.Audio.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef, false)
                elseif Selected then
                    if(Actions.onActive ~= nil) then
                        Actions.onActive()
                    end 
                end

            end

            Tree.Menu.Options = Tree.Menu.Options + 1
        end
    end
end

---@type table
local SettingsButton = {
    Rectangle = { Y = 0, Width = 431, Height = 38 },
    Text = { X = 8, Y = 3, Scale = 0.33 },
    LeftBadge = { Y = -2, Width = 40, Height = 40 },
    RightBadge = { X = 385, Y = -2, Width = 40, Height = 40 },
    RightText = { X = 420, Y = 4, Scale = 0.35 },
    SelectedSprite = { Dictionary = "commonmenu", Texture = "gradient_nav", Y = 0, Width = 431, Height = 38 },
}

---@type table
local SettingsSlider = {
    Background = { X = 250, Y = 14.5, Width = 150, Height = 9 },
    Slider = { X = 250, Y = 14.5, Width = 150, Height = 9 },
    LeftArrow = { Dictionary = "commonmenu", Texture = "arrowleft", X = 235, Y = 11.5, Width = 15, Height = 15 },
    RightArrow = { Dictionary = "commonmenu", Texture = "arrowright", X = 400, Y = 11.5, Width = 15, Height = 15 },
}

---Slider
---@param Label string
---@param ProgressStart number
---@param ProgressMax number
---@param Description string
---@param Enabled boolean
---@param Callback function
function Tree.Menu.SliderProgress(Label, ProgressStart, ProgressMax, Description, Style, Enabled, Actions)

    ---@type table
    local CurrentMenu = Tree.Menu.CurrentMenu;
    local Audio = Tree.Menu.Settings.Audio

    if CurrentMenu ~= nil then
        if CurrentMenu() then

            local Items = {}
            for i = 1, ProgressMax do
                table.insert(Items, i)
            end
            ---@type number
            local Option = Tree.Menu.Options + 1

            if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then

                ---@type number
                local Selected = CurrentMenu.Index == Option

                ---@type boolean
                local LeftArrowHovered, RightArrowHovered = false, false

                Tree.Menu.ItemsSafeZone(CurrentMenu)

                local Hovered = false;
                local LeftBadgeOffset = ((Style.LeftBadge == Tree.Menu.BadgeStyle.None or Style.LeftBadge == nil) and 0 or 27)
                local RightBadgeOffset = ((Style.RightBadge == Tree.Menu.BadgeStyle.None or Style.RightBadge == nil) and 0 or 32)
                local RightOffset = 0
                ---@type boolean
                if CurrentMenu.EnableMouse == true and (CurrentMenu.CursorStyle == 0) or (CurrentMenu.CursorStyle == 1) then
                    Hovered = Tree.Menu.ItemsMouseBounds(CurrentMenu, Selected, Option, SettingsButton);
                end

                if Selected then
                    RenderSprite(SettingsButton.SelectedSprite.Dictionary, SettingsButton.SelectedSprite.Texture, CurrentMenu.X, CurrentMenu.Y + SettingsButton.SelectedSprite.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsButton.SelectedSprite.Width + CurrentMenu.WidthOffset, SettingsButton.SelectedSprite.Height)
                    LeftArrowHovered = Tree.Menu.IsMouseInBounds(CurrentMenu.X + SettingsSlider.LeftArrow.X + CurrentMenu.SafeZoneSize.X + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsSlider.LeftArrow.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsSlider.LeftArrow.Width, SettingsSlider.LeftArrow.Height)
                    RightArrowHovered = Tree.Menu.IsMouseInBounds(CurrentMenu.X + SettingsSlider.RightArrow.X + CurrentMenu.SafeZoneSize.X + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsSlider.RightArrow.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsSlider.RightArrow.Width, SettingsSlider.RightArrow.Height)
                end
                if Enabled == true or Enabled == nil then
                    if Selected then
                        if Style.RightLabel ~= nil and Style.RightLabel ~= "" then
                            RenderText(Style.RightLabel, CurrentMenu.X + SettingsButton.RightText.X - RightBadgeOffset + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightText.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsButton.RightText.Scale, 0, 0, 0, 255, 2)
                            RightOffset = MeasureStringWidth(Style.RightLabel, 0, 0.35)
                        end
                    else
                        if Style.RightLabel ~= nil and Style.RightLabel ~= "" then
                            RightOffset = MeasureStringWidth(Style.RightLabel, 0, 0.35)
                            RenderText(Style.RightLabel, CurrentMenu.X + SettingsButton.RightText.X - RightBadgeOffset + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightText.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsButton.RightText.Scale, 245, 245, 245, 255, 2)
                        end
                    end
                end
                RightOffset = RightOffset + RightBadgeOffset
                if Enabled == true or Enabled == nil then
                    if Selected then
                        RenderText(Label, CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsButton.Text.Scale, 0, 0, 0, 255)

                        RenderSprite(SettingsSlider.LeftArrow.Dictionary, SettingsSlider.LeftArrow.Texture, CurrentMenu.X + SettingsSlider.LeftArrow.X + CurrentMenu.WidthOffset - RightOffset, CurrentMenu.Y + SettingsSlider.LeftArrow.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsSlider.LeftArrow.Width, SettingsSlider.LeftArrow.Height, 0, 0, 0, 0, 255)
                        RenderSprite(SettingsSlider.RightArrow.Dictionary, SettingsSlider.RightArrow.Texture, CurrentMenu.X + SettingsSlider.RightArrow.X + CurrentMenu.WidthOffset - RightOffset, CurrentMenu.Y + SettingsSlider.RightArrow.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsSlider.RightArrow.Width, SettingsSlider.RightArrow.Height, 0, 0, 0, 0, 255)
                    else
                        RenderText(Label, CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsButton.Text.Scale, 245, 245, 245, 255)
                    end
                else
                    RenderText(Label, CurrentMenu.X + SettingsButton.Text.X + LeftBadgeOffset, CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, SettingsButton.Text.Scale, 163, 159, 148, 255)

                    if Selected then
                        RenderSprite(SettingsSlider.LeftArrow.Dictionary, SettingsSlider.LeftArrow.Texture, CurrentMenu.X + SettingsSlider.LeftArrow.X + CurrentMenu.WidthOffset - RightOffset, CurrentMenu.Y + SettingsSlider.LeftArrow.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsSlider.LeftArrow.Width, SettingsSlider.LeftArrow.Height, 163, 159, 148, 255)
                        RenderSprite(SettingsSlider.RightArrow.Dictionary, SettingsSlider.RightArrow.Texture, CurrentMenu.X + SettingsSlider.RightArrow.X + CurrentMenu.WidthOffset - RightOffset, CurrentMenu.Y + SettingsSlider.RightArrow.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsSlider.RightArrow.Width, SettingsSlider.RightArrow.Height, 163, 159, 148, 255)
                    end
                end

                if type(Style) == "table" then
                    if Style.Enabled == true or Style.Enabled == nil then
                        if type(Style) == 'table' then
                            if Style.LeftBadge ~= nil then
                                if Style.LeftBadge ~= Tree.Menu.BadgeStyle.None then
                                    local BadgeData = Style.LeftBadge(Selected)

                                    RenderSprite(BadgeData.BadgeDictionary or "commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X, CurrentMenu.Y + SettingsButton.LeftBadge.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsButton.LeftBadge.Width, SettingsButton.LeftBadge.Height, 0, BadgeData.BadgeColour and BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.G or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.A or 255)
                                end
                            end

                            if Style.RightBadge ~= nil then
                                if Style.RightBadge ~= Tree.Menu.BadgeStyle.None then
                                    local BadgeData = Style.RightBadge(Selected)

                                    RenderSprite(BadgeData.BadgeDictionary or "commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X + SettingsButton.RightBadge.X + CurrentMenu.WidthOffset, CurrentMenu.Y + SettingsButton.RightBadge.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsButton.RightBadge.Width, SettingsButton.RightBadge.Height, 0, BadgeData.BadgeColour and BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.G or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour and BadgeData.BadgeColour.A or 255)
                                end
                            end
                        end
                    else
                        ---@type table
                        local LeftBadge = Tree.Menu.BadgeStyle.Lock

                        if LeftBadge ~= Tree.Menu.BadgeStyle.None and LeftBadge ~= nil then
                            local BadgeData = LeftBadge(Selected)

                            RenderSprite(BadgeData.BadgeDictionary or "commonmenu", BadgeData.BadgeTexture or "", CurrentMenu.X, CurrentMenu.Y + SettingsButton.LeftBadge.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsButton.LeftBadge.Width, SettingsButton.LeftBadge.Height, 0, BadgeData.BadgeColour.R or 255, BadgeData.BadgeColour.G or 255, BadgeData.BadgeColour.B or 255, BadgeData.BadgeColour.A or 255)
                        end
                    end
                else
                    error("UICheckBox Style is not a `table`")
                end

                if (type(Style.ProgressBackgroundColor) == "table") then
                    RenderRectangle(CurrentMenu.X + SettingsSlider.Background.X + CurrentMenu.WidthOffset - RightOffset, CurrentMenu.Y + SettingsSlider.Background.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SettingsSlider.Background.Width, SettingsSlider.Background.Height, Style.ProgressBackgroundColor.R, Style.ProgressBackgroundColor.G, Style.ProgressBackgroundColor.B, Style.ProgressBackgroundColor.A)
                else
                    error("Style ProgressBackgroundColor is not a table or undefined")
                end

                if (type(Style.ProgressColor) == "table") then
                    RenderRectangle(CurrentMenu.X + SettingsSlider.Slider.X + CurrentMenu.WidthOffset - RightOffset, CurrentMenu.Y + SettingsSlider.Slider.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, (((SettingsSlider.Slider.Width) / (#Items - 1)) * (ProgressStart - 1)), SettingsSlider.Slider.Height, Style.ProgressColor.R, Style.ProgressColor.G, Style.ProgressColor.B, Style.ProgressColor.A)
                else
                    error("Style ProgressColor is not a table or undefined")
                end

                Tree.Menu.ItemOffset = Tree.Menu.ItemOffset + SettingsButton.Rectangle.Height

                Tree.Menu.ItemsDescription(CurrentMenu, Description, Selected);

                if Selected and (CurrentMenu.Controls.Left.Active or (CurrentMenu.Controls.Click.Active and LeftArrowHovered)) and not (CurrentMenu.Controls.Right.Active or (CurrentMenu.Controls.Click.Active and RightArrowHovered)) then
                    ProgressStart = ProgressStart - 1
                    if ProgressStart < 1 then
                        ProgressStart = #Items
                    end
                    if (Actions.onSliderChange ~= nil) then
                        Actions.onSliderChange(ProgressStart);
                    end
                    Tree.Gui.Audio.PlaySound(Audio[Audio.Use].LeftRight.audioName, Audio[Audio.Use].LeftRight.audioRef)
                elseif Selected and (CurrentMenu.Controls.Right.Active or (CurrentMenu.Controls.Click.Active and RightArrowHovered)) and not (CurrentMenu.Controls.Left.Active or (CurrentMenu.Controls.Click.Active and LeftArrowHovered)) then
                    ProgressStart = ProgressStart + 1
                    if ProgressStart > #Items then
                        ProgressStart = 1
                    end
                    if (Actions.onSliderChange ~= nil) then
                        Actions.onSliderChange(ProgressStart);
                    end
                    Tree.Gui.Audio.PlaySound(Audio[Audio.Use].LeftRight.audioName, Audio[Audio.Use].LeftRight.audioRef)
                end

                if Selected and (CurrentMenu.Controls.Select.Active or ((Hovered and CurrentMenu.Controls.Click.Active) and (not LeftArrowHovered and not RightArrowHovered))) then
                    if (Actions.onSelected ~= nil) then
                        Actions.onSelected(ProgressStart);
                    end
                    Tree.Gui.Audio.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef)
                elseif Selected then
                    if(Actions.onActive ~= nil) then
                        Actions.onActive()
                    end 
                end
            end

            Tree.Menu.Options = Tree.Menu.Options + 1
        end
    end
end

local TextPanels = {
    Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 42 },
    Text = {
        Left = { X = 8, Y = 10, Scale = 0.35 },
        Right = { X = 8, Y = 10, Scale = 0.35 },
    },
}

---BoutonPanel
---@param LeftText string
---@param RightText string
---@public
function Tree.Menu.BoutonPanel(LeftText, RightText, Index)
    local CurrentMenu = Tree.Menu.CurrentMenu
    if CurrentMenu ~= nil then
        local leftTextSize = MeasureStringWidth(LeftText)
        if CurrentMenu() and (Index == nil or (CurrentMenu.Index == Index)) then
            RenderRectangle(CurrentMenu.X, CurrentMenu.Y + TextPanels.Background.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset + (Tree.Menu.StatisticPanelCount * 42), TextPanels.Background.Width + CurrentMenu.WidthOffset, TextPanels.Background.Height, 0, 0, 0, 170)
            RenderText(LeftText or "", CurrentMenu.X + TextPanels.Text.Left.X, (Tree.Menu.StatisticPanelCount * 40) + CurrentMenu.Y + TextPanels.Text.Left.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, TextPanels.Text.Left.Scale, 245, 245, 245, 255, 0)
            RenderText(RightText or "", CurrentMenu.X + TextPanels.Background.Width + CurrentMenu.WidthOffset - leftTextSize, (Tree.Menu.StatisticPanelCount * 40) + CurrentMenu.Y + TextPanels.Text.Left.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, TextPanels.Text.Left.Scale, 245, 245, 245, 255, 2)
            Tree.Menu.StatisticPanelCount = Tree.Menu.StatisticPanelCount + 1
        end
    end
end

---@type table
local Colour = {
    Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 112 },
    LeftArrow = { Dictionary = "commonmenu", Texture = "arrowleft", X = 7.5, Y = 15, Width = 30, Height = 30 },
    RightArrow = { Dictionary = "commonmenu", Texture = "arrowright", X = 393.5, Y = 15, Width = 30, Height = 30 },
    Header = { X = 215.5, Y = 15, Scale = 0.35 },
    Box = { X = 15, Y = 55, Width = 44.5, Height = 44.5 },
    SelectedRectangle = { X = 15, Y = 47, Width = 44.5, Height = 8 },
    Seperator = { Text = "of" }
}

---ColourPanel
---@param Title string
---@param Colours thread
---@param MinimumIndex number
---@param CurrentIndex number
---@param Callback function
---@return nil
---@public
function Tree.Menu.ColourPanel(Title, Colours, MinimumIndex, CurrentIndex, Action, Index, Style)

    ---@type table
    local CurrentMenu = Tree.Menu.CurrentMenu;

    if CurrentMenu ~= nil then
        if CurrentMenu() and (CurrentMenu.Index == Index) then

            ---@type number
            local Maximum = (#Colours > 9) and 9 or #Colours

            ---@type boolean
            local Hovered = Tree.Menu.IsMouseInBounds(CurrentMenu.X + Colour.Box.X + CurrentMenu.SafeZoneSize.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Colour.Box.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, (Colour.Box.Width * Maximum), Colour.Box.Height)

            ---@type number
            local LeftArrowHovered = Tree.Menu.IsMouseInBounds(CurrentMenu.X + Colour.LeftArrow.X + CurrentMenu.SafeZoneSize.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Colour.LeftArrow.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Colour.LeftArrow.Width, Colour.LeftArrow.Height)

            ---@type number
            local RightArrowHovered = Tree.Menu.IsMouseInBounds(CurrentMenu.X + Colour.RightArrow.X + CurrentMenu.SafeZoneSize.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Colour.RightArrow.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Colour.RightArrow.Width, Colour.RightArrow.Height)

            ---@type boolean
            local Selected = false

            RenderSprite(Colour.Background.Dictionary, Colour.Background.Texture, CurrentMenu.X, CurrentMenu.Y + Colour.Background.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Colour.Background.Width + CurrentMenu.WidthOffset, Colour.Background.Height)
            RenderSprite(Colour.LeftArrow.Dictionary, Colour.LeftArrow.Texture, CurrentMenu.X + Colour.LeftArrow.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Colour.LeftArrow.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Colour.LeftArrow.Width, Colour.LeftArrow.Height)
            RenderSprite(Colour.RightArrow.Dictionary, Colour.RightArrow.Texture, CurrentMenu.X + Colour.RightArrow.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Colour.RightArrow.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Colour.RightArrow.Width, Colour.RightArrow.Height)

            RenderRectangle(CurrentMenu.X + Colour.SelectedRectangle.X + (Colour.Box.Width * (CurrentIndex - MinimumIndex)) + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Colour.SelectedRectangle.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Colour.SelectedRectangle.Width, Colour.SelectedRectangle.Height, 245, 245, 245, 255)

            for Index = 1, Maximum do
                RenderRectangle(CurrentMenu.X + Colour.Box.X + (Colour.Box.Width * (Index - 1)) + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Colour.Box.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Colour.Box.Width, Colour.Box.Height, table.unpack(Colours[MinimumIndex + Index - 1]))
            end
            
            local ColourSeperator = {}
            if type(Style) == "table" then
                if type(Style.Seperator) == "table" then
                    ColourSeperator = Style.Seperator
                else
                    ColourSeperator = Colour.Seperator
                end
            else
                ColourSeperator = Colour.Seperator
            end
            
            RenderText((Title and Title or "") .. " (" .. CurrentIndex .. " " .. ColourSeperator.Text .. " " .. #Colours .. ")", CurrentMenu.X + Tree.Menu.Settings.Panels.Grid.Text.Top.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Tree.Menu.Settings.Panels.Grid.Text.Top.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, Tree.Menu.Settings.Panels.Grid.Text.Top.Scale, 245, 245, 245, 255, 1)

            if Hovered or LeftArrowHovered or RightArrowHovered then
                if Tree.Menu.Settings.Controls.Click.Active then
                    Selected = true

                    if LeftArrowHovered then
                        CurrentIndex = CurrentIndex - 1

                        if CurrentIndex < 1 then
                            CurrentIndex = #Colours
                            MinimumIndex = #Colours - Maximum + 1
                        elseif CurrentIndex < MinimumIndex then
                            MinimumIndex = MinimumIndex - 1
                        end
                    elseif RightArrowHovered then
                        CurrentIndex = CurrentIndex + 1

                        if CurrentIndex > #Colours then
                            CurrentIndex = 1
                            MinimumIndex = 1
                        elseif CurrentIndex > MinimumIndex + Maximum - 1 then
                            MinimumIndex = MinimumIndex + 1
                        end
                    elseif Hovered then
                        for Index = 1, Maximum do
                            if Tree.Menu.IsMouseInBounds(CurrentMenu.X + Colour.Box.X + (Colour.Box.Width * (Index - 1)) + CurrentMenu.SafeZoneSize.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Colour.Box.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Colour.Box.Width, Colour.Box.Height) then
                                CurrentIndex = MinimumIndex + Index - 1
                            end
                        end
                    end

                    if (Action.onColorChange ~= nil) then
                        Action.onColorChange(MinimumIndex, CurrentIndex)
                    end
                end
            end

            Tree.Menu.ItemOffset = Tree.Menu.ItemOffset + Colour.Background.Height + Colour.Background.Y

            if (Hovered or LeftArrowHovered or RightArrowHovered) and Tree.Menu.Settings.Controls.Click.Active then
                local Audio = Tree.Menu.Settings.Audio
                Tree.Gui.Audio.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef)
            end
        end
    end
end



local GridType = Tree.Menu.Enum {
    Default = 1,
    Horizontal = 2,
    Vertical = 3
}

local GridSprite = {
    [GridType.Default] = { Dictionary = "pause_menu_pages_char_mom_dad", Texture = "nose_grid", },
    [GridType.Horizontal] = { Dictionary = "Tree.Menu_", Texture = "horizontal_grid", },
    [GridType.Vertical] = { Dictionary = "Tree.Menu_", Texture = "vertical_grid", },
}

local Grid = {
    Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 275 },
    Grid = { X = 115.5, Y = 47.5, Width = 200, Height = 200 },
    Circle = { Dictionary = "mpinventory", Texture = "in_world_circle", X = 115.5, Y = 47.5, Width = 20, Height = 20 },
    Text = {
        Top = { X = 215.5, Y = 15, Scale = 0.35 },
        Bottom = { X = 215.5, Y = 250, Scale = 0.35 },
        Left = { X = 57.75, Y = 130, Scale = 0.35 },
        Right = { X = 373.25, Y = 130, Scale = 0.35 },
    },
}

local function UIGridPanel(Type, StartedX, StartedY, TopText, BottomText, LeftText, RightText, Action, Index)
    local CurrentMenu = Tree.Menu.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() and ((CurrentMenu.Index == Index)) then
            local X = Type == GridType.Default and StartedX or Type == GridType.Horizontal and StartedX or Type == GridType.Vertical and 0.5
            local Y = Type == GridType.Default and StartedY or Type == GridType.Horizontal and 0.5 or Type == GridType.Vertical and StartedY
            local Hovered = Tree.Menu.IsMouseInBounds(CurrentMenu.X + Grid.Grid.X + CurrentMenu.SafeZoneSize.X + 20, CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset + 20, Grid.Grid.Width + CurrentMenu.WidthOffset - 40, Grid.Grid.Height - 40)
            local Selected = false
            local CircleX = CurrentMenu.X + Grid.Grid.X + (CurrentMenu.WidthOffset / 2) + 20
            local CircleY = CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset + 20
            if X < 0.0 or X > 1.0 then
                X = 0.0
            end
            if Y < 0.0 or Y > 1.0 then
                Y = 0.0
            end
            CircleX = CircleX + ((Grid.Grid.Width - 40) * X) - (Grid.Circle.Width / 2)
            CircleY = CircleY + ((Grid.Grid.Height - 40) * Y) - (Grid.Circle.Height / 2)
            RenderSprite(Grid.Background.Dictionary, Grid.Background.Texture, CurrentMenu.X, CurrentMenu.Y + Grid.Background.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Grid.Background.Width + CurrentMenu.WidthOffset, Grid.Background.Height)
            RenderSprite(GridSprite[Type].Dictionary, GridSprite[Type].Texture, CurrentMenu.X + Grid.Grid.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Grid.Grid.Width, Grid.Grid.Height)
            RenderSprite(Grid.Circle.Dictionary, Grid.Circle.Texture, CircleX, CircleY, Grid.Circle.Width, Grid.Circle.Height)
            if (Type == GridType.Default) then
                RenderText(TopText or "", CurrentMenu.X + Grid.Text.Top.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Top.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, Grid.Text.Top.Scale, 245, 245, 245, 255, 1)
                RenderText(BottomText or "", CurrentMenu.X + Grid.Text.Bottom.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Bottom.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, Grid.Text.Bottom.Scale, 245, 245, 245, 255, 1)
                RenderText(LeftText or "", CurrentMenu.X + Grid.Text.Left.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Left.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, Grid.Text.Left.Scale, 245, 245, 245, 255, 1)
                RenderText(RightText or "", CurrentMenu.X + Grid.Text.Right.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Right.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, Grid.Text.Right.Scale, 245, 245, 245, 255, 1)
            end
            if (Type == GridType.Vertical) then
                RenderText(TopText or "", CurrentMenu.X + Grid.Text.Top.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Top.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, Grid.Text.Top.Scale, 245, 245, 245, 255, 1)
                RenderText(BottomText or "", CurrentMenu.X + Grid.Text.Bottom.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Bottom.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, Grid.Text.Bottom.Scale, 245, 245, 245, 255, 1)
            end
            if (Type == GridType.Horizontal) then
                RenderText(LeftText or "", CurrentMenu.X + Grid.Text.Left.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Left.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, Grid.Text.Left.Scale, 245, 245, 245, 255, 1)
                RenderText(RightText or "", CurrentMenu.X + Grid.Text.Right.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Right.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, Grid.Text.Right.Scale, 245, 245, 245, 255, 1)
            end
            if Hovered then
                if IsDisabledControlPressed(0, 24) then
                    Selected = true
                    CircleX = math.round(GetControlNormal(2, 239) * 1920) - CurrentMenu.SafeZoneSize.X - (Grid.Circle.Width / 2)
                    CircleY = math.round(GetControlNormal(2, 240) * 1080) - CurrentMenu.SafeZoneSize.Y - (Grid.Circle.Height / 2)
                    if CircleX > (CurrentMenu.X + Grid.Grid.X + (CurrentMenu.WidthOffset / 2) + 20 + Grid.Grid.Width - 40) then
                        CircleX = CurrentMenu.X + Grid.Grid.X + (CurrentMenu.WidthOffset / 2) + 20 + Grid.Grid.Width - 40
                    elseif CircleX < (CurrentMenu.X + Grid.Grid.X + 20 - (Grid.Circle.Width / 2)) then
                        CircleX = CurrentMenu.X + Grid.Grid.X + 20 - (Grid.Circle.Width / 2)
                    end
                    if CircleY > (CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset + 20 + Grid.Grid.Height - 40) then
                        CircleY = CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset + 20 + Grid.Grid.Height - 40
                    elseif CircleY < (CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset + 20 - (Grid.Circle.Height / 2)) then
                        CircleY = CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset + 20 - (Grid.Circle.Height / 2)
                    end
                    X = math.round((CircleX - (CurrentMenu.X + Grid.Grid.X + (CurrentMenu.WidthOffset / 2) + 20) + (Grid.Circle.Width / 2)) / (Grid.Grid.Width - 40), 2)
                    Y = math.round((CircleY - (CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset + 20) + (Grid.Circle.Height / 2)) / (Grid.Grid.Height - 40), 2)
                    if (X ~= StartedX) and (Y ~= StartedY) then
                        Action.onPositionChange(X, Y, (X * 2 - 1), (Y * 2 - 1))
                    end
                    StartedX = X;
                    StartedY = Y;
                    if X > 1.0 then
                        X = 1.0
                    end
                    if Y > 1.0 then
                        Y = 1.0
                    end
                end
            end
            Tree.Menu.ItemOffset = Tree.Menu.ItemOffset + Grid.Background.Height + Grid.Background.Y
            if Hovered and Selected then
                local Audio = Tree.Menu.Settings.Audio
                Tree.Gui.Audio.PlaySound(Audio[Audio.Use].Slider.audioName, Audio[Audio.Use].Slider.audioRef, true)
                if (Action.onSelected ~= nil) then
                    Action.onSelected(X, Y, (X * 2 - 1), (Y * 2 - 1));
                end
            end

        end
    end
end

function Tree.Menu.Grid(StartedX, StartedY, TopText, BottomText, LeftText, RightText, Action, Index)
    UIGridPanel(GridType.Default, StartedX, StartedY, TopText, BottomText, LeftText, RightText, Action, Index)
end

function Tree.Menu.GridHorizontal(StartedX, LeftText, RightText, Action, Index)
    UIGridPanel(GridType.Horizontal, StartedX, nil, nil, nil, LeftText, RightText, Action, Index)
end

function Tree.Menu.GridVertical(StartedY, TopText, BottomText, Action, Index)
    UIGridPanel(GridType.Vertical, nil, StartedY, TopText, BottomText, nil, nil, Action, Index)
end

local Percentage = {
    Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 76 },
    Bar = { X = 9, Y = 50, Width = 413, Height = 10 },
    Text = {
        Left = { X = 25, Y = 15, Scale = 0.35 },
        Middle = { X = 215.5, Y = 15, Scale = 0.35 },
        Right = { X = 398, Y = 15, Scale = 0.35 },
    },
}

---PercentagePanel
---@param Percent number
---@param HeaderText string
---@param MinText string
---@param MaxText string
---@param Callback function
---@param Index number
---@return nil
---@public
function Tree.Menu.PercentagePanel(Percent, HeaderText, MinText, MaxText, Action, Index)
    local CurrentMenu = Tree.Menu.CurrentMenu

    if CurrentMenu ~= nil then
        if CurrentMenu() and (Index == nil or (CurrentMenu.Index == Index)) then

            ---@type boolean
            local Hovered = Tree.Menu.IsMouseInBounds(CurrentMenu.X + Percentage.Bar.X + CurrentMenu.SafeZoneSize.X, CurrentMenu.Y + Percentage.Bar.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset - 4, Percentage.Bar.Width + CurrentMenu.WidthOffset, Percentage.Bar.Height + 8)

            ---@type boolean
            local Selected = false

            ---@type number
            local Progress = Percentage.Bar.Width

            if Percent < 0.0 then
                Percent = 0.0
            elseif Percent > 1.0 then
                Percent = 1.0
            end

            Progress = Progress * Percent

            RenderSprite(Percentage.Background.Dictionary, Percentage.Background.Texture, CurrentMenu.X, CurrentMenu.Y + Percentage.Background.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Percentage.Background.Width + CurrentMenu.WidthOffset, Percentage.Background.Height)
            RenderRectangle(CurrentMenu.X + Percentage.Bar.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Percentage.Bar.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Percentage.Bar.Width, Percentage.Bar.Height, 87, 87, 87, 255)
            RenderRectangle(CurrentMenu.X + Percentage.Bar.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Percentage.Bar.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Progress, Percentage.Bar.Height, 245, 245, 245, 255)

            RenderText(HeaderText or "Opacity", CurrentMenu.X + Percentage.Text.Middle.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Percentage.Text.Middle.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, Percentage.Text.Middle.Scale, 245, 245, 245, 255, 1)
            RenderText(MinText or "0%", CurrentMenu.X + Percentage.Text.Left.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Percentage.Text.Left.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, Percentage.Text.Left.Scale, 245, 245, 245, 255, 1)
            RenderText(MaxText or "100%", CurrentMenu.X + Percentage.Text.Right.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Percentage.Text.Right.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, Percentage.Text.Right.Scale, 245, 245, 245, 255, 1)

            if Hovered then
                if IsDisabledControlPressed(0, 24) then
                    Selected = true

                    Progress = math.round(GetControlNormal(2, 239) * 1920) - CurrentMenu.SafeZoneSize.X - (CurrentMenu.X + Percentage.Bar.X + (CurrentMenu.WidthOffset / 2))

                    if Progress < 0 then
                        Progress = 0
                    elseif Progress > (Percentage.Bar.Width) then
                        Progress = Percentage.Bar.Width
                    end

                    Percent = math.round(Progress / Percentage.Bar.Width, 2)
                    if (Action.onProgressChange ~= nil) then
                        Action.onProgressChange(Percent)
                    end
                end
            end

            Tree.Menu.ItemOffset = Tree.Menu.ItemOffset + Percentage.Background.Height + Percentage.Background.Y

            if Hovered and Selected then
                local Audio = Tree.Menu.Settings.Audio
                Tree.Gui.Audio.PlaySound(Audio[Audio.Use].Slider.audioName, Audio[Audio.Use].Slider.audioRef, true)
                if (Action.onSelected ~= nil) then
                    Action.onSelected(Percent)
                end
            end
        end
    end
end

local Slider = {
	Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 76 },
	Text = {
		Left = { X = 18, Y = 8, Scale = 0.32 },
		Right = { X = 380, Y = 8, Scale = 0.32 },
		Upper = {X = 230, Y = 8, Scale = 0.32},
	},
	Bar = { X = 25, Y = 36, Width = 250, Height = 16 },
	Slider = { X = 20, Y = 14.5, Width = 35, Height = 9 },
	LeftArrow = { Dictionary = "commonmenu", Texture = "arrowleft", X = 12, Y = 32.5, Width = 25, Height = 25 },
	RightArrow = { Dictionary = "commonmenu", Texture = "arrowright", X = 389, Y = 32.5, Width = 25, Height = 25 },
}

function Tree.Menu.SliderPanel(Value, MinValue, UpperText, MaxValue, Actions, Index)
	local CurrentMenu = Tree.Menu.CurrentMenu
	if CurrentMenu ~= nil then
		if CurrentMenu() and ((CurrentMenu.Index == Index)) then
			Value = Value or 0
			Slider.Bar.Width = Slider.RightArrow.X- Slider.LeftArrow.X - Slider.LeftArrow.Width - 5 + CurrentMenu.WidthOffset
			Slider.Bar.X = Slider.LeftArrow.X + Slider.LeftArrow.Width
			Slider.Text.Upper.X = (Slider.Bar.Width) / 2 + Slider.Bar.X
			Slider.Text.Right.X = Slider.RightArrow.X + Slider.LeftArrow.Width
			local Hovered = false
			local LeftArrowHovered, RightArrowHovered = false, false
			local SliderW = Slider.Bar.Width / (64 + 1)
			local SliderX =  CurrentMenu.X + Slider.Bar.X + Value * Slider.Bar.Width / MaxValue

			Hovered = Tree.Menu.IsMouseInBounds(CurrentMenu.X + Slider.Bar.X + CurrentMenu.SafeZoneSize.X, CurrentMenu.Y + Slider.Bar.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset - 4, Slider.Bar.Width, Slider.Bar.Height + 8)

			RenderSprite("commonmenu", "gradient_bgd", CurrentMenu.X, CurrentMenu.Y + Slider.Background.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Slider.Background.Width + CurrentMenu.WidthOffset, Slider.Background.Height, 0.0, 255, 255, 255, 255)
			RenderText(MinValue, CurrentMenu.X + Slider.Text.Left.X, CurrentMenu.Y + Slider.Text.Left.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, Slider.Text.Left.Scale, 255, 255, 255, 255)
			RenderText(UpperText, CurrentMenu.X + Slider.Text.Upper.X, CurrentMenu.Y + Slider.Text.Upper.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, Slider.Text.Upper.Scale, 255, 255, 255, 255, "Center")
			RenderText(MaxValue, CurrentMenu.X + Slider.Text.Right.X + CurrentMenu.WidthOffset, CurrentMenu.Y + Slider.Text.Right.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, Slider.Text.Right.Scale, 255, 255, 255, 255, "Right")

			RenderSprite(Slider.LeftArrow.Dictionary, Slider.LeftArrow.Texture, CurrentMenu.X + Slider.LeftArrow.X, CurrentMenu.Y + Slider.LeftArrow.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Slider.LeftArrow.Width, Slider.LeftArrow.Height, 0.0,  255, 255, 255, 255)
			RenderSprite(Slider.RightArrow.Dictionary, Slider.RightArrow.Texture, CurrentMenu.X + Slider.RightArrow.X + CurrentMenu.WidthOffset , CurrentMenu.Y + Slider.RightArrow.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Slider.RightArrow.Width, Slider.RightArrow.Height, 0.0, 255, 255, 255, 255)
			RenderRectangle(CurrentMenu.X + Slider.Bar.X, CurrentMenu.Y + Slider.Bar.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Slider.Bar.Width, Slider.Bar.Height, 87, 87, 87, 255)
			RenderRectangle(SliderX, CurrentMenu.Y + Slider.Bar.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, SliderW, Slider.Bar.Height, 245, 245, 245, 255)

			LeftArrowHovered = Tree.Menu.IsMouseInBounds(CurrentMenu.X + Slider.LeftArrow.X + CurrentMenu.SafeZoneSize.X, CurrentMenu.Y + Slider.LeftArrow.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Slider.LeftArrow.Width, Slider.LeftArrow.Height)
			RightArrowHovered = Tree.Menu.IsMouseInBounds(CurrentMenu.X + Slider.RightArrow.X + CurrentMenu.SafeZoneSize.X + CurrentMenu.WidthOffset, CurrentMenu.Y + Slider.RightArrow.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Slider.RightArrow.Width, Slider.RightArrow.Height)

			if Hovered then
				if IsDisabledControlPressed(0, 24) then
					local GetControl_X = GetDisabledControlNormal
					Value = (math.round(GetControl_X(2, 239) * 1920) - CurrentMenu.SafeZoneSize.X - Slider.Bar.X )/ Slider.Bar.Width * MaxValue
					if Value < 0 then
						Value = 0
					elseif Value >= MaxValue then
						Value = MaxValue
					end
					Value = math.round(Value, 0)
					print(Value)
					if (Actions.onSliderChange ~= nil) then
						Actions.onSliderChange(Value)
					end
				end
			elseif CurrentMenu.Controls.Click.Active and (LeftArrowHovered or RightArrowHovered) then
				local max = type(Items) == "table" and #Items or MaxValue
				Value = Value + (LeftArrowHovered and -1 or RightArrowHovered and 1)
				if Value < MinValue then
					Value = max
				elseif Value > max  then
					Value = MinValue
				end
				print(Value)
				if (Actions.onSliderChange ~= nil) then
					Actions.onSliderChange(Value);
				end

				local Audio = Tree.Menu.Settings.Audio
				Tree.Gui.Audio.PlaySound(Audio[Audio.Use].LeftRight.audioName, Audio[Audio.Use].LeftRight.audioRef)
			end
		end
	end
end

local TextPanels = {
    Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 42 },
}

---@type Panel
function Tree.Menu.RenderSprite(Dictionary, Texture)
    local CurrentMenu = Tree.Menu.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Dictionary, Texture, CurrentMenu.X, CurrentMenu.Y + TextPanels.Background.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset + (Tree.Menu.StatisticPanelCount * 42), TextPanels.Background.Width + CurrentMenu.WidthOffset, TextPanels.Background.Height + 200, 0, 255, 255, 255, 255);
            Tree.Menu.StatisticPanelCount = Tree.Menu.StatisticPanelCount + 1
        end
    end
end

local Statistics = {
    Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 42 },
    Text = {
        Left = { X = -40, Y = 15, Scale = 0.35 },
    },
    Bar = { Right = 8, Y = 27, Width = 200, Height = 10, OffsetRatio = 0.5 },
    Divider = {
        [1] = { X = 200, Y = 27, Width = 2, Height = 10 },
        [2] = { X = 200, Y = 27, Width = 2, Height = 10 },
        [3] = { X = 200, Y = 27, Width = 2, Height = 10 },
        [4] = { X = 200, Y = 27, Width = 2, Height = 10 },
        [5] = { X = 200, Y = 27, Width = 2, Height = 10 },
    }
}

function Tree.Menu.StatisticPanel(Percent, Text, Index)
    local CurrentMenu = Tree.Menu.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() and (Index == nil or (CurrentMenu.Index == Index)) then

            ---@type number
            local BarWidth = Statistics.Bar.Width + CurrentMenu.WidthOffset * Statistics.Bar.OffsetRatio

            RenderRectangle(CurrentMenu.X, CurrentMenu.Y + Statistics.Background.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset + (Tree.Menu.StatisticPanelCount * 42), Statistics.Background.Width + CurrentMenu.WidthOffset, Statistics.Background.Height, 0, 0, 0, 170)
            RenderText(Text or "", CurrentMenu.X + 8.0, (Tree.Menu.StatisticPanelCount * 40) + CurrentMenu.Y + Statistics.Text.Left.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, Statistics.Text.Left.Scale, 245, 245, 245, 255, 0)
            RenderRectangle(CurrentMenu.X + Tree.Menu.Settings.Items.Title.Background.Width - BarWidth - Statistics.Bar.Right + CurrentMenu.WidthOffset, (Tree.Menu.StatisticPanelCount * 40) + CurrentMenu.Y + Statistics.Bar.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, BarWidth, Statistics.Bar.Height, 87, 87, 87, 255)
            RenderRectangle(CurrentMenu.X + Tree.Menu.Settings.Items.Title.Background.Width - BarWidth - Statistics.Bar.Right + CurrentMenu.WidthOffset, (Tree.Menu.StatisticPanelCount * 40) + CurrentMenu.Y + Statistics.Bar.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Percent * BarWidth, Statistics.Bar.Height, 255, 255, 255, 255)
            for i = 1, #Statistics.Divider, 1 do
                RenderRectangle((CurrentMenu.X + Tree.Menu.Settings.Items.Title.Background.Width - BarWidth - Statistics.Bar.Right) + i * ((BarWidth - (#Statistics.Divider / Statistics.Divider[i].Width)) / (#Statistics.Divider + 1)) + CurrentMenu.WidthOffset, (Tree.Menu.StatisticPanelCount * 40) + CurrentMenu.Y + Statistics.Divider[i].Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Statistics.Divider[i].Width, Statistics.Divider[i].Height, 0, 0, 0, 255)
            end
            Tree.Menu.StatisticPanelCount = Tree.Menu.StatisticPanelCount + 1
        end
    end
end

function Tree.Menu.StatisticPanelAdvanced(Text, Percent, RGBA1, Percent2, RGBA2, RGBA3, Index)
    local CurrentMenu = Tree.Menu.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() and (Index == nil or (CurrentMenu.Index == Index)) then

            RGBA1 = RGBA1 or { 255, 255, 255, 255 }
            local BarWidth = Statistics.Bar.Width + CurrentMenu.WidthOffset * Statistics.Bar.OffsetRatio

            ---@type number
            RenderRectangle(CurrentMenu.X, CurrentMenu.Y + Statistics.Background.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset + (Tree.Menu.StatisticPanelCount * 42), Statistics.Background.Width + CurrentMenu.WidthOffset, Statistics.Background.Height, 0, 0, 0, 170)
            RenderText(Text or "", CurrentMenu.X + 8.0, (Tree.Menu.StatisticPanelCount * 40) + CurrentMenu.Y + Statistics.Text.Left.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, 0, Statistics.Text.Left.Scale, 245, 245, 245, 255, 0)
            RenderRectangle(CurrentMenu.X + Tree.Menu.Settings.Items.Title.Background.Width - BarWidth - Statistics.Bar.Right + CurrentMenu.WidthOffset, (Tree.Menu.StatisticPanelCount * 40) + CurrentMenu.Y + Statistics.Bar.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, BarWidth, Statistics.Bar.Height, 87, 87, 87, 255)
            RenderRectangle(CurrentMenu.X + Tree.Menu.Settings.Items.Title.Background.Width - BarWidth - Statistics.Bar.Right + CurrentMenu.WidthOffset, (Tree.Menu.StatisticPanelCount * 40) + CurrentMenu.Y + Statistics.Bar.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Percent * BarWidth, Statistics.Bar.Height, RGBA1[1], RGBA1[2], RGBA1[3], RGBA1[4])
            RGBA2 = RGBA2 or { 0, 153, 204, 255 }
            RGBA3 = RGBA3 or { 185, 0, 0, 255 }

            if Percent2 and Percent2 > 0 then
                local X = CurrentMenu.X + Tree.Menu.Settings.Items.Title.Background.Width - BarWidth - Statistics.Bar.Right + CurrentMenu.WidthOffset + Percent * BarWidth
                RenderRectangle(X, (Tree.Menu.StatisticPanelCount * 40) + CurrentMenu.Y + Statistics.Bar.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Percent2 * BarWidth, Statistics.Bar.Height, RGBA2[1], RGBA2[2], RGBA2[3], RGBA2[4])
            elseif Percent2 and Percent2 < 0 then
                local X = CurrentMenu.X + Tree.Menu.Settings.Items.Title.Background.Width - BarWidth - Statistics.Bar.Right + CurrentMenu.WidthOffset + Percent * BarWidth
                RenderRectangle(X, (Tree.Menu.StatisticPanelCount * 40) + CurrentMenu.Y + Statistics.Bar.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Percent2 * BarWidth, Statistics.Bar.Height, RGBA3[1], RGBA3[2], RGBA3[3], RGBA3[4])
            end

            for i = 1, #Statistics.Divider, 1 do
                RenderRectangle((CurrentMenu.X + Tree.Menu.Settings.Items.Title.Background.Width - BarWidth - Statistics.Bar.Right) + i * ((BarWidth - (#Statistics.Divider / Statistics.Divider[i].Width)) / (#Statistics.Divider + 1)) + CurrentMenu.WidthOffset, (Tree.Menu.StatisticPanelCount * 40) + CurrentMenu.Y + Statistics.Divider[i].Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Statistics.Divider[i].Width, Statistics.Divider[i].Height, 0, 0, 0, 255)
            end

            Tree.Menu.StatisticPanelCount = Tree.Menu.StatisticPanelCount + 1
        end
    end
end




---@type table
local Heritage = {
    Background = { Dictionary = "pause_menu_pages_char_mom_dad", Texture = "mumdadbg", Width = 431, Height = 228 },
    Mum = { Dictionary = "char_creator_portraits", X = 25, Width = 228, Height = 228 },
    Dad = { Dictionary = "char_creator_portraits", X = 195, Width = 228, Height = 228 },
}

---@type Window
function Tree.Menu.Window.Heritage(Mum, Dad)
    ---@type table
    local CurrentMenu = Tree.Menu.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            if Mum < 0 or Mum > 21 then
                Mum = 0
            end
            if Dad < 0 or Dad > 23 then
                Dad = 0
            end
            if Mum == 21 then
                Mum = "special_female_" .. (tonumber(string.sub(Mum, 2, 2)) - 1)
            else
                Mum = "female_" .. Mum
            end
            if Dad >= 21 then
                Dad = "special_male_" .. (tonumber(string.sub(Dad, 2, 2)) - 1)
            else
                Dad = "male_" .. Dad
            end
            RenderSprite(Heritage.Background.Dictionary, Heritage.Background.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Heritage.Background.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background.Height)
            RenderSprite(Heritage.Dad.Dictionary, Dad, CurrentMenu.X + Heritage.Dad.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Heritage.Dad.Width, Heritage.Dad.Height)
            RenderSprite(Heritage.Mum.Dictionary, Mum, CurrentMenu.X + Heritage.Mum.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + CurrentMenu.SubtitleHeight + Tree.Menu.ItemOffset, Heritage.Mum.Width, Heritage.Mum.Height)
            Tree.Menu.ItemOffset = Tree.Menu.ItemOffset + Heritage.Background.Height
        end
    end
end

---@type table
local SettingsButton = {
    Rectangle = { Y = 0, Width = 431, Height = 38 },
    Text = { X = 8, Y = 3, Scale = 0.33 },
}

function Tree.Menu.Line()
    local CurrentMenu = Tree.Menu.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            local Option = Tree.Menu.Options + 1
            if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
                RenderRectangle(CurrentMenu.X + (CurrentMenu.WidthOffset * 2.5 ~= 0 and CurrentMenu.WidthOffset * 2.5 or 200)-150+8, CurrentMenu.Y + Tree.Menu.ItemOffset + 15, 300, 3, 255,255,255,150)
                Tree.Menu.ItemOffset = Tree.Menu.ItemOffset + SettingsButton.Rectangle.Height
                if (CurrentMenu.Index == Option) then
                    if (Tree.Menu.LastControl) then
                        CurrentMenu.Index = Option - 1
                        if (CurrentMenu.Index < 1) then
                            CurrentMenu.Index = Tree.Menu.CurrentMenu.Options
                        end
                    else
                        CurrentMenu.Index = Option + 1
                    end
                end
            end
            Tree.Menu.Options = Tree.Menu.Options + 1
        end
    end
end

function Tree.Menu.Info(Title, RightText, LeftText, size)
    local LineCount = #RightText >= #LeftText and #RightText or #LeftText
    if Title ~= nil then
        RenderText("~h~" .. Title .. "~h~", 330 + 20 + 100, 7, 0, 0.34, 255, 255, 255, 255, 0)
    end
    if RightText ~= nil then
        RenderText(table.concat(RightText, "\n"), 330 + 20 + 100, Title ~= nil and 37 or 7, 0, 0.28, 255, 255, 255, 255, 0)
    end
    if LeftText ~= nil then
        RenderText(table.concat(LeftText, "\n"), 330 + size + 100, Title ~= nil and 37 or 7, 0, 0.28, 255, 255, 255, 255, 2)
    end
    RenderRectangle(330 + 10 + 100, 0, size, Title ~= nil and 50 + (LineCount * 20) or ((LineCount + 1) * 20), 0, 0, 0, 160)
end

Citizen.CreateThread(function()
    while true do
        Wait(100)
        if NetworkIsPlayerActive(PlayerId()) then
            SetTimeout(1000, function()
                local count = 0
                while true do 
                    RenderSprite("commonmenu", "interaction_bgd", 0, 0, 0, 0, 0, 0, 0, 0)
                    count = count + 1
                    if count > 1000 then
                        break
                    end
                    Wait(0)
                end
                local txd = CreateRuntimeTxd('duiTxd')
                local duiObj = CreateDui(Tree.Config.Serveur.interaction_bgd, 1000, 224)
                _G.duiObj = duiObj
                local dui = GetDuiHandle(duiObj)
                local tx = CreateRuntimeTextureFromDuiHandle(txd, 'duiTex', dui)
                local isLoaded = false
                while not isLoaded do
                    if tx then
                        AddReplaceTexture('commonmenu', "interaction_bgd", 'duiTxd', 'duiTex')
                        isLoaded = true
                    else
                        Wait(100)
                    end
                end
            end)
            break
        end
    end
end)
