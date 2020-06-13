---
description: Some of functions that will help you and i want them to be easy to find
---

# Common functions

#### Draw 3D texts

#### Vehicle driver

#### Closest ped

This function get closest ped that can be found, it does not mean closest but only ped in radius

```lua
rcore:getClosestPed(targetPed, distance)
```

How to use it? Simple target ped is ped around which we are looking for peds

```lua
local currentPed = PlayerPedId()
local findClosestPed = rcore:getClosestPed(currentPed,100.0)
if DoesEntityExists(findClosestPed) and GetPedType(findClosestPed) ~= 28 then
    print('find ped')
end
```

{% hint style="info" %}
Check ped type because ped is also animals   
More info with native documentation GetPedType [https://runtime.fivem.net/doc/natives/?\_0xFF059E1E4C01E63C](https://runtime.fivem.net/doc/natives/?_0xFF059E1E4C01E63C)
{% endhint %}

You can use alternatively method that will return table of found peds and its working with same params but new params is add, that check how many peds it will check if they are near, can cause lags with lot of checks

```lua
rcore:getClosestPeds(targetPed, distance, limit)
```

{% hint style="info" %}
Limit has default value 250
{% endhint %}

 



