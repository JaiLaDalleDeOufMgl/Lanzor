---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Dylan Malandain.
--- DateTime: 29/10/2019 02:40
---

---@type table
RageUIc = {}

---@type table
RMenuc = setmetatable({}, RMenuc)

---@type table
local TotalMenus = {}

---Add
---@param Type string
---@param Name string
---@param Menu table
---@return _G
---@public
function RMenuc.Add(Type, Name, Menu)
    if RMenuc[Type] ~= nil then
        RMenuc[Type][Name] = {
            Menu = Menu
        }
    else
        RMenuc[Type] = {}
        RMenuc[Type][Name] = {
            Menu = Menu
        }
    end
    table.insert(TotalMenus, Menu)
end

---Get
---@param Type string
---@param Name string
---@return table
---@public
function RMenuc:Get(Type, Name)
    if self[Type] ~= nil and self[Type][Name] ~= nil then
        return self[Type][Name].Menu
    end
end

---Settings
---@param Type string
---@param Name string
---@param Settings string
---@param Value any
---@return void
---@public
function RMenuc:Settings(Type, Name, Settings, Value)
    self[Type][Name][Settings] = Value
end


---Delete
---@param Type string
---@param Name string
---@return void
---@public
function RMenuc:Delete(Type, Name)
    self[Type][Name] = nil
end

---DeleteType
---@param Type string
---@return void
---@public
function RMenuc:DeleteType(Type)
    self[Type] = nil
end