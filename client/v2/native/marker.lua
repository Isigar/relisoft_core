local dbg = rdebug()
local markers = {}

AddEventHandler('onResourceStop', function(res)
    for i,v in pairs(markers) do
        if v.resource == res then
            v.stopRender()
        end
    end
end)

function createMarker(res)
    local self = {}
    self.type = 1
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
    self.setType = function(param)
        self.type = param
    end
    self.getType = function()
        return self.type
    end
    self.setPosition = function(pos)
        self.position = pos
        return self
    end
    self.getPosition = function()
        return self.position
    end
    self.setDir = function(param)
        self.dir = param
    end
    self.getDir = function()
        return self.dir
    end
    self.setScale = function(param)
        self.scale = param
    end
    self.getScale = function()
        return self.scale
    end
    self.setColor = function(param)
        self.color = param
    end
    self.getColor = function()
        return self.color
    end
    self.setAlpha = function(param)
        self.color.a = param
    end
    self.getAlpha = function()
        return self.color.a
    end
    self.setRed = function(param)
        self.color.r = param
    end
    self.getRed = function()
        return self.color.r
    end
    self.setGreen = function(param)
        self.color.g = param
    end
    self.getGreen = function()
        return self.color.g
    end
    self.setBlue = function(param)
        self.color.b = param
    end
    self.getBlue = function()
        return self.color.b
    end
    self.setRenderDistance = function(distance)
        self.renderDistance = distance
        return self
    end
    self.getRenderDistance = function()
        return self.renderDistance
    end
    self.setRotation = function(param)
        self.rotation = param
    end
    self.getRotation = function()
        return self.rotation
    end
    self.setInRadius = function(param)
        self.inRadius = param
    end
    self.getInRadius = function()
        return self.inRadius
    end
    self.render = function()
        self.stopRendering = false

        --Position thread
        Citizen.CreateThread(function()
            while true do
                if self.stopRendering == true then
                    break
                end
                Citizen.Wait(100)
                local ped = PlayerPedId()
                local coords = GetEntityCoords(ped)
                local distance = #(coords-self.position)
                if distance <= self.renderDistance then
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
                elseif distance <= self.renderDistance*2 then
                    self.rendering = false
                    Citizen.Wait(250)
                elseif distance <= self.renderDistance*5 then
                    self.rendering = false
                    Citizen.Wait(2500)
                elseif distance > self.renderDistance*10 then
                    self.rendering = false
                    Citizen.Wait(5000)
                end
            end
        end)
        --Key press thread
        Citizen.CreateThread(function()
            while true do
                if self.stopRendering == true then
                    break
                end
                if self.isIn then
                    Citizen.Wait(0)
                    for _,key in pairs(self.keys) do
                        if IsControlJustReleased(0,key) then
                            if self.onKey ~= nil then
                                self.onKey(key)
                            end
                        end
                    end
                else
                    Citizen.Wait(100)
                end
            end
        end)
        --Render thread
        Citizen.CreateThread(function()
            while true do
                if self.stopRendering == true then
                    break
                end
                if self.rendering then
                    Citizen.Wait(0)
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
                else
                    Citizen.Wait(50)
                end
            end
        end)
        return self
    end
    self.stopRender = function()
        self.stopRendering = true
        self.rendering = false
    end
    self.isRendering = function()
        return self.rendering
    end
    self.setKeys = function(keys)
        self.keys = keys
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
    end
    table.insert(markers,self)
    return self
end

exports('createMarker',createMarker)
