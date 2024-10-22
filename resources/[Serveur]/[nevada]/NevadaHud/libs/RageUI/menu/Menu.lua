---@Crédits go to https://gist.github.com/jrus
local random = math.random

---@param template string ex: '4xxx-yxxx'
local function uuid(template)
    local temp = template or 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
    return string.gsub(temp, '[xy]', function (c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
end

local Menus = {}
local SubMenus = {}

---CreateMenu
---@public
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
function RageUIMenus:CreateMenu(Title, Subtitle, X, Y, TextureDictionary, TextureName, R, G, B, A)
    local Menu = {}
    setmetatable(Menu, RageUIMenus)
    Menu.Display = {};

    Menu.InstructionalButtons = {}

    Menu.Display.Header = (Config["Menu"] and Config["Menu"]["ShowHeader"]) or Config["Menu"]["ShowHeader"] == nil;
    Menu.Display.Subtitle = (Config["Menu"] and Config["Menu"]["DisplaySubtitle"]) or Config["Menu"]["DisplaySubtitle"] == nil;
    Menu.Display.Background = (Config["Menu"] and Config["Menu"]["DisplayBackground"]) or Config["Menu"]["DisplayBackground"] == nil;
    Menu.Display.Navigation = (Config["Menu"] and Config["Menu"]["DisplayNavigationBar"]) or Config["Menu"]["DisplayNavigationBar"] == nil;
    Menu.Display.InstructionalButton = (Config["Menu"] and Config["Menu"]["DisplayInstructionalButton"]) or Config["Menu"]["DisplayInstructionalButton"] == nil;
    Menu.Display.PageCounter = (Config["Menu"] and Config["Menu"]["DisplayPageCounter"]) or Config["Menu"]["DisplayPageCounter"] == nil;

    Menu.Title = (Config["Menu"] and Config["Menu"]["Titles"]) or Title or ""
    Menu.TitleFont = (Config["Menu"] and Config["Menu"]["TitleFont"]) or 6
    Menu.TitleScale = 1.2
    Menu.Subtitle = Subtitle or ""
    Menu.SubtitleHeight = -37
    Menu.Description = nil
    Menu.DescriptionHeight = RageUI.Settings.Items.Description.Background.Height
    Menu.X = X or 0
    Menu.Y = Y or 0
    Menu.Parent = nil
    Menu.WidthOffset = RageUI.UI.Style[RageUI.UI.Current].Width
    Menu.open = false
    Menu.Controls = RageUI.Settings.Controls
    Menu.Index = 1
    Menu.Sprite = {
        Dictionary = (Config["Menu"] and Config["Menu"]["TextureDictionary"]) or TextureDictionary or "commonmenu",
        Texture = (Config["Menu"] and Config["Menu"]["TextureName"]) or TextureName or "interaction_bgd",
        Color = {
            R = (Config["Menu"] and Config["Menu"]["Color"]["R"]) or R or 255,
            G = (Config["Menu"] and Config["Menu"]["Color"]["G"]) or G or 255,
            B = (Config["Menu"] and Config["Menu"]["Color"]["B"]) or B or 255, A = (Config["Menu"] and Config["Menu"]["Color"]["A"]) or A or 255
        }
    }
    Menu.Rectangle = nil
    Menu.Pagination = { Minimum = 1, Maximum = 10, Total = 10 }
    Menu.Safezone = true
    Menu.SafeZoneSize = nil
    Menu.EnableMouse = false
    Menu.Options = 0
    Menu.Closable = true
    Menu.InstructionalScaleform = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
    Menu.CursorStyle = 1
    Menu.id = uuid("xx6xx-xxxxx")
    Menu.data = {}

    if string.starts(Menu.Subtitle, "~") then
        Menu.PageCounterColour = string.lower(string.sub(Menu.Subtitle, 1, 3))
    else
        Menu.PageCounterColour = ""
    end

    if Menu.Subtitle ~= "" then
        local SubtitleLineCount = GetLineCount(Menu.Subtitle, Menu.X + RageUI.Settings.Items.Subtitle.Text.X, Menu.Y + RageUI.Settings.Items.Subtitle.Text.Y, 0, RageUI.Settings.Items.Subtitle.Text.Scale, 245, 245, 245, 255, nil, false, false, RageUI.Settings.Items.Subtitle.Background.Width + Menu.WidthOffset)

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

function RageUIMenus:DisplayHeader(boolean)
    self.Display.Header = boolean;
    return self.Display.Header;
end

function RageUIMenus:DisplaySubtitle(boolean)
    self.Display.Subtitle = boolean;
    return self.Display.Subtitle;
end

function RageUIMenus:DisplayNavigation(boolean)
    self.Display.Navigation = boolean;
    return self.Display.Navigation;
end

function RageUIMenus:DisplayInstructionalButton(boolean)
    self.Display.InstructionalButton = boolean;
    return self.Display.InstructionalButton;
end

function RageUIMenus:DisplayPageCounter(boolean)
    self.Display.PageCounter= boolean;
    return self.Display.PageCounter;
end

---SetTitle
---@param Title string
---@return nil
---@public
function RageUIMenus:SetTitle(Title)
    self.Title = Title
end

function RageUIMenus:SetStyleSize(Value)
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
function RageUIMenus:GetStyleSize()
    if (self.WidthOffset == 100) then
        return "RageUI"
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
function RageUIMenus:SetCursorStyle(Int)
    self.CursorStyle = Int or 1 or 0
    SetMouseCursorSprite(Int)
end

---ResetCursorStyle
---@return void
---@public
function RageUIMenus:ResetCursorStyle()
    self.CursorStyle = 1
    SetMouseCursorSprite(1)
end

---UpdateCursorStyle
---@return void
---@public
function RageUIMenus:UpdateCursorStyle()
    SetMouseCursorSprite(self.CursorStyle)
end

---RefreshIndex
---@return void
---@public
function RageUIMenus:RefreshIndex()
    self.Index = 1
end

---SetSubtitle
---@param Subtitle string
---@return nil
---@public
function RageUIMenus:SetSubtitle(Subtitle)
    self.Subtitle = Subtitle;
    if self.Subtitle ~= "" then
        local SubtitleLineCount = GetLineCount(
            self.Subtitle,
            self.X + RageUI.Settings.Items.Subtitle.Text.X,
            self.Y + RageUI.Settings.Items.Subtitle.Text.Y,
            0, RageUI.Settings.Items.Subtitle.Text.Scale,
            245,
            245,
            245,
            255,
            nil,
            false,
            false,
            RageUI.Settings.Items.Subtitle.Background.Width + self.WidthOffset
        );

        if SubtitleLineCount > 1 then
            self.SubtitleHeight = 18 * SubtitleLineCount
        else
            self.SubtitleHeight = 0
        end
    end
end

---PageCounter
---@param Subtitle string
---@return nil
---@public
function RageUIMenus:SetPageCounter(Subtitle)
    self.PageCounter = Subtitle
end

---EditSpriteColor
---@param Colors table
---@return nil
---@public
function RageUIMenus:EditSpriteColor(R, G, B, A)
    if self.Sprite.Dictionary == "commonmenu" then
        self.Sprite.Color = { R = tonumber(R) or 255, G = tonumber(G) or 255, B = tonumber(B) or 255, A = tonumber(A) or 255 }
    end
end
---SetPosition
---@param X number
---@param Y number
---@return nil
---@public
function RageUIMenus:SetPosition(X, Y)
    self.X = tonumber(X) or self.X
    self.Y = tonumber(Y) or self.Y
end

---SetTotalItemsPerPage
---@param Value number
---@return nil
---@public
function RageUIMenus:SetTotalItemsPerPage(Value)
    self.Pagination.Total = tonumber(Value) or self.Pagination.Total
end

---SetRectangleBanner
---@param R number
---@param G number
---@param B number
---@param A number
---@return nil
---@public
function RageUIMenus:SetRectangleBanner(R, G, B, A)
    self.Rectangle = { R = tonumber(R) or 255, G = tonumber(G) or 255, B = tonumber(B) or 255, A = tonumber(A) or 255 }
    self.Sprite = nil
end

---SetSpriteBanner
---@param TextureDictionary string
---@param Texture string
---@return nil
---@public
function RageUIMenus:SetSpriteBanner(TextureDictionary, Texture)
    self.Sprite = { Dictionary = TextureDictionary or "commonmenu", Texture = Texture or "interaction_bgd" }
    self.Rectangle = nil
end

function RageUIMenus:Closable(boolean)
    if type(boolean) == "boolean" then
        self.Closable = boolean
    else
        error("Type is not boolean")
    end
end

function RageUIMenus:IsClosable()
    return self.Closable;
end

---@return boolean
function RageUIMenus:IsOpen()
    return self.open;
end

---@param parent UIMenu
function RageUIMenus:SetHasSubMenu(parent)

    if (parent.id) then

        self:CleanParentSubMenu();
        table.insert(SubMenus[parent.id], self.id);
        self.Parent = parent;

    end

end

---PERFORM A CLEAN FOR OPTIMIZATION PURPOSE
function RageUIMenus:CleanParentSubMenu()

    if self.Parent ~= nil then

        for i = 1, #SubMenus[self.Parent.id] do

            if (SubMenus[self.Parent.id][i] == self.id) then

                table.remove(SubMenus[self.Parent.id], i);
                self.Parent = nil
                break;

            end

        end

    end

end

function RageUIMenus:SetClosable(boolean)
    if type(boolean) == "boolean" then
        self.Closable = boolean
    else
        error("Type is not boolean")
    end
end

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

function RageUIMenus:GetSubMenus()
    if #SubMenus[self.id] > 0 then
        for _, submenu in pairs(SubMenus[self.id]) do
            RageUI.IsVisible(Menus[submenu])
            Menus[submenu]:GetSubMenus();
        end
    end
end

function RageUIMenus:Open()
    CreateThread(function()
        if RageUI.GetCurrentMenu() == nil then
            --OPEN
            local Audio = RageUI.Settings.Audio;
            RageUI.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef);
            RageUI.Visible(self, true);
            RageUI.NotificationEnabled = false;
            CreateThread(function()
                while RageUI.CurrentMenu ~= nil do
                    RageUI.DisableControlsOnMenu()
                    RageUI.IsVisible(self)
                    self:GetSubMenus();
                    Wait(1)
                end
            end);
        end
    end)
end

---@return void
function RageUIMenus:Close()
    if RageUI.GetCurrentMenu() == self then
        if (self.Closed) then
            self.Closed();
        end
        RageUI.Visible(self, false);
        self.Index = 1
        self.Pagination.Minimum = 1
        self.Pagination.Maximum = self.Pagination.Total
        RageUI.CurrentMenu = nil
        ResetScriptGfxAlign()
        local Audio = RageUI.Settings.Audio
        if (not RageUI.NextMenu) then
            RageUI.NotificationEnabled = true;
        end
        RageUI.PlaySound(Audio[Audio.Use].Select.audioName, Audio[Audio.Use].Select.audioRef)
        return
    end
    if #SubMenus[self.id] > 0 then
        for _, submenu in pairs(SubMenus[self.id]) do
            if RageUI.GetCurrentMenu() ~= nil then
                Menus[submenu]:Close();
            end
        end
    end
end

---@return UIMenu | boolean
function RageUIMenus:IsShowing()
    
    if (RageUI.CurrentMenu == self) then

        return self;

    end

    if (#SubMenus[self.id] > 0) then

        for _, submenu in pairs(SubMenus[self.id]) do

            if (RageUI.CurrentMenu ~= nil) then

                local Menu = Menus[submenu]:IsShowing();

                if (Menu) then

                    return Menu;

                end

            end
            
        end

    end

    return false;

end

function RageUIMenus:Toggle()
    CreateThread(function()
        if RageUI.GetCurrentMenu() ~= nil then
            local Audio = RageUI.Settings.Audio
            RageUI.PlaySound(Audio[Audio.Use].Back.audioName, Audio[Audio.Use].Back.audioRef)
            RageUI.GetCurrentMenu():Close();
        else
            self:Open();
        end
    end)
end

---@param key string
---@param value any
function RageUIMenus:SetData(key, value)
    self.data[key] = value
    return self.data[key]
end

---@param key string
function RageUIMenus:GetData(key)
    return self.data[key]
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
---@return UIMenu
---@public
function RageUI.CreateMenu(Title, Subtitle, X, Y, TextureDictionary, TextureName, R, G, B, A)
    return RageUIMenus:CreateMenu(Title, Subtitle, X, Y, TextureDictionary, TextureName, R, G, B, A);
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
---@return UIMenu
---@public
function RageUI.CreateSubMenu(ParentMenu, Title, Subtitle, X, Y, TextureDictionary, TextureName, R, G, B, A)
    if ParentMenu ~= nil then
        if ParentMenu then
            local Menu = RageUIMenus:CreateMenu(Title or ParentMenu.Title, Subtitle or ParentMenu.Subtitle, X or ParentMenu.X, Y or ParentMenu.Y)
            Menu.Parent = ParentMenu
            Menu.WidthOffset = ParentMenu.WidthOffset
            Menu.Safezone = ParentMenu.Safezone
            if ParentMenu.Sprite then
                Menu.Sprite = { Dictionary = TextureDictionary or ParentMenu.Sprite.Dictionary, Texture = TextureName or ParentMenu.Sprite.Texture, Color = { R = R or ParentMenu.Sprite.Color.R, G = G or ParentMenu.Sprite.Color.G, B = B or ParentMenu.Sprite.Color.B, A = A or ParentMenu.Sprite.Color.A } }
            else
                Menu.Rectangle = ParentMenu.Rectangle
            end
            SubMenus[ParentMenu.id][#SubMenus[ParentMenu.id] + 1] = Menu.id;
            return Menu
        else
            return nil
        end
    else
        return nil
    end
end
