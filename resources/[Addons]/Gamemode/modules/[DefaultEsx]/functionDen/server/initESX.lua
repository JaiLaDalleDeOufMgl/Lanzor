DEN = {}
function DEN:new()
    local DEN = {}
    setmetatable(DEN, self)
    self.__index = self
    return DEN
end

DEN = DEN:new()