--- @param x number
--- @param y number
--- @param z number
--- @param text string
function draw3DText(pos, text, options)
    options = options or { }
    local color = options.color or {r = 255, g = 255, b = 255, a = 255}
    local scaleOption = options.size or 0.8

    local camCoords      = GetGameplayCamCoords()
    local dist           = #(vector3(camCoords.x, camCoords.y, camCoords.z)-vector3(pos.x, pos.y, pos.z))
    local scale = (scaleOption / dist) * 2
    local fov   = (1 / GetGameplayCamFov()) * 100
    local scaleMultiplier = scale * fov
    SetDrawOrigin(pos.x, pos.y, pos.z, 0);
    SetTextFont(getFontId())
    SetTextProportional(0)
    SetTextScale(0.1 * scaleMultiplier, 0.55 * scaleMultiplier)
    SetTextColour(color.r,color.g,color.b,color.a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

exports('draw3DText', draw3DText)

--Taken and edited from https://forum.cfx.re/t/lua-finding-closest-ped-to-player/166950
function getClosestPed(targetPed, distance)
    local count = 0
    for ped in EnumeratePeds() do
        if DoesEntityExist(ped) and ped ~= 0 then
            local distanceCheck = #(GetEntityCoords(targetPed)-GetEntityCoords(ped))
            if distanceCheck <= distance then
                return ped
            end
            count = count + 1
        end
    end
    print('Find count',count)
    return nil
end

exports('getClosestPed',getClosestPed)

function getClosestPeds(targetPed, distance, count)
    count = count or 250

    local closestPed = {}
    local count = 0
    for ped in EnumeratePeds() do
        local distanceCheck = #(GetEntityCoords(targetPed)-GetEntityCoords(ped))
        if distanceCheck <= distance then
            table.insert(closestPed,ped)
        end
        count = count + 1
        if count >= count then
            break
        end
    end

    return closestPed
end

exports('getClosestPed',getClosestPed)
