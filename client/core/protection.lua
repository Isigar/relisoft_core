local key

TriggerServerEvent('rcore:retrieveKey')

RegisterNetEvent('rcore:updateKey')
AddEventHandler('rcore:updateKey', function(key)
    if GetCurrentResourceName() == "rcore" then
        key = key
    else
        TriggerServerEvent('rcore:logCheater',nil,'rcore:updateKey')
    end
end)

function getClientKey()
    return key
end

exports('getClientKey',getClientKey)