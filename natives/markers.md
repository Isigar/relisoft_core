---
description: Distance markers
---

# Markers

rcore provides 2 ways to create markers, in the older version there was distance marker and classic marker but we remove classic marker because its not good for performance to create marker that is still rendering.

### Newer version V2

Newer version using object with function, better show to understand the difference of these methods.

{% code title="client\_side.lua" %}
```lua
rcore = exports.rcore

function createMarker()
    marker = rcore:createMarker();
    marker.setPosition(vector3(1729.89,3313.33,40.22))
    marker.render();
    marker.on('enter',function()
        dbg.info('On enter')
    end)
    marker.on('leave', function()
        dbg.info('on leave')
    end)
    marker.setKeys({
        keys['E'],
    })
    marker.on('key', function(pressed)
        dbg.info('on key press %s',pressed)
    end)
    Citizen.Wait(20000)
    marker.stopRender()
end
```
{% endcode %}

#### createMarker\(\)

Simple function that create empty marker for you

#### marker.setPosition\(pos\)

Using vector3 as parameter to setup position of marker

#### marker.render\(\)

Starts rendering the marker

#### marker.stopRender\(\)

Stops rendering

#### marker.on\(\)

Marker on is a function that will provides you simple API to create 3 callbacks that you need and that is

* enter - on player enter the marker
* leave - on player leave the marker
* key - on player press any setup key when is in marker

{% hint style="warning" %}
on key is calling only if you setup which keys it should monitoring, look at example, its using function setKeys
{% endhint %}

Syntax

{% tabs %}
{% tab title="Lua" %}
```lua
marker.on('enter',function()
    print('On enter')
end)
```
{% endtab %}

{% tab title="" %}
```lua
marker.on('leave', function()
    print('on leave')
end)

```
{% endtab %}

{% tab title="" %}
```lua
rcore = exports.rcore
keys = rcore:getKeys()

marker.setKeys({
    keys['E'],
})
marker.on('key', function(pressed)
    print('on key press %s',pressed)
end)
```
{% endtab %}
{% endtabs %}



