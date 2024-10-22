eGangBuilder = {
    AdminList = {
        "gerant",
        "fondateur"
    },

    MaxWeight = 5000,
    MaxSlots = 150,

    DefaultJobGrade = {
        [0] = { name = "user", label = "User", grade = 0 },
        [1] = { name = "boss", label = "Owner", grade = 1 }
    },

    DefaultGradeAcces = {
        BossMenu = false,
        GarageMenu = false,
        CoffreMenu = false,

        BossAddGrade = false,
        BossRemoveGrade = false,
        BossModifGrade = false,

        BossAddMembre = false,
        BossRemoveMembre = false,
        BossModifMembre = false,
    },

    GradeAccesShow = {
        [1] = { separator = true, label = "Acces au menu" },
        [2] = { name = "BossMenu", label = "Menu du boss" },
        [3] = { name = "GarageMenu", label = "Menu du garage" },
        [4] = { name = "CoffreMenu", label = "Menu du coffre" },

        [5] = { separator = true, label = "Grade Menu Boss" },
        [6] = { name = "BossAddGrade", label = "Ajouter un grade" },
        [7] = { name = "BossRemoveGrade", label = "Supprimer un grade" },
        [8] = { name = "BossModifGrade", label = "Modifier un grade" },

        [9] = { separator = true, label = "Membre Menu Boss" },
        [10] = { name = "BossAddMembre", label = "Ajouter un membre" },
        [11] = { name = "BossRemoveMembre", label = "Supprimer un membre" },
        [12] = { name = "BossModifMembre", label = "Modifier un membre" },
    },


    Notification = {
        ['PlayerRecruit'] = "Vous avez été recruter dans le gang %s"
    }
}

return eGangBuilder