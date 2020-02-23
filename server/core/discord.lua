function sendDiscordMessage(name, message, color, footer)
    footer = footer or "relisoft_core:discord"
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

    PerformHttpRequest(Config.DiscordWebhook, function(err, text, headers) end, 'POST', json.encode({ username = name, embeds = embeds }), { ['Content-Type'] = 'application/json' })
end

exports('sendDiscordMessage',sendDiscordMessage)