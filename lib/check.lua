rcore = exports.rcore

AddEventHandler('esx:playerLoaded',function()
    dprint('Including into %s', GetCurrentResourceName())
    TriggerServerEvent('rcore:registerCheck',GetCurrentResourceName())
end)

RegisterNetEvent(string.format('rcore:check:%s',GetCurrentResourceName()))
AddEventHandler(string.format('rcore:check:%s',GetCurrentResourceName()),function()
    TriggerServerEvent('rcore:checkDone', GetCurrentResourceName(), rcore:getClientKey(GetCurrentResourceName()))
end)
