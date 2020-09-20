---
description: Create cool camera effects!
---

# Camera API

Simple example of pinkcage motel animation from air camera point to door

{% code title="your\_clientside.lua" %}
```lua
function playCam()
    local camPos = vector3(331.09,-268.47,79.74)
    local doorPosCam = vector3(316.5,-205.47,55.65)
    local doorPosPoint = vector3(311.95,-203.68,55.4)
    local pointTo = vector3(320.92,-207.27,57.28)
    rcore:cinematicLook(true)
    rcore:disableControls(true)
    local camera = rcore:createCamera('main',camPos,vector3(0,0,0))
    camera.render()
    camera.pointTo(pointTo)
    Citizen.Wait(2000)
    camera.changePosition(doorPosCam,doorPosPoint)
    camera.destroy()
    rcore:cinematicLook(false)
    rcore:disableControls(false)
    rcore:stopRendering()
end

RegisterCommand('testhotel',function(source,args)
    Citizen.CreateThread(function()
        ESX.Scaleform.ShowFreemodeMessage('~g~pinkcage motel', '~y~Prave sis zakoupil pokoj cislo 3!', 5)
    end)
    playCam()
end)

```
{% endcode %}

## Cinematic cool and disable controls

When you turning with a camera and creating cool position animation you don\`t want allow player movement or shooting, a player is on a same spot on the ground but a camera is somewhere else because that rcore offers simple toggle command for disable controls and start cinematic look which will create borders at top and bottom in black colour for a movie experience 

{% code title="your\_clientside.lua" %}
```lua
rcore = exports.rcore

rcore:cinematicLook(true)--Turn on disable controls & cinematic look
rcore:disableControls(true)
--Here do camera animation
Citizen.Wait(5000)--We will wait 5 sec
rcore:cinematicLook(false)
rcore:disableControls(false) --Turn off disable controls & cinematic look
```
{% endcode %}

### Creating camera

Creating camera is so easy... After we create our API of course. Camera has a name which need to be unique and position.

{% code title="your\_clientside.lua" %}
```lua
--Name need to be unique - mandatory field
--Position is vector3(x,y,z) - mandatory field
--Rotation is vector3(x,y,z) - if not fill it will use vector3(0,0,0)
--Fox is integer and its default value is 60 you can change it or leave it empty
--This function returning table object with functions to control camera
createCamera(name, pos, rot, fov)

--Minimum params
local pos = vector3(2580.6,150.0,26.0)
local camera = rcore:createCamera('main',pos)

--Long params
local pos = vector3(2580.6,150.0,26.0)
local rot = vector3(0,10,0)
local fov = 120
local camera = rcore:createCamera('main',pos,rot,fov)
```
{% endcode %}

### Camera object

Object that will return function createCamera is table that allows you call function on it that mean that all data and function are in camera object you dont need to use other function everything is there.

{% code title="camera object params" %}
```lua
cam -- id of camera object
position -- position of camera
rotation -- rotation of camera
fov -- fov of camera
name -- name of camera
lastPoinTo -- if you called pointTo function there will be last location or nil
pointTo(pos) -- function that will point your camera to specific point with vector3(x,y,z)
render() --Set cam active and render its
changeCam(newCam, duration)--Change camera with animation (first parameter is CAM ID not object)
destroy() --Destroy camera
changePosition(newPos,newPoint,newRot,duration)--Change camera with animation to specific position and point

```
{% endcode %}

#### pointTo\(position\)

Point your camera to specific position, allowed parameter is vector3\(\) as position

#### render\(\)

Set your camera active and render it to player

#### changeCam\(newCamId, duration\)

Change camera to another with animation between position, you need to create new camera for this and first parameter is **camera ID** not whole object

#### changePosition\(newPos, newPoint, newRot, duration\)

Change camera with animation to a new position for this will rcore create automatically one new camera and make animation change of position to a new point and then your current camera will receive new data so you can continue using it. Last two parameters is option for newRot is default vector3\(0,0,0\) and for duration its 4000 its in milliseconds

#### destroy\(\)

Remove camera and destroy it but its still not stop rendering

### Stop rendering and remove everything

if you want stop rendering your cams you have to use specific function stopRendering which will render player game camera again and stop rendering yours camera - dont forget that stopRendering will not destroy your camera

{% code title="your\_clientside.lua" %}
```lua
rcore = exports.rcore
rcore:stopRendering()
```
{% endcode %}

