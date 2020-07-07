local actions = {}
local callRegister = {}
local dbg = rdebug()

function addAction(actionName, call)
    dbg.debug(string.format('[rcore] register action %s',actionName))
    actions[actionName] = call
end

function getAction(actionName)
    return actions[actionName]
end

function removeAction(actionName)
    actions[actionName] = nil
    callRegister[actionName] = nil
end

function callAction(actionName,params)
    if actions[actionName] ~= nil then
        dbg.debug(string.format('[rcore] call action %s',actionName))
        actions[actionName](params)
    end
end

function isCalled(actionName)
    if callRegister[actionName] == true then
        return true
    else
        return false
    end
end

function callActionOnce(actionName,params)
    if callRegister[actionName] == nil then
        if actions[actionName] ~= nil then
            dbg.debug(string.format('[rcore] call action once %s',actionName))
            actions[actionName](params)
        end
        callRegister[actionName] = true
    end
end

function resetCall(actionName)
    callRegister[actionName] = nil
end
