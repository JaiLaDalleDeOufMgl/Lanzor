Config = {}
Config["Menu"] = {}; -- Don't touch this.

Config["Menu"]["CloseOnDeath"] = true; -- Close the menu when the player dies ? Menu can't be opened until revive. (true/false)
Config["Menu"]["ShowHeader"] = true; --Show Menus header
Config["Menu"]["DisplaySubtitle"] = true; --Display menus Subtitle
Config["Menu"]["DisplayBackground"] = true; --Display menus background
Config["Menu"]["DisplayNavigationBar"] = true; --Display navigation buttons
Config["Menu"]["DisplayInstructionalButton"] = true; --Display Instructional Buttons
Config["Menu"]["DisplayPageCounter"] = true; --Display Page Counter
Config["Menu"]["Titles"] = ""; --Set all menus title
Config["Menu"]["TitleFont"] = 6; --Set all menus font
Config["Menu"]["TextureDictionary"] = "commonmenu"; --https://wiki.rage.mp/index.php?title=Textures --"color"
Config["Menu"]["TextureName"] = "interaction_bgd"; --https://wiki.rage.mp/index.php?title=Textures
Config["Menu"]["Color"] = { -- To use this you must set TextureDictionary to "color"
    R = 0,
    G = 0,
    B = 0,
    A = 10
};