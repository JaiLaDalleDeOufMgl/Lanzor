function API_Logs:Warn(message, ...)
    self:send("warn", message, ...);
end

exports("Warn", function(message, ...)
    API_Logs:Warn(message, ...)
end)