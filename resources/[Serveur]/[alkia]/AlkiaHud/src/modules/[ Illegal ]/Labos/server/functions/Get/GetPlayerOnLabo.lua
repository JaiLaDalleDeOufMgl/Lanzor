function MOD_Labos:GetPlayerOnLabo(xPlayer)
    for LaboId in pairs(self.list) do
        local Labo = self.list[LaboId]

        for index, PlySource in pairs(Labo.ListPlayerOnLabo) do
            if (xPlayer.source == PlySource) then
                return self.list[LaboId]
            end
        end
    end

    return false
end