function logCheater(reason,source)
    local xPlayer = ESX.GetPlayerFromId(source)
    reason = reason or "neznámý"
    sendDiscordMessage('Cheater!',string.format('Heleď máme tu cheatera! Menu detected!\nHráč: %s\nIdentifier: %s\nDůvod: %s',xPlayer.name,xPlayer.identifier,reason),Config.DiscordColors.Red)
end

RegisterNetEvent('rcore:logCheater')
AddEventHandler('rcore:logCheater',function(_source,reason)
    if _source == nil then
        logCheater(reason,source)
    else
        logCheater(reason,_source)
    end
end)