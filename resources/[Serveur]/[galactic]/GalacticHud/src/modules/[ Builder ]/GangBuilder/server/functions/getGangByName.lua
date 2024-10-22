function MOD_GangBuilder:getGangByName(jobName)

    for id, gang in pairs(self.list) do
        if (gang.name == jobName) then
            return gang
        end
    end

    return false
end