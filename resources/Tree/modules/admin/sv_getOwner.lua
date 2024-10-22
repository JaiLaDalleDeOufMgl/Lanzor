Tree.Admin = {}

function Tree.Admin.getOwner()
    return Tree.Config.Owner
end

function Tree.Admin.isOwner(license)
    for k, v in pairs(Tree.Config.Owner) do
        if v == license then
            return true
        end
    end
    return false
end