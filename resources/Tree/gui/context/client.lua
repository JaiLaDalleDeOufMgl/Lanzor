---
--- @author Dylan MALANDAIN, Kalyptus
--- @version 1.0.0
--- File created at [26/05/2021 10:22]
---

local Settings = {
    Button = {
        Width = 220,
        Height = 32,
        Background = {
            { 0, 0, 0, 180 },
            { 240, 240, 240, 255 }
        }
    },
    Text = {
        Colors = {
            { 255, 255, 255, 255 },
            { 5, 5, 5, 255 }
        },
        X = 8.0,
        Y = 4.5,
        Scale = 0.26,
        Font = 0,
        Center = 0,
        Outline = false,
        DropShadow = false,
    },
    Title = {
        Background = { 0, 0, 0, 180 },
        Text = { 255, 255, 255, 255 }
    }
}

Tree.ContextUI = {
    Entity = {
        ID = nil,
        Type = nil,
        Model = nil,
        NetID = nil,
        ServerID = nil,
    },
    Menus = {},
    Focus = false,
    Open = false,
    Position = vector2(0.0, 0.0),
    Offset = vector2(0.0, 0.0),
    Options = 0,
    Category = "main",
    CategoryID = 0,
    Description = nil,
}

function Tree.ContextUI:OnClosed()
    ResetEntityAlpha(self.Entity.ID)
    self.Entity.ID = nil
    self.Open = false
    self.Focus = false
    self.Category = "main"
    self.Options = 0
end

local function ShowTitle(Label)
    local PosX, PosY = Tree.ContextUI.Position.x, Tree.ContextUI.Position.y
    PosY = PosY + (Tree.ContextUI.Options * Settings.Button.Height)
    Graphics.Rectangle(PosX, PosY, Settings.Button.Width, Settings.Button.Height, Settings.Title.Background[1], Settings.Title.Background[2], Settings.Title.Background[3], Settings.Title.Background[4])
    Graphics.Text(Label, PosX + 110, PosY + 4.0, Settings.Text.Font, 0.28, Settings.Title.Text[1], Settings.Title.Text[2], Settings.Title.Text[3], Settings.Title.Text[4], 1, false, false)
    Tree.ContextUI.Options = Tree.ContextUI.Options + 1
    Tree.ContextUI.Offset = vector2(PosX, PosY)
end

local function ShowDescription(Description)
    local PosX, PosY = Tree.ContextUI.Position.x, Tree.ContextUI.Position.y
    PosY = PosY + (Tree.ContextUI.Options * Settings.Button.Height)
    local GetLineCount = Graphics.GetLineCount(Description, PosX + 110, PosY, Settings.Text.Font, 0.24, Settings.Title.Text[1], Settings.Title.Text[2], Settings.Title.Text[3], Settings.Title.Text[4], 1, false, false, 215)
    Graphics.Rectangle(PosX, PosY, Settings.Button.Width, 2, Settings.Title.Background[1], Settings.Title.Background[2], Settings.Title.Background[3], Settings.Title.Background[4])
    Graphics.Rectangle(PosX, PosY + 2, Settings.Button.Width, 1 + (GetLineCount * 17.5), 0, 0, 0, 160)
    Graphics.Text(Description, PosX + 110, PosY, Settings.Text.Font, 0.24, Settings.Title.Text[1], Settings.Title.Text[2], Settings.Title.Text[3], Settings.Title.Text[4], 1, false, false, 215)
    Tree.ContextUI.Offset = vector2(PosX, PosY + 3 +(GetLineCount * 17.5))
end

function Tree.ContextUI:Button(Label, Description, Actions, Submenu)
    local PosX, PosY = self.Position.x, self.Position.y
    PosY = PosY + (self.Options * Settings.Button.Height)
    local onHovered = Graphics.IsMouseInBounds(PosX, PosY, Settings.Button.Width, Settings.Button.Height)

    if (onHovered) then
        local Selected = false;
        SetMouseCursorSprite(5)
        if IsControlJustPressed(0, 24) then
            Selected = true
            if (Submenu) then
                self.Category = Submenu.Category
            end
            local audioName = Label == "← Retour" and "BACK" or "SELECT"
            Tree.Gui.Audio.PlaySound("HUD_FRONTEND_DEFAULT_SOUNDSET", audioName, false)
        end
        if (Actions) then
            Actions(Selected)
        end
        self.Description = Description
    end

    local Index = (not onHovered) and 1 or 2
    Graphics.Rectangle(PosX, PosY, Settings.Button.Width, Settings.Button.Height, Settings.Button.Background[Index][1], Settings.Button.Background[Index][2], Settings.Button.Background[Index][3], Settings.Button.Background[Index][4])
    Graphics.Text(Label, PosX + Settings.Text.X, PosY + Settings.Text.Y, Settings.Text.Font, Settings.Text.Scale, Settings.Text.Colors[Index][1], Settings.Text.Colors[Index][2], Settings.Text.Colors[Index][3], Settings.Text.Colors[Index][4], Settings.Text.Center, Settings.Text.Outline, Settings.Text.DropShadow)
    self.Options = self.Options + 1
    self.Offset = vector2(PosX, PosY)
