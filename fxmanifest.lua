fx_version 'adamant'
games { 'gta5' }

server_scripts {
    '@async/async.lua',
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server/core/protection.lua',
    'server/core/esx.lua',
    'server/core/discord.lua',
    'server/core/log.lua',
    'server/core/common.lua',
    'server/core/datastore.lua',
    'server/core/inventory.lua',
    'server/core/account.lua',
    'server/core/society.lua',
    'server/core/weapon.lua',
    'server/core/storage.lua',
    'server/main.lua',
}

client_scripts {
    'config.lua',
    'client/core/protection.lua',
    'client/core/esx.lua',
    'client/core/common.lua',
    'client/core/action.lua',
    'client/core/marker.lua',
    'client/core/storage.lua',
    'client/core/text.lua',
    'client/core/menu.lua',
    'client/core/blip.lua',
    'client/core/permissions.lua',
    'client/core/font.lua',
    'client/main.lua',
}

shared_scripts {
    'config.lua',
    'shared/common.lua'
}

dependencies {
    'es_extended'
}