function _GamemodeBuckets:AddInBucket(entity, _type)
    assert(type(entity) == "string" or type(entity) == "number", "Entity must be a string or a number")
    assert(type(_type) == "string", "_type must be a string")

    if (_type == "object") then
        SetEntityRoutingBucket(entity, self.bucket)

        table.insert(self.objectsInBuckets, entity)

        AddEventHandler('onResourceStop', function(resourceName)
            if (GetCurrentResourceName() ~= resourceName) then
                return
            end

            DeleteEntity(entity)
        end)
    elseif (_type == "player") then
        SetPlayerRoutingBucket(entity, self.bucket)

        table.insert(self.playersInBuckets, entity)
    else
        print("Error: type must be object or player")
    end
end