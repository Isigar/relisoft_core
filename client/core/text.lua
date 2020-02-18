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
    TriggerEvent('updateText')
end

exports('removeText', removeText)

function removeDistanceText(id)
    distanceTexts[id] = nil
    TriggerEvent('updateDistanceTexts')
end

exports('removeDistanceText', removeDistanceText)

function updateText(id, text, coords, options)
    if options ~= nil and isTable(options) and not emptyTable(options) then
        options = mergeTables(options,Config.DefaultTextOptions)
    else
        options = Config.DefaultTextOptions
    end
    texts[id] = {
        text = text,
        coords = coords,
        options = options
    }
end

exports('updateMarker', updateMarker)

--- @param text string
--- @param coords vector3
--- @param options table
--- @param onEnter function|nil
--- @param onLeave function|nil
function createText(text, coords, options)
    if options ~= nil and isTable(options) and not emptyTable(options) then
        options = mergeTables(options,Config.DefaultTextOptions)
    else
        options = Config.DefaultTextOptions
    end

    local findId = findTextWithSameCoords(coords)
    if findId then
        if Config.Debug then
            print(string.format('[rcore] Find text with same coords - updating, text id: %s',findId))
        end
        updateMarker(findId, text, coords, options)

        TriggerEvent('updateText')

        return findId
    else
        table.insert(texts,{
            text = text,
            coords = coords,
            options = options
        })

        TriggerEvent('updateText')

        return tableLastIterator(texts)
    end
end

exports('createText', createText)

function updateDistanceText(id, text, coords, distance, options)
    if options ~= nil and isTable(options) and not emptyTable(options) then
        options = mergeTables(options,Config.DefaultTextOptions)
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
function createDistanceText(text, coords, distance, options)
    if options ~= nil and isTable(options) and not emptyTable(options) then
        options = mergeTables(options,Config.DefaultTextOptions)
    else
        options = Config.DefaultTextOptions
    end

    local findId = findDistanceTextWithSameCoords(coords)
    if findId then
        if Config.Debug then
            print(string.format('[rcore] Find text with same coords - updating, text id: %s',findId))
        end
        updateDistanceText(findId, text, coords, distance, options)

        TriggerEvent('updateDistanceTexts')

        return findId
    else
        table.insert(distanceTexts,{
            text = text,
            coords = coords,
            distance = distance,
            options = options
        })

        TriggerEvent('updateDistanceTexts')

        return tableLastIterator(distanceTexts)
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