function MOD_Labos:NewGestionLaboMenu(ParentMenu)
    local MenuId = #MOD_Labos.MenuList

    if (MOD_Labos.MenuList[MenuId]) then return end

    MOD_Labos.MenuList[MenuId] = {}
    MOD_Labos.MenuList[MenuId].main = RageUI.CreateSubMenu(ParentMenu, "", "Gestion du labo")

    MOD_Labos:CreateMenuGestionLabo(MOD_Labos.MenuList[MenuId].main, MenuId)

    return (MOD_Labos.MenuList[MenuId].main)
end