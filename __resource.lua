server_files {

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
    'registerSociety'
}
