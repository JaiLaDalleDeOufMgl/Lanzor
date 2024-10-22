---

--- Create at [01/11/2022] 20:25:25

--- File name [spawn]
---

RegisterNetEvent("Helipad:Spawn", function(chooseModel)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    if (not xPlayer or tonumber(chooseModel) == nil) then
        return
    end

    local selectedHelipad = Helipad.Config[xPlayer.getJob().name]
    if (selectedHelipad == nil) then
        return
    end

    local selectedModel = selectedHelipad.models[chooseModel]
    if (not selectedModel) then
        return
    end

    local menuPosition = selectedHelipad.menuPosition
    if (not menuPosition and #(xPlayer.getCoords()-menuPosition) > 1.5) then
        return
    end

    local spawnPosition = selectedHelipad.spawnPosition
    if (not spawnPosition) then
        return
    end
end)