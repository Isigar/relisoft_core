local distanceMarkers = {}
local markers = {}

--- @param type number
--- @param coords vector3
--- @param options table
--- @param onEnter function|nil
--- @param onLeave function|nil
function createMarker(type, coords, options)
    table.insert(markers,{
        type = type,
        coords = coords,
        distance = distance,
        options = options
    })
end

--- @param type number
--- @param coords vector3
--- @param distance number
--- @param options table
function createDistanceMarker(type, coords, distance, options)
    table.insert(distanceMarkers,{
        type = type,
        coords = coords,
        distance = distance,
        options = options
    })
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