end

function Tree.ContextUI:Visible()
    SetMouseCursorSprite(1)
    self.Menus[self.Entity.Type .. self.Category]()
    local X, Y = 1920, 1080
    local lastX, lastY = self.Offset.x, self.Offset.y
    if (lastY + (not self.Description and Settings.Button.Height or 0)) >= Y then
        self.Position = vector2(self.Position.x, self.Position.y - 10.0)
    end
    if (lastX + Settings.Button.Width) >= X then
        self.Position = vector2(self.Position.x - 10.0, self.Position.y)
    end
    self.Options = 0;
    self.Description = nil;
end

function Tree.ContextUI:CreateMenu(EntityType, Title)
    return { EntityType = EntityType, Category = "main", Parent = nil, Title = Title }
end

function Tree.ContextUI:CreateSubMenu(Parent, Title)
    local category = self.CategoryID + 1
    self.CategoryID = category;
    return { EntityType = Parent.EntityType, Category = category, Parent = Parent, Title = Title }
end

function Tree.ContextUI:IsVisible(Menu, Callback)
    self.Menus[Menu.EntityType .. Menu.Category] = function()
        if (Menu.Title) then
            ShowTitle(Menu.Title)
        end
        Callback(self.Entity)
        if Menu.Parent then
            self:Button("← Retour", nil, nil, Menu.Parent)
        end
        if (self.Description) then
            ShowDescription(self.Description)
        end
    end
end

Citizen.CreateThread(function()
    local controls_actions = { 239, 240, 24, 25 }
    while true do
        local Timer = 250;
        if (Tree.ContextUI.Focus) then
            DisableAllControlActions(2)
            SetMouseCursorActiveThisFrame()
            for _, control in ipairs(controls_actions) do
                EnableControlAction(0, control, true)
            end
            if (not Tree.ContextUI.Open) then
                local isFound, entityCoords, surfaceNormal, entityHit, entityType, cameraDirection, mouse = Graphics.ScreenToWorld(35.0, 31)
                if (entityType ~= 0) then
                    SetMouseCursorSprite(5)
                    if Tree.ContextUI.Entity.ID ~= entityHit then
                        ResetEntityAlpha(Tree.ContextUI.Entity.ID)
                        Tree.ContextUI.Entity.ID = entityHit
                        SetEntityAlpha(Tree.ContextUI.Entity.ID, 200, false)
                    end
                    if IsControlJustPressed(0, 24) or IsDisabledControlPressed(0, 24) then
                        if (Tree.ContextUI.Menus[entityType .. Tree.ContextUI.Category] ~= nil) then
                            local posX, posY = Graphics.ConvertToPixel(mouse.x, mouse.y)
                            Tree.ContextUI.Position = vector2(posX, posY)
                            Tree.ContextUI.Entity = {
                                ID = entityHit,
                                Type = entityType,
                                Model = GetEntityModel(entityHit) or 0,
                                NetID = NetworkGetNetworkIdFromEntity(entityHit),
                                ServerID = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entityHit))
                            }
                            Tree.ContextUI.Open = true
                            Tree.Gui.Audio.PlaySound("HUD_FRONTEND_DEFAULT_SOUNDSET", "SELECT", false)
                        end
                    end
                else
                    if (Tree.ContextUI.Entity.ID ~= nil) then
                        ResetEntityAlpha(Tree.ContextUI.Entity.ID)
                        Tree.ContextUI.Entity.ID = nil
                    end
                    SetMouseCursorSprite(1)
                end
            else
                Tree.ContextUI:Visible()
            end
            DisablePlayerFiring(PlayerPedId(), true)
            Timer = 1;
        elseif (Tree.ContextUI.Entity.ID ~= nil) then
            Tree.ContextUI:OnClosed()
        end
        Citizen.Wait(Timer)
    end
end)