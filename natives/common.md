---
description: Some of functions that will help you and i want them to be easy to find
---

# Common functions

#### Draw 3D texts

{% code title="Options" %}
```lua
{
    color = {
        r = 255,
        g = 255,
        b = 255,
        a = 255
    },
    size = 0.8
}
```
{% endcode %}

```lua
draw3DText(pos, text, options)
```

#### Vehicle driver

```lua
--Is ped in vehicle? return vehicle/false
rcore:isInVehicle(ped)
--Is ped driver of vehicle return true/fals
rcore:isDriver(ped,vehicle)
-- Get driver of vehicle return ped, false
rcore:getDriver(vehicle)
```

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

 



