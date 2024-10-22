---formatTime
---@param seconds number
---@return table
---@public
function API_Maths:formatTime(seconds)
    seconds = seconds or 0
    local hours  = math.floor(seconds/3600)
    local minutes  = math.floor((seconds/60)%60)
    seconds = math.floor(seconds%60)

    return { hours = hours, minutes = minutes, seconds = seconds}
end
