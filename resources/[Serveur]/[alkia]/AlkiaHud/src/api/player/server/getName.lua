---getName
---@param playerSrc number
---@return string
---@public
function API_Player:getName(playerSrc)
    if (not playerSrc or playerSrc <= 0) then
        return print("Unable to find name : source is invalid")
    end
    return GetPlayerName(playerSrc)
end