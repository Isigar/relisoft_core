ESX = nil
getEsxInstance(function(obj)
    ESX = obj
end)

local dbg = rdebug()
local distanceMarkers = getDistanceMarkers()
local markers = getMarkers()
local distanceTexts = getDistanceTexts()
local texts = getTexts()
local lastKey = {}
local storages = getStorages()
local storageMarkers = {}
local playerPos = vector3(0,0,0)
local isAtJobCache = {}
local nearDistanceTexts = {}
local nearDistanceMarkers = {}
local nearDistanceMarkerDistance = Config.NearObjectDistance
local isAtMarker = false
local isAtText = false

RegisterNetEvent('rcore:getWeaponAmmoClient')
AddEventHandler('rcore:getWeaponAmmoClient', function(weapon, cb)
    local ammo = GetAmmoInPedWeapon(PlayerPedId(), weapon)
    cb(ammo)
end)

RegisterNetEvent('rcore:showNotification')
AddEventHandler('rcore:showNotification',function(message,color,flashing,brief)
    showNotification(message,color,flashing,brief)
end)

RegisterNetEvent('rcore:setWeaponAmmo')
AddEventHandler('rcore:setWeaponAmmo', function(weapon, ammo)
    SetPedAmmo(PlayerPedId(), weapon, ammo)
end)

RegisterNetEvent('rcore:addWeaponAmmo')
AddEventHandler('rcore:addWeaponAmmo', function(weapon, ammo)
    AddAmmoToPed(PlayerPedId(), weapon, ammo)
end)

AddEventHandler('rcore:updateMarkers', function()
    markers = getMarkers()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.CheckPlayerPosition)
        local ped = PlayerPedId()
        playerPos = GetEntityCoords(ped)
        nearDistanceMarkers = {}
        for k, v in pairs(distanceMarkers) do
            local dist = #(playerPos - vector3(v.coords.x, v.coords.y, v.coords.z))
            if dist <= nearDistanceMarkerDistance then
                nearDistanceMarkers[k] = v
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.CheckPlayerPosition)
        local ped = PlayerPedId()
        playerPos = GetEntityCoords(ped)
        nearDistanceTexts = {}
        for k, v in pairs(distanceTexts) do
            local dist = #(playerPos - vector3(v.coords.x, v.coords.y, v.coords.z))
            if dist <= Config.NearObjectDistance then
                nearDistanceTexts[k] = v
            end
        end
    end
end)

RegisterNetEvent('rcore:changePlayer')
AddEventHandler('rcore:changePlayer',function(xPlayer)
    isAtJobCache = {}
    if Config.Debug then
        print('[rcore] player changed removing job cache')
    end
end)

function isAtJobFunc(id,v)
    if isAtJobCache[id] ~= nil then
        return isAtJobCache[id]
    else
        local isAtJobValue = false
        if v.options.jobs ~= nil or not emptyTable(v.options.jobs) then
            if v.options.grades ~= nil or not emptyTable(v.options.grades) then
                for _, j in pairs(v.options.jobs) do
                    for _, g in pairs(v.options.grades) do
                        isAtJobValue = isAtJobGrade(j, g)
                        if isAtJobValue then
                            break
                        end
                    end
                end
            else
                for _, j in pairs(v.options.jobs) do
                    isAtJobValue = isAtJob(j)
                    if isAtJobValue then
                        break
                    end
                end
            end
        else
            isAtJobValue = true
        end
        isAtJobCache[id] = isAtJobValue
        return isAtJobValue
    end
end

-- Distance marker
AddEventHandler('rcore:updateDistanceMarkers', function()
    distanceMarkers = getDistanceMarkers()
end)

--Internal key handler
function onKey(key)
    if isAtMarker ~= false then
        callActionOnce(string.format('marker-%s-onEnterKey',isAtMarker),key)
    end
    resetCall(string.format('marker-%s-onEnterKey',isAtMarker))

    if isAtText ~= false then
        callActionOnce(string.format('text-%s-onEnterKey',isAtText),key)
    end
    resetCall(string.format('text-%s-onEnterKey',isAtText))
end

--Check if press key
Citizen.CreateThread(function()
    local keys = getKeys()
    local isPressed = IsControlJustReleased
    while true do
        Citizen.Wait(0)
        for key, value in pairs(keys) do
            if isPressed(0, value) then
                onKey(value)
                TriggerEvent('rcore:onKey', value)
            end
        end
    end
end)

--Render near distance marker
Citizen.CreateThread(function()
    local atJob = isAtJobFunc
    local marker = DrawMarker

    while true do
        Citizen.Wait(1)
        for id, v in pairs(nearDistanceMarkers) do
            if atJob(id,v) then
                local dist = #(playerPos-vector3(v.coords.x, v.coords.y, v.coords.z))
                if dist < v.distance then
                    marker(v.type,
                        v.coords.x,
                        v.coords.y,
                        v.coords.z,
                        v.options.dir.x,
                        v.options.dir.y,
                        v.options.dir.z,
                        v.options.rot.x,
                        v.options.rot.y,
                        v.options.rot.x,
                        v.options.scale.x,
                        v.options.scale.y,
                        v.options.scale.z,
                        v.options.color.r,
                        v.options.color.g,
                        v.options.color.b,
                        v.options.color.a,
                        v.options.bobUpAndDown,
                        v.options.faceCamera,
                        v.options.p19,
                        v.options.rotate,
                        v.options.textureDict,
                        v.options.textureName,
                        v.options.drawOnEnts)
                end
            end
        end
    end
end)

