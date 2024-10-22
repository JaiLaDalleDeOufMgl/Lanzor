function _GamemodeInventory:getPlayerCloset()
    local Players = ESX.Game.GetPlayers()
    local PlayerPed = PlayerPedId()
    local Coords = GetEntityCoords(PlayerPed)

    for i=1, #Players, 1 do
        local target = GetPlayerPed(Players[i])
        local targetCoords = GetEntityCoords(target)
        local distance = #(targetCoords - Coords)

        if #Players <= 1 then
            ESX.ShowNotification(exports.Tree:serveurConfig().Serveur.color..'Il n\'y a aucun joueur autour de vous !')
            self.CurrentGiveItem = false
        end

        if (distance < 3) then
            table.insert(self.GiveItemTablePlayer, Players[i])
        end
    end
end