fx_version 'bodacious' 
games { 'gta5' }

author 'Isigar'
version '1.2.1'

server_scripts {
    '@async/async.lua',
    '@mysql-async/lib/MySQL.lua',
    'config_s.lua',
    'server/natives/*.lua',
    'server/core/*.lua',
    'server/esx/*.lua',
    'server/*.lua',
}

client_scripts {
    'client/natives/*.lua',
    'client/core/*.lua',
    'client/esx/*.lua',
    'client/model/*.lua',
    'client/particles/*.lua',
    'client/*.lua',
}

shared_scripts {
    'config.lua',
    'shared/common.lua'
}

dependencies {
    'es_extended',
    'esx_society',
    'esx_addoninventory',
    'esx_addonaccount',
    'esx_datastore',
}
