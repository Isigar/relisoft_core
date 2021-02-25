function isAtGroup(player, name, inherit)
    local group = player.getGroup()
    if group == name then
        return true
    end

    if inherit then
        if tableLength(Config.GroupInherit) > 0 then
            local tryFound = Config.GroupInherit[group]
            if tableLength(tryFound) > 0 then
                local foundGroup = false
                for _, inheritGroup in pairs(tryFound) do
                    if name == inheritGroup then
                        return true
                    end
                end
                return foundGroup
            else
                if group == name then
                    return true
                end
                return false
            end
        else
            print('[rcore] Group inherit not setup! WARNING')
        end
    else
        if group == name then
            return true
        end
        return false
    end
end

function isAtJob(player, name)
    local job = player.getJob()
    if job == nil then
        return false
    end

    if job.name == name then
        return true
    end

    return false
end

function registerGroupCommand(name, group, cb, inherit)
    inherit = inherit or true
    RegisterCommand(name, function(source, args, rawCmd)
        if source > 0 then
            local xPlayer = ESX.GetPlayerFromId(source)
            if xPlayer == nil then
                return
            end

            if isAtGroup(xPlayer, group, inherit) then
                cb(source, args, rawCmd)
            else
                sendChatMessageFromServer(source, 'Commands', 'You dont have permission to do this command', { 255, 0, 0 })
            end
        end
    end)
end

function registerJobCommand(name, job, cb)
    RegisterCommand(name, function(source, args, rawCmd)
        if source > 0 then
            local xPlayer = ESX.GetPlayerFromId(source)
            if xPlayer == nil then
                return
            end

            if isAtJob(xPlayer, job) then
                cb(source, args, rawCmd)
            else
                sendChatMessageFromServer(source, 'Commands', 'You dont have permission to do this command', { 255, 0, 0 })
            end
        end
    end)
end

function registerCommand(name, cb)
    RegisterCommand(name, function(source, args, rawCmd)
        if source > 0 then
            cb(source, args, rawCmd)
        end
    end)
end

function registerRconCommand(name, cb)
    RegisterCommand(name, function(source, args, rawCmd)
        if source == 0 then
            cb(source, args, rawCmd)
        end
    end)
end

---@param cmd string Name of command without slash
---@param level number Needed admin level
---@param cb function Callback with source,args,user
function addGroupCmd(cmd, group, cb, inherit)
    inherit = inherit or false
    registerGroupCommand(cmd, group, cb, inherit)
end

exports('addGroupCmd', addGroupCmd)

---@param cmd string Name of command without slash
---@param cb function Callback with source,args,user
function addCmd(cmd, cb)
    registerCommand(cmd, cb)
end

exports('addCmd', addCmd)

---@param cmd string Name of command without slash
---@param cb function Callback with source,args,user
function addRconCmd(cmd, cb)
    registerRconCommand(cmd, cb)
end

exports('addRconCmd', addRconCmd)
