Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

function isInVehicle(ped)
    ped = ped or PlayerPedId()

    local vehicle = GetVehiclePedIsIn(ped)
    if vehicle == 0 then
        return false
    else
        return vehicle
    end
end

exports('isInVehicle',isInVehicle)

--- @return vector3
function getPlayerPos()
    local ped = PlayerPedId()
    return GetEntityCoords(ped)
end

exports('getPlayerPos', getPlayerPos)

--- @param x number
--- @param y number
--- @param z number
--- @param text string
function draw3DText(pos, text, options)
    options = options or { }
    local color = options.color or {r = 255, g = 255, b = 255, a = 255}
    local scaleOption = options.scale or {scale = 0.5, size = 0.5}

    local camCoords      = GetGameplayCamCoords()
    local dist           = GetDistanceBetweenCoords(camCoords.x, camCoords.y, camCoords.z, pos.x, pos.y, pos.z, 1)
    local scale = (scaleOption.size / dist) * 2
    local fov   = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    SetDrawOrigin(pos.x, pos.y, pos.z, 0);
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(0.0 * scale, 0.55 * scale)
    SetTextColour(color)
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

function deleteVehicle(vehicle)
    SetEntityAsMissionEntity(vehicle, false, true)
    DeleteVehicle(vehicle)
end

exports('deleteVehicle', deleteVehicle)
