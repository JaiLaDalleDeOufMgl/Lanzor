function MOD_Status:getState()
    local status = {}

    for key, statu in pairs(self.list) do
        status[key] = statu.val
    end

    return (status)
end