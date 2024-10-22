sAdmin = {}
sAdmin.Config = {
    DefaultGroup = "user",
    KeyOpenMenu = "F10",
    KeyNoclip = "F11",
    Debug = false,
    Print = {
        DefaultPrefix = "[^4sAdmin^7]",
        DebugPrefix = "[^4sAdmin^7][^3Debug^7]"
    },
    Perms = {

        AccesCat = {
            ["interaction_perso"] = {

                ["animateur"] = true,
                ["helpeur"] = true,
                ["moderateur"] = true,
                ["admin"] = true, 
                ["gerant"] = true,
                ["fondateur"] = true,
            },
            ["interaction_vehicle"] ={

                ["animateur"] = true,
                ["helpeur"] = true,
                ["moderateur"] = true,
                ["admin"] = true, 
                ["gerant"] = true,
                ["fondateur"] = true,
            },
            ["report_menu"] = {

                ["animateur"] = false,
                ["helpeur"] = true,
                ["moderateur"] = true,
                ["admin"] = true, 
                ["gerant"] = true,
                ["fondateur"] = true,
            },
            ["interaction_players"] = {

                ["animateur"] = true,
                ["helpeur"] = true,
                ["moderateur"] = true,
                ["admin"] = true, 
                ["gerant"] = true,
                ["fondateur"] = true,
            },
            ["interaction_cardinal"] = {

                ["animateur"] = false,
                ["helpeur"] = false,
                ["moderateur"] = false,
                ["admin"] = false,
                ["gerant"] = false,
                ["fondateur"] = true,
            },
            ['show_staffList'] = {
                ["animateur"] = false,
                ["helpeur"] = false,
                ["moderateur"] = false,
                ["admin"] = false,
                ["gerant"] = true,
                ["fondateur"] = true,
            },
        },
        Buttons = {
            ["cat_persoMenu"] = {
                ["noclip"] = {
    
                    ["animateur"] = true,
                    ["helpeur"] = true,
                    ["moderateur"] = true,
                    ["admin"] = true, 
                    ["gerant"] = true,
                    ["fondateur"] = true,
                },
                ["invisibleMonde"] = {
    
                    ["animateur"] = true,
                    ["helpeur"] = true,
                    ["moderateur"] = true,
                    ["admin"] = true, 
                    ["gerant"] = true,
                    ["fondateur"] = true,
                },
                ["show_gamertags"] = {
    
                    ["animateur"] = true,
                    ["helpeur"] = true,
                    ["moderateur"] = true,
                    ["admin"] = true,
                     ["gerant"] = true,
                    ["fondateur"] = true,
                },
                ["teleport_waypoint"] = {
    
                    ["animateur"] = true,
                    ["helpeur"] = true,
                    ["moderateur"] = true,
                    ["admin"] = true, 
                    ["gerant"] = true,
                    ["fondateur"] = true,
                },
                ["spawn_props"] = {
                    ["animateur"] = true,
                    ["helpeur"] = false,
                    ["moderateur"] = false,
                    ["admin"] = true, 
                    ["gerant"] = true,
                    ["fondateur"] = true,
                },
            },
            ["cat_vehMenu"] = {
                ["repairVehicle"] = {
    
                    ["animateur"] = true,
                    ["helpeur"] = true,
                    ["moderateur"] = true,
                    ["admin"] = true, 
                    ["gerant"] = true,
                    ["fondateur"] = true,
                },
                ["clearVehicle"] = {
                    ["animateur"] = true,
                    ["helpeur"] = true,
                    ["moderateur"] = true,
                    ["admin"] = true, 
                    ["gerant"] = true,
                    ["fondateur"] = true,
                },
                ["upgradeVehicules"] = {
    
                    ["animateur"] = false,
                    ["helpeur"] = false,
                    ["moderateur"] = false,
                    ["admin"] = false, 
                    ["gerant"] = false,
                    ["fondateur"] = true,
                },
            },
            ["cat_playersActions"] = {
                ["goto"] = {
    
                    ["animateur"] = true,
                    ["helpeur"] = true,
                    ["moderateur"] = true,
                    ["admin"] = true, 
                    ["gerant"] = true,
                    ["fondateur"] = true,
                },
                ["wipe"] = {

                    ["animateur"] = false,
                    ["helpeur"] = false,
                    ["moderateur"] = false,
                    ["admin"] = false, 
                    ["gerant"] = false,
                    ["fondateur"] = true,
                },
                ["bring"] = {
    
                    ["animateur"] = true,
                    ["helpeur"] = true,
                    ["moderateur"] = true,
                    ["admin"] = true, 
                    ["gerant"] = true,
                    ["fondateur"] = true,
                },
                ["tpparkingcentral"] = {
    
                    ["animateur"] = true,
                    ["helpeur"] = true,
                    ["moderateur"] = true,
                    ["admin"] = true, 
                    ["gerant"] = true,
                    ["fondateur"] = true,
                },
                ["freeze"] = {
    
                    ["animateur"] = true,
                    ["helpeur"] = true,
                    ["moderateur"] = true,
                    ["admin"] = true, 
                    ["gerant"] = true,
                    ["fondateur"] = true,
                },
                ["sendMess"] = {
                    ["animateur"] = true,
                    ["helpeur"] = true,
                    ["moderateur"] = true,
                    ["admin"] = true, 
                    ["gerant"] = true,
                    ["fondateur"] = true,
                },
                ["spec"] = {
                    ["animateur"] = true,
                    ["helpeur"] = true,
                    ["moderateur"] = true,
                    ["admin"] = true,
                    ["gerant"] = true,                 
                    ["fondateur"] = true,
                },
                ["revive"] = {
                    ["animateur"] = true,
                    ["helpeur"] = true,
                    ["moderateur"] = true,
                    ["admin"] = true, 
                    ["gerant"] = true,                   
                    ["fondateur"] = true,
                },
                ["kick"] = {
                    ["animateur"] = false,
                    ["helpeur"] = false,
                    ["moderateur"] = true,
                    ["admin"] = true, 
                    ["gerant"] = true,                   
                    ["fondateur"] = true,
                },
                ["ban"] = {
                    ["animateur"] = false,
                    ["helpeur"] = false,
                    ["moderateur"] = true,
                    ["admin"] = true, 
                    ["gerant"] = true,                  
                    ["fondateur"] = true,
                },
                ["showInventory"] = {
                    ["animateur"] = true,
                    ["helpeur"] = true,
                    ["moderateur"] = true,
                    ["admin"] = true, 
                    ["gerant"] = true,
                    ["fondateur"] = true,
                },
                ["giveMoney"] = {
                    ["animateur"] = false,
                    ["helpeur"] = false,
                    ["moderateur"] = false,
                    ["admin"] = false, 
                    ["gerant"] = false,
                    ["fondateur"] = true,
                },
                ["giveItem"] = {
                    ["animateur"] = false,
                    ["helpeur"] = false,
                    ["moderateur"] = true,
                    ["admin"] = false, 
                    ["gerant"] = false,
                    ["fondateur"] = true,
                },
            },
            ["cat_cardinalActions"] = {
                ["giveVehicle"] = {
                    ["animateur"] = false,
                    ["helpeur"] = false,
                    ["moderateur"] = false,
                    ["admin"] = false, 
                    ["gerant"] = false,
                    ["fondateur"] = true,
                },
                ["giveMoney"] = {
                    ["animateur"] = false,
                    ["helpeur"] = false,
                    ["moderateur"] = false,
                    ["admin"] = false, 
                    ["gerant"] = false,
                    ["fondateur"] = true,
                },
                ["giveItem"] = {
                    ["animateur"] = false,
                    ["helpeur"] = false,
                    ["moderateur"] = false,
                    ["admin"] = false, 
                    ["gerant"] = false,
                    ["fondateur"] = true,
                },
                ["giveWeapon"] = {
                    ["animateur"] = false,
                    ["helpeur"] = false,
                    ["moderateur"] = false,
                    ["admin"] = false, 
                    ["gerant"] = false,
                    ["fondateur"] = true,
                },
                ["peds"] = {
                    ["animateur"] = false,
                    ["helpeur"] = false,
                    ["moderateur"] = false,
                    ["admin"] = false,
                    ["gerant"] = true,
                    ["fondateur"] = true,
                },
                ["clearloadout"] = {
                    ["animateur"] = false,
                    ["helpeur"] = false,
                    ["moderateur"] = false,
                    ["admin"] = true, 
                    ["gerant"] = true,
                    ["fondateur"] = true,
                },
            }
        }
    }
}