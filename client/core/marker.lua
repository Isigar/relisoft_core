---@param type number
---@param coords vector3
---@param options table
---@param onEnter function|nil
---@param onLeave function|nil
function createMarker(type, coords, options)
    if isTable(options) then
        options = mergeTables(options, Config.DefaultMarkerOptions)
    else
        options = Config.DefaultMarkerOptions
    end

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

    local pos = getPlayerPos()
    local dist = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,coords.x,coords.y,coords.z)
    if dist < options.scale.x then
        if options.onEnter ~= nil then
            options.onEnter()
        end
    else
        if options.onLeave ~= nil then
            options.onLeave()
        end
    end
end

---@param type number
---@param coords vector3
---@param distance number
---@param options table
function createDistanceMarker(type, coords, distance, options)

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

    if dist <= options.scale.x then
        if options.onEnter ~= nil then
            options.onEnter()
        end
    else
        if options.onLeave ~= nil then
            options.onLeave()
        end
    end
end
