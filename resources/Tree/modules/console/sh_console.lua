Tree.Console = {}

Tree.Console.infos = {
    ["INFO"] = "^4INFO^7",
    ["WARN"] = "^3WARNING^7",
    ["SUCCESS"] = "^2SUCCESS^7",
    ["ERROR"] = "^1ERROR^7",
    ["DEBUG"] = "^2DEBUG^7"
}

--- @param types string Type du message (INFO, WARN, SUCCESS, ERROR, DEBUG).
--- @param info string|table Information à afficher, peut être une chaîne ou une table à déboguer.
--- @param ... any Paramètres optionnels à inclure dans le message.
function Tree.Console.Send(types, info, ...)
    if types == "DEBUG" and not Tree.Config.debugMode then
        return
    end
    local language = debug.getinfo(2, "nSlfL").what
    local message, time

    local function dumpTable(tbl, indent)
        indent = indent or 0
        local toprint = string.rep(" ", indent).. "{\n"
        indent = indent + 2
        for k,v in pairs(tbl) do
            toprint = toprint .. string.rep(" ", indent)
            if type(k) == "string" then
                toprint = toprint .. string.format("^3\"%s\"^7", k) .. " = "
            else
                toprint = toprint .. string.format("^3[%s]^7", k) .. " = "
            end
            if type(v) == "table" then
                toprint = toprint .. dumpTable(v, indent + 2) .. ",\n"
            else
                toprint = toprint .. string.format("^2%s^7", tostring(v)) .. ",\n"
            end
        end
        toprint = toprint.. string.rep(" ", indent - 2).."}"
        return toprint
    end

    if type(info) == "string" then
        message = info
    elseif type(info) == "table" then
        message = dumpTable(info, 0)
    end

    print(("[%s] [^6%s^7] %s"):format(Tree.Console.infos[types] or "DEBUG", language, message), ...)
end

--- @param message string Message à afficher.
function Tree.Console.Info(message, ...)
    Tree.Console.Send("INFO", message, ...)
end

--- @param message string Message à afficher.
function Tree.Console.Warn(message, ...)
    Tree.Console.Send("WARN", message, ...)
end

--- @param message string Message à afficher.
function Tree.Console.Success(message, ...)
    Tree.Console.Send("SUCCESS", message, ...)
end

--- @param message string Message à afficher.
function Tree.Console.Error(message, ...)
    Tree.Console.Send("ERROR", message, ...)
end

--- @param message string Message à afficher.
function Tree.Console.Debug(message, ...)
    Tree.Console.Send("DEBUG", message, ...)
end

--- @param tbl table La table à afficher.
function Tree.Console.Array(tbl)
    if #tbl == 0 then
        Tree.Console.Error("Table vide")
        return
    end

    local columns = {}
    for key in pairs(tbl[1]) do
        table.insert(columns, key)
    end

    local colWidths = {}
    for _, col in ipairs(columns) do
        colWidths[col] = #col
        for _, row in ipairs(tbl) do
            colWidths[col] = math.max(colWidths[col], #tostring(row[col]))
        end
    end

    local function createLine(sep, left, right)
        local line = left
        for _, col in ipairs(columns) do
            line = line .. string.rep("─", colWidths[col] + 2) .. sep
        end
        line = line:sub(1, -2) .. right
        return line
    end

    print(createLine("┬", "┌", "┐"))

    local headerRow = "|"
    for _, col in ipairs(columns) do
        headerRow = headerRow .. " " .. col .. string.rep(" ", colWidths[col] - #col) .. " |"
    end
    print(headerRow)
    print(createLine("┼", "├", "┤"))

    for i, row in ipairs(tbl) do
        local rowLine = "|"
        for _, col in ipairs(columns) do
            local value = tostring(row[col])
            rowLine = rowLine .. " " .. value .. string.rep(" ", colWidths[col] - #value) .. " |"
        end
        print(rowLine)
    end

    print(createLine("┴", "└", "┘"))
end

-- Tree.Console.Array({
--     {Plan = "Hebdomadaire", Prix = "5.99$", ["VIP Access"] = "Non"},
--     {Plan = "Mensuel", Prix = "9.99$", ["VIP Access"] = "Non"},
--     {Plan = "Trimestriel", Prix = "14.99$", ["VIP Access"] = "Non"},
--     {Plan = "Hebdomadaire", Prix = "5.99$", ["VIP Access"] = "Non"},
--     {Plan = "Life Time", Prix = "49.99$", ["VIP Access"] = "Non"},
-- })