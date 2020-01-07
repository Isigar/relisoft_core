Marker = {}

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
            Config.DefaultMarkerOptions.dir.x,
            Config.DefaultMarkerOptions.dir.y,
            Config.DefaultMarkerOptions.dir.z,
            Config.DefaultMarkerOptions.rot.x,
            Config.DefaultMarkerOptions.rot.y,
            Config.DefaultMarkerOptions.rot.x,
            Config.DefaultMarkerOptions.scale.x,
            Config.DefaultMarkerOptions.scale.y,
            Config.DefaultMarkerOptions.scale.z,
            Config.DefaultMarkerOptions.color.r,
            Config.DefaultMarkerOptions.color.g,
            Config.DefaultMarkerOptions.color.b,
            Config.DefaultMarkerOptions.color.a,
            Config.DefaultMarkerOptions.bobUpAndDown,
            Config.DefaultMarkerOptions.faceCamera,
            Config.DefaultMarkerOptions.p19,
            Config.DefaultMarkerOptions.rotate,
            Config.DefaultMarkerOptions.textureDict,
            Config.DefaultMarkerOptions.textureName,
            Config.DefaultMarkerOptions.drawOnEnts)
end

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
                Config.DefaultMarkerOptions.dir.x,
                Config.DefaultMarkerOptions.dir.y,
                Config.DefaultMarkerOptions.dir.z,
                Config.DefaultMarkerOptions.rot.x,
                Config.DefaultMarkerOptions.rot.y,
                Config.DefaultMarkerOptions.rot.x,
                Config.DefaultMarkerOptions.scale.x,
                Config.DefaultMarkerOptions.scale.y,
                Config.DefaultMarkerOptions.scale.z,
                Config.DefaultMarkerOptions.color.r,
                Config.DefaultMarkerOptions.color.g,
                Config.DefaultMarkerOptions.color.b,
                Config.DefaultMarkerOptions.color.a,
                Config.DefaultMarkerOptions.bobUpAndDown,
                Config.DefaultMarkerOptions.faceCamera,
                Config.DefaultMarkerOptions.p19,
                Config.DefaultMarkerOptions.rotate,
                Config.DefaultMarkerOptions.textureDict,
                Config.DefaultMarkerOptions.textureName,
                Config.DefaultMarkerOptions.drawOnEnts)
    end
end

