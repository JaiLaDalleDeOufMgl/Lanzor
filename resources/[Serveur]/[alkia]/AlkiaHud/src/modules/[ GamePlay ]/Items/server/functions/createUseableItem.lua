function MOD_Items:createUsableItem(itemName, callback)
    if (self.ItemsCache[itemName]) then
        self.ItemsCache[itemName].isUsable = true
        self.ItemsCache[itemName].usable = {
            callback = callback
        }
        -- print("This item "..itemName.." has ben add on items cache.")
    else
        -- print("Item "..itemName.." does not exist.")
    end
end


CreateThread(function()
    Wait(1000)
    exports['Framework']:SetRegisterItem()
end)