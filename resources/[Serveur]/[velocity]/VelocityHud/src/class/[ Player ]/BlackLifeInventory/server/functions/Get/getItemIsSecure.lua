function _GamemodeInventory:getItemIsSecure(item, RemoveReboot)
    if (item.args) then
        if (RemoveReboot) then
            if (item.args.removeReboot) then
                return true
            end
        else
            if (item.args.antiActions) then
                return true
            end
        end
    end

    return false
end