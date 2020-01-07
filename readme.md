## relisoft_core
##### implemention of most common function in better way (using ESX)

#### Dependency:

- essentialmode
- es_extended

#### TODO:

- fraction with society creation
- easy storage system
- storage user/fraction
- permission system
- custom menu options by permissions

#### Functions:

- getEsxInstance(): ESX
- getPlayerPos(): vector3(x,y,z)
- sendChatMessage(title, message, color): void
- getPlayers(filter)
- createBlip(name, blip, coords, options): Blip
- getBlips(): Blip[]
- getBlip(instance): ?Blip
- createMarker(type, coords, options): void
- createDistanceMarker(type, coords, distance, options): void

###### Common:

- mergeTables(sourceTable, targetTable): table
- emptyTable(table): bool
- isTable(table): bool
- isFunction(func): bool
- tableLength(table): number
- tableLastIterator(table): number

#### Examples:
##### Getting players
Get players with filter, using ESX.Game.GetPlayers()
```lua
getPlayers(function(source)
    local ped = GetPlayerPed(source)
    local coords = GetEntityCoords(ped)
    if GetDistanceBetweenCoords(coords,Config.Coords) < 100 then
        ESX.Game.Utils.DrawText3D(coords, GetPlayerName(v), 2)
    end
end)
```

##### Creating blips
Default options for blips can be found at config

Normal using natives:
```lua
ourBlip = AddBlipForCoord(x, y, z)
SetBlipSprite(ourBlip, 58)
SetBlipDisplay(ourBlip, 4)
SetBlipScale(ourBlip, 1.0)
SetBlipColour(ourBlip, 53)
SetBlipAsShortRange(ourBlip, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("Name")
EndTextCommandSetBlipName(ourBlip)
```
Using relisoft_core
```lua
local blip = createBlip("Name", 53,vector3(x,y,z), {
    type = 2,
    color = 12
})
```

##### Creating markers

All create methods must be in thread and run with Citizen.Wait(0), distance marker checking current ped with position of marker and distance, other properties is set at config and can be rewritten by options table
```lua
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        createMarker(1,vector3(x,y,z),{
            color = {
                r = 50,
                g = 150,
                b = 60
            },
            rotate = true
        })
    end
end)
```
Distance marker with onEnter, onLeave callbacks, these callbacks are call only once
but callback onEnterTick is called every tick when ped is in marker
```lua
createDistanceMarker(1,vector3(x,y,z),100.0,{onEnter = function ()
    sendChatMessage('Super!','Press E to kill your self!')
end, onLeave = function()
    sendChatMessage('Ouuuch?','Where are you leaving?! I will find you!')
end, onEnterTick = function ()
    if IsControlJustReleased(1, Keys['E']) then
        --Do some action
    end
end})
```


#### Use at your scripts
LUA
```lua
local blip = exports.relisoft_core:createBlip("Name", 53,vector3(x,y,z), {
    type = 2,
    color = 12
})
```

C#
```c
Exports["myresource"].getBlips()
```
