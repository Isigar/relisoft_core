ESX = nil
getEsxInstance(function(obj)
    ESX = obj
end)

local distanceMarkers = getDistanceMarkers()
local markers = getMarkers()
local distanceTexts = getDistanceTexts()
local texts = getTexts()
local lastKey = {}
local storages = getStorages()
local storageMarkers = {}
local playerPos = vector3(0,0,0)
local isAtJobCache = {}
local nearDistanceMarkers = {}
local nearDistanceMarkerDistance = Config.NearObjectDistance
local isAtMarker = false

RegisterNetEvent('rcore:getWeaponAmmoClient')
AddEventHandler('rcore:getWeaponAmmoClient', function(weapon, cb)
    local ammo = GetAmmoInPedWeapon(PlayerPedId(), weapon)
    cb(ammo)
end)

RegisterNetEvent('rcore:showNotification')
AddEventHandler('rcore:showNotification',function(message)
    showNotification(message)
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
        local ped = PlayerPedId()
        playerPos = GetEntityCoords(ped)
        nearDistanceMarkers = {}
        for k, v in pairs(distanceMarkers) do
            local dist = #(playerPos - vector3(v.coords.x, v.coords.y, v.coords.z))
            if dist <= nearDistanceMarkerDistance then
                nearDistanceMarkers[k] = v
            end
        end

        Citizen.Wait(Config.CheckPlayerPosition)
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

-- Classic marker
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for id, v in pairs(markers) do
            if isAtJobFunc(id,v) then
                DrawMarker(v.type,
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

                local dist = #(playerPos-vector3(v.coords.x, v.coords.y, v.coords.z))
                if dist <= (v.options.scale.x+(v.options.scale.x/4)) then
                    callActionOnce(string.format('marker-%s-onEnter',id))
                    resetCall(string.format('marker-%s-onLeave',id))

                    for _, key in pairs(getKeys()) do
                        if IsControlJustReleased(0,key) then
                            callActionOnce(string.format('marker-%s-onEnterKey',id),key)
                        end
                        resetCall(string.format('marker-%s-onEnterKey',id))
                    end
                else
                    callActionOnce(string.format('marker-%s-onLeave',id))
                    resetCall(string.format('marker-%s-onEnter',id))
                    lastKey[id] = nil
                end
            end
        end
    end
end)

-- Distance marker
AddEventHandler('rcore:updateDistanceMarkers', function()
    distanceMarkers = getDistanceMarkers()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        for _, key in pairs(getKeys()) do
            if IsControlJustReleased(0,key) then
                TriggerEvent('rcore:onKey',key)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        for id, v in pairs(nearDistanceMarkers) do
            if isAtJobFunc(id,v) then
                local dist = #(playerPos-vector3(v.coords.x, v.coords.y, v.coords.z))
                if dist < v.distance then
                    DrawMarker(v.type,
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

AddEventHandler('rcore:onKey',function(key)
    if isAtMarker ~= false then
        callActionOnce(string.format('marker-%s-onEnterKey',isAtMarker),key)
    end
    resetCall(string.format('marker-%s-onEnterKey',isAtMarker))
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(150)
        for id, v in pairs(distanceMarkers) do
            if isAtJobFunc(id,v) then
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
end)

-- Distance text
AddEventHandler('rcore:updateDistanceTexts', function()
    distanceTexts = getDistanceTexts()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for _, v in pairs(distanceTexts) do
            local dist = #(playerPos-vector3(v.coords.x, v.coords.y, v.coords.z))
            if dist < v.distance then
                draw3DText(v.coords, v.text, v.options)
            end
        end
    end
end)

-- Text
AddEventHandler('rcore:updateTexts', function()
    texts = getTexts()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for _, v in pairs(texts) do
            draw3DText(v.coords, v.text, v.options)
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
            if Config.Debug then
                print(string.format('[rcore] restarting rcore - getting player data'))
            end
            loadPlayer()
        end)
    end
end)
