Blips = {}

---@param name string
---@param blip number
---@param coords vector3
---@param options table
---@return number
function createBlip(name, blip, coords, options)
    local x, y, z = table.unpack(coords)

    if options ~= nil and isTable(options) and not emptyTable(options) then
        options = mergeParams(options, Config.DefaultBlipOptions)
    else
        options = Config.DefaultBlipOptions
    end

    local ourBlip = AddBlipForCoord(x, y, z)
    SetBlipSprite(ourBlip, blip)
    SetBlipDisplay(ourBlip, options.type)
    SetBlipScale(ourBlip, options.scale)
    SetBlipColour(ourBlip, options.color)
    SetBlipAsShortRange(ourBlip, options.shortRange)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name)
    EndTextCommandSetBlipName(ourBlip)
    Blips[ourBlip] = ourBlip
    return ourBlip
end

exports('createBlip',createBlip)

function removeBlip(id)
    if DoesBlipExist(Blips[id]) then
        RemoveBlip(Blips[id])
    end
end

exports('removeBlip',removeBlip)

---@param name string
---@param blip number
---@param coords vector3
---@param rotation number
---@param width number
---@param height number
---@param options table
---@return number
function createAreaBlip(coords,rotation,width,height,options)
    local x, y, z = table.unpack(coords)

    if isTable(options) then
        options = mergeParams(options, Config.DefaultBlipOptions)
    else
        options = Config.DefaultBlipOptions
    end

    local ourBlip = AddBlipForArea(x, y, z,width,height)
    if options.blip ~= -1 then
        SetBlipSprite(ourBlip,options.blip)
    end
    SetBlipRotation(ourBlip,rotation)
    SetBlipColour(ourBlip, options.color)
    Blips[ourBlip] = ourBlip
    return ourBlip
end

exports('createAreaBlip',createAreaBlip)

---@param instance number
---@return nil|number
function getBlip(instance)
    if Blips[instance] ~= nil then
        return Blips[instance]
    end
    return nil
end

exports('getBlip',getBlip)

---@return table
function getBlips()
    return Blips
end

exports('getBlips',getBlips)
