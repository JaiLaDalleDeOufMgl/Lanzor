Tree.Math.Percent = {}

function Tree.Math.Percent.reduction(total, percent)
    local reduced_value = total - (total * percent / 100)
    return math.ceil(reduced_value / 100) * 100
end