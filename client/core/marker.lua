Markers = {}

---@param type number
---@param coords vector3
---@param options table
---@param onEnter function|nil
---@param onLeave function|nil
function createMarker(type, coords, options, onEnter, onLeave)
    if isTable(options) then
        options = mergeTables(options, Config.DefaultMarkerOptions)
    else
        options = Config.DefaultMarkerOptions
    end

    onEnter = onEnter or function() end
    onLeave = onLeave or function() end

    DrawMarker(type,
            coords.x,
            coords.y,
            coords.z,
            options.dir.x,
            options.dir.y,
            options.dir.z,
            options.rot.x,
            options.rot.y,
            options.rot.x,
            options.scale.x,
            options.scale.y,
            options.scale.z,
            options.color.r,
            options.color.g,
            options.color.b,
            options.color.a,
            options.bobUpAndDown,
            options.faceCamera,
            options.p19,
            options.rotate,
            options.textureDict,
            options.textureName,
            options.drawOnEnts)

    local enter = false

    local pos = getPlayerPos()
    local dist = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,coords.x,coords.y,coords.z)
    if dist < options.scale.x then
        if not enter then
            onEnter()
        end
        enter = true
    else
        if enter then
            onLeave()
        end
        enter = false
    end
end

---@param type number
---@param coords vector3
---@param distance number
---@param options table
---@param onEnter function|nil
---@param onLeave function|nil
function createDistanceMarker(type, coords, distance, options,onEnter, onLeave)

    if isTable(options) then
        options = mergeTables(options, Config.DefaultMarkerOptions)
    else
        options = Config.DefaultMarkerOptions
    end

    local pos = getPlayerPos()
    local dist = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,coords.x,coords.y,coords.z)
    if dist < distance then
        DrawMarker(type,
                coords.x,
                coords.y,
                coords.z,
                options.dir.x,
                options.dir.y,
                options.dir.z,
                options.rot.x,
                options.rot.y,
                options.rot.x,
                options.scale.x,
                options.scale.y,
                options.scale.z,
                options.color.r,
                options.color.g,
                options.color.b,
                options.color.a,
                options.bobUpAndDown,
                options.faceCamera,
                options.p19,
                options.rotate,
                options.textureDict,
                options.textureName,
                options.drawOnEnts)
    end

    local enter = false
    if dist < options.scale.x then
        if not enter then
            onEnter()
        end
        enter = true
    else
        if enter then
            onLeave()
        end
        enter = false
    end
end
