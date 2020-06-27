local lastKey
local clientResourceCount

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

RegisterNetEvent('rcore:retrieveKey')
AddEventHandler('rcore:retrieveKey', function()
    if Config.Debug then
        print('[rcore] Retrieving key event')
    end

    if GetCurrentResourceName() == "rcore" then
        if lastKey == nil then
            lastKey = generateKey()
            if Config.Debug then
                print(string.format('[rcore] generating key %s',lastKey))
            end
        end
        TriggerClientEvent('rcore:updateKey', source, lastKey)
    else
        TriggerEvent('rcore:logCheater',nil,'rcore:updateKey')
    end
end)

function getServerKey()
    return lastKey
end

function isProtected(key)
    if Config.Debug then
        print(string.format('[rcore] checking keys %s:%s',lastKey,key))
    end
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

RegisterNetEvent(triggerName('onClientResourceStop'))
AddEventHandler(triggerName('onClientResourceStop'),function(res)
    local _source = source
    dprint('Server get info about stopped resource by player id %s and resource %s',_source,res)
    logStopResource(_source,res)
end)
