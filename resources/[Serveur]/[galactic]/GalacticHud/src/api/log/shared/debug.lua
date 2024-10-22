function API_Logs:Debug(message, ...)
    -- if (Config["Debug"]) then
        self:send("debug", message, ...);
    -- end
end