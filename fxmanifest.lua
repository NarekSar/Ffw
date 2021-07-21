fx_version 'cerulean'
games { 'gta5' };

client_scripts {
    "Core/Client/Modules/*.lua",
    "Core/Client/*.lua",

    "Ressources/PersonnalMenu/Client.lua",
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
}
