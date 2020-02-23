local sounds = {}

function addSound(name,url,position,volume)
    sounds[name] = {
        name = name,
        url = url,
        position = position,
        volume = volume
    }
    TriggerClientEvent('rcore:soundUpdate',-1)
end

function getSounds()
    return sounds
end

function removeSound(name)
    if sounds[name] ~= nil then
        sounds[name] = nil
    end
    TriggerClientEvent('rcore:soundUpdate',-1)
end

ESX.RegisterServerCallback('rcore:addSound',function(source,cb,name, url, position, volume)
    addSound(name,url,position,volume)
    cb()
end)

ESX.RegisterServerCallback('rcore:removeSound',function(source,cb,name)
    cb(removeSound(name))
end)

ESX.RegisterServerCallback('rcore:getSounds',function(source,cb)
    cb(getSounds())
end)