Tree = {}
Tree.Function = {}
Tree.Ender = {}
Tree.Gui = {}
Tree.Plugins = {}
Tree.Config = {}

Tree.Config.forceDefaultSpawn = false
Tree.Config.defaultSpawn = { x = -1035.0, y = -2737.0, z = 20.0, heading = 0.0 }
Tree.Config.debugMode = false
Tree.Config.devMode = false

Tree.Config.gameType = GetConvar("gameType", "alk")

Tree.Config.Owner = {
    "license:e6abdf336a12329b958941572874289e898acee4", -- JaiFaim
    "license:d81a93b210ba965c5015e8a70f92aaf4bd9c1b4d", -- Kabyle
    "license:8d12cb75309701026da4ea329e7b3796d8795576", -- Lanzor
    "license:95fa819ebbadc942e4b96b894d7bfec4311328d4", -- husah
}

Tree.Config.MysteryBoxProps = {
    ["default"] = "prop_big_bag_01",
    ["weapon_pistol"] = "w_pi_pistol",
    ["bread"] = "w_me_battleaxe",
    ["adder"] = "prop_tornado_wheel",
}

Tree.Config.MysteryBoxRarityLevel = {
    COMMUN = { probabilityID = 1, name = "Commun", color = "~HUD_COLOUR_GREEN~", probabilityPercentage = 55 },
    PEU_COMMUN = { probabilityID = 2, name = "Peu commun", color = "~HUD_COLOUR_HDARK~", probabilityPercentage = 25 },
    RARE = { probabilityID = 3, name = "Rare", color = "~b~", probabilityPercentage = 10 },
    EPIQUE = { probabilityID = 4, name = "Épique", color = "~p~", probabilityPercentage = 7 },
    LEGENDAIRE = { probabilityID = 5, name = "Légendaire", color = "~HUD_COLOUR_GOLD~", probabilityPercentage = 3 }
}

if Tree.Config.gameType == "nevada" then
    Tree.Config.Serveur = {
        boutique = "",
        label = "Nevada",
        hudScript = "NevadaHud",
        discord = "discord.gg/nevada",
        color = "~g~",
        interaction_bgd = "https://cdn.discordapp.com/attachments/1267939237085446292/1285712213180416082/4dF5GUW.png?ex=66eb444f&is=66e9f2cf&hm=68657c780b0a968df5a400f8be5a0220424a1feca4552b9fca881094572513b9&",
        colorMarkers = { r = 26, g = 140, b = 58, a = 255 },
        discordid = 1271249067082518539,
        discordButtonOne = "🩷 Discord",
        discordButtonOneLink = "https://discord.gg/nevada",
        discordButtonTwo = "🩷 Se Connecter",
        discordButtonTwoLink = "fivem://connect/cfx.re/join/y5kbxm",
    }
elseif Tree.Config.gameType == "lsc" then
    Tree.Config.Serveur = {
        boutique = "https://lscboutique.tebex.io/",
        label = "LSConfidential",
        hudScript = "LSCHud",
        discord = "discord.gg/lsc",
        color = "~q~",
        interaction_bgd = "https://image.noelshack.com/fichiers/2024/32/7/1723395201-bannerf5555.jpeg",
        colorMarkers = { r = 236, g = 4, b = 152, a = 255 },
        discordid = 1271249067082518539,
        discordButtonOne = "🩷 Discord",
        discordButtonOneLink = "https://discord.gg/lsc",
        discordButtonTwo = "🩷 Se Connecter",
        discordButtonTwoLink = "fivem://connect/cfx.re/join/y5kbxm",
    }
elseif Tree.Config.gameType == "galactic" then
    Tree.Config.Serveur = {
        boutique = "https://lscboutique.tebex.io/",
        label = "GalacticRP",
        hudScript = "GalacticHud",
        discord = "discord.gg/galacticrp",
        color = "~p~",
        interaction_bgd = "https://image.noelshack.com/fichiers/2024/38/4/1726765053-f5-ezgif-com-resize-1.png",
        colorMarkers = { r = 138, g = 0, b = 255, a = 255 },
        discordid = 1277728378417316002,
        discordButtonOne = "💜 Discord",
        discordButtonOneLink = "https://discord.gg/galacticrp",
        discordButtonTwo = "💜 Se Connecter",
        discordButtonTwoLink = "fivem://connect/cfx.re/join/y5kbxm",
    }
elseif Tree.Config.gameType == "alk" then
    Tree.Config.Serveur = {
        boutique = "https://alkiaboutique.tebex.io/",
        label = "Alkia",
        hudScript = "AlkiaHud",
        discord = "discord.gg/alkia",
        color = "~p~",
        interaction_bgd = "https://image.noelshack.com/fichiers/2024/38/1/1726519618-ek48pp3.png",
        colorMarkers = { r = 168, g = 3, b = 234, a = 255 },
        discordid = 1272306893091635250,
        discordButtonOne = "💜 Discord",
        discordButtonOneLink = "https://discord.gg/alkia",
        discordButtonTwo = "💜 Se Connecter",
        discordButtonTwoLink = "",
    }
end

Tree.Config.VipRanks = {
    [0] = Tree.Config.Serveur.color .. "Aucun VIP~s~",
    [1] = "~c~Argent~s~",
    [2] = "~y~Or~s~",
    [3] = "~b~Diamant~s~",
}

Tree.Plugins.Active = {
    "boutique",
    "location",
    "shop",
    "radio",
    "utils",
    "carwash",
    "cardealer",
    "ammunation",
    "boucherie",
    "banque",
    "customvip",
    "context",
    "blanchiment",
    "gofast",
    "afkSystem",
    "annonceStaff",
    "vdabuilder",
}

exports("serveurConfig", function()
    return Tree.Config
end)

