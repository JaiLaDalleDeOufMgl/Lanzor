---trim
---@param number number
---@return number
---@public
function API_Maths:trim(number)
	print(number)
	return (string.gsub(number, "^%s*(.-)%s*$", "%1"))
end
