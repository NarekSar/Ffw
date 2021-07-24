fx_version 'cerulean'
games { 'gta5' };

client_scripts {
    "Core/Client/Modules/Menus/RMenu.lua",
    "Core/Client/Modules/Menus/menu/RageUI.lua",
    "Core/Client/Modules/Menus/menu/Menu.lua",
    "Core/Client/Modules/Menus/menu/MenuController.lua",
    "Core/Client/Modules/Menus/components/*.lua",
    "Core/Client/Modules/Menus/menu/elements/*.lua",
    "Core/Client/Modules/Menus/menu/items/*.lua",
    "Core/Client/Modules/Menus/menu/panels/*.lua",
    "Core/Client/Modules/Menus/menu/windows/*.lua",

    "Core/Client/Modules/*.lua",
    "Core/Client/*.lua",

    "Ressources/AdminSys/Client.lua",
    "Ressources/AdminSys/Menus/*.lua",

    "Ressources/Shops/Client.lua",
    "Ressources/Shops/Position.lua",
    "Ressources/Shops/Menus/*.lua",
}

shared_scripts {
    "Core/Settings.lua",
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",

    "Core/Server/Modules/*.lua",
    "Core/Server/Modules/Player/*.lua",
    "Core/Server/Modules/Job/*.lua",
    "Core/Server/*.lua",

    "Ressources/AdminSys/Server.lua",
    "Ressources/Shops/Server.lua",
}
