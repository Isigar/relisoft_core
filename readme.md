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
- extended items usage

### CLIENT:
#### Functions:
###### ESX section
- getEsxInstance(cb): void
###### Blip section
- createBlip(name, blip, coords, options): Blip
- getBlips(): Blip[]
- getBlip(instance): ?Blip
###### Marker section
- createMarker(type, coords, options): void
- createDistanceMarker(type, coords, distance, options): void
- getMarkers(): Marker[]
###### Common section
- getPlayerPos(): vector3(x,y,z)
- sendChatMessage(title, message, color): void
- sendHelpNotification(text): void
- sendNotification(text): void
- getPlayers(filter)
- getPlayerData(force: boolean): PlayerData
- isPlayerLoaded(): boolean
- getPlayer(): PlayerData
###### Menu section
- createMenu(title, name, elements, options): void
- closeAllMenu()
- closeMenu(name)
- addElement(name, action)
- getElement(name)
- removeElement(name)
###### Font section 
- getFontId(): number 
- draw3DText(x, y, z, text): void
###### Jobs section
- isAtJob(job): boolean
- isAtJobGrade(job,grade): boolean
- getPlayerJob(force: boolean): Job

### SERVER:
#### Functions:
###### ESX section
- getEsxServerInstance(cb): void
###### Command section
- addAdminCmd(cmd, level, cb, help): void
- addCmd(cmd, cb, help): void
###### Phone section
- registerNumber(number, text): void
###### Society section
- registerSociety(society, name, type): boolean|nil
###### Datastore section
- getDatastore(name,cb)
- getPlayerDatastore(identifier, name,cb)
- createDatastore(name, shared,cb)
- isDatastoreExists(name)
###### Common section
- sendChatMessageFromServer(source,title,message,color): void
- sendNotificationFromServer(source, message): void
###### Player section
- getPlayerFromId(source,cb): void
###### Job section
- addPlayerToJob(source, job, grade): void

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
        draw3DText(coords.x,cords.y, coords.z, GetPlayerName(v))
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
**== BIG UPDATE ==**
 
In new version we create markers only once, rcore is creating every native that need to run every tick inside own client side script, which is used for better optimalization, you can use onEnter, onLeave like before, because this is called every tick.

New update also containing options to show markers only to some jobs or grades in jobs
You can use options `jobs = {}` and `grades = {}`
So if you want to create marker only for job police you can do it like this

`jobs = {'police'}`

And if it be only for boss of police you can do this

`jobs = {'police'}, grades = {'boss'}`

```lua
Citizen.CreateThread(function()
    
    createMarker(1,vector3(x,y,z),{
        color = {
            r = 50,
            g = 150,
            b = 60
        },
        rotate = true
    })
end)
```

Distance marker is used to create marker only be visible at some distance 3 parameter of this function
is distance to see
```lua
Citizen.CreateThread(function()
    createDistanceMarker(1,vector3(x,y,z),100.0,{
    onEnter = function ()
        sendChatMessage('Super!','Press E to kill your self!')
    end,onLeave = function()
        sendChatMessage('Ouuuch?','Where are you leaving?! I will find you!')
    end,jobs = {'police'}})
end)
```

### Server
##### Register number & society
```lua
--Register number & society
registerNumber('bazar','Autobazar')
registerSociety('bazar','Autobazar')
```

##### Add help command
```lua
-- Creating command
addCmd('help', function(source, args, user)
    -- Send message or something to client with source
end, '/help - show help informations')
```

##### Register datastore and get / set data
```lua
-- Create shared datastore
createDatastore('bazar',true)

-- Get shared datstore and get data and set data example
getDatastore('bazar', function(store)
    store.set('name',{
        some = data
    })

    local val = store.get('value')
    if val == nil then
        store.set('val',true)
    end
end)

-- Get player weapons from property datastore
getPlayerDatastore('steam:123456789','property',function (store)
    local weapons = store.get('weapons')
end)
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

##### Tips
Use export as global variable, its simple and you can use short version of calling rcore
```lua
rcore = exports.rcore

ESX = rcore:getEsxInstance()
```
