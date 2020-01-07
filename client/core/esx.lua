ESX = nil
Blips = {}

function getEsxInstance()
    if ESX ~= nil then
        return ESX
    else
        while ESX == nil do
            TriggerEvent('esx:getSharedObject',function (obj) ESX = obj end)
            Citizen.Wait(1)
        end
    end
end

function getPlayerPos()
    local ped = PlayerPedId()
    return GetEntityCoords(ped)
end


function sendChatMessage(title, message, color)
    if color == nil then
        color = Config.DefaultChatColor
    end
    TriggerEvent('chat:addMessage', { args = { title, message }, color = color })
end

-- create blip and return it instance
function createBlip(name, blip, coords, options)
    local x,y,z = table.unpack(coords)

    if isTable(options) then
        options = mergeTables(options,Config.DefaultBlipOptions)
    else
        options = Config.DefaultBlipOptions
    end

    local ourBlip
    ourBlip = AddBlipForCoord(x, y, z)
    SetBlipSprite(ourBlip, blip)
    SetBlipDisplay(ourBlip, v.type)
    SetBlipScale(ourBlip, v.scale)
    SetBlipColour(ourBlip, v.color)
    SetBlipAsShortRange(ourBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name)
    EndTextCommandSetBlipName(ourBlip)
    table.insert(Blips, ourBlip)
    return ourBlip
end

function getBlips()
    return Blips
end

function debug(message)
    print(message)
end

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
