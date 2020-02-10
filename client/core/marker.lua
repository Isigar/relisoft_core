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

function updateMarker(id, type, coords, options)
    if options ~= nil and isTable(options) and not emptyTable(options) then
        options = mergeTables(options,Config.DefaultMarkerOptions)
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

--- @param type number
--- @param coords vector3
--- @param options table
--- @param onEnter function|nil
--- @param onLeave function|nil
function createMarker(type, coords, options)
    if options ~= nil and isTable(options) and not emptyTable(options) then
        options = mergeTables(options,Config.DefaultMarkerOptions)
    else
        options = Config.DefaultMarkerOptions
    end

    local findId = findMarkersWithSameCoords(coords)
    if findId then
        print(string.format('[rcore] Find marker with same coords - updating, marker id: %s',findId))
        updateMarker(findId, type, coords, options)
    else
        table.insert(markers,{
            type = type,
            coords = coords,
            options = options
        })
    end

    TriggerEvent('updateMarkers')

    return tableLastIterator(markers)
end

exports('createMarker', createMarker)

function updateDistanceMarker(id, type, coords, distance, options)
    if options ~= nil and isTable(options) and not emptyTable(options) then
        options = mergeTables(options,Config.DefaultMarkerOptions)
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
function createDistanceMarker(type, coords, distance, options)
    if options ~= nil and isTable(options) and not emptyTable(options) then
        options = mergeTables(options,Config.DefaultMarkerOptions)
    else
        options = Config.DefaultMarkerOptions
    end

    local findId = findDistanceMarkersWithSameCoords(coords)
    if findId then
        print(string.format('[rcore] Find marker with same coords - updating, marker id: %s',findId))
        updateDistanceMarker(findId, type, coords, distance, options)
    else
        table.insert(distanceMarkers,{
            type = type,
            coords = coords,
            distance = distance,
            options = options
        })
    end

    TriggerEvent('updateDistanceMarkers')

    return tableLastIterator(distanceMarkers)
end

exports('createDistanceMarker', createDistanceMarker)

function getMarkers()
    return markers
end

exports('getMarkers', getMarkers)

function getDistanceMarkers()
    return distanceMarkers
end

exports('getDistanceMarkers', getDistanceMarkers)