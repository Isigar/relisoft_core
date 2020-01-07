ESX = nil
Blips = {}

function getEsxInstance()
    if ESX ~= nil then
        return ESX
    else
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj)
                ESX = obj
            end)
            Citizen.Wait(1)
        end
    end
end

---@return vector3
function getPlayerPos()
    local ped = PlayerPedId()
    return GetEntityCoords(ped)
end

---@param title string
---@param message string
---@param color nil|table
function sendChatMessage(title, message, color)
    if color == nil then
        color = Config.DefaultChatColor
    end
    TriggerEvent('chat:addMessage', { args = { title, message }, color = color })
end

---@param name string
---@param blip number
---@param coords vector3
---@param options table
---@return number
function createBlip(name, blip, coords, options)
    local x, y, z = table.unpack(coords)

    if isTable(options) then
        options = mergeTables(options, Config.DefaultBlipOptions)
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

---@param instance number
---@return nil|number
function getBlip(instance)
    if Blips[instance] ~= nil then
        return Blips[instance]
    end
    return nil
end

---@return table
function getBlips()
    return Blips
end

---@param message string
function debug(message)
    print(message)
end

---@param filter nil|function
---@return table
function getPlayers(filter)
    local esx = getEsxInstance()
    local players = esx.Game.GetPlayers()
    if filter ~= nil then
        local toReturn = {}
        for i, v in pairs(players) do
            if filter(v) then
                toReturn[i] = v
            end
        end
        return toReturn
    else
        return players
    end
end
