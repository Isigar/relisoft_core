server_files {
    '@async/async.lua',
    '@mysql-async/lib/MySQL.lua',
    'shared/config.lua',
    'server/core/common.lua',
    'server/core/datastore.lua',
    'server/core/esx.lua',
    'server/core/society.lua',
    'server/main.lua',
}

client_files {
    'client/core/common.lua',
    'client/core/marker.lua',
    'client/core/blip.lua',
    'client/core/esx.lua',
    'client/main.lua'
}

exports {
    'getEsxInstance',
    'getPlayerPos',
    'sendChatMessage',
    'getPlayers',
    'createBlip',
    'getBlips',
    'getBlip',
    'createMarker',
    'createDistanceMarker',
    'mergeTables',
    'emptyTable',
    'isTable',
    'isFunction',
    'tableLength',
    'tableLastIterator'
}

server_exports {
    'addCmd',
    'addAdminCmd',
    'sendNotificationFromServer',
    'sendChatMessageFromServer',
    'registerNumber',
    'registerSociety',
    'getPlayerDatastore',
    'getDatastore',
    'createDatastore'
}
