local lastKey
local clientResourceCount
local keepAlive = {}
local registerResource = {}

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

local function dropTimer()
    Citizen.SetTimeout(2000,function()
        for source,val in pairs(keepAlive) do
            for resName, data in pairs(val) do
                dprint('Resource %s last diff %s',data.resource,(GetGameTimer()-data.time))
                if (GetGameTimer()-data.time) > 5000 then
                    dprint('Dropping a player for 5 seconds not keep alive from %s',data.resource)
                    TriggerEvent('rcore:cheaterDetect',source,data.resource)
                    DropPlayer(source,'[rcore.cz] fivemock stop resource detection')
                end
            end
        end
        dropTimer()
    end)
end
dropTimer()

RegisterNetEvent('rcore:retrieveKey')
AddEventHandler('rcore:retrieveKey', function()
    if Config.Debug then
        print('[rcore] Retrieving key event')
    end

    if GetCurrentResourceName() == "rcore" then
        if lastKey == nil then
            lastKey = generateKey()
            dprint(string.format('[rcore] generating key %s',lastKey))
        end
        TriggerClientEvent('rcore:updateKey', source, lastKey)
    else
        TriggerEvent('rcore:logCheater',nil,'rcore:updateKey')
    end
end)

RegisterNetEvent('rcore:registerCheck')
AddEventHandler('rcore:registerCheck',function(resName)
    dprint('Register resource for checking %s',resName)
    registerResource[resName] = resName
end)

RegisterNetEvent('rcore:checkDone')
AddEventHandler('rcore:checkDone',function(resource,key)
    local _source = source
    if isProtected(key) then
        dprint('Resource %s is keeping alive from player id %s',resource, _source)
        if keepAlive[_source] == nil then
            keepAlive[_source] = {}
        end
        keepAlive[_source][resource] = {
            resource = resource,
            time = GetGameTimer()
        }
    else
        logCheater('rcore:checkDone',_source)
    end
end)

AddEventHandler('esx:playerDropped',function(source)
    keepAlive[source] = nil
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
