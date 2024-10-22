local lift = {
    teleport = {
        [0] =  {pos = vector3(-1096.3, -850.5, 4.88), name = "-1 - Garage"},
        [1] =  {pos = vector3(-1096.46, -850.15, 10.28), name = "1 - Laboratoire"},
        [2] =  {pos = vector3(-1096.09, -850.3, 13.69), name = "2 - Armurie"},
        [3] =  {pos = vector3(-1096.23, -850.27, 19.0), name = "3 - Hall d'entrée"},
        [4] =  {pos = vector3(-1095.71, -850.56, 23.04), name = "4 - Etages"},
        [5] =  {pos = vector3(-1096.05, -850.67, 26.83), name = "5 - Vestiaire"},
        [6] =  {pos = vector3(-1096.09, -850.64, 30.76), name = "6 - Etages"},
        [7] =  {pos = vector3(-1096.18, -850.25, 34.36), name = "7 - Bureau Chef"},
        [8] =  {pos = vector3(-1096.31, -850.22, 38.24), name = "8 - Hélipad"},
    },
}

local function openMenuLSPD(select)
    local mainMenu = RageUI.CreateMenu("", "Ascenseur LSPD")

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
        local waiting = 250
        local myCoords = GetEntityCoords(PlayerPedId())

        for k,v in pairs(lift.teleport) do
            if #(myCoords-v.pos) < 1.0 then
                waiting = 1
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~o~choisir votre étage~s~.")
                if IsControlJustReleased(0, 54) then
                    openMenuLSPD(v)
                end
            end
        end

        Wait(waiting)
    end
end)