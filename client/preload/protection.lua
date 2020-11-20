local protectionKey
local count
local dbg = rdebug()

TriggerServerEvent('rcore:updateCount',GetNumResources())
TriggerServerEvent('rcore:registerCheck',GetCurrentResourceName())
TriggerServerEvent('rcore:retrieveKey')

RegisterNetEvent('rcore:updateKey')
AddEventHandler('rcore:updateKey', function(key)
    if GetCurrentResourceName() == "rcore" then
        protectionKey = key
        dbg.security(string.format('[rcore] Getting key: %s',key))
    else
        TriggerServerEvent('rcore:logCheater',nil,'rcore:updateKey')
    end
end)

function getClientKey(resource)
    if resource == nil then
        TriggerServerEvent('rcore:logCheater',nil,'rcore:getClientKey')
        return
    end
    dbg.securitySpam(string.format('[rcore] getting key from export %s by %s',protectionKey, resource))
    return protectionKey
end

exports('getClientKey',getClientKey)

