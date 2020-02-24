local key

RegisterNetEvent('rcore:updateKey')
AddEventHandler('rcore:updateKey', function(key)
    key = key
end)

function getClientKey()
    return key
end