Config = {}

Config.PrePhaseTimer = 15 -- En secondes

Config.TimeBeforeNewMap = 20 -- En minutes

Config.VotingPhaseTimer = 20 -- En secondes

Config.WaitingTimeBeforeRespawn = 3 -- En secondes
Config.RespawnInvincibleTimer = 5 -- En secondes

Config.KillReward = 100 -- Combien d'argent sera donné à chaque kill

Config.Lobby = {
    Blip = {
        sprite = 110,
        color = 1,
        name = "Zone de combat",
        Display = 4,
        Scale = 0.65,
    },
    Respawn = vector4(-282.6874, -1922.9244, 29.9460, 319.5175),
    NPC_Infos = {
        pos = vector4(-283.1128, -1923.5253, 29.9461, 321.7477),
        model = "u_m_y_juggernaut_01",
        weapon = "weapon_heavyrifle",
    },
}

Config.Maps = {
    [1] = { -- 
        mapName = "Ferme O'Neil",
        mapWeapon = "WEAPON_PISTOL",
        center_map = vector3(2449.1235, 4979.1021, 57.8155),
        radius_map = 75.0,
        general_spawn = vector3(2489.3726, 4962.0449, 44.7725), -- Prephase spawn
        spawns = {
            [1] = vector4(2402.7888, 4986.3853, 46.1748, 81.4322),
            [2] = vector4(2432.0676, 4994.6924, 46.2571, 81.4322),
            [3] = vector4(2501.1677, 4989.0151, 44.5833, 81.4322),
            [4] = vector4(2430.6558, 4973.1572, 45.9274, 81.4322),
            [5] = vector4(2451.0618, 4970.1660, 46.5716, 191.1704),
            [6] = vector4(2459.6780, 4977.5952, 47.3883, 267.6494),
            [7] = vector4(2459.6135, 4967.6890, 45.4690, 229.8146),
        },
    },
    [2] = { -- 
        mapName = "Shipment",
        mapWeapon = "WEAPON_PISTOL",
        center_map = vector3(1201.0132, -2866.2852, 6.2863),
        radius_map = 75.0,
        general_spawn = vector3(1201.0132, -2866.2852, 6.2863), -- Prephase spawn
        spawns = {
            [1] = vector4(1185.9666, -2866.6885, 6.4811, 314.9652),
            [2] = vector4(1195.5717, -2881.2043, 6.2864, 341.2550),
            [3] = vector4(1202.6563, -2880.2224, 6.4810, 265.8560),
            [4] = vector4(1215.9843, -2863.4199, 6.4820, 0.6297),
            [5] = vector4(1204.6738, -2855.2524, 6.2864, 263.2091),
            [6] = vector4(1201.6920, -2849.7104, 6.4810, 98.7308),
            [7] = vector4(1187.4807, -2861.2087, 6.3379, 306.4902),
        },
    },
    [3] = { -- 
        mapName = "King",
        mapWeapon = "WEAPON_PISTOL",
        center_map = vector3(-1041.4939, -3486.8147, 15.1345),
        radius_map = 75.0,
        general_spawn = vector3(-1041.4939, -3486.8147, 15.1345), -- Prephase spawn
        spawns = {
            [1] = vector4(-1036.4028, -3460.0989, 15.1368, 187.8034),
            [2] = vector4(-1016.4584, -3471.2415, 15.1345, 126.7194),
            [3] = vector4(-1041.4690, -3515.4858, 15.1345, 338.5189),
            [4] = vector4(-1060.2261, -3502.9473, 15.1368, 291.3297),
            [5] = vector4(-1023.0550, -3498.5322, 15.2457, 282.3326),
            [6] = vector4(-1054.1798, -3475.5623, 15.2456, 287.3463),
            [7] = vector4(-1038.7521, -3487.7612, 15.1345, 234.7853),
        },
    },
}