function API_Streaming:Spawn(objectHash, coords, callback)
    local model = type(objectHash) == 'number' and objectHash or GetHashKey(objectHash);
    local vector = type(coords) == "vector3" and coords or vec(coords.x, coords.y, coords.z);

    CreateThread(function()
        API_Streaming:requestModel(model)

        local obj = CreateObject(model, vector.xyz, false, false, true)
        if (callback) then
            callback(obj);
        end
    end);
end