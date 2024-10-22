

RegisterNetEvent("BoatLegal:Spawn", function(chooseModel)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    if (not xPlayer or tonumber(chooseModel) == nil) then
        return
    end

    local selectedBoatLegal = BoatLegal.Config[xPlayer.getJob().name]
    if (selectedBoatLegal == nil) then
        return
    end

    local selectedModel = selectedBoatLegal.models[chooseModel]
    if (not selectedModel) then
        return
    end

    local menuPosition = selectedBoatLegal.menuPosition
    if (not menuPosition and #(xPlayer.getCoords()-menuPosition) > 1.5) then
        return
    end

    local spawnPosition = selectedBoatLegal.spawnPosition
    if (not spawnPosition) then
        return
    end
end)