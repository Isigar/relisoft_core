local lastKey
local clientResourceCount
local keepAlive = {}
local registerResource = {}
local dbg = rdebug()

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
    local _source = source
    if GetCurrentResourceName() == "rcore" then
        if lastKey == nil then
            lastKey = generateKey()
            dbg.security(string.format('[rcore] generating key %s',lastKey))
        end
        TriggerClientEvent('rcore:updateKey', _source, lastKey)
    else
        TriggerEvent('rcore:logCheater',nil,'rcore:updateKey')
    end
end)

RegisterNetEvent('rcore:registerCheck')
AddEventHandler('rcore:registerCheck',function(resName)
    dbg.security('Register resource for checking %s',resName)
    registerResource[resName] = resName
end)

AddEventHandler(EventConfig.Common.playerDropped,function(source)
    keepAlive[source] = nil
end)

function getServerKey()
    return lastKey
end

function isProtected(key)
    if Config.Debug then
        dbg.securitySpam(string.format('[rcore] checking keys %s:%s',lastKey,key))
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
