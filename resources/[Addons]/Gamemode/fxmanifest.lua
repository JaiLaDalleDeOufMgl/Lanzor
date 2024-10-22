shared_scripts{'@KingProtect/resource/imports.lua'}
lua54 'yes'
shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield



fx_version "adamant"

game "gta5"
lua54 'yes'


---RageUI
-- client_scripts {
--     'vendors/RageUI/RageUI.lua',
--     'vendors/RageUI/Menu.lua',
--     'vendors/RageUI/MenuController.lua',
--     'vendors/RageUI/components/*.lua',
--     'vendors/RageUI/elements/*.lua',
--     'vendors/RageUI/items/*.lua',
-- }

---------------------LIBS RAGEUI
client_scripts {
    'vendors/RageUI/RMenu.lua',
    'vendors/RageUI/menu/RageUI.lua',
    'vendors/RageUI/menu/Menu.lua',
    'vendors/RageUI/menu/MenuController.lua',
    'vendors/RageUI/components/*.lua',
    'vendors/RageUI/menu/elements/*.lua',
    'vendors/RageUI/menu/items/*.lua',
    'vendors/RageUI/menu/panels/*.lua',
    'vendors/RageUI/menu/panels/*.lua',
    'vendors/RageUI/menu/windows/*.lua',

    'vendors/RageUIv1/RMenu.lua',
    'vendors/RageUIv1/menu/RageUI.lua',
    'vendors/RageUIv1/menu/Menu.lua',
    'vendors/RageUIv1/menu/MenuController.lua',

    'vendors/RageUIv1/components/*.lua',

    'vendors/RageUIv1/menu/elements/*.lua',

    'vendors/RageUIv1/menu/items/*.lua',

    'vendors/RageUIv1/menu/panels/*.lua',

    'vendors/RageUIv1/menu/panels/*.lua',
    'vendors/RageUIv1/menu/windows/*.lua',

    "vendors/RageUIv3/RMenu.lua",
    "vendors/RageUIv3/menu/RageUI.lua",
    "vendors/RageUIv3/menu/Menu.lua",
    "vendors/RageUIv3/menu/MenuController.lua",
    "vendors/RageUIv3/components/*.lua",
    "vendors/RageUIv3/menu/elements/*.lua",
    "vendors/RageUIv3/menu/items/*.lua",
    "vendors/RageUIv3/menu/panels/*.lua",
    "vendors/RageUIv3/menu/windows/*.lua",

    "vendors/RageUIv4/RMenu.lua",
    "vendors/RageUIv4/menu/RageUI.lua",
    "vendors/RageUIv4/menu/Menu.lua",
    "vendors/RageUIv4/menu/MenuController.lua",
    "vendors/RageUIv4/components/*.lua",
    "vendors/RageUIv4/menu/elements/*.lua",
    "vendors/RageUIv4/menu/items/*.lua",
    "vendors/RageUIv4/menu/panels/*.lua",
    "vendors/RageUIv4/menu/windows/*.lua",


    "vendors/src/RMenu.lua",
    "vendors/src/menu/RageUI.lua",
    "vendors/src/menu/Menu.lua",
    "vendors/src/menu/MenuController.lua",
    "vendors/src/components/*.lua",
    "vendors/src/menu/elements/*.lua",
    "vendors/src/menu/items/*.lua",
    "vendors/src/menu/panels/*.lua",
    "vendors/src/menu/panels/*.lua",
    "vendors/src/menu/windows/*.lua",

    "vendors/RMasques/RageUI/RMenu.lua",
    "vendors/RMasques/RageUI/menu/RageUI.lua",
    "vendors/RMasques/RageUI/menu/Menu.lua",
    "vendors/RMasques/RageUI/menu/MenuController.lua",
    "vendors/RMasques/RageUI/components/*.lua",
    "vendors/RMasques/RageUI/menu/elements/*.lua",
    "vendors/RMasques/RageUI/menu/items/*.lua",
    "vendors/RMasques/RageUI/menu/panels/*.lua",
    "vendors/RMasques/RageUI/menu/windows/*.lua",

    "vendors/RageUICustom/RMenu.lua",
    "vendors/RageUICustom/menu/RageUI.lua",
    "vendors/RageUICustom/menu/Menu.lua",
    "vendors/RageUICustom/menu/MenuController.lua",
    "vendors/RageUICustom/components/*.lua",
    "vendors/RageUICustom/menu/elements/*.lua",
    "vendors/RageUICustom/menu/items/*.lua",
    "vendors/RageUICustom/menu/panels/*.lua",
    "vendors/RageUICustom/menu/windows/*.lua",

    "vendors/RageUIv5/RMenu.lua",
    "vendors/RageUIv5/menu/RageUI.lua",
    "vendors/RageUIv5/menu/Menu.lua",
    "vendors/RageUIv5/menu/MenuController.lua",
    "vendors/RageUIv5/components/*.lua",
    "vendors/RageUIv5/menu/elements/*.lua",
    "vendors/RageUIv5/menu/items/*.lua",
    "vendors/RageUIv5/menu/panels/*.lua",
    "vendors/RageUIv5/menu/panels/*.lua",
    "vendors/RageUIv5/menu/windows/*.lua",

    "vendors/RageUIPolice/RMenu.lua",
	"vendors/RageUIPolice/menu/RageUI.lua",
	"vendors/RageUIPolice/menu/Menu.lua",
	"vendors/RageUIPolice/menu/MenuController.lua",
	"vendors/RageUIPolice/components/*.lua",
	"vendors/RageUIPolice/menu/elements/*.lua",
	"vendors/RageUIPolice/menu/items/*.lua",
	"vendors/RageUIPolice/menu/panels/*.lua",
	"vendors/RageUIPolice/menu/panels/*.lua",
	"vendors/RageUIPolice/menu/windows/*.lua",

    "vendors/*.lua",

    
    'shared/clotheshop/src/libs/RageUI/RMenu.lua',
    'shared/clotheshop/src/libs/RageUI/menu/RageUI.lua',
    'shared/clotheshop/src/libs/RageUI/menu/Menu.lua',
    'shared/clotheshop/src/libs/RageUI/menu/MenuController.lua',
    'shared/clotheshop/src/libs/RageUI/components/*.lua',
    'shared/clotheshop/src/libs/RageUI/menu/elements/*.lua',
    'shared/clotheshop/src/libs/RageUI/menu/items/*.lua',
    'shared/clotheshop/src/libs/RageUI/menu/panels/*.lua',
    'shared/clotheshop/src/libs/RageUI/menu/windows/*.lua',
}






