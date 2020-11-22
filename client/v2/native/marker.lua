local dbg = rdebug()

local markersV2 = {}
local nearMarkersV2 = {}

local getPed = PlayerPedId
local getCoords = GetEntityCoords

--Only near
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.CheckPlayerPosition)
        local ped = getPed()
        local coords = getCoords(ped)
        for i,self in pairs(markersV2) do
            local distance = #(coords-self.position)
            if distance < Config.NearObjectDistance then
                nearMarkersV2[self.id] = self
            else
                self.rendering = false
                markersV2[i] = self
                nearMarkersV2[self.id] = nil
            end
        end
    end
end)

----Position thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        local ped = getPed()
        local coords = getCoords(ped)
        for i,self in pairs(nearMarkersV2) do
            local distance = #(coords-self.position)
            if distance <= self.renderDistance and not self.destroyed then
                self.rendering = true
                if distance <= self.inRadius then
                    if self.isIn == false then
                        if self.onEnter ~= nil then
                            self.onEnter()
                        end
                    end
                    self.isIn = true
                else
                    if self.isIn then
                        if self.onLeave ~= nil then
                            self.onLeave()
                        end
                        self.isIn = false
                    end
                end
            else
                self.rendering = false
            end
            nearMarkersV2[i] = self
        end
    end
end)

--Render thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for i,self in pairs(nearMarkersV2) do
            if self.rendering and not self.destroyed then
                if self.isIn then
                    for _,key in pairs(self.keys) do
                        if IsControlJustReleased(0,key) then
                            if self.onKey ~= nil then
                                self.onKey(key)
                            end
                        end
                    end
                end

                --TODO: DRAW
                DrawMarker(
                        self.type,
                        self.position.x,
                        self.position.y,
                        self.position.z,
                        self.dir.x,
                        self.dir.y,
                        self.dir.z,
                        self.rot.x,
                        self.rot.y,
                        self.rot.z,
                        self.scale.x,
                        self.scale.y,
                        self.scale.z,
                        self.color.r,
                        self.color.g,
                        self.color.b,
                        self.color.a,
                        false,
                        false,
                        2,
                        self.rotation,nil,nil,false
                )
            end
        end
    end
end)

function createMarker(res)
    local self = {}
    self.id = #markersV2+1
    self.type = 1
    self.firstUpdate = false
    self.resource = res
    self.renderDistance = 20
    self.position = vector3(0,0,0)
    self.dir = vector3(0,0,0)
    self.rot = vector3(0,0,0)
    self.scale = vector3(1,1,1)
    self.rotation = false
    self.rendering = false
    self.stopRendering = false
    self.keys = {}
    self.onEnter = nil
    self.onLeave = nil
    self.onKey = nil
    self.isIn = false
    self.inRadius = 1.5
    self.color = {
        r = 255,
        g = 255,
        b = 255,
        a = 255
    }
    self.setId = function(param)
        self.id = param
        self.update()
    end
    self.getId = function()
        return self.id
    end
    self.setType = function(param)
        self.type = param
        self.update()
    end
    self.getType = function()
        return self.type
    end
    self.setPosition = function(pos)
        self.position = pos
        self.update()
        return self
    end
    self.getPosition = function()
        return self.position
    end
    self.setDir = function(param)
        self.dir = param
        self.update()
    end
    self.getDir = function()
        return self.dir
    end
    self.setScale = function(param)
        self.scale = param
        self.update()
    end
    self.getScale = function()
        return self.scale
    end
    self.setColor = function(param)
        self.color = param
        self.update()
    end
    self.getColor = function()
        return self.color
    end
    self.setAlpha = function(param)
        self.color.a = param
        self.update()
    end
    self.getAlpha = function()
        return self.color.a
    end
    self.setRed = function(param)
        self.color.r = param
        self.update()
    end
    self.getRed = function()
        return self.color.r
    end
    self.setGreen = function(param)
        self.color.g = param
        self.update()
    end
    self.getGreen = function()
        return self.color.g
    end
    self.setBlue = function(param)
        self.color.b = param
        self.update()
    end
    self.getBlue = function()
        return self.color.b
    end
    self.setRenderDistance = function(distance)
        self.renderDistance = distance
        self.update()
        return self
    end
    self.getRenderDistance = function()
        return self.renderDistance
    end
    self.setRotation = function(param)
        self.rotation = param
        self.update()
    end
    self.getRotation = function()
        return self.rotation
    end
    self.setInRadius = function(param)
        self.inRadius = param
        self.update()
    end
    self.getInRadius = function()
        return self.inRadius
    end
    self.render = function()
        self.stopRendering = false
        self.rendering = true;
        self.firstUpdate = false
        self.update()
        return self
    end
    self.stopRender = function()
        self.stopRendering = true
        self.rendering = false
        self.update()
    end
    self.destroy = function()
        self.stopRendering = true
        self.rendering = false
        self.destroyed = true
        self.update(true)
        dbg.debug('Deleted marker V2 %s', self.getId())
    end
    self.isRendering = function()
        return self.rendering
    end
    self.setKeys = function(keys)
        self.keys = keys
        self.update()
        return self
    end
    self.getKeys = function()
        return self.keys
    end
    self.on = function(type, cb)
        if string.lower(type) == 'enter' then
            self.onEnter = cb
        elseif string.lower(type) == 'leave' then
            self.onLeave = cb
        elseif string.lower(type) == 'key' then
            self.onKey = cb
        else
            rdebug.critical('Cannot create on state at 3D text because invalid state %s', self.state)
        end
        self.update()
    end
    self.update = function(destroy)
        if self.firstUpdate then
            return
        end

        if destroy then
            for ind,v in pairs(nearMarkersV2) do
                if v.getId() == self.getId() then
                    nearMarkersV2[ind] = nil
                    dbg.debug('Deleted %s text from near table', self.getId())
                end
            end

            for ind,v in pairs(markersV2) do
                if v.getId() == self.getId() then
                    markersV2[ind] = nil
                    dbg.debug('Deleted %s text from master table', self.getId())
                end
            end
        else
            for ind,v in pairs(markersV2) do
                if v.getId() == self.getId() then
                    markersV2[ind] = v
                end
            end
        end
    end
    dbg.debug('Create new marker V2 %s', self.getId())
    table.insert(markersV2, self)
    return self
end

exports('createMarker',createMarker)

AddEventHandler('onResourceStop', function(res)
    for i,v in pairs(markersV2) do
        if v.resource == res then
            v.stopRender()
        end
    end
end)
