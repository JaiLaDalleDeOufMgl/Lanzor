Tree.Function.Blips = {}
Tree.Function.Blips.cache = {}

---@class Blips : __Blips
---@param name string
---@param coords table
---@param id number
---@param colour number
---@param title string
function Tree.Function.Blips.create(name, coords, id, colour, title)
    if not Tree.Function.Blips.cache[name] then
        Tree.Function.Blips.cache[name] = {}
    else
        Tree.Function.Blips.delete(name)
    end
    Tree.Function.Blips.cache[name] = AddBlipForCoord(coords)
    SetBlipSprite(Tree.Function.Blips.cache[name], id)
    SetBlipDisplay(Tree.Function.Blips.cache[name], 4)
    SetBlipScale(Tree.Function.Blips.cache[name], 0.6)
    SetBlipColour(Tree.Function.Blips.cache[name], colour)
    SetBlipAsShortRange(Tree.Function.Blips.cache[name], true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(title)
    EndTextCommandSetBlipName(Tree.Function.Blips.cache[name])
    return Tree.Function.Blips.cache[name]
end

---@param name string
---@param coords table
---@param radius number
function Tree.Function.Blips.createRadius(name, coords, radius)
    if not Tree.Function.Blips.cache[name] then
        Tree.Function.Blips.cache[name] = {}
    else
        Tree.Function.Blips.delete(name)
    end
    Tree.Function.Blips.cache[name] = AddBlipForRadius(coords.x, coords.y, coords.z, radius + 0.0)
    SetBlipSprite(Tree.Function.Blips.cache[name], 9)
    SetBlipColour(Tree.Function.Blips.cache[name], 1)
    SetBlipAlpha(Tree.Function.Blips.cache[name], 100)

    return Tree.Function.Blips.cache[name]
end

---@param name string
function Tree.Function.Blips.delete(name)
    if Tree.Function.Blips.cache[name] then
        RemoveBlip(Tree.Function.Blips.cache[name])
        Tree.Function.Blips.cache[name] = nil
    end
end

---@param name string
---@param id number
function Tree.Function.Blips.setSprite(name, id)
    if Tree.Function.Blips.cache[name] then
        SetBlipSprite(Tree.Function.Blips.cache[name], id)
    end
end

---@param name string
---@param colour number
function Tree.Function.Blips.setColor(name, colour)
    if Tree.Function.Blips.cache[name] then
        SetBlipColour(Tree.Function.Blips.cache[name], colour)
    end
end

---@param name string
---@param scale number
function Tree.Function.Blips.setScale(name, scale)
    if Tree.Function.Blips.cache[name] then
        SetBlipScale(Tree.Function.Blips.cache[name], scale)
    end
end

---@param name string
---@param title string
function Tree.Function.Blips.setTitle(name, title)
    if Tree.Function.Blips.cache[name] then
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(title)
        EndTextCommandSetBlipName(Tree.Function.Blips.cache[name])
    end
end

---@param name string
---@param category number
function Tree.Function.Blips.setCategory(name, category)
    if Tree.Function.Blips.cache[name] then
        SetBlipCategory(Tree.Function.Blips.cache[name], category)
    end
end