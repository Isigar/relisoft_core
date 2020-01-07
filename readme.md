##relisoft_core
##### implemention of most common function in better way (using ESX)

#### Dependency:

- essentialmode
- es_extended
- esx_society

####TODO:

- main relisoft_core
- exported functions
- fraction with society creation
- easy storage system
- storage user/fraction
- creating blips
- managing blips (location, remove, change color)


####Functions:

- getEsxInstance(): ESX
- getPlayerPos(): vector3(x,y,z)
- sendChatMessage(title, message, color): void
- getPlayers(filter)
- createBlip(name, blip, coords, options): Blip
- getBlips(): Blip[]

###### Common:

- mergeTables(sourceTable, targetTable): table
- emptyTable(table): bool
- isTable(table): bool
- isFunction(func): bool

#### Examples:

```lua
Player filters:

getPlayers(function(source)
    local ped = GetPlayerPed(source)
    local coords = GetEntityCoords(ped)
    if GetDistanceBetweenCoords(coords,Config.Coords) < 100 then
        ESX.Game.Utils.DrawText3D(coords, GetPlayerName(v), 2)
    end
end)

Create blip:

createBlip("Name", 53,vector3(x,y,z), {
    type = 2
})
```
