
local function convertArgs(args)
    local argsConverted = {};
    if (#args > 0) then
        for i = 1, #args do
            if (type(args[i]) == "table") then
                argsConverted[i] = json.encode(args[i], {indent = true}); --Shared.Table:Dump(args[i]);
            elseif (type(args[i]) == "boolean" or type(args[i]) == "number" or args[i] == nil or type(args[i]) == "string") then
                argsConverted[i] = tostring(args[i]);
            end
        end
    else
        argsConverted = nil;
    end
    return argsConverted
end

function API_Logs:convertMessage(logType, message, messageType, ...)
    local msg = string.format("^7[%s^7]^0 => ^7[%s^7]^0 => %s", self:getSide(), self.types[logType], message)
    local args = convertArgs({...})

    if (messageType == "string" or messageType == "boolean" or messageType == "number" or message == nil) then
        msg = string.format("^7[%s^7]^0 => ^7[%s^7]^0 => %s", self:getSide(), self.types[logType], tostring(message))
        if (args) then
            for i = 1, #args do
                msg = string.format("%s %s", msg, args[i]);
            end
        end
    elseif (messageType == "table") then
        msg = string.format("^7[%s^7]^0 => ^7[%s^7]^0 => %s", self:getSide(), self.types[logType], json.encode(message, {indent = true}));--json.encode(message, {indent = true})--Shared.Table:Dump(message)
        if (args) then
            for i = 1, #args do
                msg = string.format("%s %s", msg, args[i]);
            end
        end
    end

    return msg
end