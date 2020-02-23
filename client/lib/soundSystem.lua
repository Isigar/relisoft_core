local playPosition = {}
local soundAtEntity = {}

AddEventHandler('rcore:soundUpdate',function()
    ESX.TriggerServerCallback('rcore:getSounds',function(sounds)
        
    end)
end)

function distanceSong(name_, distance_)
    TriggerEvent("xCore:Sound:Distance",name_,distance_)
end

function playUrl(name_, url_, volume_)
    TriggerEvent("xCore:Sound:PlayUrl",name_,url_,volume_)
end

function playUrlPos(name_, url_, volume_, pos, distance)
    TriggerEvent("xCore:Sound:PlayUrlPos",name_, url_, volume_, pos)
    if distance ~= nil then
        TriggerEvent("xCore:Sound:Distance",name_,distance)
    end
end

function play(name_, url_, volume_)
    TriggerEvent("xCore:Sound:Play",name_,url_,volume_)
end

function playPos(name_, url_, volume_, pos)
    TriggerEvent("xCore:Sound:PlayPos",name_, url_, volume_, pos)
end

function updatePosition(name_, pos)
    TriggerEvent("xCore:Sound:UpdatePosition",name_, pos)
end

function stop(name_)
    TriggerEvent("xCore:Sound:Stop",name_)
end

function resume(name_)
    TriggerEvent("xCore:Sound:Resume",name_)
end

function pause(name_)
    TriggerEvent("xCore:Sound:Pause",name_)
end