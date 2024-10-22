function MOD_inventory:getItemSecurActions(item)
    if (item.args) then
        if (item.args.antiActions) then
            return true
        end
    end

    return false
end