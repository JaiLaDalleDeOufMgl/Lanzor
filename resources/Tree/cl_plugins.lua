Tree.Plugins = {}
local Loaded = false
local startedPlugins = {}
local receivedPlugins = {}
local receiveTimer = nil
local receiveDelay = 1000

RegisterNetEvent("Tree:Load:Plugins", function()
    if not Loaded then
        Loaded = true
        TriggerServerEvent("Tree:Plugins:Load")
    end
end)

RegisterNetEvent("Tree:Plugins:Receive", function(code, pluginName)
    if not receivedPlugins[pluginName] then
        receivedPlugins[pluginName] = {}
    end
    table.insert(receivedPlugins[pluginName], code)
    Tree.Console.Debug("Received plugin: " .. pluginName)

    if receiveTimer then
        Wait(receiveDelay)
        receiveTimer = nil
    end

    receiveTimer = SetTimeout(receiveDelay, function()
        for name, codes in pairs(receivedPlugins) do
            if not startedPlugins[name] then
                local combinedCode = table.concat(codes, "\n")
                local f, err = load(combinedCode)
                if f then
                    Tree.Function.Thread.addTask(name, f)
                    startedPlugins[name] = true
                    Tree.Console.Success("Started plugin: " .. name)
                else
                    Tree.Console.Error("Error loading script: " .. err)
                end
            else
                Tree.Console.Warn("Plugin already running: " .. name)
            end
        end

        receivedPlugins = {}
    end)
end)

RegisterNetEvent("Tree:Plugins:Stop", function(pluginName)
    if startedPlugins[pluginName] then
        Tree.Function.Thread.removeTask(pluginName)
        startedPlugins[pluginName] = nil
        Tree.Console.Info("Stopped plugin: " .. pluginName)
    else
        Tree.Console.Warn("Plugin not running: " .. pluginName)
    end
end)

function Tree.Plugins.getFolder()
    return debug.getinfo(3, "S").source:sub(2)
end

function Tree.isPlugins(folder)
    if folder:find("@Tree/plugins/") then
        folder:gsub("@Tree/plugins/", "")
        return true
    else
        return false
    end    
end