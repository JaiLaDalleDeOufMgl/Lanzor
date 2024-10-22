Tree.Function.While = {}
Tree.Function.While.cache = {
    [0] = {},
    [250] = {},
    [500] = {},
    [1000] = {},
    [5000] = {},
    [15000] = {}
}

function Tree.Function.While.addTick(type, name, func)
    Tree.Function.While.cache[type][name] = func;
end

function Tree.Function.While.removeTick(name)
    for k, v in pairs(Tree.Function.While.cache) do
        v[name] = nil;
    end
end

CreateThread(function()
    while true do
        Wait(0);
        for k, func in pairs(Tree.Function.While.cache[0]) do
            func();
        end
    end
end)

CreateThread(function()
    while true do
        Wait(250);
        for k, func in pairs(Tree.Function.While.cache[250]) do
            func();
        end
    end
end)

CreateThread(function()
    while true do
        Wait(500);
        for k, func in pairs(Tree.Function.While.cache[500]) do
            func();
        end
    end
end)

CreateThread(function()
    while true do
        Wait(1000);
        for k, func in pairs(Tree.Function.While.cache[1000]) do
            func();
        end
    end
end)

CreateThread(function()
    while true do
        Wait(5000);
        for k, func in pairs(Tree.Function.While.cache[5000]) do
            func();
        end
    end
end)

CreateThread(function()
    while true do
        Wait(15000);
        for k, func in pairs(Tree.Function.While.cache[15000]) do
            func();
        end
    end
end)