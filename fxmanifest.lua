fx_version 'cerulean'
games { 'gta5' };

client_scripts {
    "Core/Settings.lua",
    "Core/Client/Modules/*.lua",
    "Core/Client/*.lua",
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    "Core/Settings.lua",
    "Core/Server/Modules/*.lua",
    "Core/Server/*.lua",
}
