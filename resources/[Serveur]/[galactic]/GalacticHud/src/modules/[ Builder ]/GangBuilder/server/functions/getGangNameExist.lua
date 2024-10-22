function MOD_GangBuilder:getGangNameExist(name)
    for id, gang in pairs(self.list) do
        if (gang.name == name) then
            return true
        end
    end
end