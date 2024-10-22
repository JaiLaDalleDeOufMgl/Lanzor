function API_Logs:send(logType, message, ...)
    local msg = self:convertMessage(logType, message, type(message), ...);
    print(msg);
end