shared_scripts {
    '@Framework/locale/locale.lua',
	'locales/fr.lua',

    'config/shared/**.lua',

    'shared/society/*.lua',
    'shared/braquage/*.lua',
    'shared/clotheshop/configs/cConfig.lua',
    'shared/creator/configs/cConfig.lua',
    'shared/creator/src/translation/*.lua',
}


client_scripts {
    'config/client/*.lua',
    
    'init/client/*.lua',

    'api/**/client/*.lua',

    'modules/**/**/config/*.lua',
    'modules/**/**/client/*.lua',


    'shared/creator/src/utils.lua',
    'shared/creator/src/client/*.lua',
    'shared/creator/src/client/menu\'s/*.lua',


    'shared/clotheshop/src/utils.lua',
    'shared/clotheshop/data/client/*.lua',
    'shared/clotheshop/src/client/*.lua',

}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config/server/*.lua',

    'init/server/*.lua',

    'api/**/server/*.lua',

    'modules/**/**/config/*.lua',
    'modules/**/**/server/*.lua',


    'shared/creator/configs/sConfig.lua',
    'shared/creator/src/server/*.lua',


    'shared/clotheshop/configs/sConfig.lua',
    'shared/clotheshop/data/server/*.lua',
    'shared/clotheshop/src/server/*.lua',
}


exports {
	'GetFuel',
	'SetFuel',
    'IsInMenotte',
    'IsInPorter',
    'IsInTrunk',
    'IsInOtage',
    'IsInStaff',
    'GeneratePlate'
}



files {
    'modules/[Utils]/utils/client/popcycle.dat'
}
data_file 'POPSCHED_FILE' 'modules/[Utils]/utils/client/popcycle.dat'