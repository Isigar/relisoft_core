---
description: Distance 3D text
---

# 3D Text

## Create 3D Text

Rcore provides two methods for creating 3D texts, one easier to use, but not that advanced and one harder to use, but with many advanced functions. The older one can be found in common functions. 

### 3D Text V2

The newer method for creating 3D texts is object-oriented, same as marker V2 method, so we will show you examples of how to use it.

{% code title="client\_side.lua" %}
```lua
rcore = exports.rcore

function create3DText()

    text = rcore:create3DText()
    text.setText("Hi!")
    text.setPosition(vector3(1729.89,3313.33,40.22))
    text.setRed(red)
    text.setGreen(green)
    text.render()
    text.on('enter',function()
        dbg.info('On enter')
    end)
    text.on('leave', function()
        dbg.info('on leave')
    end)
    text.setKeys({
        keys['E'],
    })
    text.on('key', function(pressed)
        dbg.info('on key press %s',pressed)
    end)
    Wait(10000)
    text.destroy()
end
```
{% endcode %}

#### create3Dtext\(\)

A simple function that creates empty 3D text for you.

#### text.setText\("text"\) / text.getText\(\)

Sets the text which you want to display using 3D text. / Gets text which is being displayed \(default is an empty string\).

#### text.setPosition\(pos\) / text.getPosition\(pos\)

Using vector3 as a parameter to setup position of 3D text.

#### text.render\(\)

Starts rendering the 3D text.

#### text.stopRender\(\)

Stops rendering the 3D text.

#### text.on\(\)

Text on is a function that will provide you simple API to create 3 callbacks that you need and that is

* enter - on player enter the 3D text
* leave - on player leave the 3D text
* key - on player press any setup key when is in 3D text

{% hint style="warning" %}
On key is calling only if you setup which keys it should be monitoring, look at example, its using function setKeys
{% endhint %}

#### Syntax

{% tabs %}
{% tab title="Enter" %}
{% code title="client\_side.lua" %}
```lua
text.on('enter',function()
    print('On enter')
end)
```
{% endcode %}
{% endtab %}

{% tab title="Leave" %}
{% code title="client\_side.lua" %}
```lua
marker.on('leave',function()
    print('On leave')
end)
```
{% endcode %}
{% endtab %}

{% tab title="Key" %}
{% code title="client\_side.lua" %}
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
{% endcode %}
{% endtab %}
{% endtabs %}

#### text.getKeys\(\)

Returns all the keys you has set for your 3D text \(default: empty table\)

#### text.getId\(\)

Returns your 3D text id.

#### text.setScale\(vector3\) / text.getScale\(vector3\)

Set/Get scale of 3D text \(default: 0.1\).

#### text.setSize\(\) / text.getSize\(\)

Sets/gets size of the 3D text \(default: 0.8\).

#### text.setColor\(table\) / text.getColor \(table\)

you can set color with RGBA table {r = 0, g= 0, b=255,a=255} or you can set every color by self

* setAlpha\(alpha\)
* getAlpha\(\)
* setRed\(red\)
* getRed\(\)
* setGreen\(green\)
* getGreen\(\)
* setBlue\(blue\)
* getBlue\(\)

#### text.setRenderDistance\(value\) / text.getdRenderDistance\(value\)

Sets/gets distance from which 3D text renders \(default: 20\)

#### text.setFont\(\) / text.getFont\(\)

Sets/gets font which 3D text is using.

#### text.setInRadius\(\) / text.getInRadius\(\)

Set/Get radius for calling enter/leave function \(default: 1.5\)

#### text.destroy\(\)

Destroys the 3D text.

#### text.isRendering\(\)

Returns true/false whether is text being rendered.

#### 



