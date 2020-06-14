local cmds = {}
local currentPlayer

RegisterNetEvent('rcore:changePlayer')
AddEventHandler('rcore:changePlayer',function(xPlayer)
    currentPlayer = xPlayer
end)

function isAtGroup(name)
    local group = currentPlayer.getGroup()
    if group == name then
        return true
    end
    return false
end

function isAtJob(name)
    local job = currentPlayer.getJob()
    if job == nil then
        return false
    end

    if job.name == name then
        return true
    end
    return false
end

function registerGroupCommand(name,group,cb)
    RegisterCommand(name, function(source,args,rawCmd)
        if source > 0 then
            if isAtGroup(group) then
                cb(source,args,rawCmd)
            else
                sendChatMessageFromServer(source,'Commands','You dont have permission to do this command', {255,0,0})
            end
        end
    end)
end

function registerJobCommand(name,job, cb)
    RegisterCommand(name, function(source,args,rawCmd)
        if source > 0 then
            if isAtJob(job) then
                cb(source,args,rawCmd)
            else
                sendChatMessageFromServer(source,'Commands','You dont have permission to do this command', {255,0,0})
            end
        end
    end)
end

function registerAdvancedCommand(name, permissions, cb)

end

function registerCommand(name, cb)
    RegisterCommand(name, function(source,args, rawCmd)
        if source > 0 then
            cb(source,args,rawCmd)
        end
    end)
end

function registerRconCommand(name,cb)
    RegisterCommand(name,function(source,args,rawCmd)
        if source == 0 then
            cb(source,args,rawCmd)
        end
    end)
end

---@param cmd string Name of command without slash
---@param level number Needed admin level
---@param cb function Callback with source,args,user
function addGroupCmd(cmd, group, cb)
    registerGroupCommand(cmd,group,cb)
end

exports('addGroupCmd',addGroupCmd)


---@param cmd string Name of command without slash
---@param cb function Callback with source,args,user
function addCmd(cmd, cb)
    registerCommand(cmd,cb)
end

exports('addCmd',addCmd)

---@param cmd string Name of command without slash
---@param cb function Callback with source,args,user
function addRconCmd(cmd, cb)
    registerRconCommand(cmd,cb)
end

exports('addRconCmd',addRconCmd)
