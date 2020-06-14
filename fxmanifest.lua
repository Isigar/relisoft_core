fx_version 'bodacious' 
games { 'gta5' }

author 'Isigar'
version '1.2.1'

server_scripts {
    '@async/async.lua',
    '@mysql-async/lib/MySQL.lua',
    'config_s.lua',
    'server/core/protection.lua',
    'server/core/callback.lua',
    'server/core/esx.lua',
    'server/core/discord.lua',
    'server/core/log.lua',
    'server/core/common.lua',
    'server/core/datastore.lua',
    'server/core/inventory.lua',
    'server/core/account.lua',
    'server/core/job.lua',
    'server/core/society.lua',
    'server/core/weapon.lua',
    'server/core/storage.lua',
    'server/core/player.lua',
    'server/cmd/cmd.lua',
    'server/main.lua',
}

client_scripts {
    'config.lua',
    'client/core/protection.lua',
    'client/core/enumerator.lua',
    'client/core/callback.lua',
    'client/core/esx.lua',
    'client/core/common.lua',
    'client/core/action.lua',
    'client/core/permissions.lua',
    'client/core/marker.lua',
    'client/core/storage.lua',
    'client/core/text.lua',
    'client/core/menu.lua',
    'client/core/blip.lua',
    'client/core/font.lua',
    'client/model/model.lua',
    'client/particles/particles.lua',
    'client/main.lua',
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
