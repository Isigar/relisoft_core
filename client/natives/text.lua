local distanceTexts = {}
local texts = {}

function findDistanceTextWithSameCoords(coords)
    for k, v in pairs(distanceTexts) do
        if v.coords == coords then
            return k
        end
    end
end

function findTextWithSameCoords(coords)
    for k, v in pairs(texts) do
        if v.coords == coords then
            return k
        end
    end
end

function removeText(id)
    texts[id] = nil
    TriggerEvent('rcore:updateText')
end

exports('removeText', removeText)

function removeDistanceText(id)
    distanceTexts[id] = nil
    TriggerEvent('updateDistanceTexts')
end

exports('removeDistanceText', removeDistanceText)

function updateText(id, text, coords, options)
    if options ~= nil and isTable(options) and not emptyTable(options) then
        options = mergeParams(options,Config.DefaultTextOptions)
    else
        options = Config.DefaultTextOptions
    end
    texts[id] = {
        text = text,
        coords = coords,
        options = options
    }
end

exports('updateText', updateText)

function removeTextAction(id)
    removeAction(string.format('text-%s-onEnter',id))
    removeAction(string.format('text-%s-onEnterKey',id))
    removeAction(string.format('text-%s-onLeave',id))
end

--- @param text string
--- @param coords vector3
--- @param options table
--- @param onEnter function|nil
--- @param onLeave function|nil
function createText(text, coords, options, cb)
    if options ~= nil and isTable(options) and not emptyTable(options) then
        options = mergeParams(options,Config.DefaultTextOptions)
    else
        options = Config.DefaultTextOptions
    end
    cb = cb or {}

    local findId = findTextWithSameCoords(coords)
    if findId then
        if Config.Debug then
            print(string.format('[rcore] Find text with same coords - updating, text id: %s',findId))
        end
        updateText(findId, text, coords, options)

        if cb.onEnter ~= nil then
            addAction(string.format('text-%s-onEnter',findId),cb.onEnter)
        end

        if cb.onEnterKey ~= nil then
            addAction(string.format('text-%s-onEnterKey',findId),cb.onEnterKey)
        end

        if cb.onLeave ~= nil then
            addAction(string.format('text-%s-onLeave',findId),cb.onLeave)
        end

        TriggerEvent('rcore:updateText')

        return findId
    else
        local findId = tableLastIterator(texts)

        table.insert(texts,{
            text = text,
            coords = coords,
            options = options,
        })

        if cb.onEnter ~= nil then
            addAction(string.format('text-%s-onEnter',findId),cb.onEnter)
        end

        if cb.onEnterKey ~= nil then
            addAction(string.format('text-%s-onEnterKey',findId),cb.onEnterKey)
        end

        if cb.onLeave ~= nil then
            addAction(string.format('text-%s-onLeave',findId),cb.onLeave)
        end

        TriggerEvent('rcore:updateText')

        return findId
    end
end

exports('createText', createText)

function updateDistanceText(id, text, coords, distance, options)
    if options ~= nil and isTable(options) and not emptyTable(options) then
        options = mergeParams(options,Config.DefaultTextOptions)
    else
        options = Config.DefaultTextOptions
    end
    distanceTexts[id] = {
        text = text,
        coords = coords,
        distance = distance,
        options = options
    }
end

exports('updateDistanceText', updateDistanceText)

--- @param type number
--- @param coords vector3
--- @param distance number
--- @param options table
function createDistanceText(text, coords, distance, options, cb)
    if options ~= nil and isTable(options) and not emptyTable(options) then
        options = mergeParams(options,Config.DefaultTextOptions)
    else
        options = Config.DefaultTextOptions
    end
    cb = cb or {}

    local findId = findDistanceTextWithSameCoords(coords)
    if findId then
        if Config.Debug then
            print(string.format('[rcore] Find text with same coords - updating, text id: %s',findId))
        end
        updateDistanceText(findId, text, coords, distance, options)

        if cb.onEnter ~= nil then
            addAction(string.format('text-%s-onEnter',findId),cb.onEnter)
        end

        if cb.onEnterKey ~= nil then
            addAction(string.format('text-%s-onEnterKey',findId),cb.onEnterKey)
        end

        if cb.onLeave ~= nil then
            addAction(string.format('text-%s-onLeave',findId),cb.onLeave)
        end

        TriggerEvent('updateDistanceTexts')

        return findId
    else
        local findId = tableLastIterator(distanceTexts)

        table.insert(distanceTexts,{
            text = text,
            coords = coords,
            distance = distance,
            options = options
        })

        if cb.onEnter ~= nil then
            addAction(string.format('text-%s-onEnter',findId),cb.onEnter)
        end

        if cb.onEnterKey ~= nil then
            addAction(string.format('text-%s-onEnterKey',findId),cb.onEnterKey)
        end

        if cb.onLeave ~= nil then
            addAction(string.format('text-%s-onLeave',findId),cb.onLeave)
        end

        TriggerEvent('updateDistanceTexts')

        return findId
    end
end

exports('createDistanceText', createDistanceText)

function getTexts()
    return texts
end

exports('getTexts', getTexts)

function getDistanceTexts()
    return distanceTexts
end

exports('getDistanceTexts', getDistanceTexts)
