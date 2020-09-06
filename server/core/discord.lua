function sendDiscordMessage(name, message, color, footer)
    footer = footer or "rcore:discord | rcore.cz"
    color = color or Config.DiscordColors.Grey
    local embeds = {
        {
            ["title"] = name,
            ["description"] = message,
            ["type"] = "rich",
            ["color"] = color,
            ["footer"] = {
                ["text"] = footer,
            },
        }
    }

    PerformHttpRequest(SConfig.DiscordWebhook, function(err, text, headers) end, 'POST', json.encode({ username = name, embeds = embeds }), { ['Content-Type'] = 'application/json' })
end

exports('sendDiscordMessage',sendDiscordMessage)

function sendCustomDiscordMessage(webhook,name,message,color,footer)
    footer = footer or "rcore:discord | rcore.cz"
    color = color or Config.DiscordColors.Grey
    local embeds = {
        {
            ["title"] = name,
            ["description"] = message,
            ["type"] = "rich",
            ["color"] = color,
            ["footer"] = {
                ["text"] = footer,
            },
        }
    }

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = name, embeds = embeds }), { ['Content-Type'] = 'application/json' })
end

exports('sendCustomDiscordMessage',sendCustomDiscordMessage)
