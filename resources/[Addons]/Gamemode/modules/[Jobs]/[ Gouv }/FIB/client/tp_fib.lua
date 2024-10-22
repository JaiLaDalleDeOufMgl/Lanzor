local lift = {
    teleport = {
        [0] =  {pos = vector3(2497.21, -349.4678, 94.09224), name = "1 - Hall d'entrée"},
        [1] =  {pos = vector3(2497.28,  -349.1656, 101.8933), name = "2 - Laboratoire et Armurie"},
        [2] =  {pos = vector3(2497.738,  -349.0152, 105.6906), name = "3 - Cellules et salle interrogatoires"},
    },
}

local function openMenu(select)
    local mainMenu = RageUI.CreateMenu("", "Ascenseur FIB")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while mainMenu do
        Wait(1)
        RageUI.IsVisible(mainMenu, function()
            RageUI.Line()
            for k,v in pairs(lift.teleport) do
                RageUI.Button(v.name, nil, {RightLabel =  ""}, v.pos ~= select.pos, {
                    onSelected = function ()
                        SetEntityCoordsNoOffset(PlayerPedId(), v.pos)
                        SetEntityHeading(PlayerPedId(), 33.0)
                        ESX.ShowNotification("Vous êtes bien arrivé a l'étage "..v.name)
                        RageUI.CloseAll()
                    end
                })
            end
        end)

        if not RageUI.Visible(mainMenu) then
            mainMenu = RMenu:DeleteType("menu", true)
        end
    end
end

CreateThread(function()
    while true do
        local waiting = 1000
        local myCoords = GetEntityCoords(PlayerPedId())

        for k,v in pairs(lift.teleport) do
            if #(myCoords-v.pos) < 2.0 then
                waiting = 0
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~o~choisir votre étage~s~.")
                if IsControlJustReleased(0, 54) then
                    openMenu(v)
                end
            end
        end

        Wait(waiting)
    end
end)