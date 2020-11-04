local dbg = rdebug()
local distanceMarkers = {}
local markers = {}

function findDistanceMarkersWithSameCoords(coords)
    for k, v in pairs(distanceMarkers) do
        if v.coords == coords then
            return k
        end
    end
end

function findMarkersWithSameCoords(coords)
    for k, v in pairs(markers) do
        if v.coords == coords then
            return k
        end
    end
end

function removeMarker(id)
    markers[id] = nil
    removeMarkerAction(id)
    TriggerEvent('rcore:updateMarkers')
end

exports('removeMarker', removeMarker)

function removeDistanceMarker(id)
    distanceMarkers[id] = nil
    removeMarkerAction(id)
    TriggerEvent('rcore:updateDistanceMarkers')
end

exports('removeDistanceMarker', removeDistanceMarker)

function removeDistanceMarkerByPos(pos)
    local findId = findDistanceMarkersWithSameCoords(pos)
    if findId then
        removeDistanceMarker(findId)
    end
end

exports('removeDistanceMarkerByPos',removeDistanceMarkerByPos)

function updateMarker(id, type, coords, options)
    if options ~= nil and isTable(options) and not emptyTable(options) then
        options = mergeParams(options,Config.DefaultMarkerOptions)
    else
        options = Config.DefaultMarkerOptions
    end
    markers[id] = {
        type = type,
        coords = coords,
        distance = distance,
        options = options
    }
end

exports('updateMarker', updateMarker)

function removeMarkerAction(id)
    removeAction(string.format('marker-%s-onEnter',id))
    removeAction(string.format('marker-%s-onEnterKey',id))
    removeAction(string.format('marker-%s-onLeave',id))
end

--- @param type number
--- @param coords vector3
--- @param options table
--- @param onEnter function|nil
--- @param onLeave function|nil
--function createMarker(type, coords, cb, options)
--    if options ~= nil and isTable(options) and not emptyTable(options) then
--        options = mergeParams(options,Config.DefaultMarkerOptions)
--    else
--        options = Config.DefaultMarkerOptions
--    end
--
--    local findId = findMarkersWithSameCoords(coords)
--    if findId then
--        if Config.Debug then
--            dbg.debug(string.format('[rcore] Find marker with same coords - updating, marker id: %s',findId))
--        end
--        updateMarker(findId, type, coords, options)
--
--        if cb.onEnter ~= nil then
--            addAction(string.format('marker-%s-onEnter',findId),cb.onEnter)
--        end
--
--        if cb.onEnterKey ~= nil then
--            addAction(string.format('marker-%s-onEnterKey',findId),cb.onEnterKey)
--        end
--
--        if cb.onLeave ~= nil then
--            addAction(string.format('marker-%s-onLeave',findId),cb.onLeave)
--        end
--
--        TriggerEvent('rcore:updateMarkers',findId)
--
--        return findId
--    else
--        table.insert(markers,{
--            type = type,
--            coords = coords,
--            options = options
--        })
--
--        local currentId = tableLastIterator(distanceMarkers)
--
--        if cb.onEnter ~= nil then
--            addAction(string.format('marker-%s-onEnter',currentId),cb.onEnter)
--        end
--
--        if cb.onLeave ~= nil then
--            addAction(string.format('marker-%s-onLeave',currentId),cb.onLeave)
--        end
--
--        if cb.onEnterKey ~= nil then
--            addAction(string.format('marker-%s-onEnterKey',currentId),cb.onEnterKey)
--        end
--
--        TriggerEvent('rcore:updateMarkers',currentId)
--
--        return currentId
--    end
--end
--
--exports('createMarker', createMarker)

function updateDistanceMarker(id, type, coords, distance, options)
    if options ~= nil and isTable(options) and not emptyTable(options) then
        options = mergeParams(options,Config.DefaultMarkerOptions)
    else
        options = Config.DefaultMarkerOptions
    end
    distanceMarkers[id] = {
        type = type,
        coords = coords,
        distance = distance,
        options = options
    }
end

exports('updateDistanceMarker', updateDistanceMarker)

--- @param type number
--- @param coords vector3
--- @param distance number
--- @param options table
function createDistanceMarker(type, coords, distance, cb, options)
    if options ~= nil and isTable(options) and not emptyTable(options) then
        options = mergeParams(options,Config.DefaultMarkerOptions)
    else
        options = Config.DefaultMarkerOptions
    end

    local findId = findDistanceMarkersWithSameCoords(coords)
    if findId then
        if Config.Debug then
            dbg.debug(string.format('[rcore] Find marker with same coords - updating, marker id: %s',findId))
        end
        updateDistanceMarker(findId, type, coords, distance, options)

        if cb.onEnter ~= nil then
            addAction(string.format('marker-%s-onEnter',findId),cb.onEnter)
        end

        if cb.onLeave ~= nil then
            addAction(string.format('marker-%s-onLeave',findId),cb.onLeave)
        end

        if cb.onEnterKey ~= nil then
            addAction(string.format('marker-%s-onEnterKey',findId),cb.onEnterKey)
        end

        TriggerEvent('rcore:updateDistanceMarkers',findId)

        return findId
    else
        table.insert(distanceMarkers,{
            type = type,
            coords = coords,
            distance = distance,
            options = options
        })
        local currentId = tableLastIterator(distanceMarkers)

        if cb.onEnter ~= nil then
            addAction(string.format('marker-%s-onEnter',currentId),cb.onEnter)
        end

        if cb.onLeave ~= nil then
            addAction(string.format('marker-%s-onLeave',currentId),cb.onLeave)
        end

        if cb.onEnterKey ~= nil then
            addAction(string.format('marker-%s-onEnterKey',currentId),cb.onEnterKey)
        end

        TriggerEvent('rcore:updateDistanceMarkers',currentId)

        return currentId
    end
end

exports('createDistanceMarker', createDistanceMarker)

function getMarkers()
    return markers
end

exports('getMarkers', getMarkers)

function getMarker(id)
    return markers[id]
end

exports('getMarker', getMarker)

function getDistanceMarkers()
    return distanceMarkers
end

exports('getDistanceMarkers', getDistanceMarkers)

function getDistanceMarker(id)
    return distanceMarkers[id]
end

exports('getDistanceMarker', getDistanceMarker)
