---unformatTime
---@param tblTime table
---@return number
---@public
function API_Maths:unformatTime(tblTime)
    local years  = tblTime.years or 0
    local months  = tblTime.months or 0
    local days  = tblTime.days or 0
    local hours  = tblTime.hours or 0
    local minutes  = tblTime.minutes or 0
    local seconds  = tblTime.seconds or 0
    return (years * 31536000 + months * 2592000 + days * 86400 + hours * 3600 + minutes * 60 + seconds)
end