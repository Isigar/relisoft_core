function logCheater(reason,source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifiers = GetPlayerIdentifiers(source)
    reason = reason or "neznámý"
    local message = 'Heleď máme tu cheatera! Menu detected!\n'
    message = message..string.format('Hráč: %s\n',GetPlayerName(source))
    if identifiers then
        for i,v in pairs(identifiers) do
            message = message..string.format('\n%s: %s',i,v)
        end
    end
    message = message..string.format('\nDůvod: %s',reason)
    sendCustomDiscordMessage(SConfig.DiscordLogWebhook,'Cheater!',message,Config.DiscordColors.Red)
end

function logStopResource(source,resource)
    local identifiers = GetPlayerIdentifiers(source)
    local message = string.format('User stopped resource - %s\n',resource)
    message = message..string.format('\nName: %s',GetPlayerName(source))
    if identifiers then
        for i,v in pairs(identifiers) do
            message = message..string.format('\n%s: %s',i,v)
        end
    end
    sendCustomDiscordMessage(SConfig.DiscordLogWebhook,'Stopped resource',message,Config.DiscordColors.Red)
end

RegisterNetEvent('rcore:logCheater')
AddEventHandler('rcore:logCheater',function(_source,reason)
    if _source == nil then
        logCheater(reason,source)
    else
        logCheater(reason,_source)
    end
end)
