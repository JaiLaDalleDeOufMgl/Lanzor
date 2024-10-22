---requestAnimDict
---@param animDict string
---@return any
---@public
function API_Streaming:requestAnimDict(animDict, callback)
    if (not HasAnimDictLoaded(animDict)) then
        RequestAnimDict(animDict);

        while (not HasAnimDictLoaded(animDict)) do
            Wait(0);
        end
    end

    if (callback) then
        callback();
    end
end