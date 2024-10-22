function _GamemodeBuckets:IsRegistered(entity, _type)
    assert(type(entity) == "string" or type(entity) == "number", "Entity must be a string or a number")
    assert(type(_type) == "string", "_type must be a string")

    if (_type == "object") then
        for index, BuckEntity in pairs(self.objectsInBuckets) do
            if (BuckEntity == entity) then 
                return true, index
            end
        end

        return (false)
    elseif (_type == "player") then
        for index, BuckEntity in pairs(self.playersInBuckets) do
            if (BuckEntity == entity) then 
                return true, index
            end
        end

        return (false)
    else
        print("Error: type must be object or player")
        return (false)
    end
end