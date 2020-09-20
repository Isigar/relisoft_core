---
description: How to use ESX instance with rcore
---

# ESX Instance

{% hint style="info" %}
If you are using some sort of anticheat that will change your callbacks for ESX don't forget to change it in config or rcore cannot load ESX instance, it can cause it that players will not be able to connect to a server
{% endhint %}

### Client side

{% code title="your\_clientside.lua" %}
```lua
rcore = exports.rcore
rcore:getEsxInstance(function(obj)
    ESX = obj
end)
```
{% endcode %}

### Server side

{% code title="your\_serverside.lua" %}
```lua
rcore = exports.rcore
rcore:getEsxServerInstance(function(esx)
    ESX = esx
end)
```
{% endcode %}

