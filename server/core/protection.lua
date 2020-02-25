local lastKey

--Thanks nit34byte <3
function generateKey()
    local chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
    local a = ''

    math.randomseed(os.time())

    b = {}
    for c in chars:gmatch "." do
        table.insert(b, c)
    end

    for i = 1, 10 do
        a = a .. b[math.random(1, #b)]
    end

    return a
end

AddEventHandler('rcore:retrieveKey', function()
    if Config.Debug then
        print('[rcore] Retrieving key event')
    end

    local newKey = generateKey()
    lastKey = newKey
    TriggerClientEvent('rcore:updateKey', -1, newKey)
end)

function getServerKey()
    return lastKey
end

function isProtected(key)
    if key == nil then
        return false
    end

    if key == lastKey then
        return true
    else
        return false
    end
end

exports('isProtected', isProtected)