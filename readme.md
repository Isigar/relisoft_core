## relisoft_core
##### implemention of most common function in better way (using ESX)

#### Dependency:

- essentialmode
- es_extended

#### TODO:

- main relisoft_core
- exported functions
- fraction with society creation
- easy storage system
- storage user/fraction
- creating blips
- managing blips (location, remove, change color)
- permission system
- custom menu options by permissions
- marker system

#### Functions:

- getEsxInstance(): ESX
- getPlayerPos(): vector3(x,y,z)
- sendChatMessage(title, message, color): void
- getPlayers(filter)
- createBlip(name, blip, coords, options): Blip
- getBlips(): Blip[]
- getBlip(instance): ?Blip
- createMarker(type, coords, options)
- createDistanceMarker(type, coords, distance, options)

###### Common:

- mergeTables(sourceTable, targetTable): table
- emptyTable(table): bool
- isTable(table): bool
- isFunction(func): bool

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
