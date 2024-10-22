function MOD_Society:getSocietyByName(jobName)
    if (self.list[jobName]) then
        return self.list[jobName]
    end

    return false
end