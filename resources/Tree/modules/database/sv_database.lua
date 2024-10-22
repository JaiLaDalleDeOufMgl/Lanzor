Tree.Database = {}
Tree.Database.requests = {}

local function getFullPath(filePath)
    return ("resources/%s/data/%s"):format(GetCurrentResourceName(), filePath)
end

--- @param filePath string Le chemin du fichier à charger.
--- @return table Le contenu décodé du fichier JSON.
--- @example local data = Tree.Database.loadFile("example.json")
function Tree.Database.loadFile(filePath)
    local fullPath = getFullPath(filePath)
    local file = io.open(fullPath, "r")
    if not file then
        Tree.Console.Error("File not found: " .. filePath)
        Tree.Database.createFile(filePath)
        return {}
    end
    local data = file:read("*a")
    file:close()
    local decodedData = json.decode(data)
    if not decodedData then
        Tree.Console.Error("Failed to decode JSON from file: " .. filePath)
        return {}
    end
    return decodedData
end

--- @param filePath string Le chemin du fichier où sauvegarder.
--- @param data table Les données à sauvegarder.
--- @example Tree.Database.saveFile("example.json", { key = "value" })
function Tree.Database.saveFile(filePath, data)
    local fullPath = getFullPath(filePath)
    local file = io.open(fullPath, "w")
    if not file then
        Tree.Console.Error("Failed to open file: " .. filePath)
        return
    end
    file:write(json.encode(data, { indent = true }))
    file:close()
end

--- @param filePath string Le chemin du fichier à créer.
--- @example Tree.Database.createFile("example.json")
function Tree.Database.createFile(filePath)
    local fullPath = getFullPath(filePath)
    local file = SaveResourceFile(GetCurrentResourceName(), filePath, "[]", -1)
    if file then
        Tree.Console.Success("File created: " .. filePath)
    else
        Tree.Console.Error("Failed to create file: " .. filePath)
    end
end

--- @param table string Le nom de la table à sélectionner.
--- @param where string Le chemin du fichier JSON.
--- @return table Les données sélectionnées.
--- @example local data = Tree.Database.select("users", "example.json")
function Tree.Database.select(table, where)
    local data = Tree.Database.loadFile(where)
    return data[table] or {}
end

--- @param table string Le nom de la table à mettre à jour.
--- @param where string Le chemin du fichier JSON.
--- @param request table Les nouvelles données pour la table.
--- @example Tree.Database.update("users", "example.json", { id = 1, name = "John" })
function Tree.Database.update(table, where, request)
    local data = Tree.Database.loadFile(where)
    if not data[table] then
        Tree.Console.Error("Table not found in file: " .. where)
        return {}
    end
    data[table] = request
    Tree.Database.saveFile(where, data)
end

--- @param table string Le nom de la table où insérer les données.
--- @param where string Le chemin du fichier JSON.
--- @param request table Les données à insérer.
--- @example Tree.Database.insert("users", "example.json", { id = 1, name = "John" })
function Tree.Database.insert(table, where, request)
    local data = Tree.Database.loadFile(where)
    if not data[table] then
        data[table] = {}
    end
    table.insert(data[table], request)
    Tree.Database.saveFile(where, data)
end

--- @param table string Le nom de la table à supprimer.
--- @param where string Le chemin du fichier JSON.
--- @example Tree.Database.delete("users", "example.json")
function Tree.Database.delete(table, where)
    local data = Tree.Database.loadFile(where)
    data[table] = nil
    Tree.Database.saveFile(where, data)
end

--- @param table string Le nom de la table où ajouter les données.
--- @param where string Le chemin du fichier JSON.
--- @param newData table Les nouvelles données à ajouter.
--- @example Tree.Database.addToTable("users", "example.json", { id = 2, name = "Doe" })
function Tree.Database.addToTable(table, where, newData)
    local data = Tree.Database.loadFile(where)
    if not data[table] then
        data[table] = {}
    end
    if type(data[table]) ~= "table" then
        Tree.Console.Error("Data is not a table in file: " .. where)
        return
    end
    table.insert(data[table], newData)
    Tree.Database.saveFile(where, data)
end

--- @param table string Le nom de la table où supprimer les données.
--- @param where string Le chemin du fichier JSON.
--- @param conditionFunc function La fonction de condition pour déterminer les données à supprimer.
--- @example Tree.Database.removeFromTable("users", "example.json", function(user) return user.id == 2 end)
function Tree.Database.removeFromTable(table, where, conditionFunc)
    local data = Tree.Database.loadFile(where)
    if data[table] then
        for i = #data[table], 1, -1 do
            if conditionFunc(data[table][i]) then
                table.remove(data[table], i)
            end
        end
    end
    Tree.Database.saveFile(where, data)
end

--- @param table string Le nom de la table à mettre à jour.
--- @param where string Le chemin du fichier JSON.
--- @param conditionFunc function La fonction de condition pour déterminer les données à mettre à jour.
--- @param updateFunc function La fonction de mise à jour qui modifie les données.
--- @example Tree.Database.updateInTable("users", "example.json", function(user) return user.id == 1 end, function(user) user.name = "John Doe" return user end)
function Tree.Database.updateInTable(table, where, conditionFunc, updateFunc)
    local data = Tree.Database.loadFile(where)
    if data[table] then
        for i, entry in ipairs(data[table]) do
            if conditionFunc(entry) then
                data[table][i] = updateFunc(entry)
            end
        end
    end
    Tree.Database.saveFile(where, data)
end