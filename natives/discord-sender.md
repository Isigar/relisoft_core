---
description: Send discord message via webhook
---

# Discord sender

rcore has even discord implementation, so you can simply send discord notification via webhook to any of your room. 

{% hint style="warning" %}
Webhook has to be only visible for server! If it will be visible for client as well it can be stolen and someone make spam your rooms.
{% endhint %}

### Sending notification as rcore

rcore has sconfig that mean Server Config so it is visible only for server in this config you can find DiscordWebhook field, if you want to send message into this webhook only you can use method 

{% code title="your\_serverside.lua" %}
```lua
rcore = exports.rcore
rcore:sendDiscordMessage(title, message, color, footer)
```
{% endcode %}

### Sending custom notification

other way if you want to send discord to any webhook for example in your own script you can use very similar native to it.

{% code title="your\_serverside.lua" %}
```lua
rcore = exports.rcore
rcore:sendCustomDiscordMessage(webhook, title, message, color, footer)
```
{% endcode %}

### Example of sending join notification

{% code title="your\_serverside.lua" %}
```lua
rcore = exports.rcore

AddEventHandler('esx:playerLoaded', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local webhook = ''
        local title = 'Player joined!'
        local message = string.format('Player %s has joined!', xPlayer.getName())
        local rcoreConfig = rcore:getConfig()
        local footer = 'cool script'
        
        rcore:sendCustomDiscordNotification(webhook, title, message, rcoreConfig.DiscordColors.Green, footer)
    end
    
end)
```
{% endcode %}

### Colors

rcore has already table in config with colors, for more search for discord documentation

{% code title="rcore/config.lua" %}
```lua
Config.DiscordColors = {
    ['Green'] = 56108,
    ['Grey'] = 8421504,
    ['Red'] = 16711680,
    ['Orange'] = 16744192,
    ['Blue'] = 2061822,
    ['Purple'] = 11750815
}
```
{% endcode %}

