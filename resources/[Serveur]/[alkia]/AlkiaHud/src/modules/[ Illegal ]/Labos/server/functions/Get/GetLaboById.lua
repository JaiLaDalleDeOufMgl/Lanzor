function MOD_Labos:GetLaboById(LaboId)
    return (MOD_Labos.list[LaboId] and MOD_Labos.list[LaboId] or false)
end