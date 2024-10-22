function API_Logs:Info(message, ...)
    self:send("info", message, ...);
end