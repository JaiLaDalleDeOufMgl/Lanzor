local GridPanelVertical = {
    Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 275 },
    Grid = { Dictionary = "RageUIc", Texture = "vertical_grid", X = 115.5, Y = 47.5, Width = 200, Height = 200 },
    Circle = { Dictionary = "mpinventory", Texture = "in_world_circle", X = 115.5, Y = 47.5, Width = 20, Height = 20 },
    Text = {
        Top = { X = 215.5, Y = 15, Scale = 0.35 },
        Bottom = { X = 215.5, Y = 250, Scale = 0.35 },
    },
}

---GridPanelVertical
---@param Y number
---@param TopText string
---@param BottomText string
---@param Callback table
---@param Index number
---@return table
---@public
function RageUIc.GridPanelVertical(Y, TopText, BottomText, Callback, Index)
    local CurrentMenu = RageUIc.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() and (Index == nil or (CurrentMenu.Index == Index)) then

            ---@type boolean
            local Hovered = RageUIc.IsMouseInBounds(CurrentMenu.X + GridPanelVertical.Grid.X + CurrentMenu.SafeZoneSize.X + 20, CurrentMenu.Y + GridPanelVertical.Grid.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUIc.ItemOffset + 20, GridPanelVertical.Grid.Width + CurrentMenu.WidthOffset - 40, GridPanelVertical.Grid.Height - 40)

            ---@type boolean
            local Selected = false

            ---@type number
            local CircleX = CurrentMenu.X + GridPanelVertical.Grid.X + (CurrentMenu.WidthOffset / 2) + 20

            ---@type number
            local CircleY = CurrentMenu.Y + GridPanelVertical.Grid.Y + CurrentMenu.SubtitleHeight + RageUIc.ItemOffset + 20

            local X = 0.5

            if Y < 0.0 or Y > 1.0 then
                Y = 0.0
            end

            CircleX = CircleX + ((GridPanelVertical.Grid.Width - 40) * X) - (GridPanelVertical.Circle.Width / 2)
            CircleY = CircleY + ((GridPanelVertical.Grid.Height - 40) * Y) - (GridPanelVertical.Circle.Height / 2)

            RenderSprite(GridPanelVertical.Background.Dictionary, GridPanelVertical.Background.Texture, CurrentMenu.X, CurrentMenu.Y + GridPanelVertical.Background.Y + CurrentMenu.SubtitleHeight + RageUIc.ItemOffset, GridPanelVertical.Background.Width + CurrentMenu.WidthOffset, GridPanelVertical.Background.Height)
            RenderSprite(GridPanelVertical.Grid.Dictionary, GridPanelVertical.Grid.Texture, CurrentMenu.X + GridPanelVertical.Grid.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + GridPanelVertical.Grid.Y + CurrentMenu.SubtitleHeight + RageUIc.ItemOffset, GridPanelVertical.Grid.Width, GridPanelVertical.Grid.Height)
            RenderSprite(GridPanelVertical.Circle.Dictionary, GridPanelVertical.Circle.Texture, CircleX, CircleY, GridPanelVertical.Circle.Width, GridPanelVertical.Circle.Height)

            RenderText(TopText or "", CurrentMenu.X + GridPanelVertical.Text.Top.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + GridPanelVertical.Text.Top.Y + CurrentMenu.SubtitleHeight + RageUIc.ItemOffset, 0, GridPanelVertical.Text.Top.Scale, 245, 245, 245, 255, 1)
            RenderText(BottomText or "", CurrentMenu.X + GridPanelVertical.Text.Bottom.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + GridPanelVertical.Text.Bottom.Y + CurrentMenu.SubtitleHeight + RageUIc.ItemOffset, 0, GridPanelVertical.Text.Bottom.Scale, 245, 245, 245, 255, 1)

            if Hovered then
                if IsDisabledControlPressed(0, 24) then
                    Selected = true

                    CircleY = math.round(GetControlNormal(0, 240) * 1080) - CurrentMenu.SafeZoneSize.Y - (RageUIc.Settings.Panels.Grid.Circle.Height / 2)

                    if CircleY > (CurrentMenu.Y + RageUIc.Settings.Panels.Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUIc.ItemOffset + 20 + RageUIc.Settings.Panels.Grid.Grid.Height - 40) then
                        CircleY = CurrentMenu.Y + RageUIc.Settings.Panels.Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUIc.ItemOffset + 20 + RageUIc.Settings.Panels.Grid.Grid.Height - 40
                    elseif CircleY < (CurrentMenu.Y + RageUIc.Settings.Panels.Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUIc.ItemOffset + 20 - (RageUIc.Settings.Panels.Grid.Circle.Height / 2)) then
                        CircleY = CurrentMenu.Y + RageUIc.Settings.Panels.Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUIc.ItemOffset + 20 - (RageUIc.Settings.Panels.Grid.Circle.Height / 2)
                    end

                    Y = math.round((CircleY - (CurrentMenu.Y + RageUIc.Settings.Panels.Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUIc.ItemOffset + 20) + (RageUIc.Settings.Panels.Grid.Circle.Height / 2)) / (RageUIc.Settings.Panels.Grid.Grid.Height - 40), 2)

                    if Y > 1.0 then
                        Y = 1.0
                    end
                end
            end
            RageUIc.ItemOffset = RageUIc.ItemOffset + GridPanelVertical.Background.Height + GridPanelVertical.Background.Y
            if Hovered and Selected then
                local Audio = RageUIc.Settings.Audio
                RageUIc.PlaySound(Audio[Audio.Use].Slider.audioName, Audio[Audio.Use].Slider.audioRef, true)
            end
            Callback(Hovered, Selected, Y)
        end
    end
end