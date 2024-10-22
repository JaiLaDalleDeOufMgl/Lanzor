Tree.Function.Thread = {}
Tree.Function.Thread.cache = {}

function Tree.Function.Thread.addTask(name, func)
    if Tree.Function.Thread.cache[name] then
        Tree.Console.Debug("Task with this name already exists.")
        return
    end

    local threadId = CreateThread(function()
        local startTime = GetGameTimer()

        func()

        local endTime = GetGameTimer()
        local duration = endTime - startTime
        Tree.Console.Debug(string.format("Task ^2%s^7 executed in ^2%d^7 ms", name, duration))
    end)

    Tree.Function.Thread.cache[name] = {
        threadId = threadId
    }

    Tree.Console.Debug(string.format("Task ^2%s^7 added", name))
    return true
end

function Tree.Function.Thread.removeTask(name)
    if not Tree.Function.Thread.cache[name] then
        Tree.Console.Debug("No task found with this name.")
        return
    end

    local task = Tree.Function.Thread.cache[name]
    TerminateThread(task.threadId)
    Tree.Function.Thread.cache[name] = nil

    Tree.Console.Debug(string.format("Task ^2%s^7 removed", name))
end

function Tree.Function.Thread.getCurrentThreadId()
    return GetIdOfThisThread()
end

function Tree.Function.Thread.getThreadName(threadId)
    return GetNameOfThread(threadId)
end

function Tree.Function.Thread.isThreadActive(threadId)
    return IsThreadActive(threadId)
end

function Tree.Function.Thread.setThreadPriority(threadId, priority)
    SetThreadPriority(threadId, priority)
end

function Tree.Function.Thread.getRecentAverageExecutionTime()
    local total = 0
    local count = 0

    for name, task in pairs(Tree.Function.Thread.cache) do
        if task.execTimes and #task.execTimes > 0 then
            local taskTotal = 0

            for _, duration in ipairs(task.execTimes) do
                taskTotal = taskTotal + duration
            end

            local taskAverage = taskTotal / #task.execTimes
            total = total + taskAverage
            count = count + 1
        end
    end

    if count > 0 then
        return total / count
    else
        return 0
    end
end