--Check distance marker on enter, on leave
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(150)
        for id, v in pairs(nearDistanceMarkers) do
            if isAtJobFunc(id,v) then
                if not playerPos then
                    playerPos = GetEntityCoords(PlayerPedId())
                end
                if v.coords == nil or v.coords.x == nil then
                    dbg.critical('Marker id %s has invalid coordinates, skipping for now!',id)
                else
                    local dist = #(playerPos-vector3(v.coords.x, v.coords.y, v.coords.z))

                    if dist <= (v.options.scale.x+(v.options.scale.x/4)) then
                        isAtMarker = id
                        callActionOnce(string.format('marker-%s-onEnter',id))
                        resetCall(string.format('marker-%s-onLeave',id))
                    else
                        if isAtMarker == id then
                            isAtMarker = false
                        end
                        if isCalled(string.format('marker-%s-onEnter',id)) then
                            isAtMarker = false
                            callActionOnce(string.format('marker-%s-onLeave',id))
                            resetCall(string.format('marker-%s-onEnter',id))
                        end
                    end
                end
            end
        end
    end
end)

--Update distance text
AddEventHandler('rcore:updateDistanceTexts', function()
    distanceTexts = getDistanceTexts()
end)

RegisterCommand('rcorestats', function()
    print(string.format('RENDERING: DISTANCE MARKERS: %s | DISTANCE TEXTS: %s', tableLength(nearDistanceMarkers), tableLength(nearDistanceTexts)))
end)

--Render distance text
Citizen.CreateThread(function()
    local atJob = isAtJobFunc
    local draw = draw3DText
    while true do
        Citizen.Wait(0)
        for id, v in pairs(nearDistanceMarkers) do
            if atJob(id,v) then
                local dist = #(playerPos-vector3(v.coords.x, v.coords.y, v.coords.z))
                if dist < v.distance then
                    draw(v.coords, v.text, v.options)
                end
            end
        end
    end
end)

--Call distance text on enter, on leave
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(150)
        for id, v in pairs(nearDistanceTexts) do
            local dist = #(playerPos-vector3(v.coords.x, v.coords.y, v.coords.z))
            if dist < v.distance then
                if dist <= (v.options.actionDistance+(v.options.actionDistance/4)) then
                    isAtText = id
                    callActionOnce(string.format('text-%s-onEnter',id))
                    resetCall(string.format('text-%s-onLeave',id))
                else
                    if isAtText == id then
                        isAtText = false
                    end
                    if isCalled(string.format('text-%s-onEnter',id)) then
                        isAtText = false
                        callActionOnce(string.format('text-%s-onLeave',id))
                        resetCall(string.format('text-%s-onEnter',id))
                    end
                end
            end
        end
    end
end)

AddEventHandler('rcore:updateStorages',function()
    storages = getStorages()


    Citizen.CreateThread(function()
        Citizen.Wait(500)
        for id, storage in pairs(storages) do
            if storageMarkers[id] == nil then
                storageMarkers[id] = {}
            end

            if storage.updated then
                for _, m in pairs(storageMarkers[id]) do
                    removeDistanceMarker(m)
                end
            end
            local marker = createDistanceMarker(1, storage.coords, storage.distance, {
                onEnter = function()
                    if not isInVehicle() then
                        if isStorageBusy(storage.id) then
                            showHelpNotification('V tomto skladu jiz nekdo radi, ty se tam uz fakt nevlezes!')
                        else
                            showHelpNotification('Zmackni ~INPUT_CONTEXT~ pro otevreni skladu')
                        end
                    end
                end,
                onEnterKey = function(key)
                    if not isInVehicle() then
                        if key == getKeys()['E'] then
                            if isStorageBusy(storage.id) then
                                showNotification('V tomto skladu jiz nekdo radi, ty se tam ~r~nevlezes~w~, pockej!')
                            else
                                setStorageBusy(storage.id, true)
                                openStorageMenu(storage.id,storage.title,storage.name, storage.datastore)
                            end
                        end
                    end
                end,
                onLeave = function()
                    closeStorageMenu(storage.id)
                    setStorageBusy(storage.id, false)
                end
            },
                storage.options)

            table.insert(storageMarkers[id],marker)
        end
    end)
end)

AddEventHandler('onClientResourceStart',function(name)
    if GetCurrentResourceName() == name then
        Citizen.CreateThread(function()
            Citizen.Wait(1500)
            dbg.info(string.format('[rcore] restarting rcore - getting player data'))
            loadPlayer()
        end)
    end
end)
